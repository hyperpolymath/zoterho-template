// SPDX-License-Identifier: (MIT OR Palimpsest-0.8)
// Copyright (c) 2025 Zoterho Template Contributors

// Package main implements an RSR-compliant INI file parser.
//
// This example demonstrates RSR principles:
//   - Type safety (Go's static typing)
//   - Memory safety (automatic garbage collection)
//   - Offline-first (no network dependencies)
//   - Zero dependencies (stdlib only)
//   - Comprehensive error handling and testing
package main

import (
	"bufio"
	"fmt"
	"os"
	"strings"
)

// Config represents a parsed INI configuration.
type Config struct {
	sections map[string]map[string]string
}

// ParseError represents a configuration parsing error.
type ParseError struct {
	Line    int
	Message string
}

// Error implements the error interface.
func (e *ParseError) Error() string {
	return fmt.Sprintf("line %d: %s", e.Line, e.Message)
}

// NewConfig creates a new empty configuration.
func NewConfig() *Config {
	return &Config{
		sections: make(map[string]map[string]string),
	}
}

// Parse parses INI content into a Config.
//
// Supported format:
//   - [section]
//   - key = value
//   - # comments
func Parse(content string) (*Config, error) {
	config := NewConfig()
	scanner := bufio.NewScanner(strings.NewReader(content))

	var currentSection string
	lineNum := 0

	for scanner.Scan() {
		lineNum++
		line := strings.TrimSpace(scanner.Text())

		// Skip empty lines and comments
		if line == "" || strings.HasPrefix(line, "#") {
			continue
		}

		// Section header
		if strings.HasPrefix(line, "[") && strings.HasSuffix(line, "]") {
			currentSection = strings.TrimSpace(line[1 : len(line)-1])
			if currentSection == "" {
				return nil, &ParseError{
					Line:    lineNum,
					Message: "empty section name",
				}
			}
			if config.sections[currentSection] == nil {
				config.sections[currentSection] = make(map[string]string)
			}
			continue
		}

		// Key-value pair
		parts := strings.SplitN(line, "=", 2)
		if len(parts) != 2 {
			return nil, &ParseError{
				Line:    lineNum,
				Message: "expected key=value format",
			}
		}

		key := strings.TrimSpace(parts[0])
		value := strings.TrimSpace(parts[1])

		if key == "" {
			return nil, &ParseError{
				Line:    lineNum,
				Message: "empty key not allowed",
			}
		}

		if currentSection == "" {
			return nil, &ParseError{
				Line:    lineNum,
				Message: "key-value pair outside of section",
			}
		}

		config.sections[currentSection][key] = value
	}

	if err := scanner.Err(); err != nil {
		return nil, fmt.Errorf("scan error: %w", err)
	}

	return config, nil
}

// Get retrieves a value from a section.
func (c *Config) Get(section, key string) (string, bool) {
	if sec, ok := c.sections[section]; ok {
		val, exists := sec[key]
		return val, exists
	}
	return "", false
}

// GetSection retrieves all key-value pairs from a section.
func (c *Config) GetSection(section string) (map[string]string, bool) {
	sec, ok := c.sections[section]
	if !ok {
		return nil, false
	}
	// Return a copy to prevent external modification
	result := make(map[string]string, len(sec))
	for k, v := range sec {
		result[k] = v
	}
	return result, true
}

// Sections returns all section names.
func (c *Config) Sections() []string {
	sections := make([]string, 0, len(c.sections))
	for section := range c.sections {
		sections = append(sections, section)
	}
	return sections
}

func main() {
	if len(os.Args) < 2 {
		fmt.Fprintln(os.Stderr, "Usage: go run main.go <config.ini>")
		fmt.Fprintln(os.Stderr, "\nRSR-Compliant INI Parser")
		fmt.Fprintln(os.Stderr, "Parses simple INI files using only Go stdlib")
		os.Exit(1)
	}

	filename := os.Args[1]

	// Read file
	content, err := os.ReadFile(filename)
	if err != nil {
		fmt.Fprintf(os.Stderr, "Error reading file: %v\n", err)
		os.Exit(1)
	}

	// Parse configuration
	config, err := Parse(string(content))
	if err != nil {
		fmt.Fprintf(os.Stderr, "Parse error: %v\n", err)
		os.Exit(1)
	}

	// Display results
	fmt.Println("✅ INI parsed successfully!")
	fmt.Printf("\nFound %d sections:\n", len(config.Sections()))

	for _, section := range config.Sections() {
		fmt.Printf("\n[%s]\n", section)
		if sectionData, ok := config.GetSection(section); ok {
			for key, value := range sectionData {
				fmt.Printf("  %s = %s\n", key, value)
			}
		}
	}
}
