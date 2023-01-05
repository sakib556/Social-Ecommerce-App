import 'package:flutter/material.dart';

import 'package:protibeshi_app/views/custom_widgets/builders/user_basic_builder.dart';

class UserName extends StatelessWidget {
  final String? userId;
  const UserName({
    Key? key,
    this.userId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return UserBasicBuilder(
      builder: (context, userBasicModel, isOnline) => Text(
        userBasicModel.name ?? "No Name",
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context).textTheme.subtitle2,
      ),
      userId: userId,
    );
  }
}
