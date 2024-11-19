// views/post_detail_view.dart

import 'package:flutter/material.dart';
import 'package:pas1_mobile_10pplg2_14/model/PostModel.dart';
import 'package:pas1_mobile_10pplg2_14/widget/font.dart';

class PostDetailView extends StatelessWidget {
  final PostModel post;

  const PostDetailView({required this.post, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(post.strTeam)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.network(
                post.strBadge,
                width: 100,
                height: 100,
                errorBuilder:
                    (context, error, stackTrace) =>
                        Icon(Icons.broken_image, size: 100),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'League: ${post.strLeague}',
              style: AppTextStyles.headline1(18),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  post.strDescriptionEN,
                  style: AppTextStyles.bodyText(16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
