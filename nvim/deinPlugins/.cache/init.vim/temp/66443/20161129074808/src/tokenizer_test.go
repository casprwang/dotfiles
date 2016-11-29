package fzf

import (
	"testing"

	"github.com/junegunn/fzf/src/util"
)

func TestParseRange(t *testing.T) {
	{
		i := ".."
		r, _ := ParseRange(&i)
		if r.begin != rangeEllipsis || r.end != rangeEllipsis {
			t.Errorf("%s", r)
		}
	}
	{
		i := "3.."
		r, _ := ParseRange(&i)
		if r.begin != 3 || r.end != rangeEllipsis {
			t.Errorf("%s", r)
		}
	}
	{
		i := "3..5"
		r, _ := ParseRange(&i)
		if r.begin != 3 || r.end != 5 {
			t.Errorf("%s", r)
		}
	}
	{
		i := "-3..-5"
		r, _ := ParseRange(&i)
		if r.begin != -3 || r.end != -5 {
			t.Errorf("%s", r)
		}
	}
	{
		i := "3"
		r, _ := ParseRange(&i)
		if r.begin != 3 || r.end != 3 {
			t.Errorf("%s", r)
		}
	}
}

func TestTokenize(t *testing.T) {
	// AWK-style
	input := "  abc:  def:  ghi  "
	tokens := Tokenize(util.RunesToChars([]rune(input)), Delimiter{})
	if tokens[0].text.ToString() != "abc:  " || tokens[0].prefixLength != 2 || tokens[0].trimLength != 4 {
		t.Errorf("%s", tokens)
	}

	// With delimiter
	tokens = Tokenize(util.RunesToChars([]rune(input)), delimiterRegexp(":"))
	if tokens[0].text.ToString() != "  abc:" || tokens[0].prefixLength != 0 || tokens[0].trimLength != 4 {
		t.Errorf("%s", tokens)
	}

	// With delimiter regex
	tokens = Tokenize(util.RunesToChars([]rune(input)), delimiterRegexp("\\s+"))
	if tokens[0].text.ToString() != "  " || tokens[0].prefixLength != 0 || tokens[0].trimLength != 0 ||
		tokens[1].text.ToString() != "abc:  " || tokens[1].prefixLength != 2 || tokens[1].trimLength != 4 ||
		tokens[2].text.ToString() != "def:  " || tokens[2].prefixLength != 8 || tokens[2].trimLength != 4 ||
		tokens[3].text.ToString() != "ghi  " || tokens[3].prefixLength != 14 || tokens[3].trimLength != 3 {
		t.Errorf("%s", tokens)
	}
}

func TestTransform(t *testing.T) {
	input := "  abc:  def:  ghi:  jkl"
	{
		tokens := Tokenize(util.RunesToChars([]rune(input)), Delimiter{})
		{
			ranges := splitNth("1,2,3")
			tx := Transform(tokens, ranges)
			if string(joinTokens(tx)) != "abc:  def:  ghi:  " {
				t.Errorf("%s", tx)
			}
		}
		{
			ranges := splitNth("1..2,3,2..,1")
			tx := Transform(tokens, ranges)
			if string(joinTokens(tx)) != "abc:  def:  ghi:  def:  ghi:  jklabc:  " ||
				len(tx) != 4 ||
				tx[0].text.ToString() != "abc:  def:  " || tx[0].prefixLength != 2 ||
				tx[1].text.ToString() != "ghi:  " || tx[1].prefixLength != 14 ||
				tx[2].text.ToString() != "def:  ghi:  jkl" || tx[2].prefixLength != 8 ||
				tx[3].text.ToString() != "abc:  " || tx[3].prefixLength != 2 {
				t.Errorf("%s", tx)
			}
		}
	}
	{
		tokens := Tokenize(util.RunesToChars([]rune(input)), delimiterRegexp(":"))
		{
			ranges := splitNth("1..2,3,2..,1")
			tx := Transform(tokens, ranges)
			if string(joinTokens(tx)) != "  abc:  def:  ghi:  def:  ghi:  jkl  abc:" ||
				len(tx) != 4 ||
				tx[0].text.ToString() != "  abc:  def:" || tx[0].prefixLength != 0 ||
				tx[1].text.ToString() != "  ghi:" || tx[1].prefixLength != 12 ||
				tx[2].text.ToString() != "  def:  ghi:  jkl" || tx[2].prefixLength != 6 ||
				tx[3].text.ToString() != "  abc:" || tx[3].prefixLength != 0 {
				t.Errorf("%s", tx)
			}
		}
	}
}

func TestTransformIndexOutOfBounds(t *testing.T) {
	Transform([]Token{}, splitNth("1"))
}
