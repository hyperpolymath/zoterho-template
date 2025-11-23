# RSR Quick Reference Card

One-page reference for RSR (Rhodium Standard Repository) compliance.

## RSR Bronze Compliance Checklist

```
✅ Documentation (7 files)
   □ README.md          - Project overview
   □ LICENSE.txt        - Dual MIT + Palimpsest v0.8
   □ SECURITY.md        - Vulnerability disclosure
   □ CONTRIBUTING.md    - Contribution guidelines
   □ CODE_OF_CONDUCT.md - Community standards
   □ MAINTAINERS.md     - Project governance
   □ CHANGELOG.md       - Version history

✅ .well-known/ (3 files)
   □ security.txt       - RFC 9116 security contact
   □ ai.txt            - AI training policies
   □ humans.txt        - Human attribution

✅ Build Automation
   □ justfile          - Build recipes (25+ commands)

✅ Type Safety
   □ Rust: Compile-time type checking
   □ TypeScript: Strict mode enabled
   □ Python: Type hints + mypy strict
   □ Go: Static typing

✅ Memory Safety
   □ Rust: Ownership model, zero unsafe
   □ TypeScript/Python: Automatic GC
   □ Go: Garbage collection + bounds checking

✅ Offline-First
   □ Zero mandatory network dependencies
   □ Works in air-gapped environments

✅ Testing
   □ 100% test pass rate
   □ Unit tests
   □ Integration tests (optional for Bronze)

✅ TPCF
   □ Perimeter 3: Community Sandbox
   □ Open contribution model

✅ Dual Licensing
   □ MIT License (code use)
   □ Palimpsest v0.8 (AI training)

✅ Security
   □ SECURITY.md with disclosure process
   □ security.txt (RFC 9116)
   □ Vulnerability scanning

✅ Attribution
   □ MAINTAINERS.md
   □ humans.txt
   □ Git commit history
```

## Essential Commands

### Validation
```bash
just validate              # Full RSR compliance check
just compliance-report     # Detailed compliance report
```

### Development
```bash
just test                  # Run all tests
just build                 # Build project
just lint                  # Run linter
just format                # Format code
just dev                   # Development server
```

### Quality
```bash
just ci                    # Full CI pipeline
just pre-commit            # Pre-commit checks
just security-check        # Security scanning
```

## File Templates

### README.md Header
```markdown
# Project Name

**RSR Compliance**: 🥉 Bronze ✅
**TPCF Perimeter**: 3 (Community Sandbox)
**License**: MIT OR Palimpsest-0.8

## Features

- 🔒 Type Safety
- 🛡️ Memory Safety
- 📴 Offline-First
- 📚 Complete Documentation
```

### security.txt Minimal
```
Contact: security@example.com
Expires: 2026-12-31T23:59:59Z
Canonical: https://example.com/.well-known/security.txt
```

### CHANGELOG.md Entry
```markdown
## [0.1.0] - 2025-11-22

### Added
- Feature description

### Fixed
- Bug fix description
```

## Language-Specific Quick Start

### Rust
```bash
cargo new my-project
cd my-project
# Add to Cargo.toml:
# license = "MIT OR Palimpsest-0.8"
cargo test
```

### TypeScript
```bash
npm init -y
npm install -D typescript @types/node
npx tsc --init --strict
```

### Python
```bash
python -m venv .venv
source .venv/bin/activate  # or .venv\Scripts\activate (Windows)
pip install mypy ruff pytest
```

### Go
```bash
go mod init github.com/user/project
# Create main.go
go test
```

## Common Patterns

### Error Handling (Rust)
```rust
#[derive(Debug)]
enum MyError {
    Io(std::io::Error),
    Parse(String),
}

impl From<std::io::Error> for MyError {
    fn from(e: std::io::Error) -> Self {
        MyError::Io(e)
    }
}
```

### Type Safety (TypeScript)
```typescript
// Branded type
type UserId = string & { readonly __brand: unique symbol };

function createUserId(id: string): UserId {
  return id as UserId;
}
```

### Type Hints (Python)
```python
from typing import TypedDict

class User(TypedDict):
    name: str
    email: str
    age: int
```

## Security Checklist

```
□ No hardcoded secrets
□ Input validation on all external input
□ Parameterized queries (no SQL injection)
□ HTTPS only (if network is used)
□ Dependencies scanned (cargo audit, npm audit, pip-audit)
□ No unsafe code (Rust) or eval (Python)
□ Error messages don't leak sensitive info
□ Rate limiting on APIs
□ CORS configured correctly
□ Security headers set
```

## Testing Standards

```
Bronze:  80%+ coverage
Silver:  90%+ coverage
Gold:    95%+ coverage
```

### Test Structure (AAA Pattern)
```rust
#[test]
fn test_name() {
    // Arrange
    let input = create_test_input();

    // Act
    let result = function_under_test(input);

    // Assert
    assert_eq!(result, expected);
}
```

## Git Workflow

```bash
# Feature branch
git checkout -b feature/my-feature

# Make changes
git add .
git commit -m "feat: add new feature"

# Before pushing
just pre-commit  # Runs format, lint, test

# Push
git push origin feature/my-feature

# Create PR
gh pr create
```

## Commit Message Format

```
<type>(<scope>): <subject>

<body>

<footer>
```

**Types**: feat, fix, docs, style, refactor, test, chore

**Example**:
```
feat(parser): add YAML support

Implement YAML parsing using only stdlib.

Closes #123
```

## CI/CD Integration

### GitHub Actions
```yaml
name: CI
on: [push, pull_request]
jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - run: just ci
```

### GitLab CI
```yaml
test:
  script:
    - just ci
```

## Documentation Standards

### Function Documentation (Rust)
```rust
/// Parses a configuration file.
///
/// # Arguments
///
/// * `path` - Path to config file
///
/// # Returns
///
/// * `Ok(Config)` - Parsed config
/// * `Err(Error)` - Parse error
///
/// # Examples
///
/// ```
/// let config = parse("config.toml")?;
/// ```
pub fn parse(path: &str) -> Result<Config> {
    // ...
}
```

### TSDoc (TypeScript)
```typescript
/**
 * Validates user input.
 *
 * @param input - User input to validate
 * @returns Validation result
 * @throws {ValidationError} If input is invalid
 */
function validate(input: string): boolean {
  // ...
}
```

### Docstring (Python)
```python
def parse(path: str) -> Config:
    """
    Parse configuration file.

    Args:
        path: Path to configuration file

    Returns:
        Parsed configuration object

    Raises:
        ValueError: If file format is invalid
    """
```

## Troubleshooting

| Problem | Solution |
|---------|----------|
| `just: command not found` | `cargo install just` |
| Tests failing | `just test -- --nocapture` (Rust)<br>`npm test` (TS)<br>`pytest -v` (Python) |
| Linter errors | `just format` then `just lint` |
| Type errors | Enable strict mode, add type annotations |
| Build errors | Check dependencies, update toolchain |

## Resources

- **Guides**: [docs/guides/](../guides/)
- **Examples**: [examples/](../../examples/)
- **Roadmap**: [ROADMAP.md](../../ROADMAP.md)
- **Getting Started**: [GETTING-STARTED.md](../../GETTING-STARTED.md)

## Quick Links

- [RSR Framework](https://github.com/hyperpolymath/rhodium-minimal)
- [Palimpsest License](../../LICENSE.txt)
- [RFC 9116](https://www.rfc-editor.org/rfc/rfc9116.html)
- [Contributor Covenant](https://www.contributor-covenant.org/)

---

**Version**: 1.0 | **Last Updated**: 2025-11-22 | **License**: MIT OR Palimpsest-0.8
