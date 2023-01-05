import 'package:flutter/material.dart';
import 'package:protibeshi_app/providers/theme_provider.dart';
import 'package:protibeshi_app/themes/images.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' as rp;
import 'package:protibeshi_app/views/custom_widgets/builders/notification_builder.dart';
import 'package:protibeshi_app/views/tabs/home/components/home_post/home_post.dart';
import 'package:protibeshi_app/views/tabs/home/components/notification/notification_screen.dart';
import 'package:protibeshi_app/views/tabs/home/components/notification/notification_icon.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isNotification = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: SizedBox(
            width: MediaQuery.of(context).size.width * 0.25,
            child: Image.asset(MyImages.logo),
          ),
          actions: [
              IconButton(
                padding: const EdgeInsets.all(0),
                onPressed: () {
                  setState(() {
                    isNotification = false;
                  });
                },
                icon: const Icon(
                  Icons.home,
                )),
           
            IconButton(
                padding: const EdgeInsets.all(0),
                onPressed: () {
                  setState(() {
                    isNotification  = true;
                  });
                },
                icon: const NotificationIcon() ),
           rp.Consumer(builder: ((context, ref, child) {
              return Switch(
                value: ref.watch(themeProvider),
                onChanged: (value) {
                  ref.read(themeProvider.notifier).toggleDark();
                },
              );
            }))
          ],
        ),
        body: isNotification ?  NotificationBuilder(
          builder: ((context, notifyList) {
            return NotificationScreen(notifyList);
          }) )
          : const HomePostScreen()
          );
  }
}


