import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:protibeshi_app/models/borrow_post/borrow_post_model.dart';
import 'package:protibeshi_app/providers/post_provider.dart';
import 'package:protibeshi_app/views/other_pages/loading.dart';
import 'package:protibeshi_app/views/other_pages/something_went_wrong.dart';

class PostBuilder extends ConsumerWidget {
  final Widget Function(BuildContext context, List<BorrowPostModel> postList)
      builder;
  final bool isLoading;
  const PostBuilder({
    Key? key,
    required this.builder,
    required this.isLoading,
  }) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(getBorrowPostsProvider).maybeMap(
          error: (_) =>  SomethingWentWrong(errorMessage: _.error),
          orElse: () => isLoading ? const Loading() : const SizedBox.shrink(),
          loaded: (posts) => posts.data.isNotEmpty
              ? builder(context, posts.data)
              : const Center(child: Text("No posts")),
        );
  }
  // return TeachingBuilder(builder: ((context, skillList) {
  // return builder(context,allList);
}
