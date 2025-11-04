import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/comment_model.dart';
import 'post_provider.dart';

// Comments provider for a specific post
final commentsProvider = StreamProvider.family<List<Comment>, String>((
  ref,
  postId,
) {
  return ref.watch(firestoreServiceProvider).getComments(postId);
});
