import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:protibeshi_app/providers/auth_provider.dart';
import 'package:protibeshi_app/views/tabs/profile/settings/verification/verification_steps.dart';
import 'package:protibeshi_app/views/tabs/profile/components/user_locations.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text('My Locations'),
            trailing: const Icon(Icons.location_on_outlined),
            onTap: () async {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const UserLocations()));
            },
          ),

          //TODO: This tile needs modification.Icon Should change depending on the verification status, its static for now
          ListTile(
            title: const Text('Get Verified'),
            trailing: const Icon(Icons.verified_outlined),
            onTap: () async {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const GetVerifiedPage(),
                ),
              );
            },
          ),
          ListTile(
            title: const Text('Log Out'),
            trailing: const Icon(Icons.logout_outlined),
            onTap: () async {
              EasyLoading.show(status: 'Logging out...');
              await ref
                  .watch(signOutProvider.notifier)
                  .signOut(context)
                  .then((value) async {
                Navigator.pop(context);
              });
              EasyLoading.dismiss();
            },
          ),
        ],
      ),
    );
  }
}
