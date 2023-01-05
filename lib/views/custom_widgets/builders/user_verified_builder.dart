import 'package:flutter/material.dart';
import 'package:protibeshi_app/views/custom_widgets/builders/user_basic_builder.dart';

class UserVerifiedBuilder extends StatelessWidget {
  final Widget Function(BuildContext context, bool isVerified) builder;
  final String? userId;

  const UserVerifiedBuilder({
    Key? key,
    required this.builder,
    this.userId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return UserBasicBuilder(
      builder: (context, userBasicModel, isOnline) =>
          builder(context, userBasicModel.isVerified),
      userId: userId,
    );
  }
}
