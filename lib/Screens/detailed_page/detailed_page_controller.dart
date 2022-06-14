// enric corrected 2022JUN14

import 'dart:io';
import 'dart:typed_data';
import '../../api/api.dart';
import '../../model/movie_details.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart' as pp;

class DetailedPageController extends GetxController {
  final int id;
  DetailedPageController(this.id) {
    _getMovieDetails();
  }

  List<Cast> casts = [];

  _getMovieDetails() async {
    MovieDetails movieDetails = await Api.movieDetails(id: id);
    casts = movieDetails.data.movie.cast;
    update();
  }

  downloadTorrent(String title, String url) async {
    Directory? downloadDir = await pp.getExternalStorageDirectory();
    // print(downloadDir.path);

    File torrentFile = File(downloadDir!.path + "/" + title + ".torrent");

    http.Response response = await http.get(Uri.parse(url));
    Uint8List content = response.bodyBytes;
    torrentFile.writeAsBytesSync(content);
    Get.back();
    print("download complete");
  }
}
