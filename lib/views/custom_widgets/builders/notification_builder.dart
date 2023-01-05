import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:protibeshi_app/constants/firebase_constants.dart';
import 'package:protibeshi_app/models/notification/notification.dart';
import 'package:protibeshi_app/providers/notification_provider.dart';
import 'package:protibeshi_app/views/other_pages/loading.dart';
import 'package:protibeshi_app/views/other_pages/something_went_wrong.dart';

class NotificationBuilder extends ConsumerWidget {
  final Widget Function(BuildContext context, List<NotificationModel> notifyList) builder;
  const NotificationBuilder({
    Key? key,
    required this.builder,
  }) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(getNotificationProvider).maybeMap(
        orElse: () => const Loading(),
        error: (_) => const SomethingWentWrong(),
        loaded: (list) {
          return builder(context,list.data);
        });
  }
}
