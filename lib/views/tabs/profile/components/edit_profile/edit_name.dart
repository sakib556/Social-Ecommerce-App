import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:protibeshi_app/providers/user_provider.dart';
import 'package:protibeshi_app/views/custom_widgets/custom_button.dart';
import 'package:protibeshi_app/views/custom_widgets/builders/user_basic_builder.dart';
import 'package:protibeshi_app/views/others/space_vertical.dart';

class EditNameScreen extends ConsumerWidget {
  const EditNameScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController _nameController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Change Name'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: UserBasicBuilder(builder: (context, user, isOnline) {
            _nameController.text = user.name ?? '';
            return Column(
              children: [
                TextField(
                  keyboardType: TextInputType.name,
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: "Your Name",
                  ),
                ),
                const SpaceVertical(16),
                CustomButton(
                  text: "Update",
                  onPressed: () {
                    if (_nameController.text.isEmpty) {
                      EasyLoading.showInfo(
                        "Please enter your name",
                      );
                    } else {
                      ref
                          .watch(userUpdateNameProvider.notifier)
                          .updateName(_nameController.text.trim());
                      _nameController.clear();
                      Navigator.pop(context);
                    }
                  },
                  color: Theme.of(context).colorScheme.primary,
                )
              ],
            );
          }),
        ),
      ),
    );
  }
}
