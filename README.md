# 🎓 Campus Connect

A modern Flutter app for students to share notes, announcements, jobs, and campus events — all in one place.

![Flutter](https://img.shields.io/badge/Flutter-3.9.2+-02569B?logo=flutter)
![Firebase](https://img.shields.io/badge/Firebase-Enabled-FFA611?logo=firebase)
![License](https://img.shields.io/badge/License-MIT-green)

## ✨ Features

### MVP Features (Implemented)
- 🔐 **Authentication**: Google Sign-In (FAST NUCES emails only)
- 🏠 **Feed Page**: Browse all posts with category badges
- 📝 **Add Post**: Create new posts with title, description, and category
- 🔍 **Category Filter**: Filter posts by Notes, Jobs, Events, Lost & Found, and Announcements
- 🔎 **Search**: Search posts by title or description
- 👍 **Upvote/Downvote**: Reddit-style voting system with score calculation
- 📊 **Sort Options**: Sort by Most Popular, Most Recent, or Oldest First
- 💬 **Comments**: Full commenting system with add, view, and delete functionality
- 📈 **Real-time Updates**: Comment counts automatically update across the app
- 📑 **Bookmark**: Save favorite posts for later
- 👤 **Profile**: View your posts and bookmarks
- 🗑️ **Delete**: Authors can delete their own posts and comments
- 🎨 **Polished UI**: Material 3 design with smooth animations
- 🎓 **FAST NUCES Only**: Restricted to students with @nu.edu.pk, @isb.nu.edu.pk, @lhr.nu.edu.pk, @pwr.nu.edu.pk, @fsd.nu.edu.pk email domains

## 🏗️ Tech Stack

- **Framework**: Flutter 3.9.2+
- **State Management**: Riverpod
- **Backend**: Firebase (Authentication, Firestore)
- **UI**: Material 3, Google Fonts
- **Authentication**: Firebase Auth + Google Sign-In

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (3.9.2 or higher)
- Dart SDK
- Firebase account
- Android Studio / Xcode (for mobile development)
- Node.js (for Firebase CLI)

### Installation

1. **Clone the repository**
   ```bash
   git clone <your-repo-url>
   cd campus_connect
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Firebase Setup (CRITICAL - FOLLOW CAREFULLY)**

   #### a. Install Firebase CLI
   ```bash
   npm install -g firebase-tools
   dart pub global activate flutterfire_cli
   ```

   #### b. Login to Firebase
   ```bash
   firebase login
   ```

   #### c. Create Firebase Project
   - Go to [Firebase Console](https://console.firebase.google.com/)
   - Click "Add project"
   - Name it "Campus Connect" (or your preferred name)
   - Disable Google Analytics (optional for MVP)
   - Click "Create project"

   #### d. Configure FlutterFire
   ```bash
   flutterfire configure
   ```
   - Select your Firebase project
   - Select platforms (Android, iOS, Web, etc.)
   - This will create `firebase_options.dart` automatically

   #### e. Enable Firebase Authentication
   - In Firebase Console, go to **Authentication** → **Sign-in method**
   - Enable **Email/Password**
   - Enable **Google** sign-in
     - Add your support email
     - Download the configuration files if prompted

   #### f. Enable Cloud Firestore
   - In Firebase Console, go to **Firestore Database**
   - Click **Create database**
   - Start in **Test mode** (for development)
   - Choose a location closest to you
   - Click **Enable**

   #### g. Set Firestore Security Rules ⚠️ IMPORTANT
   In Firestore Console → **Rules**, replace with:
   ```javascript
   rules_version = '2';
   service cloud.firestore {
     match /databases/{database}/documents {
       
       function isSignedIn() {
         return request.auth != null;
       }
       
       function isOwner(userId) {
         return isSignedIn() && request.auth.uid == userId;
       }
       
       // Posts collection
       match /posts/{postId} {
         allow read: if true;
         allow create: if isSignedIn() && request.resource.data.authorId == request.auth.uid;
         allow update: if isOwner(resource.data.authorId);
         allow delete: if isOwner(resource.data.authorId);
       }
       
       // Comments collection (REQUIRED for commenting feature)
       match /comments/{commentId} {
         allow read: if true;
         allow create: if isSignedIn() && request.resource.data.authorId == request.auth.uid;
         allow delete: if isOwner(resource.data.authorId);
         allow update: if false;
       }
     }
   }
   ```
   
   **Note**: See `FIRESTORE_RULES_SETUP.md` for detailed explanation.

4. **Android Setup (For Google Sign-In)**

   #### a. Download google-services.json
   - In Firebase Console → Project Settings → Your apps
   - Download `google-services.json` for Android
   - Place it in `android/app/google-services.json`

   #### b. Get SHA-1 Certificate
   ```bash
   cd android
   ./gradlew signingReport
   ```
   - Copy the SHA-1 and SHA-256 fingerprints
   - Add them to Firebase Console → Project Settings → Your Android app

   #### c. Update android/app/build.gradle.kts
   Ensure the file has:
   ```kotlin
   plugins {
       id("com.android.application")
       id("kotlin-android")
       id("dev.flutter.flutter-gradle-plugin")
       id("com.google.gms.google-services") // Add this line
   }
   ```

   #### d. Update android/build.gradle.kts
   Ensure you have:
   ```kotlin
   buildscript {
       dependencies {
           classpath("com.google.gms:google-services:4.4.0")
       }
   }
   ```

5. **iOS Setup (For Google Sign-In)**

   #### a. Download GoogleService-Info.plist
   - In Firebase Console → Project Settings → Your apps
   - Download `GoogleService-Info.plist` for iOS
   - Place it in `ios/Runner/GoogleService-Info.plist`

   #### b. Update Info.plist
   Add the following to `ios/Runner/Info.plist`:
   ```xml
   <key>CFBundleURLTypes</key>
   <array>
     <dict>
       <key>CFBundleTypeRole</key>
       <string>Editor</string>
       <key>CFBundleURLSchemes</key>
       <array>
         <!-- Copy this from GoogleService-Info.plist REVERSED_CLIENT_ID -->
         <string>YOUR_REVERSED_CLIENT_ID</string>
       </array>
     </dict>
   </array>
   ```

6. **Run the app**
   ```bash
   flutter run
   ```

## 📂 Project Structure

```
lib/
├── main.dart                   # App entry point
├── models/
│   ├── post_model.dart        # Post data model
│   └── user_model.dart        # User data model
├── screens/
│   ├── home_screen.dart       # Main feed screen
│   ├── login_screen.dart      # Login screen
│   ├── signup_screen.dart     # Signup screen
│   ├── add_post_screen.dart   # Create new post
│   ├── post_detail_screen.dart # View post details
│   └── profile_screen.dart    # User profile
├── providers/
│   ├── auth_provider.dart     # Auth state management
│   └── post_provider.dart     # Posts state management
├── services/
│   ├── auth_service.dart      # Firebase Auth service
│   └── firestore_service.dart # Firestore CRUD operations
├── widgets/
│   ├── post_card.dart         # Post card widget
│   └── category_chip.dart     # Category filter chip
└── utils/
    └── constants.dart         # App constants & theme
```

## 🎨 Design System

### Colors
- **Primary**: `#3B82F6` (Blue)
- **Accent**: `#6366F1` (Indigo)
- **Background**: `#F8FAFC` (Light Grey)
- **Success**: `#10B981` (Green)
- **Error**: `#EF4444` (Red)

### Categories
- 📚 **Notes** - Blue
- 💼 **Jobs** - Green
- 📅 **Events** - Orange
- 🔍 **Lost & Found** - Red
- 📢 **Announcements** - Indigo

## 🔧 Configuration Files Needed

### Files you need to add manually:
1. ✅ `firebase_options.dart` - Auto-generated by `flutterfire configure`
2. ✅ `android/app/google-services.json` - Downloaded from Firebase Console
3. ✅ `ios/Runner/GoogleService-Info.plist` - Downloaded from Firebase Console

### Files already configured:
- ✅ `pubspec.yaml` - All dependencies added
- ✅ `android/build.gradle.kts` - May need Google Services plugin
- ✅ `android/app/build.gradle.kts` - May need Google Services plugin

## 🐛 Troubleshooting

### Common Issues

1. **Firebase not initialized**
   - Make sure you ran `flutterfire configure`
   - Check that `firebase_options.dart` exists

2. **Google Sign-In not working**
   - Ensure SHA-1 is added to Firebase Console
   - Check that `google-services.json` is in the right place
   - Verify Google Sign-In is enabled in Firebase Console

3. **Firestore permission denied**
   - Check Firestore security rules
   - Ensure user is authenticated before accessing data

4. **Build errors**
   ```bash
   flutter clean
   flutter pub get
   flutter run
   ```

## 📋 Manual Steps Checklist

- [ ] Create Firebase project at console.firebase.google.com
- [ ] Run `flutterfire configure`
- [ ] Enable Email/Password authentication in Firebase Console
- [ ] Enable Google Sign-In in Firebase Console
- [ ] Enable Firestore Database in Firebase Console
- [ ] Update Firestore security rules
- [ ] Download `google-services.json` for Android
- [ ] Download `GoogleService-Info.plist` for iOS
- [ ] Add SHA-1 fingerprint to Firebase Console (Android)
- [ ] Update `Info.plist` with REVERSED_CLIENT_ID (iOS)
- [ ] Add Google Services plugin to `android/build.gradle.kts`
- [ ] Test authentication flow
- [ ] Test post creation and retrieval

## 🚀 Next Features (Post-MVP)

- [ ] Dark mode toggle
- [ ] Push notifications (FCM)
- [ ] Image upload for posts
- [ ] Comments on posts
- [ ] User profiles with avatars
- [ ] Real-time chat
- [ ] Event calendar view
- [ ] File attachments for notes
- [ ] Admin moderation panel

## 📄 License

This project is licensed under the MIT License.

## 👨‍💻 Author

**Ammaar**
- Building this for Flutter internship at Xgrid
- Campus Connect - Connect, Share, Succeed Together

---

**Built with ❤️ using Flutter**
