# Firestore Security Rules Setup

## Quick Fix for "Permission Denied" Error

### Step 1: Open Firebase Console
1. Go to https://console.firebase.google.com/
2. Select your project

### Step 2: Navigate to Firestore Rules
1. Click on **Firestore Database** in the left sidebar
2. Click on the **Rules** tab at the top

### Step 3: Replace Rules
Copy and paste these rules (replace everything):

```
rules_version = '2';

service cloud.firestore {
  match /databases/{database}/documents {
    
    // Helper function to check if user is authenticated
    function isSignedIn() {
      return request.auth != null;
    }
    
    // Helper function to check if user owns the document
    function isOwner(userId) {
      return isSignedIn() && request.auth.uid == userId;
    }
    
    // Posts collection rules
    match /posts/{postId} {
      // Anyone can read posts
      allow read: if true;
      
      // Only authenticated users can create posts
      allow create: if isSignedIn() 
                    && request.resource.data.authorId == request.auth.uid;
      
      // Only post author can update their post
      allow update: if isOwner(resource.data.authorId);
      
      // Only post author can delete their post
      allow delete: if isOwner(resource.data.authorId);
    }
    
    // Comments collection rules
    match /comments/{commentId} {
      // Anyone can read comments
      allow read: if true;
      
      // Only authenticated users can create comments
      allow create: if isSignedIn() 
                    && request.resource.data.authorId == request.auth.uid;
      
      // Only comment author can delete their comment
      allow delete: if isOwner(resource.data.authorId);
      
      // Comments cannot be updated (only create and delete)
      allow update: if false;
    }
  }
}
```

### Step 4: Publish Rules
1. Click the **Publish** button at the top
2. Wait for confirmation message

### Step 5: Test in Your App
- Try adding a comment again
- Comments should now load and save successfully

---

## What These Rules Do

### Posts:
- ✅ **Read**: Anyone can view posts (public feed)
- ✅ **Create**: Only logged-in users can create posts
- ✅ **Update**: Only the author can edit their post (for likes, bookmarks, upvotes, downvotes)
- ✅ **Delete**: Only the author can delete their post

### Comments:
- ✅ **Read**: Anyone can view comments
- ✅ **Create**: Only logged-in users can add comments
- ✅ **Delete**: Only comment author can delete their comment
- ❌ **Update**: Comments cannot be edited (prevented)

---

## Security Features

1. **Authentication Required**: Users must be signed in with Google to create posts/comments
2. **Ownership Verification**: Only authors can modify/delete their own content
3. **Public Read**: Anyone can browse posts and comments (good for campus community)
4. **No Anonymous Write**: Prevents spam and abuse

---

## Alternative: Test Mode (NOT RECOMMENDED FOR PRODUCTION)

If you just want to test quickly (⚠️ INSECURE - anyone can read/write):

```
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /{document=**} {
      allow read, write: if request.auth != null;
    }
  }
}
```

**Use the secure rules above for production!**
