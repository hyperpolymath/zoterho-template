;;; STATE.scm --- ZoteRho-template conversation checkpoint
;;; Format: Guile Scheme S-expressions
;;; Schema: RSR STATE v2.0

(define-module (zoterho-template state)
  #:export (state))

(define state
  `((metadata
     (format-version . "2.0")
     (schema-version . "2025-12-17")
     (project . "ZoteRho-template")
     (created . "2025-12-10T19:03:55+00:00")
     (updated . "2025-12-17T00:00:00+00:00"))

    (position
     (summary . "RSR-compliant Zotero 7+ plugin template")
     (phase . implementation)
     (maturity . alpha)
     (rsr-tier . infrastructure)
     (primary-language . "rescript")
     (secondary-languages . ("guile" "typescript"))
     (domain . "Zotero Plugin Development"))

    (context
     (last-session . "2025-12-17")
     (focus-area . "SCM security review and roadmap update")
     (blockers . ())
     (decisions-pending . ("npm-to-deno-conversion" "typescript-to-rescript-migration")))

    (implementations
     ((name . "Initial setup")
      (status . complete)
      (files . ())
      (notes . "Project scaffolding"))
     ((name . "SCM files")
      (status . complete)
      (files . ("META.scm" "ECOSYSTEM.scm" "STATE.scm" "guix.scm"))
      (notes . "Valid Guile Scheme syntax"))
     ((name . "Security files")
      (status . complete)
      (files . (".well-known/security.txt" ".well-known/ai.txt" ".well-known/provenance.json"))
      (notes . "RFC 9116 compliant, placeholders resolved"))
     ((name . "ReScript core")
      (status . complete)
      (files . ("bootstrap.res" "ZoteRhoTemplate.res" "RhodiumColorizer.res"))
      (notes . "Core Zotero 7+ bootstrap implemented")))

    (issues
     (active
      ((id . "npm-removal")
       (description . "Remove npm dependency from Justfile setup")
       (priority . high))
      ((id . "ts-migration")
       (description . "Migrate src-2.0/*.ts to ReScript")
       (priority . medium)))
     (resolved
      ((id . "scm-syntax")
       (description . "Fixed invalid Scheme syntax in META.scm and ECOSYSTEM.scm")
       (resolved-date . "2025-12-17"))
      ((id . "security-placeholders")
       (description . "Replaced template placeholders in security.txt, provenance.json, humans.txt")
       (resolved-date . "2025-12-17")))
     (known-limitations
      ("Node build system in guix.scm needs updating to Deno"))
     (technical-debt
      ("Legacy TypeScript in src-2.0/"
       "npm references in Justfile")))

    (roadmap
     (current-version . "0.1.0")
     (next-milestone . "MVP")
     (version-plan
      ;; v0.2.0 - Package Manager Migration
      ((version . "0.2.0")
       (target . "2025-Q1")
       (theme . "Package Manager Migration")
       (features
        ("Create deno.json configuration"
         "Update Justfile to use deno task"
         "Remove npm dependencies"
         "Update guix.scm to use deno build system")))
      ;; v0.3.0 - Language Migration
      ((version . "0.3.0")
       (target . "2025-Q2")
       (theme . "TypeScript to ReScript Migration")
       (features
        ("Convert src-2.0/bootstrap.ts to ReScript"
         "Convert src-2.0/make-it-red.ts to ReScript"
         "Remove legacy TypeScript files"
         "Update CI for ReScript-only validation")))
      ;; v0.4.0 - Containerization
      ((version . "0.4.0")
       (target . "2025-Q2")
       (theme . "Reproducible Builds")
       (features
        ("Create Containerfile for reproducible builds"
         "Add flake.nix for Nix users"
         "Implement Sigstore attestation"
         "Add SBOM generation")))
      ;; v1.0.0 - Stable Release
      ((version . "1.0.0")
       (target . "2025-Q3")
       (theme . "Stable Release")
       (features
        ("Full RSR Gold compliance"
         "Comprehensive test coverage (70%+)"
         "Published to Zotero plugin registry"
         "Complete documentation")))))

    (ecosystem
     (part-of . ("RSR Framework" "hyperpolymath"))
     (depends-on . ("Zotero 7+"))
     (integrates-with . ("rhodium-standard-repositories"))
     (supersedes . ()))

    (session-files
     ("META.scm" "ECOSYSTEM.scm" "STATE.scm"
      ".well-known/security.txt" ".well-known/provenance.json" ".well-known/humans.txt"))

    (notes
     "2025-12-17: SCM files reviewed and fixed for valid Guile Scheme syntax. "
     "Security files updated with proper values instead of placeholders. "
     "Roadmap expanded with detailed version plan through v1.0.0.")))
