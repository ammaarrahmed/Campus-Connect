import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/auth_provider.dart';
import '../providers/post_provider.dart';
import '../utils/constants.dart';
import '../widgets/post_card.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(authStateProvider).value;
    final authService = ref.read(authServiceProvider);

    if (currentUser == null) {
      return const Scaffold(body: Center(child: Text('Not logged in')));
    }

    final userPostsAsync = ref.watch(userPostsProvider(currentUser.uid));
    final bookmarkedPostsAsync = ref.watch(
      bookmarkedPostsProvider(currentUser.uid),
    );

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          title: const Text('Profile'),
          actions: [
            PopupMenuButton(
              icon: const Icon(Icons.more_vert),
              itemBuilder: (context) => [
                PopupMenuItem(
                  child: const Row(
                    children: [
                      Icon(Icons.logout, color: AppColors.error),
                      SizedBox(width: 8),
                      Text('Sign Out'),
                    ],
                  ),
                  onTap: () async {
                    await authService.signOut();
                  },
                ),
              ],
            ),
          ],
          bottom: const TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            indicatorColor: Colors.white,
            tabs: [
              Tab(text: 'My Posts', icon: Icon(Icons.article)),
              Tab(text: 'Bookmarks', icon: Icon(Icons.bookmark)),
            ],
          ),
        ),
        body: Column(
          children: [
            // Profile header
            Container(
              color: AppColors.primary,
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: currentUser.photoURL != null
                        ? NetworkImage(currentUser.photoURL!)
                        : null,
                    child: currentUser.photoURL == null
                        ? Text(
                            (currentUser.displayName ?? 'U')[0].toUpperCase(),
                            style: const TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        : null,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Text(
                    currentUser.displayName ?? 'Anonymous',
                    style: AppTextStyles.heading2.copyWith(color: Colors.white),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    currentUser.email ?? '',
                    style: AppTextStyles.body2.copyWith(color: Colors.white70),
                  ),
                ],
              ),
            ),

            // Tab content
            Expanded(
              child: TabBarView(
                children: [
                  // My Posts tab
                  userPostsAsync.when(
                    data: (posts) {
                      if (posts.isEmpty) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.article_outlined,
                                size: 80,
                                color: Colors.grey[300],
                              ),
                              const SizedBox(height: AppSpacing.md),
                              Text(
                                'No posts yet',
                                style: AppTextStyles.heading3.copyWith(
                                  color: Colors.grey[600],
                                ),
                              ),
                              const SizedBox(height: AppSpacing.sm),
                              Text(
                                'Create your first post!',
                                style: AppTextStyles.body2,
                              ),
                            ],
                          ),
                        );
                      }

                      return ListView.builder(
                        padding: const EdgeInsets.symmetric(
                          vertical: AppSpacing.md,
                        ),
                        itemCount: posts.length,
                        itemBuilder: (context, index) {
                          return PostCard(post: posts[index]);
                        },
                      );
                    },
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                    error: (error, stack) =>
                        Center(child: Text('Error: $error')),
                  ),

                  // Bookmarks tab
                  bookmarkedPostsAsync.when(
                    data: (posts) {
                      if (posts.isEmpty) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.bookmark_border,
                                size: 80,
                                color: Colors.grey[300],
                              ),
                              const SizedBox(height: AppSpacing.md),
                              Text(
                                'No bookmarks yet',
                                style: AppTextStyles.heading3.copyWith(
                                  color: Colors.grey[600],
                                ),
                              ),
                              const SizedBox(height: AppSpacing.sm),
                              Text(
                                'Bookmark posts to see them here!',
                                style: AppTextStyles.body2,
                              ),
                            ],
                          ),
                        );
                      }

                      return ListView.builder(
                        padding: const EdgeInsets.symmetric(
                          vertical: AppSpacing.md,
                        ),
                        itemCount: posts.length,
                        itemBuilder: (context, index) {
                          return PostCard(post: posts[index]);
                        },
                      );
                    },
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                    error: (error, stack) =>
                        Center(child: Text('Error: $error')),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
