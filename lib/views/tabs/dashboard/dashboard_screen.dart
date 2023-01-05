import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:protibeshi_app/providers/offer_provider.dart';
import 'package:protibeshi_app/providers/order_provider.dart';
import 'package:protibeshi_app/themes/images.dart';
import 'package:protibeshi_app/views/tabs/dashboard/pages/sent.dart';
import 'package:protibeshi_app/views/tabs/dashboard/pages/recieved.dart';
import 'package:protibeshi_app/views/tabs/dashboard/pages/orders.dart';

class DashBoardScreen extends ConsumerWidget {
  const DashBoardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
           appBar: AppBar(
        centerTitle: false,
        title: SizedBox(
          width: MediaQuery.of(context).size.width * 0.25,
          child: Image.asset(MyImages.logo),
        ),
        actions: [
          IconButton(
              padding: const EdgeInsets.all(0),
              onPressed: () {},
              icon: const Icon(
                Icons.notifications_none_outlined,
              )),
          ElevatedButton(onPressed: (){
            ref.read(getOfferProvider.notifier).getOffers();
            ref.read(getOrderProvider.notifier).getOrders();
          }, child: const Text("refresh"))
        ],
      ),
        body: CustomScrollView(
          slivers: [
          const SliverAppBar(
             automaticallyImplyLeading: false,
             floating: true,
              title: TabBar(
                // labelColor: MyColors.primaryColor,
                // indicatorColor: MyColors.primaryColor,
                // unselectedLabelColor: MyColors.blackColor,
                tabs: [
                  Tab(icon: Text("Orders")),
                  Tab(icon: Text("Recieved")),
                  Tab(icon: Text("Sent")),
                ],
              ),
              pinned: true,
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: const TabBarView(
                    children: [
                      OrdersPage(),        
                      OfferRecievedPage(),
                      OfferSentPage(),
                    ],
                  ),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}

