# Release Strategy

This document defines how Campus Connect ships stable releases as an open-source project.

## Versioning Model

Campus Connect uses Semantic Versioning:

- `MAJOR`: incompatible API or architectural changes
- `MINOR`: backward-compatible features
- `PATCH`: backward-compatible bug fixes

Before 1.0, minor versions may include broader changes, but release notes must clearly describe migration impact.

## Release Cadence

- Patch releases: as needed for regressions or urgent fixes
- Minor releases: every 4-8 weeks, depending on merged scope
- Major releases: when architecture or public contracts change significantly

## Release Branching

- `main` is always deployable.
- Optional: create `release/x.y.z` branch for stabilization if needed.
- Hotfixes can branch from latest tag and merge back to `main`.

## Changelog Management

- Maintain `docs/CHANGELOG.md` in Keep a Changelog format.
- New contributions should add entries under `## [Unreleased]`.
- During release, convert `Unreleased` entries into a dated version section.

## Release Checklist

1. Freeze release scope and label deferred issues.
2. Ensure CI is green on `main`.
3. Update `docs/CHANGELOG.md` and version in `pubspec.yaml`.
4. Create and push git tag: `vX.Y.Z`.
5. Publish GitHub release notes from changelog.
6. Announce breaking changes and migration guidance.

## Pre-release Channels (Optional)

Use pre-release tags (`vX.Y.Z-rc.1`) for risky changes that need community validation before stable release.
