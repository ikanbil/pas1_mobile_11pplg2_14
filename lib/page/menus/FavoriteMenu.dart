// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pas1_mobile_10pplg2_14/controller/PostController.dart';
import 'package:pas1_mobile_10pplg2_14/database/databasehelper.dart';
import 'package:pas1_mobile_10pplg2_14/model/PostModel.dart';
import 'package:pas1_mobile_10pplg2_14/widget/color.dart';
import 'package:pas1_mobile_10pplg2_14/widget/my_card.dart';

class FavoriteMenu extends StatefulWidget {
  const FavoriteMenu({Key? key}) : super(key: key);

  @override
  _FavoriteState createState() => _FavoriteState();
}

class _FavoriteState extends State<FavoriteMenu> {
  List<PostModel> favoriteList = [];

  @override
  void initState() {
    super.initState();
    fetchFavorites();
  }

  // Fetch favorite posts from the database
  Future<void> fetchFavorites() async {
    final favorites = await DatabaseHelper.instance.getFavorites();
    setState(() {
      favoriteList = favorites;
    });
  }

  // Delete a favorite post
  Future<void> deleteFavorite(String teamName) async {
    await DatabaseHelper.instance.removeFavorite(teamName);
    // Panggil sinkronisasi di PostController
    final PostController postController = Get.find();
    postController.updateFavoriteStatus(teamName, false);
    fetchFavorites(); // Refresh the list
  }

  // Show confirmation dialog for deleting a favorite
  void showDeleteConfirmationDialog(String teamName) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirm Delete"),
          content: Text("Are you sure you want to delete this favorite?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                deleteFavorite(teamName);
                Navigator.of(context).pop();
              },
              child: Text("Delete"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.primary, Color.fromARGB(255, 183, 210, 255)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child:
            favoriteList.isEmpty
                ? Center(
                  child: Text(
                    "No favorites yet",
                    style: TextStyle(color: Colors.white),
                  ),
                )
                : Container(
                  margin: EdgeInsets.fromLTRB(30, 0, 30, 12),
                  child: ListView.builder(
                    itemCount: favoriteList.length,
                    itemBuilder: (context, index) {
                      final post = favoriteList[index];
                      return ReusableCard(
                        leading:
                            post.strBadge.isNotEmpty
                                ? Image.network(
                                  post.strBadge,
                                  width: 50,
                                  height: 50,
                                )
                                : Icon(Icons.image, color: Colors.white),
                        title: post.strTeam,
                        trailing: IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed:
                              () => showDeleteConfirmationDialog(post.strTeam),
                        ),
                      );
                    },
                  ),
                ),
      ),
    );
  }
}
