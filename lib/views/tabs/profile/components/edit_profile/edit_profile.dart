import 'package:flutter/material.dart';
import 'package:protibeshi_app/views/tabs/profile/components/edit_profile/edit_add_bio.dart';
import 'package:protibeshi_app/views/tabs/profile/components/edit_profile/edit_name.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Change Name'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const EditNameScreen(),
                ),
              );
            },
          ),
          ListTile(
            title: const Text('Edit Bio'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const EditAddBioScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
