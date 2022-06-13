import '../api/api.dart';
import '../Model/movie_suggestion.dart';
import '../Screens/detailed_page/detailed_page.dart';
import '../utils/custom_color.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Model/listmovies.dart';

class SearchBar extends StatelessWidget {
  final SearchBarController searchBarController = SearchBarController();
  final double searchBarWidth;
  SearchBar({Key? key, required this.searchBarWidth}) : super(key: key);
  final border = OutlineInputBorder(borderRadius: BorderRadius.circular(100));
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [_bar(), _suggestionBox()],
      ),
    );
  }

  Widget _suggestionBox() {
    return GetBuilder(
      init: searchBarController,
      builder: (_) => searchBarController.query.isEmpty
          ? const SizedBox()
          : Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              margin: const EdgeInsets.only(top: 10),
              width: searchBarWidth,
              height: Get.height * .4,
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.shade400,
                        offset: const Offset(2, 2),
                        blurRadius: 3,
                        spreadRadius: 1)
                  ],
                  borderRadius: BorderRadius.circular(18)),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    for (var each in searchBarController.suggestionList)
                      _eachSuggestionCard(each)
                  ],
                ),
              ),
            ),
    );
  }

  Widget _eachSuggestionCard(Movie movie) {
    return GestureDetector(
      onTap: () {
        searchBarController.hideSuggestionBox();
        // enric
        Get.to(DetailedPage());
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.only(top: 10),
        width: searchBarWidth,
        height: Get.height * .15,
        color: Colors.white,
        child: Row(
          children: [
            _movieCover(movie.mediumCoverImage),
            const SizedBox(
              width: 10,
            ),
            _title(movie.titleEnglish)
          ],
        ),
      ),
    );
  }

  Widget _movieCover(String url) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: Image.network(
        url,
        width: Get.width * .15,
        height: Get.height * .12,
        fit: BoxFit.fitHeight,
      ),
    );
  }

  Widget _title(String title) {
    return Text(title);
  }

  Widget _bar() {
    return SizedBox(
      width: searchBarWidth,
      child: TextField(
        onChanged: (value) {
          searchBarController.onChanged(value);
        },
        decoration: InputDecoration(
            filled: true,
            fillColor: CustomColors.background,
            // contentPadding: EdgeInsets.only(left:20),
            isDense: true,
            hintText: "Type something",
            focusedBorder: border,
            enabledBorder: border),
      ),
    );
  }
}

class SearchBarController extends GetxController {
  String query = '';

// Enric
  List<Movie> suggestionList = [];

  onChanged(String val) {
    query = val;
    update();
    _getMovieSuggestion();
  }

  _getMovieSuggestion() async {
    MovieSuggestion suggestions = await Api.searchMovies(queryTerm: query);
    List<Movie> movies = suggestions.data.movies.cast<Movie>();
    suggestionList = movies;
    update();
  }

  hideSuggestionBox() {
    query = "";
    update();
  }

  getSuggestionList() {}
}
