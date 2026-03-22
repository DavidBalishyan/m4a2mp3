#!/bin/bash

check_command() {
  command -v "$1" >/dev/null 2>&1
}

# Verify dependencies
missing=0

if ! check_command ffmpeg; then
  echo "Error: ffmpeg is not installed."
  missing=1
fi

if ! check_command parallel; then
  echo "Error: GNU parallel is not installed."
  missing=1
fi

if [[ $missing -eq 1 ]]; then
  printf "\n Install required tools: "
  echo "Ubuntu/Debian: sudo apt install ffmpeg parallel"
  echo "Arch: sudo pacman -S ffmpeg parallel"
  echo "macOS: brew install ffmpeg parallel"
  exit 1
fi

# Default values
THREADS=4
INPUT="."
OUTPUT="mp3"
QUALITY=2
VERBOSE=0

show_help() {
  echo "Usage: m4a2mp3 [options]"
  echo ""
  echo "Options:"
  echo "  -i, --input DIR       Input directory (default: current)"
  echo "  -o, --output DIR      Output directory (default: ./mp3)"
  echo "  -t, --threads N       Number of parallel jobs (default: 4)"
  echo "  -q, --quality N       MP3 quality (0=best, 9=worst, default: 2)"
  echo "  -v, --verbose         Show full ffmpeg output"
  echo "  -h, --help            Show this help"
}

# Parse args
while [[ $# -gt 0 ]]; do
  case "$1" in
    -i|--input) INPUT="$2"; shift 2 ;;
    -o|--output) OUTPUT="$2"; shift 2 ;;
    -t|--threads) THREADS="$2"; shift 2 ;;
    -q|--quality) QUALITY="$2"; shift 2 ;;
    -v|--verbose) VERBOSE=1; shift ;;
    -h|--help) show_help; exit 0 ;;
    *) echo "Unknown option: $1"; exit 1 ;;
  esac
done

mkdir -p "$OUTPUT"

cd "$INPUT" || exit 1

echo "Converting .m4a -> .mp3"
echo "Threads: $THREADS | Quality: $QUALITY | Output: $OUTPUT"
echo ""

# Build ffmpeg command
if [[ $VERBOSE -eq 1 ]]; then
  PARALLEL_OPTS="--tag --group"
else
  PARALLEL_OPTS="--bar"
fi

parallel -j "$THREADS" $PARALLEL_OPTS \
	ffmpeg -i {} -vn -q:a "$QUALITY" "$OUTPUT/{/.}.mp3" ::: *.m4a

printf "\nDone!"
