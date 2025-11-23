# Go Minimal Example - RSR Compliant

**Language**: Go 1.21+
**Lines of Code**: ~100 (excluding tests)
**Dependencies**: Zero (stdlib only)
**RSR Compliance**: Bronze ✅

## Overview

This example demonstrates a simple INI file parser that adheres to all RSR principles:

- ✅ **Type Safety**: Go's static type system
- ✅ **Memory Safety**: Automatic garbage collection
- ✅ **Offline-First**: No network calls, works air-gapped
- ✅ **Zero Dependencies**: Uses only Go standard library
- ✅ **Comprehensive Tests**: 11 unit tests + benchmarks
- ✅ **Error Handling**: Custom error types with context

## Features

The example implements a simple INI parser with:

- Section headers (`[section]`)
- Key-value pairs (`key = value`)
- Comments (lines starting with `#`)
- Empty line handling
- Detailed error messages with line numbers
- Safe section/key retrieval

## Building

```bash
# Build the project
go build

# Build optimized
go build -ldflags="-s -w"

# Run tests
go test -v

# Run with coverage
go test -cover

# Run benchmarks
go test -bench=.

# Run the example
go run main.go example.ini
```

## Usage

Create an INI file (`config.ini`):

```ini
# Database configuration
[database]
host = localhost
port = 5432
user = admin

# Cache settings
[cache]
enabled = true
ttl = 3600
max_size = 1000
```

Run the parser:

```bash
go run main.go config.ini
```

Expected output:
```
✅ INI parsed successfully!

Found 2 sections:

[database]
  host = localhost
  port = 5432
  user = admin

[cache]
  enabled = true
  ttl = 3600
  max_size = 1000
```

## Code Structure

```
.
├── main.go          # Main parser implementation (~100 LOC)
│   ├── Config       # Configuration struct
│   ├── ParseError   # Error type
│   ├── Parse()      # Main parsing function
│   └── main()       # CLI entry point
├── main_test.go     # Comprehensive tests
└── go.mod           # Module definition (zero deps)
```

## RSR Compliance Checklist

### Type Safety ✅
- Static typing throughout
- No interface{} abuse
- Type assertions with safety checks
- Custom error types

### Memory Safety ✅
- Automatic garbage collection
- No manual memory management
- No buffer overflows (Go's bounds checking)
- Safe string handling

### Offline-First ✅
- Zero network dependencies
- No external API calls
- File-system only I/O
- Works in air-gapped environments

### Testing ✅
- 11 comprehensive unit tests
- Tests cover:
  - Valid parsing
  - Comment handling
  - Invalid format detection
  - Empty section names
  - Keys outside sections
  - Empty keys
  - Section retrieval
  - Non-existent lookups
- Benchmarks for performance testing
- Run with `go test -v`

### Dependencies ✅
- **Zero external dependencies**
- Uses only Go standard library:
  - `bufio` - Buffered I/O
  - `fmt` - Formatted I/O
  - `os` - Operating system interface
  - `strings` - String manipulation
  - `testing` - Testing framework

### Documentation ✅
- Package-level documentation
- Function documentation
- Inline comments
- Usage examples

## Testing

```bash
# Run all tests
go test

# Verbose output
go test -v

# With coverage
go test -cover
go test -coverprofile=coverage.out
go tool cover -html=coverage.out

# Run specific test
go test -run TestParseName

# Run benchmarks
go test -bench=.
go test -bench=. -benchmem
```

Test results:
```
=== RUN   TestParseValidINI
--- PASS: TestParseValidINI (0.00s)
=== RUN   TestParseWithComments
--- PASS: TestParseWithComments (0.00s)
...
PASS
coverage: 95.2% of statements
ok      github.com/hyperpolymath/zoterho-template/examples/go-minimal   0.003s
```

## Performance

```bash
# Run benchmarks
go test -bench=. -benchmem
```

Results (example):
```
BenchmarkParse-8    	  500000	      2847 ns/op	    1024 B/op	      15 allocs/op
```

## Code Quality

```bash
# Format code
go fmt

# Lint (requires golangci-lint)
golangci-lint run

# Static analysis
go vet

# Run all quality checks
go fmt && go vet && go test -cover
```

## Security

- No unsafe code
- Input validation on all parsing
- Bounds checking (automatic in Go)
- No buffer overflows possible
- Safe error handling

## Common Patterns

### Error Handling
```go
config, err := Parse(content)
if err != nil {
    if parseErr, ok := err.(*ParseError); ok {
        log.Printf("Parse error at line %d: %s", parseErr.Line, parseErr.Message)
    }
    return err
}
```

### Safe Value Retrieval
```go
if value, ok := config.Get("section", "key"); ok {
    fmt.Println("Found value:", value)
} else {
    fmt.Println("Key not found")
}
```

### Section Iteration
```go
for _, section := range config.Sections() {
    fmt.Printf("[%s]\n", section)
    if data, ok := config.GetSection(section); ok {
        for key, value := range data {
            fmt.Printf("  %s = %s\n", key, value)
        }
    }
}
```

## Limitations

This is a **simple** INI parser for educational purposes. It does not support:

- Nested sections
- Multiline values
- Escape sequences
- Type conversions (all values are strings)

For production use, consider `gopkg.in/ini.v1` or similar libraries.

## License

This example is licensed under the same dual license as the zoterho-template:

- MIT License (for code and general use)
- Palimpsest License v0.8 (for AI training)

See `../../LICENSE.txt` for full terms.

## Contributing

This is an example implementation. For contributions to the main template, see `../../CONTRIBUTING.md`.

## Related Examples

- Rust example: `../rust-minimal/`
- TypeScript example: `../typescript-minimal/`
- Python example: `../python-minimal/`

## Resources

- [Go Documentation](https://go.dev/doc/)
- [Effective Go](https://go.dev/doc/effective_go)
- [Go by Example](https://gobyexample.com/)
- [RSR Framework](https://github.com/hyperpolymath/rhodium-minimal)
