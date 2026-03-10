# Local Development Guide

This guide helps contributors run Campus Connect locally on Linux, macOS, or Windows.

## 1. Install Tooling

## Flutter

1. Install Flutter from https://docs.flutter.dev/get-started/install.
2. Add Flutter to `PATH`.
3. Run:

```bash
flutter doctor
```

Resolve all required items for your target platform.

## Android (recommended for first-time contributors)

1. Install Android Studio.
2. Install Android SDK and command-line tools.
3. Create an emulator (Pixel API 34+ recommended).
4. Verify devices:

```bash
flutter devices
```

## iOS (macOS only)

1. Install Xcode from App Store.
2. Install command-line tools.
3. Open Simulator once and accept licenses.

## 2. Clone and Bootstrap

```bash
git clone https://github.com/ammaarrahmed/Campus-Connect.git
cd Campus-Connect
flutter pub get
```

## 3. Configure Firebase

Use this checklist:

1. Create/choose a Firebase project.
2. Enable Authentication providers used by the app.
3. Enable Firestore.
4. Apply repository Firestore rules from `firestore.rules`.

Required files (not committed with secrets):

- `android/app/google-services.json`
- `ios/Runner/GoogleService-Info.plist`

`lib/firebase_options.dart` can be generated with FlutterFire CLI:

```bash
dart pub global activate flutterfire_cli
flutterfire configure
```

## Cloudinary (Image Uploads)

Cloudinary setup is configured in `lib/services/image_upload_service.dart`.

- Set `_cloudName`
- Set `_uploadPreset`

Use unsigned upload presets scoped to the project folder for safer defaults.

## 4. Run the App

Start an emulator/device, then run:

```bash
flutter run
```

## 5. Run Quality Checks

```bash
dart format --output=none --set-exit-if-changed .
flutter analyze --no-fatal-infos
flutter test
```

## 6. Common Contributor Workflow

```bash
git checkout -b feature/your-change
# make changes
dart format --output=none --set-exit-if-changed .
flutter analyze --no-fatal-infos
flutter test
git commit -m "feat: your summary"
git push origin feature/your-change
```

Open a PR and follow `.github/PULL_REQUEST_TEMPLATE.md`.
