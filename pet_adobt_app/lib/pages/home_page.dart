import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_adobt_app/pages/adobt_page.dart';
import 'package:pet_adobt_app/pages/checkout_page.dart';
import 'package:pet_adobt_app/pages/history_page.dart';
import 'package:pet_adobt_app/pages/profile_page.dart';

import '../config/app_asset.dart';
import '../config/app_color.dart';
import '../controller/c_home.dart';
import 'list_page.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final cHome = Get.put(CHome());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (cHome.indexPage == 1) {
          return const ListPage();
        } else if (cHome.indexPage == 2) {
          return const HistoryPage();
        } else if (cHome.indexPage == 3) {
          return ProfilePage();
        }
        return const AdobtPage();
      }),
      bottomNavigationBar: Obx(() {
        return Material(
          elevation: 8,
          child: Container(
            color: Colors.white,
            padding: const EdgeInsets.only(top: 8, bottom: 6),
            child: BottomNavigationBar(
              currentIndex: cHome.indexPage,
              onTap: (value) => cHome.indexPage = value,
              backgroundColor: Colors.transparent,
              elevation: 0,
              type: BottomNavigationBarType.fixed,
              unselectedItemColor: Colors.grey,
              selectedItemColor: Colors.black54,
              selectedIconTheme: const IconThemeData(color: AppColor.primary),
              selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
              selectedFontSize: 12,
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.pets),
                  label: 'Pet List',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_cart),
                  label: 'History',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person_outline),
                  label: 'Profile',
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
