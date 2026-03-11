# AI Usage Policy

Campus Connect allows contributors to use AI coding assistants (for example Copilot, ChatGPT, Claude, Codeium) under the rules below.

## Acceptable AI Usage

- Brainstorming implementation options
- Drafting tests, comments, or documentation
- Refactoring boilerplate
- Explaining APIs and patterns
- Generating initial code skeletons

## Required Contributor Responsibilities

Contributors remain fully responsible for all submitted code, regardless of how it was produced.

Before opening a PR, you must:

- Review all AI-generated code line by line
- Verify logic, security, and edge cases
- Run formatting, analysis, and tests locally
- Ensure generated code matches project architecture
- Remove hallucinated or unused code

## Prohibited Usage

- Blindly submitting AI-generated code without review
- Copying code with unclear licensing or attribution
- Submitting generated secrets, tokens, or private data
- Using AI output to bypass plagiarism, policy, or review checks

## Disclosure Guidance

You do not need to disclose every minor AI-assisted edit.

You should disclose substantial AI assistance in the PR description when:

- AI generated major portions of implementation
- AI influenced design decisions or architecture
- AI produced non-trivial tests or migrations

Recommended statement:

```text
AI assistance used for initial draft/refactor. All code was reviewed, validated, and tested by the contributor.
```

## Maintainer Review Rights

Maintainers may request:

- Additional tests
- Design rationale
- Rework of low-confidence generated code
- Proof of manual verification

PRs that violate this policy may be closed until compliant.
