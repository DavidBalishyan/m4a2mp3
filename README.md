# m4a2mp3

A command-line utility for batch converting `.m4a` audio files to `.mp3` using FFmpeg, with optional parallel execution via GNU Parallel (avalable for Linux/MacOS and Windows)

---

## Features

* Batch conversion from `.m4a` to `.mp3`
* Parallel processing with configurable concurrency
* Adjustable audio quality (VBR)
* Configurable input and output directories
* Verbose and progress display modes
* Dependency validation before execution

---

## Requirements

The following dependencies must be installed and available in your system PATH:

* ffmpeg
* GNU parallel

### Installation

#### Debian / Ubuntu

```bash
sudo apt install ffmpeg parallel
```

#### Arch Linux

```bash
sudo pacman -S ffmpeg parallel
```

#### macOS (Homebrew)

```bash
brew install ffmpeg parallel
```

---

## Installation (Linux / macOS)

```bash
chmod +x m4a2mp3
sudo mv m4a2mp3 /usr/local/bin/
```

---

## Installation (Windows)

Ensure `ffmpeg` is installed and added to PATH.

You can use either PowerShell or Batch script versions provided below.

---

## Usage

```bash
m4a2mp3 [options]
```

### Options

| Option           | Description                                   |
| ---------------- | --------------------------------------------- |
| -i, --input DIR  | Input directory (default: current directory)  |
| -o, --output DIR | Output directory (default: ./mp3)             |
| -t, --threads N  | Number of parallel jobs (default: 4)          |
| -q, --quality N  | MP3 quality (0 = best, 9 = worst, default: 2) |
| -v, --verbose    | Enable verbose output                         |
| -h, --help       | Display help message                          |

---

## Examples

### Convert files in current directory

```bash
m4a2mp3
```

### Specify number of threads

```bash
m4a2mp3 -t 8
```

### Convert files from another directory

```bash
m4a2mp3 -i ./music -o ./converted
```

### Set maximum quality

```bash
m4a2mp3 -q 0
```

### Enable verbose output

```bash
m4a2mp3 -v
```

---

## Windows Scripts

There are 2 scripts(ps1 and batch) available for windows 

## Notes

* High concurrency values may significantly increase CPU usage
* Ensure sufficient disk space for output files
* Filenames with spaces are supported

---

## License

MIT License

---

## Contributing

Contributions are welcome. Please open an issue or submit a pull request.
