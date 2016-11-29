/*
Package fzf implements fzf, a command-line fuzzy finder.

The MIT License (MIT)

Copyright (c) 2016 Junegunn Choi

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
*/
package fzf

import (
	"fmt"
	"os"
	"time"

	"github.com/junegunn/fzf/src/util"
)

/*
Reader   -> EvtReadFin
Reader   -> EvtReadNew        -> Matcher  (restart)
Terminal -> EvtSearchNew:bool -> Matcher  (restart)
Matcher  -> EvtSearchProgress -> Terminal (update info)
Matcher  -> EvtSearchFin      -> Terminal (update list)
Matcher  -> EvtHeader         -> Terminal (update header)
*/

// Run starts fzf
func Run(opts *Options) {
	sort := opts.Sort > 0
	sortCriteria = opts.Criteria

	if opts.Version {
		fmt.Println(version)
		os.Exit(exitOk)
	}

	// Event channel
	eventBox := util.NewEventBox()

	// ANSI code processor
	ansiProcessor := func(data []byte) (util.Chars, *[]ansiOffset) {
		return util.ToChars(data), nil
	}
	ansiProcessorRunes := func(data []rune) (util.Chars, *[]ansiOffset) {
		return util.RunesToChars(data), nil
	}
	if opts.Ansi {
		if opts.Theme != nil {
			var state *ansiState
			ansiProcessor = func(data []byte) (util.Chars, *[]ansiOffset) {
				trimmed, offsets, newState := extractColor(string(data), state, nil)
				state = newState
				return util.RunesToChars([]rune(trimmed)), offsets
			}
		} else {
			// When color is disabled but ansi option is given,
			// we simply strip out ANSI codes from the input
			ansiProcessor = func(data []byte) (util.Chars, *[]ansiOffset) {
				trimmed, _, _ := extractColor(string(data), nil, nil)
				return util.RunesToChars([]rune(trimmed)), nil
			}
		}
		ansiProcessorRunes = func(data []rune) (util.Chars, *[]ansiOffset) {
			return ansiProcessor([]byte(string(data)))
		}
	}

	// Chunk list
	var chunkList *ChunkList
	header := make([]string, 0, opts.HeaderLines)
	if len(opts.WithNth) == 0 {
		chunkList = NewChunkList(func(data []byte, index int) *Item {
			if len(header) < opts.HeaderLines {
				header = append(header, string(data))
				eventBox.Set(EvtHeader, header)
				return nil
			}
			chars, colors := ansiProcessor(data)
			return &Item{
				index:  int32(index),
				text:   chars,
				colors: colors}
		})
	} else {
		chunkList = NewChunkList(func(data []byte, index int) *Item {
			tokens := Tokenize(util.ToChars(data), opts.Delimiter)
			trans := Transform(tokens, opts.WithNth)
			if len(header) < opts.HeaderLines {
				header = append(header, string(joinTokens(trans)))
				eventBox.Set(EvtHeader, header)
				return nil
			}
			textRunes := joinTokens(trans)
			item := Item{
				index:    int32(index),
				origText: &data,
				colors:   nil}

			trimmed, colors := ansiProcessorRunes(textRunes)
			item.text = trimmed
			item.colors = colors
			return &item
		})
	}

	// Reader
	streamingFilter := opts.Filter != nil && !sort && !opts.Tac && !opts.Sync
	if !streamingFilter {
		reader := Reader{func(data []byte) bool {
			return chunkList.Push(data)
		}, eventBox, opts.ReadZero}
		go reader.ReadSource()
	}

	// Matcher
	forward := true
	for _, cri := range opts.Criteria[1:] {
		if cri == byEnd {
			forward = false
			break
		}
		if cri == byBegin {
			break
		}
	}
	patternBuilder := func(runes []rune) *Pattern {
		return BuildPattern(
			opts.Fuzzy, opts.FuzzyAlgo, opts.Extended, opts.Case, forward,
			opts.Filter == nil, opts.Nth, opts.Delimiter, runes)
	}
	matcher := NewMatcher(patternBuilder, sort, opts.Tac, eventBox)

	// Filtering mode
	if opts.Filter != nil {
		if opts.PrintQuery {
			opts.Printer(*opts.Filter)
		}

		pattern := patternBuilder([]rune(*opts.Filter))

		found := false
		if streamingFilter {
			slab := util.MakeSlab(slab16Size, slab32Size)
			reader := Reader{
				func(runes []byte) bool {
					item := chunkList.trans(runes, 0)
					if item != nil {
						if result, _, _ := pattern.MatchItem(item, false, slab); result != nil {
							opts.Printer(item.text.ToString())
							found = true
						}
					}
					return false
				}, eventBox, opts.ReadZero}
			reader.ReadSource()
		} else {
			eventBox.Unwatch(EvtReadNew)
			eventBox.WaitFor(EvtReadFin)

			snapshot, _ := chunkList.Snapshot()
			merger, _ := matcher.scan(MatchRequest{
				chunks:  snapshot,
				pattern: pattern})
			for i := 0; i < merger.Length(); i++ {
				opts.Printer(merger.Get(i).item.AsString(opts.Ansi))
				found = true
			}
		}
		if found {
			os.Exit(exitOk)
		}
		os.Exit(exitNoMatch)
	}

	// Synchronous search
	if opts.Sync {
		eventBox.Unwatch(EvtReadNew)
		eventBox.WaitFor(EvtReadFin)
	}

	// Go interactive
	go matcher.Loop()

	// Terminal I/O
	terminal := NewTerminal(opts, eventBox)
	deferred := opts.Select1 || opts.Exit0
	go terminal.Loop()
	if !deferred {
		terminal.startChan <- true
	}

	// Event coordination
	reading := true
	ticks := 0
	eventBox.Watch(EvtReadNew)
	for {
		delay := true
		ticks++
		eventBox.Wait(func(events *util.Events) {
			defer events.Clear()
			for evt, value := range *events {
				switch evt {

				case EvtReadNew, EvtReadFin:
					reading = reading && evt == EvtReadNew
					snapshot, count := chunkList.Snapshot()
					terminal.UpdateCount(count, !reading)
					matcher.Reset(snapshot, terminal.Input(), false, !reading, sort)

				case EvtSearchNew:
					switch val := value.(type) {
					case bool:
						sort = val
					}
					snapshot, _ := chunkList.Snapshot()
					matcher.Reset(snapshot, terminal.Input(), true, !reading, sort)
					delay = false

				case EvtSearchProgress:
					switch val := value.(type) {
					case float32:
						terminal.UpdateProgress(val)
					}

				case EvtHeader:
					terminal.UpdateHeader(value.([]string))

				case EvtSearchFin:
					switch val := value.(type) {
					case *Merger:
						if deferred {
							count := val.Length()
							if opts.Select1 && count > 1 || opts.Exit0 && !opts.Select1 && count > 0 {
								deferred = false
								terminal.startChan <- true
							} else if val.final {
								if opts.Exit0 && count == 0 || opts.Select1 && count == 1 {
									if opts.PrintQuery {
										opts.Printer(opts.Query)
									}
									if len(opts.Expect) > 0 {
										opts.Printer("")
									}
									for i := 0; i < count; i++ {
										opts.Printer(val.Get(i).item.AsString(opts.Ansi))
									}
									if count > 0 {
										os.Exit(exitOk)
									}
									os.Exit(exitNoMatch)
								}
								deferred = false
								terminal.startChan <- true
							}
						}
						terminal.UpdateList(val)
					}
				}
			}
		})
		if delay && reading {
			dur := util.DurWithin(
				time.Duration(ticks)*coordinatorDelayStep,
				0, coordinatorDelayMax)
			time.Sleep(dur)
		}
	}
}
