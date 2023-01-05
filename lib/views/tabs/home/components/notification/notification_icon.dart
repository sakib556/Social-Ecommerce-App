import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:protibeshi_app/views/custom_widgets/builders/notification_builder.dart';

class NotificationIcon extends ConsumerWidget {
  const NotificationIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return Stack(
    children: <Widget>[
       const Icon(Icons.notifications),
       NotificationBuilder(
          builder: ((context, notifyList) {
            final notReadList = notifyList.where((element) => !element.isRead).toList();
            return NotificationBadge(counter: notReadList.length);
          }) ),
       
    ],
  );
  }
}
class NotificationBadge extends StatelessWidget {
  const NotificationBadge({Key? key, required this.counter}) : super(key: key);
  final int counter;
  @override
  Widget build(BuildContext context) {
    return  Positioned(
        right: 0,
        child:  Container(
          padding: const EdgeInsets.all(1),
          decoration:  BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(6),
          ),
          constraints: const BoxConstraints(
            minWidth: 12,
            minHeight: 12,
          ),
          child: Text(
            '$counter',
            style:  const TextStyle(
              // color: Colors.white,
              fontSize: 8,
            ),
            textAlign: TextAlign.center,
          )
            ),
        );
  }
}