// enric corrected 2022JUN14

import '../../screens/home/homecontroller.dart';
import '../../utils/custom_color.dart';
import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class Home extends StatelessWidget {
  HomeController homeController = HomeController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      bottomNavigationBar: _bottomNavBar(),
      body: _body(),
    );
  }

  Widget _body() {
    return GetBuilder(
      init: homeController,
      builder: (_) {
        return homeController.homePage;
      },
    );
  }

  Widget _bottomNavBar() {
    return GetBuilder(
      init: homeController,
      builder: (_) => BottomNavigationBar(
        onTap: (index) {
          homeController.onNavbarItemTap(index);
        },
        currentIndex: homeController.navbarIndex,
        backgroundColor: CustomColors.primaryBlue,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey.shade800,
        items: _navbarItems(),
      ),
    );
  }

  List<BottomNavigationBarItem> _navbarItems() {
    return [
      eachNavbarItem(title: "Movies", iconData: FontAwesomeIcons.film),
      eachNavbarItem(title: "Trending", iconData: FontAwesomeIcons.fire)
    ];
  }

  BottomNavigationBarItem eachNavbarItem({String? title, IconData? iconData}) {
    return BottomNavigationBarItem(icon: FaIcon(iconData), label: title);
  }
}
