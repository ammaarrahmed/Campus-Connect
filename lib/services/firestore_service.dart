import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';
import '../models/post_model.dart';
import '../models/comment_model.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final _uuid = const Uuid();

  // Collection reference
  CollectionReference get _postsCollection => _firestore.collection('posts');
  CollectionReference get _commentsCollection =>
      _firestore.collection('comments');

  // Get all posts (ordered by created date)
  Stream<List<Post>> getPosts() {
    return _postsCollection
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((doc) {
            return Post.fromMap(doc.data() as Map<String, dynamic>);
          }).toList();
        });
  }

  // Get posts by category
  Stream<List<Post>> getPostsByCategory(String category) {
    return _postsCollection
        .where('category', isEqualTo: category)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((doc) {
            return Post.fromMap(doc.data() as Map<String, dynamic>);
          }).toList();
        });
  }

  // Get posts by user
  Stream<List<Post>> getPostsByUser(String userId) {
    return _postsCollection
        .where('authorId', isEqualTo: userId)
        .snapshots()
        .map((snapshot) {
          final posts = snapshot.docs.map((doc) {
            return Post.fromMap(doc.data() as Map<String, dynamic>);
          }).toList();

          // Sort on client side to avoid index requirement
          posts.sort((a, b) => b.createdAt.compareTo(a.createdAt));
          return posts;
        });
  }

  // Add a new post
  Future<void> addPost({
    required String title,
    required String description,
    required String category,
    required String authorId,
    required String authorName,
    String? authorPhotoUrl,
    String? imageUrl,
  }) async {
    final postId = _uuid.v4();
    final post = Post(
      id: postId,
      title: title,
      description: description,
      category: category,
      authorId: authorId,
      authorName: authorName,
      authorPhotoUrl: authorPhotoUrl,
      imageUrl: imageUrl,
      createdAt: DateTime.now(),
    );

    await _postsCollection.doc(postId).set(post.toMap());
  }

  // Update a post
  Future<void> updatePost(Post post) async {
    await _postsCollection.doc(post.id).update(post.toMap());
  }

  // Delete a post
  Future<void> deletePost(String postId) async {
    await _postsCollection.doc(postId).delete();
  }

  // Toggle like on a post
  Future<void> toggleLike(String postId, String userId) async {
    final docRef = _postsCollection.doc(postId);
    final doc = await docRef.get();

    if (doc.exists) {
      final post = Post.fromMap(doc.data() as Map<String, dynamic>);
      List<String> likedBy = List.from(post.likedBy);

      if (likedBy.contains(userId)) {
        likedBy.remove(userId);
      } else {
        likedBy.add(userId);
      }

      await docRef.update({'likedBy': likedBy});
    }
  }

  // Toggle bookmark on a post
  Future<void> toggleBookmark(String postId, String userId) async {
    final docRef = _postsCollection.doc(postId);
    final doc = await docRef.get();

    if (doc.exists) {
      final post = Post.fromMap(doc.data() as Map<String, dynamic>);
      List<String> bookmarkedBy = List.from(post.bookmarkedBy);

      if (bookmarkedBy.contains(userId)) {
        bookmarkedBy.remove(userId);
      } else {
        bookmarkedBy.add(userId);
      }

      await docRef.update({'bookmarkedBy': bookmarkedBy});
    }
  }

  // Toggle upvote on a post (removes downvote if present)
  Future<void> toggleUpvote(String postId, String userId) async {
    final docRef = _postsCollection.doc(postId);
    final doc = await docRef.get();

    if (doc.exists) {
      final post = Post.fromMap(doc.data() as Map<String, dynamic>);
      List<String> upvotedBy = List.from(post.upvotedBy);
      List<String> downvotedBy = List.from(post.downvotedBy);

      // Remove from downvotes if present
      if (downvotedBy.contains(userId)) {
        downvotedBy.remove(userId);
      }

      // Toggle upvote
      if (upvotedBy.contains(userId)) {
        upvotedBy.remove(userId);
      } else {
        upvotedBy.add(userId);
      }

      await docRef.update({'upvotedBy': upvotedBy, 'downvotedBy': downvotedBy});
    }
  }

  // Toggle downvote on a post (removes upvote if present)
  Future<void> toggleDownvote(String postId, String userId) async {
    final docRef = _postsCollection.doc(postId);
    final doc = await docRef.get();

    if (doc.exists) {
      final post = Post.fromMap(doc.data() as Map<String, dynamic>);
      List<String> upvotedBy = List.from(post.upvotedBy);
      List<String> downvotedBy = List.from(post.downvotedBy);

      // Remove from upvotes if present
      if (upvotedBy.contains(userId)) {
        upvotedBy.remove(userId);
      }

      // Toggle downvote
      if (downvotedBy.contains(userId)) {
        downvotedBy.remove(userId);
      } else {
        downvotedBy.add(userId);
      }

      await docRef.update({'upvotedBy': upvotedBy, 'downvotedBy': downvotedBy});
    }
  }

  // Get bookmarked posts for a user
  Stream<List<Post>> getBookmarkedPosts(String userId) {
    return _postsCollection
        .where('bookmarkedBy', arrayContains: userId)
        .snapshots()
        .map((snapshot) {
          final posts = snapshot.docs.map((doc) {
            return Post.fromMap(doc.data() as Map<String, dynamic>);
          }).toList();

          // Sort on client side to avoid index requirement
          posts.sort((a, b) => b.createdAt.compareTo(a.createdAt));
          return posts;
        });
  }

  // Search posts
  Stream<List<Post>> searchPosts(String query) {
    return _postsCollection
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs
              .map((doc) => Post.fromMap(doc.data() as Map<String, dynamic>))
              .where(
                (post) =>
                    post.title.toLowerCase().contains(query.toLowerCase()) ||
                    post.description.toLowerCase().contains(
                      query.toLowerCase(),
                    ),
              )
              .toList();
        });
  }

  // ==================== COMMENT METHODS ====================

  // Add a comment to a post
  Future<void> addComment({
    required String postId,
    required String content,
    required String authorId,
    required String authorName,
    String? authorPhotoUrl,
  }) async {
    final commentId = _uuid.v4();
    final comment = Comment(
      id: commentId,
      postId: postId,
      content: content,
      authorId: authorId,
      authorName: authorName,
      authorPhotoUrl: authorPhotoUrl,
      createdAt: DateTime.now(),
    );

    // Add comment to comments collection
    await _commentsCollection.doc(commentId).set(comment.toMap());

    // Increment comment count on the post
    final postRef = _postsCollection.doc(postId);
    await postRef.update({'commentCount': FieldValue.increment(1)});
  }

  // Get comments for a post
  Stream<List<Comment>> getComments(String postId) {
    return _commentsCollection
        .where('postId', isEqualTo: postId)
        .snapshots()
        .map((snapshot) {
          final comments = snapshot.docs.map((doc) {
            return Comment.fromMap(doc.data() as Map<String, dynamic>);
          }).toList();

          // Sort on client side to avoid index requirement
          comments.sort((a, b) => a.createdAt.compareTo(b.createdAt));
          return comments;
        });
  }

  // Delete a comment
  Future<void> deleteComment(String commentId, String postId) async {
    await _commentsCollection.doc(commentId).delete();

    // Decrement comment count on the post
    final postRef = _postsCollection.doc(postId);
    await postRef.update({'commentCount': FieldValue.increment(-1)});
  }
}
