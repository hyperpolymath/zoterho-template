#!/bin/bash
# RSR Project Initialization Script
# Usage: ./scripts/init-rsr-project.sh <project-name> <language>

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TEMPLATE_ROOT="$(dirname "$SCRIPT_DIR")"

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

print_success() {
    echo -e "${GREEN}✅ $1${NC}"
}

print_info() {
    echo -e "${BLUE}ℹ️  $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

print_error() {
    echo -e "${RED}❌ $1${NC}"
}

# Check arguments
if [ $# -lt 2 ]; then
    echo "Usage: $0 <project-name> <language>"
    echo ""
    echo "Languages: rust, typescript, python, go"
    echo ""
    echo "Example: $0 my-app rust"
    exit 1
fi

PROJECT_NAME=$1
LANGUAGE=$2
PROJECT_DIR="$(pwd)/$PROJECT_NAME"

# Validate language
case "$LANGUAGE" in
    rust|typescript|python|go)
        ;;
    *)
        print_error "Invalid language: $LANGUAGE"
        echo "Valid options: rust, typescript, python, go"
        exit 1
        ;;
esac

print_info "Initializing RSR-compliant $LANGUAGE project: $PROJECT_NAME"
echo ""

# Check if directory exists
if [ -d "$PROJECT_DIR" ]; then
    print_error "Directory already exists: $PROJECT_DIR"
    exit 1
fi

# Create project directory
mkdir -p "$PROJECT_DIR"
print_success "Created directory: $PROJECT_DIR"

# Copy RSR documentation files
print_info "Copying RSR documentation..."
cp "$TEMPLATE_ROOT/LICENSE.txt" "$PROJECT_DIR/"
cp "$TEMPLATE_ROOT/SECURITY.md" "$PROJECT_DIR/"
cp "$TEMPLATE_ROOT/CONTRIBUTING.md" "$PROJECT_DIR/"
cp "$TEMPLATE_ROOT/CODE_OF_CONDUCT.md" "$PROJECT_DIR/"
cp "$TEMPLATE_ROOT/MAINTAINERS.md" "$PROJECT_DIR/"
cp "$TEMPLATE_ROOT/CHANGELOG.md" "$PROJECT_DIR/"
print_success "Copied documentation files"

# Copy .well-known directory
print_info "Copying .well-known/ directory..."
cp -r "$TEMPLATE_ROOT/.well-known" "$PROJECT_DIR/"
print_success "Copied .well-known/ directory"

# Copy build automation
print_info "Copying build automation..."
cp "$TEMPLATE_ROOT/justfile" "$PROJECT_DIR/"
cp "$TEMPLATE_ROOT/.editorconfig" "$PROJECT_DIR/"
cp "$TEMPLATE_ROOT/.gitattributes" "$PROJECT_DIR/"
print_success "Copied build files"

# Copy language-specific example
print_info "Copying $LANGUAGE example..."
case "$LANGUAGE" in
    rust)
        cp -r "$TEMPLATE_ROOT/examples/rust-minimal/"* "$PROJECT_DIR/"
        ;;
    typescript)
        cp -r "$TEMPLATE_ROOT/examples/typescript-minimal/"* "$PROJECT_DIR/"
        ;;
    python)
        cp -r "$TEMPLATE_ROOT/examples/python-minimal/"* "$PROJECT_DIR/"
        ;;
    go)
        cp -r "$TEMPLATE_ROOT/examples/go-minimal/"* "$PROJECT_DIR/"
        ;;
esac
print_success "Copied $LANGUAGE example code"

# Create README
print_info "Creating README.md..."
cat > "$PROJECT_DIR/README.md" << EOF
# $PROJECT_NAME

**RSR Compliance Level**: 🥉 Bronze ✅
**TPCF Perimeter**: 3 (Community Sandbox)
**Language**: $LANGUAGE

## Features

- 🔒 **Type Safety**: Strong typing throughout
- 🛡️ **Memory Safety**: Safe memory management
- 📴 **Offline-First**: No mandatory network dependencies
- 📚 **Complete Documentation**: All RSR-required files
- 🤝 **TPCF Perimeter 3**: Open community contribution
- ⚖️ **Dual Licensed**: MIT + Palimpsest v0.8

## Quick Start

\`\`\`bash
# Build
just build

# Run tests
just test

# Validate RSR compliance
just validate
\`\`\`

## RSR Compliance

This repository meets all Bronze RSR requirements:

- ✅ Documentation (7 files)
- ✅ .well-known/ (3 files)
- ✅ Build automation (justfile)
- ✅ Type safety
- ✅ Memory safety
- ✅ Offline-first
- ✅ Testing
- ✅ TPCF Perimeter 3
- ✅ Dual licensing
- ✅ Security policies
- ✅ Attribution

## License

Dual-licensed under MIT + Palimpsest v0.8. See [LICENSE.txt](LICENSE.txt).
EOF
print_success "Created README.md"

# Initialize git
cd "$PROJECT_DIR"
print_info "Initializing git repository..."
git init
git add .
git commit -m "Initial RSR-compliant project setup

Project: $PROJECT_NAME
Language: $LANGUAGE
RSR Level: Bronze

Generated using zoterho-template initialization script."
print_success "Git repository initialized"

# Final instructions
echo ""
echo "═══════════════════════════════════════════"
print_success "RSR project initialized successfully!"
echo "═══════════════════════════════════════════"
echo ""
print_info "Next steps:"
echo ""
echo "  1. cd $PROJECT_NAME"
echo "  2. just validate      # Verify RSR compliance"
echo "  3. just test          # Run tests"
echo "  4. Start coding!"
echo ""
print_info "Customize these files:"
echo "  - README.md           # Update project description"
echo "  - .well-known/security.txt  # Add your contact info"
echo "  - MAINTAINERS.md      # Add yourself as maintainer"
echo ""
print_info "Resources:"
echo "  - Getting Started: $TEMPLATE_ROOT/GETTING-STARTED.md"
echo "  - Language Guide: $TEMPLATE_ROOT/docs/guides/$LANGUAGE-implementation.md"
echo "  - Testing Guide: $TEMPLATE_ROOT/docs/guides/testing-best-practices.md"
echo ""
echo "═══════════════════════════════════════════"
print_success "Happy coding! 🚀"
echo "═══════════════════════════════════════════"
