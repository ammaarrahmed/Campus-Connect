# Contributing to Campus Connect

Thank you for your interest in improving Campus Connect.

This project is transitioning from a personal app to a community-maintained open-source project. We optimize for respectful collaboration, reviewable changes, and predictable release quality.

## Before You Start

- Read `README.md` for project context and architecture.
- Read `CODE_OF_CONDUCT.md`.
- Read `AI_USAGE_POLICY.md` if using AI tools.
- Check open issues labeled `good first issue` or `help wanted`.

## Development Environment Setup

1. Fork the repository and clone your fork.
2. Create a branch from `main`.
3. Install Flutter and platform tooling.
4. Configure Firebase and environment files.
5. Install dependencies and run checks.

```bash
git clone https://github.com/ammaarrahmed/Campus-Connect.git
cd Campus-Connect
flutter pub get
dart format --output=none --set-exit-if-changed .
flutter analyze --no-fatal-infos
flutter test
```

Detailed setup is documented in `docs/LOCAL_DEVELOPMENT.md`.

## Branching Strategy

- `main`: protected, always releasable.
- `feature/<short-name>`: new features.
- `fix/<short-name>`: bug fixes.
- `docs/<short-name>`: documentation-only work.
- `chore/<short-name>`: maintenance and tooling.
- `release/<version>`: optional release preparation branches.

Keep branches focused. One logical change per PR.

## Commit Convention (Required)

This repository uses Conventional Commits and validates them in CI.

Format:

```text
<type>(optional-scope): <short summary>
```

Allowed common types:

- `feat`: new feature
- `fix`: bug fix
- `docs`: documentation
- `refactor`: code restructure with no behavior change
- `test`: test additions/changes
- `chore`: maintenance
- `ci`: CI/CD changes
- `build`: build/dependency updates
- `perf`: performance improvements

Examples:

- `feat: add post upvoting`
- `fix(auth): restrict login to FAST domains`
- `docs: update local development guide`
- `ci: add dependency review workflow`

## Signed Commits Policy

Signed commits are strongly recommended and expected for maintainers.

### Option A: GPG Signed Commits

```bash
git config --global user.signingkey <your-gpg-key-id>
git config --global commit.gpgsign true
```

### Option B: SSH Signing (Git 2.34+)

```bash
git config --global gpg.format ssh
git config --global user.signingkey ~/.ssh/id_ed25519.pub
git config --global commit.gpgsign true
```

### Option C: GitHub Verified Web Commits

If you use the GitHub UI, GitHub can mark commits as verified by default.

Maintainers may request re-signing if commit provenance is unclear.

## Coding Conventions

- Use null-safe Dart idioms and explicit typing where practical.
- Follow lints in `analysis_options.yaml`.
- Prefer small, composable widgets over monolithic screens.
- Keep providers and services testable.
- Avoid unrelated refactors in feature/fix PRs.

## Pull Request Workflow

1. Sync your branch with `main`.
2. Ensure quality checks pass locally.
3. Push your branch and open a PR to `main`.
4. Fill out the PR template completely.
5. Address reviewer feedback promptly.

### PR Requirements

- Conventional commit history
- Passing CI checks
- Updated tests for behavior changes
- Updated docs for API, setup, or behavior changes
- Screenshots for UI changes

## Testing

Run these commands before requesting review:

```bash
dart format --output=none --set-exit-if-changed .
flutter analyze --no-fatal-infos
flutter test
```

If tests are not possible for a change, explain why in the PR.

## Reporting Bugs

Use the bug template in `.github/ISSUE_TEMPLATE/bug_report.md` and include:

- Reproduction steps
- Expected vs actual behavior
- Device/platform details
- Logs or screenshots

## Proposing Features

Use `.github/ISSUE_TEMPLATE/feature_request.md` and include:

- Problem statement
- Proposed solution
- Alternatives considered
- Scope and impact

## Questions and Discussions

Use `.github/ISSUE_TEMPLATE/question.md` for usage or design questions.

## Code Review Expectations

Reviewers prioritize:

- Correctness and regressions
- Security/privacy implications
- Test quality and coverage impact
- Readability and maintainability

Authors should:

- Keep discussion technical and respectful
- Respond with code updates or rationale
- Mark conversations resolved only after addressing feedback

## First-Time Contributor Path

1. Pick an issue labeled `good first issue`.
2. Comment on the issue to claim it.
3. Ask clarifying questions early.
4. Open a draft PR quickly for feedback.

## Security

Do not report security vulnerabilities in public issues.

See `SECURITY.md` for responsible disclosure instructions.
