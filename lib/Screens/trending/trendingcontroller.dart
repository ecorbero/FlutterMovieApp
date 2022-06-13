import '../../api/api.dart';
import '../../custom_widgets/trending_card.dart';
import '../../model/listmovies.dart' as lm;
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

class TrendingController extends GetxController {
  TrendingController() {
    getTrendingList();
    getRecentList();
  }

  List<Widget> trendingList = [
    for (int i = 0; i < 5; i++) _inProgressTrendingCard()
  ];
// enric
  List<lm.Movie> recentList = [];

  getRecentList() async {
    lm.ListMovies listMovies = (await Api.recentMovies()) as lm.ListMovies;
    List<lm.Movie> tempList = [];
    for (lm.Movie each in listMovies.data!.movies) {
      tempList.add(each);
    }

    recentList = tempList;
    update();
  }

  getTrendingList() async {
    lm.ListMovies listMovies = (await Api.trendingMovies()) as lm.ListMovies;
    List<Widget> tempList = [];

    for (lm.Movie each in listMovies.data!.movies) {
      tempList.add(TrendingCard(isInProgress: false, movieModel: each));
    }

    trendingList = tempList;
    update();
  }

  static _inProgressTrendingCard() => TrendingCard(isInProgress: true);
}
