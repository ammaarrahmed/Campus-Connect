# Campus Connect

Campus Connect is an open-source Flutter community platform for FAST-NUCES students.

Mission: build a high-quality, student-owned digital campus space for discussion, collaboration, and trusted information sharing.

[![Flutter](https://img.shields.io/badge/Flutter-stable-02569B?logo=flutter)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.9.2-0175C2?logo=dart)](https://dart.dev)
[![Firebase](https://img.shields.io/badge/Firebase-enabled-FFCA28?logo=firebase)](https://firebase.google.com)
[![License](https://img.shields.io/badge/license-Apache--2.0-green.svg)](LICENSE)
[![CI](https://github.com/ammaarrahmed/Campus-Connect/actions/workflows/flutter_ci.yml/badge.svg)](https://github.com/ammaarrahmed/Campus-Connect/actions/workflows/flutter_ci.yml)
[![PR Validation](https://github.com/ammaarrahmed/Campus-Connect/actions/workflows/pr_validation.yml/badge.svg)](https://github.com/ammaarrahmed/Campus-Connect/actions/workflows/pr_validation.yml)

## Screenshots

Add screenshots before public launch:

- Feed: `docs/images/feed.png`
- Post detail: `docs/images/post-detail.png`
- Create post: `docs/images/create-post.png`
- Profile: `docs/images/profile.png`

You can keep placeholders in git and replace them as UI evolves.

## Key Features

- FAST-only authentication (`@nu.edu.pk` and campus domains)
- Post feed with categories, search, sort, and filters
- Reddit-style voting and bookmarking
- Comment threads with real-time updates
- Profile with authored posts and saved posts
- Firebase-backed auth and Firestore data flow
- Flutter + Riverpod architecture for scalable state management

## Tech Stack

- Framework: Flutter
- Language: Dart 3.9.2
- State Management: Riverpod
- Backend: Firebase Auth + Cloud Firestore
- Media: `image_picker`, `image_cropper`, Cloudinary uploads
- UI: Material 3, `google_fonts`, `flutter_animate`
- CI/CD: GitHub Actions

## Architecture Overview

Campus Connect follows a feature-module Flutter architecture with shared foundations:

1. App shell and theme: `lib/app/`
2. Feature modules: `lib/features/<feature>/{presentation,application,domain,infrastructure}`
3. Shared UI primitives: `lib/shared/`
4. Existing state/models/services: `lib/providers/`, `lib/models/`, `lib/services/`
5. Bootstrap/config: `lib/main.dart`, `lib/firebase_options.dart`, `lib/utils/`

This keeps UI and feature ownership clear while the remaining non-UI layers are incrementally migrated.

## Installation

### Prerequisites

- Flutter SDK (stable)
- Dart SDK (matches Flutter stable)
- Android Studio (Android emulator) and/or Xcode (iOS simulator on macOS)
- Firebase project with Auth + Firestore enabled

### Quick Start

```bash
git clone https://github.com/ammaarrahmed/Campus-Connect.git
cd Campus-Connect
flutter pub get
flutter run
```

For full setup, including Firebase and emulator provisioning, see `docs/LOCAL_DEVELOPMENT.md`.

## Development Setup

1. Install dependencies: `flutter pub get`
2. Configure Firebase and local platform setup using `docs/LOCAL_DEVELOPMENT.md`
3. Apply Firestore rules from `firestore.rules`
4. Generate platform files and run:
- `flutter doctor`
- `flutter run`

### Quality Gates (Local)

Run these before opening a PR:

```bash
dart format --output=none --set-exit-if-changed .
flutter analyze --no-fatal-infos
flutter test
```

## Contributing

Community contributions are welcome. Start here:

- `docs/CONTRIBUTING.md`
- `docs/CODE_OF_CONDUCT.md`
- `docs/AI_USAGE_POLICY.md`
- `docs/SECURITY.md`

## Code Structure

Current source layout:

```text
lib/
  app/
    app.dart
    theme/
  features/
    auth/
    posts/
    profiles/
    comments/
    messaging/
    moderation/
  shared/
    widgets/
  main.dart
  firebase_options.dart
  models/
  providers/
  services/
  utils/
test/
docs/
  images/
.github/
  ISSUE_TEMPLATE/
  workflows/
```

Recommended long-term structure and conventions are documented in `docs/REPOSITORY_STRUCTURE.md`.

## Roadmap

Short and mid-term product roadmap is tracked in:

- `docs/ROADMAP.md`
- GitHub Issues with labels `enhancement`, `good first issue`, and `priority-high`

Engineering architecture and standards documents are tracked in `engineering-foundation/`.

Release planning and semantic versioning policy live in `docs/RELEASE_STRATEGY.md`.

## License

This project is licensed under Apache License 2.0. See `LICENSE`.

Why Apache-2.0:

- Clear patent grant for contributors and adopters
- Strong compatibility with commercial and community use
- Well understood in large open-source ecosystems

## Maintainers

- `@ammaarrahmed` (Founder and Primary Maintainer)

If you want to help maintain the project, open a governance proposal issue.
