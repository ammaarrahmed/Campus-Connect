# GitHub Admin Setup (Owner Checklist)

This file documents the recommended repository settings for `ammaarrahmed/Campus-Connect`.

## Branch Protection: `main`

Configure in GitHub: `Settings` -> `Branches` -> `Add branch protection rule`.

Recommended rule values:

- Branch name pattern: `main`
- Require a pull request before merging: enabled
- Required approvals: `1`
- Dismiss stale pull request approvals when new commits are pushed: enabled
- Require review from Code Owners: enabled
- Require conversation resolution before merging: enabled
- Require status checks to pass before merging: enabled
- Require branches to be up to date before merging: enabled
- Restrict who can push to matching branches: maintainers only
- Allow force pushes: disabled
- Allow deletions: disabled
- Require linear history: enabled
- Require signed commits: enabled

## Required Status Checks

Add these checks in the branch protection rule:

- `Flutter CI / quality`
- `PR Validation / Conventional Commits Check`
- `PR Validation / Lint and Format Check`
- `Dependency Audit / dependency-review`

Optional additional required check:

- `Dependency Audit / pub-outdated`

## Pull Request Defaults

Set in `Settings` -> `General` -> `Pull Requests`:

- Allow squash merging: enabled
- Allow merge commits: disabled
- Allow rebase merging: optional
- Default to pull request title and description for squash commit messages
- Automatically delete head branches: enabled

## Repository Security

Set in `Settings` -> `Security`:

- Dependency graph: enabled
- Dependabot alerts: enabled
- Dependabot security updates: enabled
- Secret scanning (if available): enabled
- Push protection for secrets (if available): enabled

## Discussions and Community

Optional but recommended:

- Enable GitHub Discussions for design/usage Q&A.
- Keep issues for actionable work; move broad questions to Discussions.

## Owner Notes

- Current primary maintainer: `@ammaarrahmed`
- Security contact: `ammaarlatif53@gmail.com`
- Funding is intentionally disabled for now (`.github/FUNDING.yml`).
