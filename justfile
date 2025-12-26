# SPDX-License-Identifier: MIT OR Apache-2.0
# SPDX-FileCopyrightText: 2025 Jonathan D.A. Jewell
#
# ZoteRho-template - ReScript + Deno Development Tasks
# Hyperpolymath Rhodium Standard Compliant

set shell := ["bash", "-uc"]
set dotenv-load := true
set positional-arguments := true

project := "zoterho-template"
version := "2.0.0"
tier := "plugin"
target_version := "2.0"

# --- Default & Help ---

# Show all recipes
default:
    @just --list --unsorted

# Show detailed help
help:
    @echo "ZoteRho-template Development Tasks"
    @echo ""
    @echo "Build Commands:"
    @echo "  build         - Build ReScript to JavaScript"
    @echo "  build-clean   - Clean and rebuild"
    @echo "  watch         - Watch mode for development"
    @echo "  clean         - Clean build artifacts"
    @echo ""
    @echo "Quality Commands:"
    @echo "  fmt           - Format ReScript code"
    @echo "  lint          - Run linter"
    @echo "  validate      - Run mustfile validations"
    @echo ""
    @echo "Packaging:"
    @echo "  package       - Create XPI package"
    @echo "  compile-nickel - Compile Nickel configs to JSON"
    @echo ""
    @echo "Deployment:"
    @echo "  must          - Run full must deployment flow"

# Project info
info:
    @echo "Project: {{project}}"
    @echo "Version: {{version}}"
    @echo "Tier: {{tier}}"

# --- Build & Compile (Deno-based) ---

# Build ReScript to JavaScript
build:
    @echo "Building ReScript source..."
    deno run --allow-run --allow-read --allow-write npm:rescript build

# Clean and rebuild
build-clean:
    @echo "Clean building ReScript..."
    deno run --allow-run --allow-read --allow-write npm:rescript build -clean-world

# Watch mode for development
watch:
    @echo "Starting watch mode..."
    deno run --allow-run --allow-read --allow-write npm:rescript build -w

# Clean build artifacts
clean:
    @echo "Cleaning build artifacts..."
    deno run --allow-run --allow-read --allow-write npm:rescript clean
    rm -rf build/
    rm -rf lib/
    rm -f src-{{target_version}}/manifest.json
    rm -f src-{{target_version}}/updates-{{target_version}}.json

# --- Quality ---

# Format ReScript code
fmt:
    @echo "Formatting ReScript code..."
    deno run --allow-run --allow-read --allow-write npm:rescript format -all

# Run linter
lint:
    @echo "Running Deno linter..."
    deno lint --ignore=node_modules,lib,build || true

# Run all quality checks
quality: fmt lint validate
    @echo "All quality checks passed!"

# --- Nickel Configuration ---

# Compile Nickel manifest to JSON
compile-nickel:
    @echo "Compiling Nickel configurations..."
    @if command -v nickel >/dev/null 2>&1; then \
        if [ -f config/manifest.ncl ]; then \
            nickel export --format json config/manifest.ncl -o src-{{target_version}}/manifest.json; \
            echo "Generated manifest.json"; \
        fi; \
        if [ -f config/updates.ncl ]; then \
            nickel export --format json config/updates.ncl -o src-{{target_version}}/updates-{{target_version}}.json; \
            echo "Generated updates.json"; \
        fi; \
    else \
        echo "nickel not installed - skipping config compilation"; \
    fi

# Validate Nickel configurations
validate-nickel:
    @echo "Validating Nickel configurations..."
    @if command -v nickel >/dev/null 2>&1; then \
        for f in config/*.ncl; do \
            if [ -f "$$f" ]; then \
                nickel typecheck "$$f" && echo "Valid: $$f"; \
            fi; \
        done; \
    else \
        echo "nickel not installed - skipping validation"; \
    fi

# --- Package ---

# Create XPI package
package: build compile-nickel
    @echo "Creating XPI package..."
    @mkdir -p build
    @cd src-{{target_version}} && zip -r ../build/zoterho-template-{{target_version}}.xpi . \
        -x "*.ts" -x "*.tsx" -x "*.res" -x "*.resi" -x ".git/*" -x "node_modules/*"
    @echo "Package created: build/zoterho-template-{{target_version}}.xpi"

# Generate update JSON with hash
generate-update-json:
    @echo "Generating update JSON..."
    @if [ -f build/zoterho-template-{{target_version}}.xpi ]; then \
        XPI_HASH=$$(sha256sum build/zoterho-template-{{target_version}}.xpi | awk '{print $$1}'); \
        echo "SHA256: $$XPI_HASH"; \
        if command -v nickel >/dev/null 2>&1 && [ -f config/updates.ncl ]; then \
            nickel export --format json \
                --field 'version' '"{{target_version}}"' \
                --field 'hash' "\"sha256:$$XPI_HASH\"" \
                config/updates.ncl \
                -o build/updates-{{target_version}}.json; \
        fi; \
    else \
        echo "Error: XPI file not found. Run 'just package' first."; \
        exit 1; \
    fi

# --- Validation & Deployment ---

# Run mustfile validations
validate:
    @echo "Running MUST validations..."
    ./mustfile validate

# Run full must deployment
must:
    ./mustfile build

# Pre-commit checks
pre-commit: quality
    @echo "Pre-commit checks passed!"

# --- Dependencies ---

# Install Deno dependencies
deps:
    @echo "Caching Deno dependencies..."
    deno cache --reload deno.json

# Audit dependencies
deps-audit:
    @echo "Auditing dependencies..."
    deno run --allow-read --allow-net npm:audit || true

# --- Development Setup ---

# Setup development environment
setup:
    @echo "Setting up development environment..."
    @if ! command -v deno >/dev/null 2>&1; then \
        echo "Deno not found. Install from https://deno.land/"; \
        exit 1; \
    fi
    @if ! command -v just >/dev/null 2>&1; then \
        echo "just not found. Install from https://just.systems/"; \
        exit 1; \
    fi
    @echo "Installing Deno dependencies..."
    deno cache deno.json || true
    @echo "Setup complete!"

# --- CI/CD ---

# Full CI pipeline
ci: setup quality build validate
    @echo "CI pipeline complete!"
