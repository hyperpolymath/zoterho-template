# TypeScript/JavaScript to ReScript Migration - COMPLETE

This repository has been fully migrated to ReScript. All TypeScript files have been removed.

## Migration Status: COMPLETE

- All TypeScript files in `src-1.0/`, `src-1.1/`, `src-1.2/`, and `src-2.0/` have been deleted
- ReScript equivalents exist in the root directory:
  - `ZoteRhoTemplate.res` - Core plugin functionality
  - `bootstrap.res` - Plugin entry point
  - `RhodiumColorizer.res` - Color manipulation utilities

## Policy Enforcement

The following mechanisms prevent regression:

1. **CI Workflow**: `.github/workflows/ts-blocker.yml` blocks:
   - New TypeScript/TSX files
   - New raw JavaScript files (except `.res.js` output)
   - New Makefiles
   - Package manager lockfiles (npm, yarn, pnpm, bun)
   - Go files

2. **Mustfile Validation**: `./mustfile validate` checks policy compliance locally

3. **gitignore**: Banned files are listed in `.gitignore`

## Development

Use ReScript for all new code:

```bash
# Build
just build

# Watch mode
just watch

# Format
just fmt

# Validate policy
just validate
```

## Package Management

This project uses **Deno** (not npm/bun/yarn/pnpm):

```bash
# Install dependencies
just deps

# Run via Deno
deno run --allow-run npm:rescript build
```
