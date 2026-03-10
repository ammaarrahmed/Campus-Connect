import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart' show StateProvider;
import '../models/post_model.dart';
import '../services/firestore_service.dart';

// Firestore service provider
final firestoreServiceProvider = Provider<FirestoreService>((ref) {
  return FirestoreService();
});

// All posts provider
final postsProvider = StreamProvider<List<Post>>((ref) {
  return ref.watch(firestoreServiceProvider).getPosts();
});

// Selected category provider
final selectedCategoryProvider = StateProvider<String?>((ref) => null);

// Search query provider
final searchQueryProvider = StateProvider<String>((ref) => '');

// Sort option provider
enum SortOption { popular, recent, oldest }

final sortOptionProvider = StateProvider<SortOption>(
  (ref) => SortOption.recent,
);

// Filtered posts provider (combines category filter, search, and sorting)
final filteredPostsProvider = Provider<List<Post>>((ref) {
  final postsAsync = ref.watch(postsProvider);
  final selectedCategory = ref.watch(selectedCategoryProvider);
  final searchQuery = ref.watch(searchQueryProvider);
  final sortOption = ref.watch(sortOptionProvider);

  return postsAsync.when(
    data: (posts) {
      var filtered = posts;

      // Filter by category
      if (selectedCategory != null) {
        filtered = filtered
            .where((post) => post.category == selectedCategory)
            .toList();
      }

      // Filter by search query
      if (searchQuery.isNotEmpty) {
        filtered = filtered.where((post) {
          return post.title.toLowerCase().contains(searchQuery.toLowerCase()) ||
              post.description.toLowerCase().contains(
                searchQuery.toLowerCase(),
              );
        }).toList();
      }

      // Sort posts based on selected option
      switch (sortOption) {
        case SortOption.popular:
          filtered.sort((a, b) => b.score.compareTo(a.score));
          break;
        case SortOption.recent:
          filtered.sort((a, b) => b.createdAt.compareTo(a.createdAt));
          break;
        case SortOption.oldest:
          filtered.sort((a, b) => a.createdAt.compareTo(b.createdAt));
          break;
      }

      return filtered;
    },
    loading: () => [],
    error: (_, __) => [],
  );
});

// User posts provider
final userPostsProvider = StreamProvider.family<List<Post>, String>((
  ref,
  userId,
) {
  return ref.watch(firestoreServiceProvider).getPostsByUser(userId);
});

// Bookmarked posts provider
final bookmarkedPostsProvider = StreamProvider.family<List<Post>, String>((
  ref,
  userId,
) {
  return ref.watch(firestoreServiceProvider).getBookmarkedPosts(userId);
});
