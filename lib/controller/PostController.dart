// controllers/post_controller.dart

import 'package:get/get.dart';
import 'package:pas1_mobile_10pplg2_14/api/ApiService.dart';
import 'package:pas1_mobile_10pplg2_14/database/databasehelper.dart';
import 'package:pas1_mobile_10pplg2_14/model/PostModel.dart';

class PostController extends GetxController {
  var isLoading = true.obs;
  var postList = <PostModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchPosts();
  }

  void fetchPosts() async {
    isLoading(true);
    try {
      // Fetch data (contoh fetch API di sini)
      final data = await ApiService().fetchPosts();
      postList.assignAll(data);

      // Sinkronisasi dengan favorit di database
      syncFavoritesWithDatabase();
    } finally {
      isLoading(false);
    }
  }

  Future<void> syncFavoritesWithDatabase() async {
    final favorites = await DatabaseHelper.instance.getFavorites();
    for (var post in postList) {
      post.isFavorite.value = favorites.any(
        (fav) => fav.strTeam == post.strTeam,
      );
    }
  }

  void updateFavoriteStatus(String teamName, bool isFavorite) {
    for (var post in postList) {
      if (post.strTeam == teamName) {
        post.isFavorite.value = isFavorite;
        break;
      }
    }
  }
}
