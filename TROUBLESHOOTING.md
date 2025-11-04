# Troubleshooting Common Issues

## ❌ "Permission Denied" / "Caller doesn't have permission"

### Problem
```
cloud firestore permission denied
the caller doesn't have permission to execute the specified operation
```

### Cause
Your Firestore security rules don't allow access to the `comments` collection.

### Solution
1. Open [Firebase Console](https://console.firebase.google.com/)
2. Select your project
3. Go to **Firestore Database** → **Rules** tab
4. Copy the rules from `firestore.rules` or `FIRESTORE_RULES_SETUP.md`
5. Click **Publish**
6. Wait 1-2 minutes for rules to propagate
7. Restart your app

**Quick Test**: Try the rules in `FIRESTORE_RULES_SETUP.md` first!

---

## ❌ "Error loading comments"

### Possible Causes & Solutions

#### 1. Firestore Index Issue (FIXED)
**Symptom**: Error mentions "requires an index"
**Solution**: Already fixed in code - using client-side sorting instead

#### 2. Permission Denied (Most Common)
**Symptom**: Error mentions "permission denied"
**Solution**: Update Firestore rules (see above)

#### 3. No Internet Connection
**Symptom**: Generic connection error
**Solution**: Check your device's internet connection

#### 4. Firebase Not Initialized
**Symptom**: Error on app startup
**Solution**: Make sure `google-services.json` is in `android/app/`

---

## ❌ Google Sign-In Not Working

### Problem
Sign-in button doesn't work or shows error after selecting Google account

### Solutions

1. **Add SHA-1 Fingerprint** (Android)
   ```bash
   cd android
   ./gradlew signingReport
   ```
   Copy SHA-1 and add to Firebase Console → Project Settings → Your apps

2. **Download latest google-services.json**
   After adding SHA-1, download new `google-services.json`

3. **Enable Google Sign-In in Firebase**
   Firebase Console → Authentication → Sign-in method → Google → Enable

4. **Add Support Email**
   Required for Google Sign-In OAuth consent screen

---

## ❌ "Failed Precondition" / "Requires an index"

### Problem
```
cloud_firestore/failed-precondition
The query requires an index
```

### Solution
This should already be fixed, but if you still see it:

1. **For Posts**: The app uses client-side sorting - no action needed
2. **For Comments**: Updated in latest version - make sure you have latest code
3. **Alternative**: Click the error link to create the index in Firebase Console

---

## ❌ Build Errors

### "Could not resolve dependencies"
```bash
cd android
./gradlew clean
cd ..
flutter clean
flutter pub get
```

### "No Firebase App '[DEFAULT]'"
- Check if `Firebase.initializeApp()` is in `main.dart`
- Verify `google-services.json` exists in `android/app/`
- Run `flutterfire configure` again

---

## ⚠️ Common Mistakes

1. **Forgot to publish Firestore rules** - Rules won't work until published
2. **Old google-services.json** - Download fresh copy after any Firebase config change
3. **Wrong SHA-1** - Must use debug SHA-1 for development builds
4. **Email domain restriction** - Only @nu.edu.pk and campus emails allowed
5. **Test mode expired** - Firestore test mode expires after 30 days

---

## 🔍 Debugging Tips

### Check Firebase Console
1. **Authentication** tab - See if users are signing in
2. **Firestore Data** tab - Check if posts/comments are being created
3. **Rules Playground** - Test your rules before publishing

### Check App Logs
```bash
flutter run --verbose
```
Look for specific error messages

### Test Firestore Connection
```dart
// Add temporary test in your code
FirebaseFirestore.instance.collection('test').add({'test': 'data'})
  .then((_) => print('✅ Firestore working'))
  .catchError((e) => print('❌ Firestore error: $e'));
```

---

## 📞 Still Having Issues?

1. Check `README.md` - Complete setup guide
2. Check `FIRESTORE_RULES_SETUP.md` - Detailed rules explanation
3. Check `QUICK_START.md` - Fast-track setup
4. Review Firebase Console for any warnings/errors
5. Make sure you're using FAST NUCES email (@nu.edu.pk, @isb.nu.edu.pk, etc.)

---

## ✅ Quick Checklist

Before asking for help, verify:
- [ ] Firestore rules published and include `comments` collection
- [ ] `google-services.json` in `android/app/`
- [ ] SHA-1 fingerprint added to Firebase
- [ ] Google Sign-In enabled in Firebase Console
- [ ] Using valid FAST NUCES email domain
- [ ] Internet connection working
- [ ] Latest code pulled/updated
- [ ] Ran `flutter clean` and `flutter pub get`
