package fzf

import (
	"bytes"
	"regexp"
	"strconv"
	"strings"
	"unicode/utf8"

	"github.com/junegunn/fzf/src/tui"
)

type ansiOffset struct {
	offset [2]int32
	color  ansiState
}

type ansiState struct {
	fg   tui.Color
	bg   tui.Color
	attr tui.Attr
}

func (s *ansiState) colored() bool {
	return s.fg != -1 || s.bg != -1 || s.attr > 0
}

func (s *ansiState) equals(t *ansiState) bool {
	if t == nil {
		return !s.colored()
	}
	return s.fg == t.fg && s.bg == t.bg && s.attr == t.attr
}

var ansiRegex *regexp.Regexp

func init() {
	/*
		References:
		- https://github.com/gnachman/iTerm2
		- http://ascii-table.com/ansi-escape-sequences.php
		- http://ascii-table.com/ansi-escape-sequences-vt-100.php
		- http://tldp.org/HOWTO/Bash-Prompt-HOWTO/x405.html
	*/
	// The following regular expression will include not all but most of the
	// frequently used ANSI sequences
	ansiRegex = regexp.MustCompile("\x1b[\\[()][0-9;]*[a-zA-Z@]|\x1b.|[\x08\x0e\x0f]")
}

func extractColor(str string, state *ansiState, proc func(string, *ansiState) bool) (string, *[]ansiOffset, *ansiState) {
	var offsets []ansiOffset
	var output bytes.Buffer

	if state != nil {
		offsets = append(offsets, ansiOffset{[2]int32{0, 0}, *state})
	}

	idx := 0
	for _, offset := range ansiRegex.FindAllStringIndex(str, -1) {
		prev := str[idx:offset[0]]
		output.WriteString(prev)
		if proc != nil && !proc(prev, state) {
			return "", nil, nil
		}
		newState := interpretCode(str[offset[0]:offset[1]], state)

		if !newState.equals(state) {
			if state != nil {
				// Update last offset
				(&offsets[len(offsets)-1]).offset[1] = int32(utf8.RuneCount(output.Bytes()))
			}

			if newState.colored() {
				// Append new offset
				state = newState
				newLen := int32(utf8.RuneCount(output.Bytes()))
				offsets = append(offsets, ansiOffset{[2]int32{newLen, newLen}, *state})
			} else {
				// Discard state
				state = nil
			}
		}

		idx = offset[1]
	}

	rest := str[idx:]
	if len(rest) > 0 {
		output.WriteString(rest)
		if state != nil {
			// Update last offset
			(&offsets[len(offsets)-1]).offset[1] = int32(utf8.RuneCount(output.Bytes()))
		}
	}
	if proc != nil {
		proc(rest, state)
	}
	if len(offsets) == 0 {
		return output.String(), nil, state
	}
	return output.String(), &offsets, state
}

func interpretCode(ansiCode string, prevState *ansiState) *ansiState {
	// State
	var state *ansiState
	if prevState == nil {
		state = &ansiState{-1, -1, 0}
	} else {
		state = &ansiState{prevState.fg, prevState.bg, prevState.attr}
	}
	if ansiCode[0] != '\x1b' || ansiCode[1] != '[' || ansiCode[len(ansiCode)-1] != 'm' {
		return state
	}

	ptr := &state.fg
	state256 := 0

	init := func() {
		state.fg = -1
		state.bg = -1
		state.attr = 0
		state256 = 0
	}

	ansiCode = ansiCode[2 : len(ansiCode)-1]
	if len(ansiCode) == 0 {
		init()
	}
	for _, code := range strings.Split(ansiCode, ";") {
		if num, err := strconv.Atoi(code); err == nil {
			switch state256 {
			case 0:
				switch num {
				case 38:
					ptr = &state.fg
					state256++
				case 48:
					ptr = &state.bg
					state256++
				case 39:
					state.fg = -1
				case 49:
					state.bg = -1
				case 1:
					state.attr = state.attr | tui.Bold
				case 2:
					state.attr = state.attr | tui.Dim
				case 3:
					state.attr = state.attr | tui.Italic
				case 4:
					state.attr = state.attr | tui.Underline
				case 5:
					state.attr = state.attr | tui.Blink
				case 7:
					state.attr = state.attr | tui.Reverse
				case 0:
					init()
				default:
					if num >= 30 && num <= 37 {
						state.fg = tui.Color(num - 30)
					} else if num >= 40 && num <= 47 {
						state.bg = tui.Color(num - 40)
					} else if num >= 90 && num <= 97 {
						state.fg = tui.Color(num - 90 + 8)
					} else if num >= 100 && num <= 107 {
						state.bg = tui.Color(num - 100 + 8)
					}
				}
			case 1:
				switch num {
				case 2:
					state256 = 10 // MAGIC
				case 5:
					state256++
				default:
					state256 = 0
				}
			case 2:
				*ptr = tui.Color(num)
				state256 = 0
			case 10:
				*ptr = tui.Color(1<<24) | tui.Color(num<<16)
				state256++
			case 11:
				*ptr = *ptr | tui.Color(num<<8)
				state256++
			case 12:
				*ptr = *ptr | tui.Color(num)
				state256 = 0
			}
		}
	}
	if state256 > 0 {
		*ptr = -1
	}
	return state
}
