import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Model/listmovies.dart';
import '../Screens/detailed_page/detailed_page.dart';
import '../utils/custom_color.dart';

class MovieCard extends StatelessWidget {
  const MovieCard({super.key, required this.movie});
  final Movie movie;

  //final Movie? movie;
  //DetailedPage({super.key, this.movie});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(DetailedPage());
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        height: Get.height * .30,
        width: Get.width * .9,
        // color: Colors.blue,
        child: Stack(
          children: [
            Positioned(left: Get.width * .05, bottom: 0, child: _bottomCard()),
            Positioned(left: Get.width * .05, child: _movieCover()),
          ],
        ),
      ),
    );
  }

  Widget _bottomCard() {
    return Container(
      height: Get.height * .25,
      width: Get.width * .9,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: CustomColors.background,
          boxShadow: _cardShadow()),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(),
          Flexible(child: _movieDetails()),
        ],
      ),
    );
  }

  Widget _movieDetails() {
    return Padding(
      padding: const EdgeInsets.all(0),
      child: Container(
        width: Get.width * .55,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [_title(), _ratingDuration(), _genres()],
        ),
      ),
    );
  }

  Widget _title() {
    return Flexible(
      child: Text(movie.titleEnglish,
          style: TextStyle(
              color: CustomColors.primaryBlue,
              fontSize: 20,
              fontWeight: FontWeight.bold)),
    );
  }

  Widget _ratingDuration() {
    return Row(
      children: [
        Icon(
          Icons.star,
          color: CustomColors.orange,
        ),
        Text("${movie.rating}/10 IMDb"),
        const SizedBox(
          width: 10,
        ),
        Text("${movie.runtime} min")
      ],
    );
  }

  Widget _genres() {
    return Container(
      // color: Colors.blue,
      height: 40,
      width: Get.width * .55,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [for (String genre in movie.genres) _eachGenre(genre)],
        ),
      ),
    );
  }

  Widget _eachGenre(String genre) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2.5),
        margin: const EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: CustomColors.lightPurple),
        child: Text(
          genre,
          style: TextStyle(fontSize: 12, color: CustomColors.primaryBlue),
        ));
  }

  Widget _movieCover() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Image.network(movie.mediumCoverImage,
          height: Get.height * .25,
          fit: BoxFit.fitHeight,
          width: Get.width * .3),
    );
  }

  List<BoxShadow> _cardShadow() => <BoxShadow>[
        BoxShadow(
            offset: const Offset(1.5, 1.5),
            color: CustomColors.shadow,
            blurRadius: 3,
            spreadRadius: 1),
      ];
}
