# Local Development Guide

This guide is a full, step-by-step walkthrough to run Campus Connect locally on Linux, macOS, or Windows.

It covers:

- Required tools and exact verification commands
- Android and iOS setup
- Firebase setup (including required files)
- Cloudinary setup
- Running, testing, and troubleshooting

## 1. Prerequisites and Tooling

## 1.1 Git

Install Git first, then verify:

```bash
git --version
```

If the command is not found, install Git and restart your terminal.

## 1.2 Flutter SDK

1. Install Flutter from https://docs.flutter.dev/get-started/install.
2. Add Flutter to your `PATH`.
3. Verify Flutter is available:

```bash
flutter --version
```

4. Run health checks:

```bash
flutter doctor -v
```

5. Resolve all items marked with `X` or `!` for your target platform.

## 1.3 Dart SDK

Dart is bundled with Flutter. Verify it:

```bash
dart --version
```

## 1.4 Android Studio + Android SDK (recommended first target)

1. Install Android Studio.
2. Open Android Studio and install these components:
- Android SDK Platform (API 34 or newer)
- Android SDK Build-Tools
- Android SDK Command-line Tools
- Android Emulator
3. Accept Android SDK licenses:

```bash
flutter doctor --android-licenses
```

4. Verify Android toolchain:

```bash
flutter doctor -v
```

5. Create an emulator from Android Studio Device Manager:
- Device: Pixel 6 (or equivalent)
- API level: 34+

## 1.5 iOS Tooling (macOS only)

1. Install Xcode from App Store.
2. Open Xcode once and accept all license prompts.
3. Install command-line tools:

```bash
xcode-select --install
```

4. Verify:

```bash
flutter doctor -v
```

## 1.6 Editor (VS Code or Android Studio)

Recommended VS Code extensions:

- Dart
- Flutter

Optional but useful:

- Error Lens
- GitLens

## 2. Clone the Repository and Install Dependencies

From your preferred projects directory:

```bash
git clone https://github.com/ammaarrahmed/Campus-Connect.git
cd Campus-Connect
flutter pub get
```

Verify package resolution completed successfully. You should not see unresolved dependency errors.

## 3. Configure Firebase (Required)

Campus Connect relies on Firebase for authentication and data.

## 3.1 Create or Select a Firebase Project

1. Go to Firebase Console.
2. Create a new project or pick an existing one.
3. In Project Settings, note your project ID.

## 3.2 Enable Firebase Products Used by the App

Enable at minimum:

- Authentication
- Cloud Firestore

If your environment requires additional providers (for example Google Sign-In), enable those under Authentication -> Sign-in method.

## 3.3 Register Platform Apps in Firebase

Register each platform you plan to run:

- Android app (package name must match this project)
- iOS app (bundle identifier must match this project)

Download platform files:

- Android: `google-services.json`
- iOS: `GoogleService-Info.plist`

## 3.4 Place Firebase Config Files in Correct Paths

Required file paths:

- `android/app/google-services.json`
- `ios/Runner/GoogleService-Info.plist`

Important notes:

- `android/app/google-services.example.json` is only a template.
- Do not use placeholder values for production testing.
- Keep real credentials out of public commits.

## 3.5 Generate `lib/firebase_options.dart` (FlutterFire)

Install and run FlutterFire CLI:

```bash
dart pub global activate flutterfire_cli
flutterfire configure
```

During setup:

- Select the same Firebase project created above.
- Select the platforms you will run.
- Confirm generated file updates in `lib/firebase_options.dart`.

## 3.6 Apply Firestore Rules

Use the repository rules file:

- `firestore.rules`

Deploy from your Firebase workflow or apply through Firebase Console.

## 4. Configure Cloudinary (Image Uploads)

Cloudinary is configured in:

- `lib/services/image_upload_service.dart`

Update these values:

- `_cloudName`
- `_uploadPreset`

Best practice:

- Use unsigned upload presets with restricted folder scope.
- Avoid exposing admin credentials in app code.

## 5. Start a Device and Run the App

## 5.1 Check Connected Devices

```bash
flutter devices
```

If no device appears:

- Start an emulator from Android Studio Device Manager.
- Or connect a physical device with USB debugging enabled.

## 5.2 Run the App

```bash
flutter run
```

If multiple devices are available:

```bash
flutter run -d <device_id>
```

## 6. Quality Checks Before Committing

Run all three commands before pushing:

```bash
dart format --output=none --set-exit-if-changed .
flutter analyze --no-fatal-infos
flutter test
```

What each command verifies:

- `dart format ...` checks code formatting
- `flutter analyze ...` checks static analysis/lints
- `flutter test` runs automated tests

## 7. Recommended Contributor Workflow

```bash
git checkout -b feature/your-change
# make code changes
dart format --output=none --set-exit-if-changed .
flutter analyze --no-fatal-infos
flutter test
git add .
git commit -m "feat: your summary"
git push origin feature/your-change
```

Then open a pull request and follow:

- `.github/PULL_REQUEST_TEMPLATE.md`

## 8. Troubleshooting

## 8.1 `google-services.json is missing` (Android)

If you see an error like `:app:processDebugGoogleServices` failed:

1. Ensure file exists exactly as:
- `android/app/google-services.json`
2. Confirm the filename has no hidden spaces or uppercase mismatch.
3. If needed, also place a copy under:
- `android/app/src/google-services.json`
- `android/app/src/debug/google-services.json`
- `android/app/src/Debug/google-services.json`

Verify quickly:

```bash
ls -la android/app | grep google-services
ls -la android/app/src | grep google-services
ls -la android/app/src/debug | grep google-services
```

## 8.2 Build Cache Issues

If configuration is correct but build still fails:

```bash
flutter clean
flutter pub get
flutter run
```

## 8.3 Doctor Still Reports Missing Dependencies

Re-run:

```bash
flutter doctor -v
```

Fix each unresolved item, then retry `flutter run`.
