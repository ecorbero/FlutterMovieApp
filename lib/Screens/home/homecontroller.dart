// enric corrected 2022JUN14

import '../../screens/movies/movies.dart';
import '../../screens/trending/trending.dart';
import 'package:flutter/material.dart';

import 'package:get/state_manager.dart';

class HomeController extends GetxController {
  int navbarIndex = 0;

  onNavbarItemTap(int index) {
    navbarIndex = index;
    update();
  }

  final List<Widget> _homePages = [Movies(), Trending()];

  Widget get homePage => _homePages[navbarIndex];
}
