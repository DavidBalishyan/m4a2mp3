# Makefile for m4a2mp3

SHELL := /bin/bash
BIN := m4a2mp3.sh
PREFIX ?= /usr/local
INSTALL_PATH := $(PREFIX)/bin/m4a2mp3

.PHONY: all help check test install uninstall clean

all: help

help:
	@echo "m4a2mp3 Makefile commands:"
	@echo "  make check       Verify that required tools are installed"
	@echo "  make test        Run a basic script smoke test"
	@echo "  make install     Install script to $(INSTALL_PATH)"
	@echo "  make uninstall   Remove installed script from $(INSTALL_PATH)"
	@echo "  make clean       No-op (preserves user files)"
	@echo "  make run         Run converter with defaults (calls ./m4a2mp3)"

check:
	@command -v ffmpeg >/dev/null 2>&1 || { echo "Error: ffmpeg not found in PATH" >&2; exit 1; }
	@command -v parallel >/dev/null 2>&1 || { echo "Error: parallel not found in PATH" >&2; exit 1; }
	@echo "All dependencies are present."

test: check
	@echo "Running smoke test against script help output..."
	@./$(BIN) -h >/dev/null
	@echo "Smoke test passed."

run: check
	@echo "Running m4a2mp3 with defaults (input: ., output: ./mp3, threads:4)"
	@./$(BIN)

install: check
	@if [ ! -f "$(BIN)" ]; then echo "Error: $(BIN) not found in repo root" >&2; exit 1; fi
	@chmod +x "$(BIN)"
	@cp "$(BIN)" "$(INSTALL_PATH)"
	@echo "Installed to $(INSTALL_PATH)"

uninstall:
	@rm -f "$(INSTALL_PATH)"
	@echo "Removed $(INSTALL_PATH)"
