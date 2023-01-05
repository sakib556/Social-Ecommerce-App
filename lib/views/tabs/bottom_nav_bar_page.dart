import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:protibeshi_app/providers/call_provider.dart';
import 'package:protibeshi_app/providers/user_provider.dart';
import 'package:protibeshi_app/providers/verification_provider.dart';
import 'package:protibeshi_app/views/other_pages/loading.dart';
import 'package:protibeshi_app/views/tabs/call/call_screen.dart';
import 'package:protibeshi_app/views/tabs/explore/explore_screen.dart';
import 'package:protibeshi_app/views/tabs/home/home_screen.dart';
import 'package:protibeshi_app/views/tabs/dashboard/dashboard_screen.dart';
import 'package:protibeshi_app/views/tabs/profile/profile_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' as rp;

class BottomNavBarPage extends StatefulWidget {
  const BottomNavBarPage({Key? key}) : super(key: key);

  @override
  _BottomNavBarPageState createState() => _BottomNavBarPageState();
}

class _BottomNavBarPageState extends State<BottomNavBarPage>
    with WidgetsBindingObserver {
  late PageController _pageController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    WidgetsBinding.instance.addObserver(this);
    _notification = AppLifecycleState.resumed;
  }

  @override
  void dispose() {
    _pageController.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  late AppLifecycleState _notification;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    setState(() {
      _notification = state;
    });
  }

  void _onItemTapped(int index) {
    if (_currentIndex != index) {
      setState(() {
        _currentIndex = index;
        _pageController.jumpToPage(index);
        // _pageController.animateToPage(index,
        //     duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_notification == AppLifecycleState.resumed) {
      SetUserOnlineStatusProvider.setUserOnlineStatus(
          uid: FirebaseAuth.instance.currentUser!.uid, status: true);
    } else {
      SetUserOnlineStatusProvider.setUserOnlineStatus(
          uid: FirebaseAuth.instance.currentUser!.uid, status: false);
    }

    return WillPopScope(
      onWillPop: () async {
        if (_currentIndex == 0) {
          return true;
        } else {
          _onItemTapped(0);
          return false;
        }
      },
      child: rp.Consumer(builder: (context, ref, child) {
        ref.watch(verificationProvider);
        return ref.watch(getCallProvider).maybeMap(
            orElse: () => const Center(child: Loading()),
            loaded: (value) {
              return Stack(
                children: [
                  Scaffold(
                    bottomNavigationBar: BottomNavigationBar(
                      type: BottomNavigationBarType.fixed,
                      items: _bottomNavigationBarItems,
                      onTap: _onItemTapped,
                      showUnselectedLabels: false,
                      currentIndex: _currentIndex,
                      // unselectedItemColor: MyColors.secondaryColor,
                      // backgroundColor: MyColors.whiteColor,
                      elevation: 0,
                    ),
                    body: SizedBox.expand(
                      child: PageView(
                        controller: _pageController,
                        onPageChanged: (index) {
                          setState(() => _currentIndex = index);
                        },
                        children: const <Widget>[
                          KeepAlivePage(child: HomeScreen()),
                          KeepAlivePage(child: ExploreScreen()),
                          KeepAlivePage(child: DashBoardScreen()),
                          // KeepAlivePage(child: InboxScreen()),
                          KeepAlivePage(child: ProfileScreen()),
                        ],
                        physics: const NeverScrollableScrollPhysics(),
                      ),
                    ),
                  ),
                  value.data.isNotEmpty
                      ? RecieveCallScreen(callModel: value.data.first)
                      : const SizedBox(),
                ],
              );
            });
      }),
    );
  }
}

List<BottomNavigationBarItem> _bottomNavigationBarItems = [
  const BottomNavigationBarItem(
    icon: Icon(Icons.home_outlined),
    activeIcon: Icon(Icons.home),
    label: 'Home',
  ),
  const BottomNavigationBarItem(
    icon: Icon(Icons.explore_outlined),
    activeIcon: Icon(Icons.explore),
    label: 'Explore',
  ),
  const BottomNavigationBarItem(
    icon: Icon(Icons.category_outlined),
    activeIcon: Icon(Icons.category),
    label: 'Dashboard',
  ),
  // const BottomNavigationBarItem(
  //   icon: Icon(Icons.inbox_outlined),
  //   activeIcon: Icon(Icons.inbox),
  //   label: 'Inbox',
  // ),
  const BottomNavigationBarItem(
    icon: Icon(Icons.person_outline),
    activeIcon: Icon(Icons.person),
    label: 'Profile',
  ),
];

class KeepAlivePage extends StatefulWidget {
  final Widget child;
  const KeepAlivePage({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  _KeepAlivePageState createState() => _KeepAlivePageState();
}

class _KeepAlivePageState extends State<KeepAlivePage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    /// Dont't forget this
    super.build(context);

    return widget.child;
  }

  @override
  bool get wantKeepAlive => true;
}
