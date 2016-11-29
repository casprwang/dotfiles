package fzf

import (
	"regexp"
	"strings"

	"github.com/junegunn/fzf/src/algo"
	"github.com/junegunn/fzf/src/util"
)

// fuzzy
// 'exact
// ^exact-prefix
// exact-suffix$
// !not-fuzzy
// !'not-exact
// !^not-exact-prefix
// !not-exact-suffix$

type termType int

const (
	termFuzzy termType = iota
	termExact
	termPrefix
	termSuffix
	termEqual
)

type term struct {
	typ           termType
	inv           bool
	text          []rune
	caseSensitive bool
	origText      []rune
}

type termSet []term

// Pattern represents search pattern
type Pattern struct {
	fuzzy         bool
	fuzzyAlgo     algo.Algo
	extended      bool
	caseSensitive bool
	forward       bool
	text          []rune
	termSets      []termSet
	cacheable     bool
	delimiter     Delimiter
	nth           []Range
	procFun       map[termType]algo.Algo
}

var (
	_patternCache map[string]*Pattern
	_splitRegex   *regexp.Regexp
	_cache        ChunkCache
)

func init() {
	_splitRegex = regexp.MustCompile("\\s+")
	clearPatternCache()
	clearChunkCache()
}

func clearPatternCache() {
	// We can uniquely identify the pattern for a given string since
	// search mode and caseMode do not change while the program is running
	_patternCache = make(map[string]*Pattern)
}

func clearChunkCache() {
	_cache = NewChunkCache()
}

// BuildPattern builds Pattern object from the given arguments
func BuildPattern(fuzzy bool, fuzzyAlgo algo.Algo, extended bool, caseMode Case, forward bool,
	cacheable bool, nth []Range, delimiter Delimiter, runes []rune) *Pattern {

	var asString string
	if extended {
		asString = strings.Trim(string(runes), " ")
	} else {
		asString = string(runes)
	}

	cached, found := _patternCache[asString]
	if found {
		return cached
	}

	caseSensitive := true
	termSets := []termSet{}

	if extended {
		termSets = parseTerms(fuzzy, caseMode, asString)
	Loop:
		for _, termSet := range termSets {
			for idx, term := range termSet {
				// If the query contains inverse search terms or OR operators,
				// we cannot cache the search scope
				if !cacheable || idx > 0 || term.inv {
					cacheable = false
					break Loop
				}
			}
		}
	} else {
		lowerString := strings.ToLower(asString)
		caseSensitive = caseMode == CaseRespect ||
			caseMode == CaseSmart && lowerString != asString
		if !caseSensitive {
			asString = lowerString
		}
	}

	ptr := &Pattern{
		fuzzy:         fuzzy,
		fuzzyAlgo:     fuzzyAlgo,
		extended:      extended,
		caseSensitive: caseSensitive,
		forward:       forward,
		text:          []rune(asString),
		termSets:      termSets,
		cacheable:     cacheable,
		nth:           nth,
		delimiter:     delimiter,
		procFun:       make(map[termType]algo.Algo)}

	ptr.procFun[termFuzzy] = fuzzyAlgo
	ptr.procFun[termEqual] = algo.EqualMatch
	ptr.procFun[termExact] = algo.ExactMatchNaive
	ptr.procFun[termPrefix] = algo.PrefixMatch
	ptr.procFun[termSuffix] = algo.SuffixMatch

	_patternCache[asString] = ptr
	return ptr
}

func parseTerms(fuzzy bool, caseMode Case, str string) []termSet {
	tokens := _splitRegex.Split(str, -1)
	sets := []termSet{}
	set := termSet{}
	switchSet := false
	for _, token := range tokens {
		typ, inv, text := termFuzzy, false, token
		lowerText := strings.ToLower(text)
		caseSensitive := caseMode == CaseRespect ||
			caseMode == CaseSmart && text != lowerText
		if !caseSensitive {
			text = lowerText
		}
		origText := []rune(text)
		if !fuzzy {
			typ = termExact
		}

		if text == "|" {
			switchSet = false
			continue
		}

		if strings.HasPrefix(text, "!") {
			inv = true
			typ = termExact
			text = text[1:]
		}

		if strings.HasPrefix(text, "'") {
			// Flip exactness
			if fuzzy && !inv {
				typ = termExact
				text = text[1:]
			} else {
				typ = termFuzzy
				text = text[1:]
			}
		} else if strings.HasPrefix(text, "^") {
			if strings.HasSuffix(text, "$") {
				typ = termEqual
				text = text[1 : len(text)-1]
			} else {
				typ = termPrefix
				text = text[1:]
			}
		} else if strings.HasSuffix(text, "$") {
			typ = termSuffix
			text = text[:len(text)-1]
		}

		if len(text) > 0 {
			if switchSet {
				sets = append(sets, set)
				set = termSet{}
			}
			set = append(set, term{
				typ:           typ,
				inv:           inv,
				text:          []rune(text),
				caseSensitive: caseSensitive,
				origText:      origText})
			switchSet = true
		}
	}
	if len(set) > 0 {
		sets = append(sets, set)
	}
	return sets
}

// IsEmpty returns true if the pattern is effectively empty
func (p *Pattern) IsEmpty() bool {
	if !p.extended {
		return len(p.text) == 0
	}
	return len(p.termSets) == 0
}

// AsString returns the search query in string type
func (p *Pattern) AsString() string {
	return string(p.text)
}

// CacheKey is used to build string to be used as the key of result cache
func (p *Pattern) CacheKey() string {
	if !p.extended {
		return p.AsString()
	}
	cacheableTerms := []string{}
	for _, termSet := range p.termSets {
		if len(termSet) == 1 && !termSet[0].inv && (p.fuzzy || termSet[0].typ == termExact) {
			cacheableTerms = append(cacheableTerms, string(termSet[0].origText))
		}
	}
	return strings.Join(cacheableTerms, " ")
}

// Match returns the list of matches Items in the given Chunk
func (p *Pattern) Match(chunk *Chunk, slab *util.Slab) []*Result {
	// ChunkCache: Exact match
	cacheKey := p.CacheKey()
	if p.cacheable {
		if cached, found := _cache.Find(chunk, cacheKey); found {
			return cached
		}
	}

	// Prefix/suffix cache
	var space []*Result
Loop:
	for idx := 1; idx < len(cacheKey); idx++ {
		// [---------| ] | [ |---------]
		// [--------|  ] | [  |--------]
		// [-------|   ] | [   |-------]
		prefix := cacheKey[:len(cacheKey)-idx]
		suffix := cacheKey[idx:]
		for _, substr := range [2]*string{&prefix, &suffix} {
			if cached, found := _cache.Find(chunk, *substr); found {
				space = cached
				break Loop
			}
		}
	}

	matches := p.matchChunk(chunk, space, slab)

	if p.cacheable {
		_cache.Add(chunk, cacheKey, matches)
	}
	return matches
}

func (p *Pattern) matchChunk(chunk *Chunk, space []*Result, slab *util.Slab) []*Result {
	matches := []*Result{}

	if space == nil {
		for _, item := range *chunk {
			if match, _, _ := p.MatchItem(item, false, slab); match != nil {
				matches = append(matches, match)
			}
		}
	} else {
		for _, result := range space {
			if match, _, _ := p.MatchItem(result.item, false, slab); match != nil {
				matches = append(matches, match)
			}
		}
	}
	return matches
}

// MatchItem returns true if the Item is a match
func (p *Pattern) MatchItem(item *Item, withPos bool, slab *util.Slab) (*Result, []Offset, *[]int) {
	if p.extended {
		if offsets, bonus, trimLen, pos := p.extendedMatch(item, withPos, slab); len(offsets) == len(p.termSets) {
			return buildResult(item, offsets, bonus, trimLen), offsets, pos
		}
		return nil, nil, nil
	}
	offset, bonus, trimLen, pos := p.basicMatch(item, withPos, slab)
	if sidx := offset[0]; sidx >= 0 {
		offsets := []Offset{offset}
		return buildResult(item, offsets, bonus, trimLen), offsets, pos
	}
	return nil, nil, nil
}

func (p *Pattern) basicMatch(item *Item, withPos bool, slab *util.Slab) (Offset, int, int, *[]int) {
	input := p.prepareInput(item)
	if p.fuzzy {
		return p.iter(p.fuzzyAlgo, input, p.caseSensitive, p.forward, p.text, withPos, slab)
	}
	return p.iter(algo.ExactMatchNaive, input, p.caseSensitive, p.forward, p.text, withPos, slab)
}

func (p *Pattern) extendedMatch(item *Item, withPos bool, slab *util.Slab) ([]Offset, int, int, *[]int) {
	input := p.prepareInput(item)
	offsets := []Offset{}
	var totalScore int
	var totalTrimLen int
	var allPos *[]int
	if withPos {
		allPos = &[]int{}
	}
	for _, termSet := range p.termSets {
		var offset Offset
		var currentScore int
		var trimLen int
		matched := false
		for _, term := range termSet {
			pfun := p.procFun[term.typ]
			off, score, tLen, pos := p.iter(pfun, input, term.caseSensitive, p.forward, term.text, withPos, slab)
			if sidx := off[0]; sidx >= 0 {
				if term.inv {
					continue
				}
				offset, currentScore, trimLen = off, score, tLen
				matched = true
				if withPos {
					if pos != nil {
						*allPos = append(*allPos, *pos...)
					} else {
						for idx := off[0]; idx < off[1]; idx++ {
							*allPos = append(*allPos, int(idx))
						}
					}
				}
				break
			} else if term.inv {
				offset, currentScore, trimLen = Offset{0, 0}, 0, 0
				matched = true
				continue
			}
		}
		if matched {
			offsets = append(offsets, offset)
			totalScore += currentScore
			totalTrimLen += trimLen
		}
	}
	return offsets, totalScore, totalTrimLen, allPos
}

func (p *Pattern) prepareInput(item *Item) []Token {
	if item.transformed != nil {
		return item.transformed
	}

	var ret []Token
	if len(p.nth) == 0 {
		ret = []Token{Token{text: &item.text, prefixLength: 0, trimLength: int32(item.text.TrimLength())}}
	} else {
		tokens := Tokenize(item.text, p.delimiter)
		ret = Transform(tokens, p.nth)
	}
	item.transformed = ret
	return ret
}

func (p *Pattern) iter(pfun algo.Algo, tokens []Token, caseSensitive bool, forward bool, pattern []rune, withPos bool, slab *util.Slab) (Offset, int, int, *[]int) {
	for _, part := range tokens {
		if res, pos := pfun(caseSensitive, forward, *part.text, pattern, withPos, slab); res.Start >= 0 {
			sidx := int32(res.Start) + part.prefixLength
			eidx := int32(res.End) + part.prefixLength
			if pos != nil {
				for idx := range *pos {
					(*pos)[idx] += int(part.prefixLength)
				}
			}
			return Offset{sidx, eidx}, res.Score, int(part.trimLength), pos
		}
	}
	return Offset{-1, -1}, 0, -1, nil
}
