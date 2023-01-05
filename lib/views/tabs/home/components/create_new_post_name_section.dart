import 'package:flutter/material.dart';

import 'package:protibeshi_app/views/custom_widgets/user_avatar.dart';
import 'package:protibeshi_app/views/custom_widgets/user_name.dart';

class CretePostNameSection extends StatelessWidget {
  const CretePostNameSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: const [
          UserAvatar(),
          SizedBox(width: 16),
          Expanded(child: UserName()),
        ],
      ),
    );
  }
}
