# 🔥 Firebase Setup Guide - Campus Connect

## CRITICAL: Complete These Steps Before Running the App!

### Step 1: Install Firebase CLI Tools

```bash
# Install Firebase CLI
npm install -g firebase-tools

# Install FlutterFire CLI
dart pub global activate flutterfire_cli

# Add to PATH (if not already)
export PATH="$PATH":"$HOME/.pub-cache/bin"
```

### Step 2: Login to Firebase

```bash
firebase login
```

This will open a browser window. Login with your Google account.

### Step 3: Create Firebase Project

1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Click **"Add project"**
3. Project name: `campus-connect` (or your choice)
4. Google Analytics: **Disable** (optional for now)
5. Click **"Create project"**
6. Wait for project creation to complete

### Step 4: Configure FlutterFire

```bash
# Run this from your project root directory
flutterfire configure
```

**What this does:**
- Links your Flutter app to Firebase project
- Creates `lib/firebase_options.dart` automatically
- Configures all platforms (Android, iOS, Web)

**During configuration:**
- Select your Firebase project (campus-connect)
- Select platforms: Android, iOS (and others if needed)
- Enter bundle ID when prompted (default is fine)

### Step 5: Enable Firebase Authentication

1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Select your project
3. Navigate to **Build** → **Authentication**
4. Click **"Get started"**
5. Go to **"Sign-in method"** tab

**Enable Email/Password:**
- Click on **Email/Password**
- Toggle **Enable**
- Click **Save**

**Enable Google Sign-In:**
- Click on **Google**
- Toggle **Enable**
- Enter support email (your email)
- Click **Save**

### Step 6: Enable Cloud Firestore

1. In Firebase Console, navigate to **Build** → **Firestore Database**
2. Click **"Create database"**
3. Select **"Start in test mode"** (for development)
4. Choose a location (e.g., `us-central`, `asia-south1`)
5. Click **Enable**

### Step 7: Configure Firestore Security Rules

1. In Firestore Database, go to **Rules** tab
2. Replace the content with:

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    
    // Allow users to read all user profiles
    // Allow users to write only their own profile
    match /users/{userId} {
      allow read: if true;
      allow write: if request.auth != null && request.auth.uid == userId;
    }
    
    // Posts collection rules
    match /posts/{postId} {
      // Anyone can read posts
      allow read: if true;
      
      // Authenticated users can create posts
      allow create: if request.auth != null && 
                    request.resource.data.authorId == request.auth.uid;
      
      // Authenticated users can update any post (for likes/bookmarks)
      allow update: if request.auth != null;
      
      // Only post author can delete their post
      allow delete: if request.auth != null && 
                    request.auth.uid == resource.data.authorId;
    }
  }
}
```

3. Click **Publish**

### Step 8: Android Configuration

#### 8.1: Add Android App to Firebase

1. In Firebase Console → **Project Settings** (gear icon)
2. Scroll to **"Your apps"**
3. Click **Android** icon
4. Register app:
   - Android package name: `com.example.campus_connect` (or your package)
   - App nickname: `Campus Connect Android`
   - Click **Register app**

#### 8.2: Download google-services.json

1. Download the `google-services.json` file
2. Place it at: `android/app/google-services.json`

#### 8.3: Get SHA-1 Certificate Fingerprint

```bash
cd android
./gradlew signingReport
```

Look for **SHA-1** and **SHA-256** under `Variant: debug` → `Task: :app:signingReport`

Copy both fingerprints.

#### 8.4: Add SHA Fingerprints to Firebase

1. In Firebase Console → **Project Settings** → **Your apps**
2. Find your Android app
3. Scroll to **SHA certificate fingerprints**
4. Click **"Add fingerprint"**
5. Paste SHA-1, click **Save**
6. Repeat for SHA-256

#### 8.5: Update Android Build Files

**File: `android/build.gradle.kts`**

Add to `buildscript` → `dependencies`:

```kotlin
buildscript {
    repositories {
        google()
        mavenCentral()
    }

    dependencies {
        classpath("com.android.tools.build:gradle:8.1.0")
        classpath("org.jetbrains.kotlin:kotlin-gradle-plugin:1.9.0")
        classpath("com.google.gms:google-services:4.4.0") // ADD THIS
    }
}
```

**File: `android/app/build.gradle.kts`**

At the top, add:

```kotlin
plugins {
    id("com.android.application")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
    id("com.google.gms.google-services") // ADD THIS LINE
}
```

### Step 9: iOS Configuration (Optional)

#### 9.1: Add iOS App to Firebase

1. In Firebase Console → **Project Settings**
2. Click **iOS** icon
3. Register app:
   - iOS bundle ID: `com.example.campusConnect`
   - App nickname: `Campus Connect iOS`
   - Click **Register app**

#### 9.2: Download GoogleService-Info.plist

1. Download `GoogleService-Info.plist`
2. Open Xcode: `open ios/Runner.xcworkspace`
3. Drag `GoogleService-Info.plist` into Runner folder (ensure "Copy items if needed" is checked)

#### 9.3: Update Info.plist

Open `ios/Runner/Info.plist` and add before `</dict>`:

```xml
<key>CFBundleURLTypes</key>
<array>
  <dict>
    <key>CFBundleTypeRole</key>
    <string>Editor</string>
    <key>CFBundleURLSchemes</key>
    <array>
      <!-- Get this from GoogleService-Info.plist → REVERSED_CLIENT_ID -->
      <string>com.googleusercontent.apps.YOUR-CLIENT-ID</string>
    </array>
  </dict>
</array>
```

**To find REVERSED_CLIENT_ID:**
- Open `GoogleService-Info.plist`
- Find key `REVERSED_CLIENT_ID`
- Copy its value and use it in the XML above

### Step 10: Install Dependencies

```bash
flutter pub get
```

### Step 11: Verify Setup

```bash
# Clean build
flutter clean

# Get dependencies
flutter pub get

# Run app
flutter run
```

### Step 12: Test the App

1. **Sign Up**: Create a new account with email/password
2. **Google Sign-In**: Test Google authentication
3. **Create Post**: Add a new post
4. **Like/Bookmark**: Test interactions
5. **Filter**: Try category filters
6. **Search**: Test search functionality
7. **Profile**: View your posts and bookmarks
8. **Delete**: Delete one of your posts

## ✅ Verification Checklist

- [ ] `firebase login` successful
- [ ] `flutterfire configure` completed
- [ ] `lib/firebase_options.dart` exists
- [ ] Firebase Authentication enabled (Email + Google)
- [ ] Firestore Database created
- [ ] Firestore security rules updated
- [ ] `android/app/google-services.json` added
- [ ] SHA-1 certificate added to Firebase
- [ ] Google Services plugin added to gradle files
- [ ] `flutter pub get` successful
- [ ] App runs without errors
- [ ] Sign up works
- [ ] Google Sign-In works
- [ ] Posts can be created
- [ ] Posts can be liked/bookmarked

## 🐛 Common Issues & Solutions

### Issue: "Firebase not initialized"
**Solution:** Make sure `firebase_options.dart` exists and `Firebase.initializeApp()` is called in `main()`

### Issue: "Google Sign-In failed"
**Solution:** 
1. Check SHA-1 is added to Firebase Console
2. Verify `google-services.json` is in `android/app/`
3. Ensure Google Sign-In is enabled in Firebase Console

### Issue: "Firestore permission denied"
**Solution:** Update Firestore security rules as shown in Step 7

### Issue: "Build failed" after adding Firebase
**Solution:**
```bash
cd android
./gradlew clean
cd ..
flutter clean
flutter pub get
flutter run
```

### Issue: "google-services.json not found"
**Solution:** Download from Firebase Console and place in `android/app/google-services.json`

## 🎉 Success!

If all steps are completed successfully, you should see:
- Beautiful login screen
- Ability to sign up/sign in
- Home feed with posts
- Create, like, bookmark functionality
- Profile page with your posts

## 📞 Need Help?

If you encounter issues:
1. Check the troubleshooting section above
2. Verify all files are in the correct locations
3. Ensure Firebase Console settings match the guide
4. Run `flutter doctor` to check your setup

---

**Next Steps:** Once MVP is working, we can add core features like:
- Image uploads
- Comments
- Push notifications
- Dark mode
- And more!
