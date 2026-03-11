# Recommended Repository Structure

Target structure for a mature Flutter open-source project:

```text
campus_connect/
  lib/
    app/
    features/
    shared/
    models/
    providers/
    services/
    utils/
  test/
  docs/
    AI_USAGE_POLICY.md
    CHANGELOG.md
    CODE_OF_CONDUCT.md
    CONTRIBUTING.md
    FEATURES.md
    GOVERNANCE.md
    ROADMAP.md
    SECURITY.md
    images/
  assets/
  scripts/
  .github/
    ISSUE_TEMPLATE/
    workflows/
  README.md
  LICENSE
```

## Directory Purpose

- `lib/`: production Flutter source code
- `test/`: unit, widget, and integration tests
- `docs/`: contributor and architecture documentation
- `assets/`: static assets checked into source control
- `scripts/`: helper scripts for local and CI automation
- `.github/`: templates, automation, and community health files

## Scaling Guidance

As the app grows, consider:

- `packages/` for shared internal Dart packages
- `integration_test/` for end-to-end test suites
- `docs/adr/` for architecture decision records
