# Getting Started with RSR-Compliant Development

**Welcome to the Rhodium Standard Repository (RSR) Template!**

This guide will get you up and running with RSR-compliant development in 15 minutes.

## Table of Contents

- [What is RSR?](#what-is-rsr)
- [Quick Start (5 Minutes)](#quick-start-5-minutes)
- [Language Selection](#language-selection)
- [Development Environment](#development-environment)
- [Your First RSR Project](#your-first-rsr-project)
- [Next Steps](#next-steps)

---

## What is RSR?

RSR (Rhodium Standard Repository) is a framework for creating **politically autonomous**, **ethically sound**, and **technically excellent** software projects.

### Core Principles

1. **🔒 Type Safety** - Prevent bugs with strong typing
2. **🛡️ Memory Safety** - Avoid crashes and security vulnerabilities
3. **📴 Offline-First** - Works without network dependencies
4. **📚 Complete Documentation** - All stakeholders informed
5. **🤝 TPCF Governance** - Transparent community collaboration
6. **⚖️ Dual Licensing** - MIT + Palimpsest (ethical AI training)

### Compliance Levels

- **🥉 Bronze** - Essential compliance (this template)
- **🥈 Silver** - Advanced features + security hardening
- **🥇 Gold** - Formal verification + zero dependencies
- **💎 Platinum** - Research-grade + academic publications

---

## Quick Start (5 Minutes)

### Option 1: Use This Template (GitHub)

```bash
# Click "Use this template" on GitHub, then:
git clone https://github.com/YOUR-USERNAME/your-project
cd your-project

# Validate RSR compliance
just validate

# You're ready to code!
```

### Option 2: Manual Setup

```bash
# Clone the template
git clone https://github.com/Hyperpolymath/zoterho-template
cd zoterho-template

# Copy files to your project
cp -r examples/rust-minimal/* /path/to/your-project/  # or other language
cp README.md LICENSE.txt SECURITY.md /path/to/your-project/
cp -r .well-known /path/to/your-project/
cp justfile /path/to/your-project/

# Initialize your project
cd /path/to/your-project
git init
git add .
git commit -m "Initial RSR-compliant project"
```

### Option 3: Dev Container (One-Click)

```bash
# Open in GitHub Codespaces or VS Code with Dev Containers
# Everything is pre-configured!

# Once inside:
just validate  # ✅ Ready to go!
```

---

## Language Selection

Choose your language and follow its guide:

### 🦀 Rust
**Best for**: Systems programming, CLI tools, high-performance apps

```bash
cd examples/rust-minimal
cargo build
cargo test
```

**Guide**: [docs/guides/rust-implementation.md](docs/guides/rust-implementation.md)

### 📘 TypeScript
**Best for**: Web apps, Node.js services, full-stack development

```bash
cd examples/typescript-minimal
npm install  # dev dependencies only
npm run build
npm test
```

**Guide**: [docs/guides/typescript-implementation.md](docs/guides/typescript-implementation.md)

### 🐍 Python
**Best for**: Data science, automation, rapid prototyping

```bash
cd examples/python-minimal
python -m yaml_validator example.yaml
pytest
```

**Guide**: [docs/guides/python-implementation.md](docs/guides/python-implementation.md)

### 🐹 Go
**Best for**: Cloud-native apps, microservices, distributed systems

```bash
cd examples/go-minimal
go build
go test
go run main.go example.ini
```

**Guide**: Coming soon!

---

## Development Environment

### Prerequisites

**Install these tools:**

| Tool | Purpose | Install |
|------|---------|---------|
| **Git** | Version control | [git-scm.com](https://git-scm.com/) |
| **just** | Build automation | [github.com/casey/just](https://github.com/casey/just) |
| **Your language runtime** | Rust/Node/Python/Go | See language guides |
| **VS Code** (optional) | IDE | [code.visualstudio.com](https://code.visualstudio.com/) |

### VS Code Setup (Recommended)

1. **Install VS Code**
2. **Open the template folder**
3. **Install recommended extensions** (VS Code will prompt you)
4. **Start coding!**

**Included configurations:**
- ✅ Auto-formatting on save
- ✅ Linting and type checking
- ✅ Debug configurations
- ✅ Test runners
- ✅ RSR-specific snippets

### Command-Line Setup

```bash
# Install just
cargo install just
# or: brew install just (macOS)
# or: choco install just (Windows)

# Verify installation
just --version
```

---

## Your First RSR Project

Let's create an RSR-compliant project from scratch!

### Step 1: Choose Your Language

We'll use **Rust** as an example (adapt for your language):

```bash
# Create new Rust project
cargo new my-rsr-app
cd my-rsr-app
```

### Step 2: Copy RSR Files

```bash
# Copy documentation
cp /path/to/zoterho-template/README.md .
cp /path/to/zoterho-template/LICENSE.txt .
cp /path/to/zoterho-template/SECURITY.md .
cp /path/to/zoterho-template/CONTRIBUTING.md .
cp /path/to/zoterho-template/CODE_OF_CONDUCT.md .
cp /path/to/zoterho-template/MAINTAINERS.md .
cp /path/to/zoterho-template/CHANGELOG.md .

# Copy .well-known directory
cp -r /path/to/zoterho-template/.well-known .

# Copy build automation
cp /path/to/zoterho-template/justfile .

# Copy editor config
cp /path/to/zoterho-template/.editorconfig .
```

### Step 3: Customize for Your Project

**Update `README.md`:**
```markdown
# My RSR App

**RSR Compliance**: 🥉 Bronze ✅
**Language**: Rust

## Description
[Your app description here]
```

**Update `Cargo.toml`:**
```toml
[package]
name = "my-rsr-app"
version = "0.1.0"
edition = "2021"
license = "MIT OR Palimpsest-0.8"
description = "My RSR-compliant application"
```

**Update `.well-known/security.txt`:**
```
Contact: your-email@example.com
```

### Step 4: Write Your Code

```rust
// src/main.rs
fn main() {
    println!("Hello, RSR!");
}

#[cfg(test)]
mod tests {
    #[test]
    fn test_basic() {
        assert_eq!(2 + 2, 4);
    }
}
```

### Step 5: Validate Compliance

```bash
# Run validation
just validate

# Should output:
# ✅ All 7 documentation files present
# ✅ All 3 .well-known/ files present
# ✅ Build automation configured
# ✅ RSR Bronze compliance verified!
```

### Step 6: Commit and Push

```bash
git add .
git commit -m "Initial RSR-compliant project setup"
git push origin main
```

**🎉 You're done! You have an RSR-compliant project!**

---

## Common Workflows

### Running Tests

```bash
# Rust
just test
# or: cargo test

# TypeScript
npm test

# Python
pytest

# Go
go test
```

### Building for Production

```bash
# Rust
just build
# or: cargo build --release

# TypeScript
npm run build

# Python
python -m build  # if using setuptools

# Go
go build -ldflags="-s -w"
```

### Code Quality Checks

```bash
# Run all checks (format, lint, test, build)
just ci

# Individual checks
just format    # Format code
just lint      # Run linter
just test      # Run tests
```

### Security Scanning

```bash
# Check dependencies for vulnerabilities
just security-check

# Rust: cargo audit
# TypeScript: npm audit
# Python: pip-audit
# Go: govulncheck
```

---

## Troubleshooting

### Issue: `just: command not found`

**Solution**: Install just
```bash
cargo install just
# or follow: https://github.com/casey/just#installation
```

### Issue: RSR validation fails

**Solution**: Check which files are missing
```bash
just validate

# Add missing files from the template
cp /path/to/zoterho-template/SECURITY.md .
# ... etc
```

### Issue: Tests fail

**Solution**: Check test output
```bash
# Rust - verbose output
cargo test -- --nocapture

# TypeScript
npm test

# Python - verbose
pytest -v
```

### Issue: Can't find language-specific tools

**Solutions**:

**Rust**: Install via [rustup.rs](https://rustup.rs/)
```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```

**Node.js/TypeScript**: Install via [nodejs.org](https://nodejs.org/)
```bash
# Install Node 20 LTS
nvm install 20  # if using nvm
```

**Python**: Install via [python.org](https://python.org/)
```bash
# Install Python 3.11+
pyenv install 3.11  # if using pyenv
```

**Go**: Install via [go.dev](https://go.dev/)
```bash
# Download and install from go.dev/dl
```

---

## Next Steps

### Learn More

📖 **Implementation Guides** (Choose your language):
- [Rust Implementation Guide](docs/guides/rust-implementation.md)
- [TypeScript Implementation Guide](docs/guides/typescript-implementation.md)
- [Python Implementation Guide](docs/guides/python-implementation.md)

📖 **Best Practices**:
- [Testing Best Practices](docs/guides/testing-best-practices.md)
- [Security Hardening Guide](docs/guides/security-hardening.md)
- [Migration Guide](docs/guides/migration-guide.md)

### Explore Examples

```bash
# Check out working examples
cd examples/rust-minimal && cargo test
cd examples/typescript-minimal && npm test
cd examples/python-minimal && pytest
cd examples/go-minimal && go test
```

### Join the Community

- **GitHub Discussions**: [Ask questions](https://github.com/Hyperpolymath/zoterho-template/discussions)
- **Issues**: [Report bugs](https://github.com/Hyperpolymath/zoterho-template/issues)
- **Contributing**: See [CONTRIBUTING.md](CONTRIBUTING.md)

### Advance Your Compliance Level

**Current**: 🥉 Bronze

**Next**: 🥈 Silver
- Add GitHub Actions workflows
- Implement Nix flake for reproducible builds
- Add comprehensive benchmarks
- Set up security scanning

See [ROADMAP.md](ROADMAP.md) for the full progression path.

---

## Quick Reference

### Essential Commands

```bash
just validate          # Check RSR compliance
just test             # Run tests
just build            # Build project
just lint             # Run linter
just format           # Format code
just ci               # Full CI pipeline
just security-check   # Security scanning
```

### Directory Structure

```
my-rsr-project/
├── src/              # Source code
├── tests/            # Tests
├── .well-known/      # RFC 9116 compliance
├── README.md         # Project overview
├── LICENSE.txt       # Dual license
├── SECURITY.md       # Security policy
├── CONTRIBUTING.md   # Contribution guide
├── CODE_OF_CONDUCT.md
├── MAINTAINERS.md
├── CHANGELOG.md
└── justfile          # Build automation
```

### Getting Help

1. Check the [guides](docs/guides/)
2. Review [examples](examples/)
3. Read the [README](README.md)
4. Open an [issue](https://github.com/Hyperpolymath/zoterho-template/issues)

---

## Success Stories

*"RSR helped us ship a type-safe, secure CLI tool in 2 days with 95% test coverage"* - Example User

*"The dual licensing made our AI training policies crystal clear"* - Another User

---

## Support

- 📧 **Email**: See [MAINTAINERS.md](MAINTAINERS.md)
- 🔒 **Security**: See [.well-known/security.txt](.well-known/security.txt)
- 💬 **Community**: [GitHub Discussions](https://github.com/Hyperpolymath/zoterho-template/discussions)

---

**Ready to build something awesome? Let's go! 🚀**

*Happy coding! - The RSR Community*
