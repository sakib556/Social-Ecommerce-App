import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:protibeshi_app/providers/user_provider.dart';
import 'package:protibeshi_app/views/custom_widgets/custom_button.dart';
import 'package:protibeshi_app/views/others/space_vertical.dart';

class EditAddBioScreen extends ConsumerWidget {
  const EditAddBioScreen({Key? key}) : super(key: key);
 //new code
  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final _userProvider = ref.watch(userbasicInfoProvider(FirebaseAuth.instance.currentUser!.uid));
    final TextEditingController _bioController = TextEditingController();

    return _userProvider.maybeMap(
      orElse:()=> const Scaffold(),
      loaded: (_){
       if(_.data.toMap().isNotEmpty) {
          if(_.data.bio!=null){
              _bioController.text = _.data.bio!;
          }
        }
        return _.data.toMap().isNotEmpty ? Scaffold(
                appBar: AppBar(
                  title:
                      Text(_.data.bio == null ? 'Add Bio' : 'Edit Bio'),
                ),
                body: SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        TextField( 
                          keyboardType: TextInputType.multiline,
                          maxLength: null,
                          maxLines: null,
                          controller: _bioController,
                          decoration: const InputDecoration(
                            labelText: "Your bio",
                          ),
                        ),
                        const SpaceVertical(16),
                        CustomButton(
                          text:
                              _.data.bio == null ? "Add Bio" : "Update",
                          onPressed: () {
                            if (_bioController.text.isEmpty) {
                              EasyLoading.showInfo(
                                "Please enter your bio",
                              );
                            } else {
                              ref.watch(userBioUpdateProvider.notifier)
                                  .addUpdateBio(_bioController.text.trim());
                              _bioController.clear();
                              Navigator.pop(context);
                            }
                          },
                          color: Theme.of(context).colorScheme.primary,
                        )
                      ],
                    ),
                  ),
                ),
              )
                                         : const Scaffold();
      } 

      );
      
      }

}
