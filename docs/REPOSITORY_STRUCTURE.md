# Recommended Repository Structure

Target structure for a mature Flutter open-source project:

```text
campus_connect/
  lib/
    models/
    providers/
    screens/
    services/
    utils/
    widgets/
  test/
  docs/
    images/
  assets/
  scripts/
  .github/
    ISSUE_TEMPLATE/
    workflows/
  README.md
  CONTRIBUTING.md
  CODE_OF_CONDUCT.md
  SECURITY.md
  GOVERNANCE.md
  AI_USAGE_POLICY.md
  CHANGELOG.md
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
