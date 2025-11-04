# 🚀 Quick Start Guide - Campus Connect

## Before You Begin

This app requires Firebase setup. **You must complete Firebase configuration before running the app.**

## ⚡ Fast Track (30 minutes)

### 1. Install Flutter Dependencies
```bash
flutter pub get
```

### 2. Firebase Setup (CRITICAL)

```bash
# Install Firebase CLI tools
npm install -g firebase-tools
dart pub global activate flutterfire_cli

# Login to Firebase
firebase login

# Configure FlutterFire (this creates firebase_options.dart)
flutterfire configure
```

**During `flutterfire configure`:**
- Create a new Firebase project or select existing
- Name it "campus-connect"
- Select Android and iOS platforms

### 3. Enable Firebase Services

Go to [Firebase Console](https://console.firebase.google.com/):

**A. Authentication:**
1. Go to Authentication → Sign-in method
2. Enable "Email/Password"
3. Enable "Google"

**B. Firestore:**
1. Go to Firestore Database
2. Create database in "Test mode"
3. Choose your region
4. Go to Rules tab and paste:

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /users/{userId} {
      allow read: if true;
      allow write: if request.auth != null && request.auth.uid == userId;
    }
    
    match /posts/{postId} {
      allow read: if true;
      allow create: if request.auth != null;
      allow update: if request.auth != null;
      allow delete: if request.auth != null && 
                    request.auth.uid == resource.data.authorId;
    }
  }
}
```

### 4. Android Setup

**Download google-services.json:**
1. Firebase Console → Project Settings → Your apps
2. Click Android app (created by flutterfire)
3. Download `google-services.json`
4. Place it at: `android/app/google-services.json`

**Get SHA-1 certificate:**
```bash
cd android
./gradlew signingReport
```
- Copy SHA-1 fingerprint (under debug variant)
- Add it to Firebase Console → Project Settings → Your Android app → SHA certificate fingerprints

### 5. Run the App

```bash
flutter clean
flutter pub get
flutter run
```

## ✅ What You Should See

1. **Login Screen** with:
   - Email/Password sign in
   - Google Sign-In button
   - Sign up option

2. **After Login:**
   - Home feed
   - Floating button to create posts
   - Search bar
   - Category filters

## 🎯 MVP Features to Test

- ✅ Sign up with email/password
- ✅ Sign in with Google
- ✅ Create a post (select category, add title & description)
- ✅ View all posts in feed
- ✅ Filter by category (Notes, Jobs, Events, etc.)
- ✅ Search posts
- ✅ Like posts (heart icon)
- ✅ Bookmark posts
- ✅ View post details
- ✅ View your profile (your posts & bookmarks)
- ✅ Delete your own posts
- ✅ Sign out

## 📋 Manual Steps Checklist

### Firebase Console
- [ ] Create Firebase project
- [ ] Enable Email/Password authentication
- [ ] Enable Google authentication  
- [ ] Create Firestore database (Test mode)
- [ ] Update Firestore security rules
- [ ] Add SHA-1 fingerprint (Android)
- [ ] Download google-services.json (Android)

### Local Setup
- [ ] Run `flutterfire configure`
- [ ] Verify `lib/firebase_options.dart` exists
- [ ] Place `google-services.json` in `android/app/`
- [ ] Run `flutter pub get`
- [ ] Run `flutter clean`

## 🐛 Troubleshooting

**App crashes on startup:**
```bash
# Make sure you ran flutterfire configure
flutterfire configure

# Clean and rebuild
flutter clean
flutter pub get
flutter run
```

**Google Sign-In not working:**
1. Check SHA-1 is added to Firebase Console
2. Verify google-services.json is in android/app/
3. Rebuild: `flutter clean && flutter run`

**Firestore errors:**
1. Check Firestore security rules are updated
2. Verify Firestore is in "Test mode" or rules allow read/write

## 📖 Need More Details?

See the detailed guides:
- **SETUP_GUIDE.md** - Complete step-by-step Firebase setup
- **README.md** - Full project documentation

## 🎉 You're Ready!

Once you complete these steps, you have a fully functional Campus Connect MVP with:
- Authentication (Email + Google)
- Post creation
- Category filtering
- Search
- Like/Bookmark
- User profiles

## 🚀 Next Steps

After testing MVP, you can add:
- Image uploads
- Comments
- Push notifications
- Dark mode
- File attachments

---

**Need help?** Check SETUP_GUIDE.md for detailed instructions!
