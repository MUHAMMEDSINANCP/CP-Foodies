import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/color_extension.dart';
import 'package:food_delivery_app/common_widget/tab_button.dart';
import 'package:food_delivery_app/view/home/home_view.dart';
import 'package:food_delivery_app/view/menu/menu_view.dart';
import 'package:food_delivery_app/view/more/more_view.dart';
import 'package:food_delivery_app/view/offer/offer_view.dart';
import 'package:food_delivery_app/view/profile/profile_view.dart';

class MainTabView extends StatefulWidget {
  const MainTabView({super.key});

  @override
  State<MainTabView> createState() => _MainTabViewState();
}

class _MainTabViewState extends State<MainTabView> {
  int selectTab = 2;
  PageStorageBucket storageBucket = PageStorageBucket();
  Widget selectPageview = const HomeView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(bucket: storageBucket, child: selectPageview),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: SizedBox(
        width: 60,
        height: 60,
        child: FloatingActionButton(
          onPressed: () {
            if (selectTab != 2) {
              selectTab = 2;
              selectPageview = const HomeView();
            }
            if (mounted) {
              setState(() {});
            }
          },
          shape: const CircleBorder(),
          backgroundColor: selectTab == 2 ? TColor.primary : TColor.placeholder,
          child: Image.asset(
            "assets/img/tab_home.png",
            height: 30,
            width: 30,
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        surfaceTintColor: TColor.white,
        shadowColor: Colors.black,
        elevation: 1,
        notchMargin: 12,
        height: 64,
        shape: const CircularNotchedRectangle(),
        child: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TabButton(
                onTap: () {
                  if (selectTab != 0) {
                    selectTab = 0;
                    selectPageview = const MenuView();
                  }
                  if (mounted) {
                    setState(() {});
                  }
                },
                title: "Menu",
                isSelected: selectTab == 0,
                icon: "assets/img/tab_menu.png",
              ),
              TabButton(
                onTap: () {
                  if (selectTab != 1) {
                    selectTab = 1;
                    selectPageview = const OfferView();
                  }
                  if (mounted) {
                    setState(() {});
                  }
                },
                title: "Offer",
                isSelected: selectTab == 1,
                icon: "assets/img/tab_offer.png",
              ),
              const SizedBox(
                height: 40,
                width: 40,
              ),
              TabButton(
                onTap: () {
                  if (selectTab != 3) {
                    selectTab = 3;
                    selectPageview = const ProfileView();
                  }
                  if (mounted) {
                    setState(() {});
                  }
                },
                title: "Profile",
                isSelected: selectTab == 3,
                icon: "assets/img/tab_profile.png",
              ),
              TabButton(
                onTap: () {
                  if (selectTab != 4) {
                    selectTab = 4;
                    selectPageview = const MoreView();
                  }
                  if (mounted) {
                    setState(() {});
                  }
                },
                title: "More",
                isSelected: selectTab == 4,
                icon: "assets/img/tab_more.png",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
