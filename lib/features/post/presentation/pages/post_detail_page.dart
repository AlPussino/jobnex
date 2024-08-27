import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../data/model/post.dart';

class PostDetailPage extends StatelessWidget {
  final Post post;
  const PostDetailPage({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(title: const Text("Post Detail")),
      body: Hero(
        tag: post.text,
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CachedNetworkImage(
                        imageUrl: post.image,
                        fit: BoxFit.cover,
                        height: size.width / 2,
                        width: size.width,
                      ),
                    ),
                    SizedBox(height: size.height / 20),
                    Text(post.text),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
