import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../models/post_model.dart';
import '../utils/constants.dart';
import '../providers/auth_provider.dart';
import '../providers/post_provider.dart';
import '../providers/comment_provider.dart';

class PostDetailScreen extends ConsumerStatefulWidget {
  final Post post;

  const PostDetailScreen({super.key, required this.post});

  @override
  ConsumerState<PostDetailScreen> createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends ConsumerState<PostDetailScreen> {
  final _commentController = TextEditingController();

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  void _addComment() async {
    if (_commentController.text.trim().isEmpty) return;

    final currentUser = ref.read(authStateProvider).value;
    if (currentUser == null) return;

    final firestoreService = ref.read(firestoreServiceProvider);

    try {
      await firestoreService.addComment(
        postId: widget.post.id,
        content: _commentController.text.trim(),
        authorId: currentUser.uid,
        authorName: currentUser.displayName ?? 'Anonymous',
        authorPhotoUrl: currentUser.photoURL,
      );

      _commentController.clear();
      FocusScope.of(context).unfocus();

      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Comment added!')));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error adding comment: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = ref.watch(authStateProvider).value;
    final isUpvoted =
        currentUser != null && widget.post.upvotedBy.contains(currentUser.uid);
    final isDownvoted =
        currentUser != null &&
        widget.post.downvotedBy.contains(currentUser.uid);
    final isBookmarked =
        currentUser != null &&
        widget.post.bookmarkedBy.contains(currentUser.uid);
    final firestoreService = ref.read(firestoreServiceProvider);
    final commentsAsync = ref.watch(commentsProvider(widget.post.id));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        title: const Text('Post Details'),
        actions: [
          if (currentUser != null && currentUser.uid == widget.post.authorId)
            PopupMenuButton(
              icon: const Icon(Icons.more_vert),
              itemBuilder: (context) => [
                PopupMenuItem(
                  child: const Row(
                    children: [
                      Icon(Icons.delete, color: AppColors.error),
                      SizedBox(width: 8),
                      Text('Delete'),
                    ],
                  ),
                  onTap: () async {
                    await firestoreService.deletePost(widget.post.id);
                    if (context.mounted) {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Post deleted')),
                      );
                    }
                  },
                ),
              ],
            ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Author info and post content...
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 24,
                        backgroundImage: widget.post.authorPhotoUrl != null
                            ? NetworkImage(widget.post.authorPhotoUrl!)
                            : null,
                        child: widget.post.authorPhotoUrl == null
                            ? Text(widget.post.authorName[0].toUpperCase())
                            : null,
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.post.authorName,
                              style: AppTextStyles.heading3,
                            ),
                            Text(
                              DateFormat(
                                'MMM dd, yyyy',
                              ).format(widget.post.createdAt),
                              style: AppTextStyles.caption,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  Text(widget.post.title, style: AppTextStyles.heading1),
                  const SizedBox(height: AppSpacing.md),
                  Text(widget.post.description, style: AppTextStyles.body1),
                  const SizedBox(height: AppSpacing.lg),

                  // Action buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          IconButton(
                            onPressed: currentUser != null
                                ? () => firestoreService.toggleUpvote(
                                    widget.post.id,
                                    currentUser.uid,
                                  )
                                : null,
                            icon: Icon(
                              Icons.arrow_upward,
                              color: isUpvoted ? Colors.orange : Colors.grey,
                            ),
                          ),
                          Text('${widget.post.score}'),
                          IconButton(
                            onPressed: currentUser != null
                                ? () => firestoreService.toggleDownvote(
                                    widget.post.id,
                                    currentUser.uid,
                                  )
                                : null,
                            icon: Icon(
                              Icons.arrow_downward,
                              color: isDownvoted ? Colors.blue : Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  const Divider(),
                  Text('Comments', style: AppTextStyles.heading2),
                  const SizedBox(height: AppSpacing.md),

                  // Comments list
                  commentsAsync.when(
                    data: (comments) {
                      if (comments.isEmpty) {
                        return const Center(child: Text('No comments yet'));
                      }
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: comments.length,
                        itemBuilder: (context, index) {
                          final comment = comments[index];
                          return ListTile(
                            leading: CircleAvatar(
                              child: Text(comment.authorName[0].toUpperCase()),
                            ),
                            title: Text(comment.authorName),
                            subtitle: Text(comment.content),
                            trailing:
                                currentUser != null &&
                                    comment.authorId == currentUser.uid
                                ? IconButton(
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                    onPressed: () =>
                                        firestoreService.deleteComment(
                                          comment.id,
                                          widget.post.id,
                                        ),
                                  )
                                : null,
                          );
                        },
                      );
                    },
                    loading: () => const CircularProgressIndicator(),
                    error: (_, __) => const Text('Error loading comments'),
                  ),
                ],
              ),
            ),
          ),

          // Comment input
          if (currentUser != null)
            Container(
              padding: const EdgeInsets.all(AppSpacing.sm),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _commentController,
                      decoration: const InputDecoration(
                        hintText: 'Add a comment...',
                      ),
                      onSubmitted: (_) => _addComment(),
                    ),
                  ),
                  IconButton(
                    onPressed: _addComment,
                    icon: const Icon(Icons.send),
                    color: AppColors.primary,
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
