import '../../model/listmovies.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CoverWithTitle extends StatelessWidget {
  final Movie movie;
  const CoverWithTitle(this.movie);

  @override
  Widget build(BuildContext context) {
    return coverWithTitle();
  }

  Widget coverWithTitle() {
    return SizedBox(
        height: Get.height * .25,
        width: Get.width,
        child: Stack(
          children: [
            _background(),
            _opacity(),
            _movieInfo(),
          ],
        ));
  }

  Widget _backButton() {
    return IconButton(
      onPressed: () {
        Get.back();
      },
      icon: const Icon(
        Icons.arrow_back_ios,
        color: Colors.white,
      ),
    );
  }

  Widget _opacity() {
    return Opacity(
      opacity: 0.3,
      child: Container(
        height: Get.height * .25,
        width: Get.width,
        decoration: const BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20)),
        ),
      ),
    );
  }

  Widget _movieInfo() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _backButton(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _title(),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  _review(),
                  const SizedBox(width: 50),
                  _duration(),
                ],
              ),
              _genres(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _review() {
    return Text("no reviews", style: TextStyle(color: Colors.grey.shade300));
  }

  Widget _title() {
    return RichText(
      text: TextSpan(
          text: movie.titleEnglish,
          style: const TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          children: [
            TextSpan(
                text: "(${movie.year})",
                style: TextStyle(color: Colors.grey.shade300, fontSize: 14))
          ]),
    );
  }

  Widget _duration() {
    return Text("${movie.runtime} min",
        style: TextStyle(color: Colors.grey.shade300));
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
            borderRadius: BorderRadius.circular(50), color: Colors.black26),
        child: Text(
          genre,
          style: const TextStyle(fontSize: 12, color: Colors.white),
        ));
  }

  Widget _background() {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
      child: Image.network(
        movie.mediumCoverImage,
        fit: BoxFit.fitWidth,
        width: Get.width,
      ),
    );
  }
}
