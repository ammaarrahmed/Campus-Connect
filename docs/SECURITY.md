# Security Policy

## Supported Versions

Campus Connect is pre-1.0 and evolves quickly. Security fixes are prioritized for the latest `main` branch and the most recent tagged release.

| Version | Supported |
| --- | --- |
| `main` | Yes |
| latest release tag | Yes |
| older tags | Best effort |

## Reporting a Vulnerability

Please do not open public GitHub issues for security problems.

Use one of these channels:

1. GitHub Private Vulnerability Reporting (preferred)
2. Email: `ammaarlatif53@gmail.com`

Include the following in your report:

- Affected component or file
- Reproduction steps or proof of concept
- Potential impact
- Suggested fix if available
- Your contact details for follow-up

You should receive an acknowledgment within 72 hours.

## Disclosure Process

1. We acknowledge receipt and assign a maintainer.
2. We validate impact and define severity.
3. We work on remediation and regression tests.
4. We coordinate a release and security advisory.
5. We publicly disclose after a fix is available.

## Scope

In scope:

- Authentication and authorization bypasses
- Data exposure in Firestore rules or APIs
- Sensitive token leakage
- Privilege escalation
- Dependency vulnerabilities with practical impact

Out of scope (unless chained with another bug):

- Social engineering
- Missing best-practice headers without exploit path
- Denial-of-service with unrealistic assumptions
- Issues in third-party services with no project-side fix

## Safe Harbor

If you act in good faith and avoid data destruction or privacy violations, we will treat your research as authorized under this policy.
