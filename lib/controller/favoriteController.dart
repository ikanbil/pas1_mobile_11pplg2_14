import 'package:get/get.dart';
import 'package:pas1_mobile_10pplg2_14/database/databasehelper.dart';
import 'package:pas1_mobile_10pplg2_14/model/PostModel.dart';


class FavoriteController extends GetxController {
  var favoriteList = <PostModel>[].obs;

  @override
  void onInit() {
    fetchFavorites();
    super.onInit();
  }

  Future<void> fetchFavorites() async {
    final favorites = await DatabaseHelper.instance.getFavorites();
    favoriteList.assignAll(favorites);
  }

  Future<void> addFavorite(PostModel post) async {
    await DatabaseHelper.instance.addFavorite(post);
    fetchFavorites();
  }

  Future<void> removeFavorite(String teamName) async {
    await DatabaseHelper.instance.removeFavorite(teamName);
    fetchFavorites();
  }

  bool isFavorite(String teamName) {
    return favoriteList.any((post) => post.strTeam == teamName);
  }
}
