import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/post_model.dart';
import '../utils/constants.dart';
import '../providers/auth_provider.dart';
import '../providers/post_provider.dart';
import '../screens/post_detail_screen.dart';

class PostCard extends ConsumerWidget {
  final Post post;

  const PostCard({super.key, required this.post});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(authStateProvider).value;
    final isUpvoted =
        currentUser != null && post.upvotedBy.contains(currentUser.uid);
    final isDownvoted =
        currentUser != null && post.downvotedBy.contains(currentUser.uid);
    final isBookmarked =
        currentUser != null && post.bookmarkedBy.contains(currentUser.uid);
    final firestoreService = ref.read(firestoreServiceProvider);

    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PostDetailScreen(post: post),
            ),
          );
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with author info and category
              Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: post.authorPhotoUrl != null
                        ? NetworkImage(post.authorPhotoUrl!)
                        : null,
                    child: post.authorPhotoUrl == null
                        ? Text(
                            post.authorName[0].toUpperCase(),
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          )
                        : null,
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          post.authorName,
                          style: AppTextStyles.body1.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          DateFormat('MMM dd, yyyy').format(post.createdAt),
                          style: AppTextStyles.caption,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.sm,
                      vertical: AppSpacing.xs,
                    ),
                    decoration: BoxDecoration(
                      color: PostCategory.getColor(
                        post.category,
                      ).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          PostCategory.getIcon(post.category),
                          size: 14,
                          color: PostCategory.getColor(post.category),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          post.category,
                          style: TextStyle(
                            fontSize: 12,
                            color: PostCategory.getColor(post.category),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.md),

              // Title
              Text(
                post.title,
                style: AppTextStyles.heading3,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: AppSpacing.sm),

              // Description
              Text(
                post.description,
                style: AppTextStyles.body2,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: AppSpacing.sm),

              // Post image
              if (post.imageUrl != null) ...[
                const SizedBox(height: AppSpacing.sm),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: CachedNetworkImage(
                    imageUrl: post.imageUrl!,
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(
                      height: 200,
                      color: Colors.grey[300],
                      child: const Center(child: CircularProgressIndicator()),
                    ),
                    errorWidget: (context, url, error) => Container(
                      height: 200,
                      color: Colors.grey[300],
                      child: const Icon(Icons.error),
                    ),
                  ),
                ),
              ],
              const SizedBox(height: AppSpacing.md),

              // Action buttons
              Row(
                children: [
                  // Upvote button
                  InkWell(
                    onTap: currentUser != null
                        ? () => firestoreService.toggleUpvote(
                            post.id,
                            currentUser.uid,
                          )
                        : null,
                    borderRadius: BorderRadius.circular(8),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.arrow_upward,
                        size: 20,
                        color: isUpvoted
                            ? Colors.orange
                            : AppColors.textSecondary,
                      ),
                    ),
                  ),

                  // Score
                  Text(
                    '${post.score}',
                    style: AppTextStyles.body1.copyWith(
                      fontWeight: FontWeight.w600,
                      color: post.score > 0
                          ? Colors.orange
                          : post.score < 0
                          ? Colors.blue
                          : AppColors.textSecondary,
                    ),
                  ),

                  // Downvote button
                  InkWell(
                    onTap: currentUser != null
                        ? () => firestoreService.toggleDownvote(
                            post.id,
                            currentUser.uid,
                          )
                        : null,
                    borderRadius: BorderRadius.circular(8),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.arrow_downward,
                        size: 20,
                        color: isDownvoted
                            ? Colors.blue
                            : AppColors.textSecondary,
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),

                  // Comment count
                  Row(
                    children: [
                      Icon(
                        Icons.comment_outlined,
                        size: 20,
                        color: AppColors.textSecondary,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${post.commentCount}',
                        style: AppTextStyles.caption,
                      ),
                    ],
                  ),
                  const Spacer(),

                  // Bookmark button
                  InkWell(
                    onTap: currentUser != null
                        ? () => firestoreService.toggleBookmark(
                            post.id,
                            currentUser.uid,
                          )
                        : null,
                    borderRadius: BorderRadius.circular(8),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                        size: 20,
                        color: isBookmarked
                            ? AppColors.primary
                            : AppColors.textSecondary,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
