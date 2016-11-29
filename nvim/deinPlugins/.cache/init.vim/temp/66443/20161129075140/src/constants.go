package fzf

import (
	"time"

	"github.com/junegunn/fzf/src/util"
)

const (
	// Current version
	version = "0.15.9"

	// Core
	coordinatorDelayMax  time.Duration = 100 * time.Millisecond
	coordinatorDelayStep time.Duration = 10 * time.Millisecond

	// Reader
	readerBufferSize = 64 * 1024

	// Terminal
	initialDelay     = 20 * time.Millisecond
	initialDelayTac  = 100 * time.Millisecond
	spinnerDuration  = 200 * time.Millisecond
	maxPatternLength = 100

	// Matcher
	numPartitionsMultiplier = 8
	maxPartitions           = 32
	progressMinDuration     = 200 * time.Millisecond

	// Capacity of each chunk
	chunkSize int = 100

	// Pre-allocated memory slices to minimize GC
	slab16Size int = 100 * 1024 // 200KB * 32 = 12.8MB
	slab32Size int = 2048       // 8KB * 32 = 256KB

	// Do not cache results of low selectivity queries
	queryCacheMax int = chunkSize / 5

	// Not to cache mergers with large lists
	mergerCacheMax int = 100000

	// History
	defaultHistoryMax int = 1000

	// Jump labels
	defaultJumpLabels string = "asdfghjklqwertyuiopzxcvbnm1234567890ASDFGHJKLQWERTYUIOPZXCVBNM`~;:,<.>/?'\"!@#$%^&*()[{]}-_=+"
)

// fzf events
const (
	EvtReadNew util.EventType = iota
	EvtReadFin
	EvtSearchNew
	EvtSearchProgress
	EvtSearchFin
	EvtHeader
	EvtClose
)

const (
	exitOk        = 0
	exitNoMatch   = 1
	exitError     = 2
	exitInterrupt = 130
)
