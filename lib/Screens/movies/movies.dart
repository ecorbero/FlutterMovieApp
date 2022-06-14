// enric corrected 2022JUN14

import '../../custom_widgets/search_bar.dart';
import '../../screens/movies/movies_controller.dart';
import '../../utils/custom_color.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

// ignore: must_be_immutable
class Movies extends StatelessWidget {
  Orientation orientation = Orientation.portrait;
  final MoviesController moviesController = MoviesController();

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        this.orientation = orientation;
        return orientation == Orientation.portrait
            ? _portraitView()
            : _landscapeView();
      },
    );
  }

  Widget _portraitView() {
    return SizedBox(
      height: Get.height,
      width: Get.width,
      child: Stack(
        children: [
          Column(
            children: [
              SizedBox(
                height: 5,
              ),
              _appbar(),
              _body()
            ],
          ),
          Positioned(top: 10 + 5, right: Get.width * .05, child: _searchBar()),
        ],
      ),
    );
  }

  Widget _landscapeView() {
    return Container();
  }

  Widget _appbar() {
    return Stack(
      children: [
        Container(
          height: Get.height * .20,
          width: Get.width,
          decoration: BoxDecoration(
              color: CustomColors.primaryBlue,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20))),
        ),
        Positioned(
          right: -70,
          top: -50,
          child: Container(
            height: Get.height * .3,
            width: Get.height * .3,
            decoration: BoxDecoration(
                // borderRadius:
                //     BorderRadius.only(bottomRight: Radius.circular(20)),
                color: CustomColors.lightBlue,
                shape: BoxShape.circle),
          ),
        ),
        Positioned(bottom: 0, child: _categoryTabs())
      ],
    );
  }

  Widget _searchBar() {
    return SearchBar(
      searchBarWidth: Get.width * .9,
    );
  }

  Widget _categoryTabs() {
    return GetBuilder(
      init: moviesController,
      builder: (_) => Container(
          color: Colors.transparent,
          height: Get.height * .08,
          width: Get.width,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                for (String category in moviesController.categoryList)
                  _singleTab(
                      title: category,
                      isSelected: moviesController.currentIndex ==
                          moviesController.categoryList.indexOf(category),
                      index: moviesController.categoryList.indexOf(category))

                // _singleTab(
                //     title: "Popular",
                //     isSelected: moviesController.currentIndex == 0,
                //     index: 0),
                // _singleTab(
                //     isSelected: moviesController.currentIndex == 1,
                //     title: "Trending",
                //     index: 1),
                // _singleTab(
                //     isSelected: moviesController.currentIndex == 2,
                //     title: "Recent",
                //     index: 2)
              ],
            ),
          )),
    );
  }

  Widget _singleTab(
      {required String title, required bool isSelected, required int index}) {
    return GestureDetector(
      onTap: () {
        moviesController.onTabClick(index);
      },
      child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 7.5),
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          decoration: BoxDecoration(
              color:
                  isSelected ? CustomColors.orange : CustomColors.lightPurple,
              borderRadius: BorderRadius.circular(50)),
          child: Text(
            title,
            style: const TextStyle(color: Colors.white),
          )),
    );
  }

  Widget _body() {
    return GetBuilder(
      init: moviesController,
      builder: (_) => SizedBox(
        height: Get.height * .8 - 5,
        width: Get.width,
        child: ListView(
          children: moviesController.movieList,
        ),
      ),
    );
  }
}
