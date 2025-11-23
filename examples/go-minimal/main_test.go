package main

import (
	"testing"
)

func TestParseValidINI(t *testing.T) {
	input := `[database]
host = localhost
port = 5432

[cache]
enabled = true
ttl = 3600
`
	config, err := Parse(input)
	if err != nil {
		t.Fatalf("expected no error, got %v", err)
	}

	// Test database section
	if host, ok := config.Get("database", "host"); !ok || host != "localhost" {
		t.Errorf("expected host=localhost, got %s", host)
	}

	if port, ok := config.Get("database", "port"); !ok || port != "5432" {
		t.Errorf("expected port=5432, got %s", port)
	}

	// Test cache section
	if enabled, ok := config.Get("cache", "enabled"); !ok || enabled != "true" {
		t.Errorf("expected enabled=true, got %s", enabled)
	}
}

func TestParseWithComments(t *testing.T) {
	input := `# This is a comment
[section]
# Another comment
key = value
`
	config, err := Parse(input)
	if err != nil {
		t.Fatalf("expected no error, got %v", err)
	}

	if val, ok := config.Get("section", "key"); !ok || val != "value" {
		t.Errorf("expected key=value, got %s", val)
	}
}

func TestParseInvalidFormat(t *testing.T) {
	input := "invalid line"
	_, err := Parse(input)
	if err == nil {
		t.Fatal("expected error for invalid format")
	}

	parseErr, ok := err.(*ParseError)
	if !ok {
		t.Fatal("expected ParseError")
	}

	if parseErr.Line != 1 {
		t.Errorf("expected line 1, got %d", parseErr.Line)
	}
}

func TestParseEmptySectionName(t *testing.T) {
	input := "[]"
	_, err := Parse(input)
	if err == nil {
		t.Fatal("expected error for empty section name")
	}
}

func TestParseKeyValueOutsideSection(t *testing.T) {
	input := "key = value"
	_, err := Parse(input)
	if err == nil {
		t.Fatal("expected error for key-value outside section")
	}
}

func TestParseEmptyKey(t *testing.T) {
	input := `[section]
= value`
	_, err := Parse(input)
	if err == nil {
		t.Fatal("expected error for empty key")
	}
}

func TestGetSection(t *testing.T) {
	input := `[test]
key1 = value1
key2 = value2
`
	config, err := Parse(input)
	if err != nil {
		t.Fatalf("parse error: %v", err)
	}

	section, ok := config.GetSection("test")
	if !ok {
		t.Fatal("expected section to exist")
	}

	if len(section) != 2 {
		t.Errorf("expected 2 keys, got %d", len(section))
	}

	if section["key1"] != "value1" {
		t.Errorf("expected value1, got %s", section["key1"])
	}
}

func TestGetNonexistentSection(t *testing.T) {
	config := NewConfig()
	_, ok := config.GetSection("nonexistent")
	if ok {
		t.Fatal("expected section not to exist")
	}
}

func TestGetNonexistentKey(t *testing.T) {
	input := `[section]
key = value
`
	config, err := Parse(input)
	if err != nil {
		t.Fatalf("parse error: %v", err)
	}

	_, ok := config.Get("section", "nonexistent")
	if ok {
		t.Fatal("expected key not to exist")
	}
}

func TestSections(t *testing.T) {
	input := `[section1]
key = value

[section2]
key = value
`
	config, err := Parse(input)
	if err != nil {
		t.Fatalf("parse error: %v", err)
	}

	sections := config.Sections()
	if len(sections) != 2 {
		t.Errorf("expected 2 sections, got %d", len(sections))
	}
}

// Benchmark parsing
func BenchmarkParse(b *testing.B) {
	input := `[section1]
key1 = value1
key2 = value2

[section2]
key3 = value3
key4 = value4
`
	b.ResetTimer()
	for i := 0; i < b.N; i++ {
		_, _ = Parse(input)
	}
}
