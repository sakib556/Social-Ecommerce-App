import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:protibeshi_app/models/user/location_model.dart';
import 'package:protibeshi_app/providers/user_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
class UserLocationBuilder extends ConsumerWidget {
  final Widget Function(
      BuildContext context, List<LocationModel> locationModels) builder;

  const UserLocationBuilder({Key? key, required this.builder})
      : super(key: key);

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return ref.watch(userLocationsProvider(FirebaseAuth.instance.currentUser!.uid))
              .maybeMap(
                orElse: () => Container(),
                error: (_) => Container(),
                loaded: (_)=> _.data.isNotEmpty 
                                    ? builder(context, _.data)
                                    : Container()
                  );
  }
}
