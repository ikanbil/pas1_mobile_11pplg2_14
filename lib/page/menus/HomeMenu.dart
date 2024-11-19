// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pas1_mobile_10pplg2_14/controller/PostController.dart';
import 'package:pas1_mobile_10pplg2_14/database/databasehelper.dart';
import 'package:pas1_mobile_10pplg2_14/page/PostDetailView.dart';
import 'package:pas1_mobile_10pplg2_14/widget/color.dart';

class Homemenu extends StatelessWidget {
  final PostController postController = Get.put(PostController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.primary, Color.fromARGB(255, 120, 169, 255)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Container(
          child: Obx(() {
            if (postController.isLoading.value) {
              return Center(
                child: CircularProgressIndicator(color: Colors.white),
              );
            }
            return ListView.builder(
              itemCount: postController.postList.length,
              itemBuilder: (context, index) {
                final post = postController.postList[index];
                return Container(
                  margin: EdgeInsets.fromLTRB(30, 0, 30, 12),
                  child: Card(
                    color: Colors.white,
                    child: ListTile(
                      leading:
                          post.strBadge.isNotEmpty
                              ? Image.network(
                                post.strBadge,
                                width: 50,
                                height: 50,
                                errorBuilder:
                                    (context, error, stackTrace) => Icon(
                                      Icons.broken_image,
                                      color: Colors.white,
                                    ),
                              )
                              : Icon(Icons.image, color: Colors.white),
                      title: Text(
                        post.strTeam,
                        style: TextStyle(color: Colors.black),
                      ),
                      trailing: Obx(
                        () => IconButton(
                          icon: Icon(
                            Icons.favorite,
                            color:
                                post.isFavorite.value
                                    ? Colors.red
                                    : Colors.grey[500],
                          ),
                          onPressed: () async {
                            post.isFavorite.value = !post.isFavorite.value;

                            if (post.isFavorite.value) {
                              await DatabaseHelper.instance.addFavorite(post);
                            } else {
                              await DatabaseHelper.instance.removeFavorite(
                                post.strTeam,
                              );
                            }

                            final PostController postController = Get.find();
                            postController.updateFavoriteStatus(
                              post.strTeam,
                              post.isFavorite.value,
                            );
                          },
                        ),
                      ),

                      onTap: () {
                        Get.to(PostDetailView(post: post));
                      },
                    ),
                  ),
                );
              },
            );
          }),
        ),
      ),
    );
  }
}
