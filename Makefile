CONFIGURATION ?= release
PREFIX ?= /usr/local
VALID_CONFIGURATIONS := debug release
SOURCES := $(shell find Sources -type f -name '*.swift')
TESTS := $(shell find Tests -type f -name '*.swift')
PACKAGE := Package.swift

ifeq ($(filter $(CONFIGURATION),$(VALID_CONFIGURATIONS)),)
	$(error Invalid value for CONFIGURATION. Valid values are $(VALID_CONFIGURATIONS))
endif


.PHONY: all test clean
all: build
build: $(wildcard Sources/**/*.swift Tests/**/*.swift Package.swift Package.resolved)
	swift build -c $(CONFIGURATION) --static-swift-stdlib -Xswiftc -g
	@touch build
install: build
	cp .build/$(CONFIGURATION)/rssh $(PREFIX)/bin
format:
	swift-format -i --recursive Package.swift Sources/ Tests/
lint:
	swiftlint --progress Sources/ Tests/ Package.swift
clean:
	swift package clean

