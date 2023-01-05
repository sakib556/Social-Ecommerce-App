import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:protibeshi_app/helper/api_state.dart';
import 'package:protibeshi_app/models/borrow_post/borrow_post_model.dart';
import 'package:protibeshi_app/state_notfiers/post_notifier.dart';

//New Codes of riverpod
// final parentCategoryProviders =
//     StateNotifierProvider<ParentCategoryNotifier, ApiState<List<ParentCategoryModelOld>>>(
//         (ref) => ParentCategoryNotifier());
final getBorrowPostsProvider =
    StateNotifierProvider<GetBorrowPostNotifier, ApiState<List<BorrowPostModel>>>(
        (ref) => GetBorrowPostNotifier());
final borrowPostProvider =
    StateNotifierProvider<BorrowPostNotifier, ApiState<String>>(
        (ref) => BorrowPostNotifier());
