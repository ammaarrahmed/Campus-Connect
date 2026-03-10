import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String id;
  final String title;
  final String description;
  final String category;
  final String authorId;
  final String authorName;
  final String? authorPhotoUrl;
  final String? imageUrl; // Post image
  final DateTime createdAt;
  final List<String> likedBy; // Keep for backwards compatibility
  final List<String> upvotedBy;
  final List<String> downvotedBy;
  final List<String> bookmarkedBy;
  final int commentCount;

  Post({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.authorId,
    required this.authorName,
    this.authorPhotoUrl,
    this.imageUrl,
    required this.createdAt,
    this.likedBy = const [],
    this.upvotedBy = const [],
    this.downvotedBy = const [],
    this.bookmarkedBy = const [],
    this.commentCount = 0,
  });

  // Calculate Reddit-style score
  int get score => upvotedBy.length - downvotedBy.length;

  // Convert Post to Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'category': category,
      'authorId': authorId,
      'authorName': authorName,
      'authorPhotoUrl': authorPhotoUrl,
      'imageUrl': imageUrl,
      'createdAt': Timestamp.fromDate(createdAt),
      'likedBy': likedBy,
      'upvotedBy': upvotedBy,
      'downvotedBy': downvotedBy,
      'bookmarkedBy': bookmarkedBy,
      'commentCount': commentCount,
    };
  }

  // Create Post from Firestore document
  factory Post.fromMap(Map<String, dynamic> map) {
    final createdAtRaw = map['createdAt'];

    return Post(
      id: map['id'] as String? ?? '',
      title: map['title'] as String? ?? '',
      description: map['description'] as String? ?? '',
      category: map['category'] as String? ?? '',
      authorId: map['authorId'] as String? ?? '',
      authorName: map['authorName'] as String? ?? 'Anonymous',
      authorPhotoUrl: map['authorPhotoUrl'] as String?,
      imageUrl: map['imageUrl'] as String?,
      createdAt: createdAtRaw is Timestamp
          ? createdAtRaw.toDate()
          : DateTime.now(),
      likedBy: List<String>.from(map['likedBy'] as Iterable<dynamic>? ?? []),
      upvotedBy: List<String>.from(
        map['upvotedBy'] as Iterable<dynamic>? ?? [],
      ),
      downvotedBy: List<String>.from(
        map['downvotedBy'] as Iterable<dynamic>? ?? [],
      ),
      bookmarkedBy: List<String>.from(
        map['bookmarkedBy'] as Iterable<dynamic>? ?? [],
      ),
      commentCount: map['commentCount'] as int? ?? 0,
    );
  }

  // Create a copy with modifications
  Post copyWith({
    String? id,
    String? title,
    String? description,
    String? category,
    String? authorId,
    String? authorName,
    String? authorPhotoUrl,
    String? imageUrl,
    DateTime? createdAt,
    List<String>? likedBy,
    List<String>? upvotedBy,
    List<String>? downvotedBy,
    List<String>? bookmarkedBy,
    int? commentCount,
  }) {
    return Post(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      category: category ?? this.category,
      authorId: authorId ?? this.authorId,
      authorName: authorName ?? this.authorName,
      authorPhotoUrl: authorPhotoUrl ?? this.authorPhotoUrl,
      imageUrl: imageUrl ?? this.imageUrl,
      createdAt: createdAt ?? this.createdAt,
      likedBy: likedBy ?? this.likedBy,
      upvotedBy: upvotedBy ?? this.upvotedBy,
      downvotedBy: downvotedBy ?? this.downvotedBy,
      bookmarkedBy: bookmarkedBy ?? this.bookmarkedBy,
      commentCount: commentCount ?? this.commentCount,
    );
  }
}
