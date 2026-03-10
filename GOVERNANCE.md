# Governance

## Project Roles

## Maintainers

Maintainers are responsible for project direction, release quality, and community safety.

Responsibilities:

- Triage issues and pull requests
- Review and merge contributions
- Enforce code quality and security practices
- Maintain CI/CD and release process
- Steward roadmap and architecture decisions

## Reviewers

Trusted contributors may be invited to review PRs in specific areas.

Responsibilities:

- Provide constructive technical feedback
- Flag regressions, risk, and missing tests
- Help new contributors succeed

## Contributors

Anyone submitting issues, docs, tests, or code improvements.

Responsibilities:

- Follow `CONTRIBUTING.md`
- Follow `CODE_OF_CONDUCT.md`
- Submit focused, testable changes

## Decision-Making

- Small changes: maintainer consensus through normal PR review.
- Significant architecture changes: issue discussion plus explicit maintainer sign-off.
- Security-sensitive changes: at least one maintainer with security review.

In case of disagreement, maintainers prioritize stability, user safety, and long-term maintainability.

## Contribution Review Process

1. Issue triage and scope clarification.
2. Contributor opens draft PR early.
3. CI and quality checks pass.
4. At least one maintainer review.
5. Merge with squash or rebase strategy.

High-risk areas (auth, data rules, destructive operations) may require two approvals.

## Issue Labeling System

Use labels consistently to keep triage fast and transparent.

| Label | Purpose |
| --- | --- |
| `good first issue` | Beginner-friendly tasks with clear acceptance criteria |
| `help wanted` | Maintainer-prioritized tasks open for community ownership |
| `bug` | Incorrect behavior or regression |
| `enhancement` | Improvements to existing behavior |
| `documentation` | Docs-only changes |
| `question` | Usage or design questions |
| `priority-high` | Time-sensitive or blocking work |
| `needs-triage` | Awaiting initial maintainer classification |
| `blocked` | Waiting on dependency or external decision |
| `security` | Security-sensitive issue (minimal public detail) |

## Maintainer Rotation and Transparency

- Maintenance decisions should be documented in issues or PR threads.
- Inactive maintainers can be moved to emeritus status after prolonged inactivity.
- New maintainers should have consistent contribution history and review quality.

## Beginner Onboarding Strategy

See `docs/GOOD_FIRST_ISSUES.md` for templates and acceptance criteria used to attract and retain first-time contributors.
