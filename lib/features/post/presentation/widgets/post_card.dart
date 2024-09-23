import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:JobNex/core/theme/app_pallete.dart';
import 'package:JobNex/core/util/change_to_time_ago.dart';
import 'package:JobNex/features/post/data/model/post.dart';
import 'package:JobNex/features/post/presentation/pages/comment_list_page.dart';
import 'package:JobNex/features/post/presentation/pages/post_detail_page.dart';
import 'package:JobNex/features/post/presentation/widgets/post_owner.dart';
import 'package:JobNex/features/post/presentation/widgets/react_and_comment_bar.dart';

class PostCard extends StatelessWidget {
  final Post post;
  final int index;
  const PostCard({super.key, required this.post, required this.index});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return AnimationConfiguration.staggeredList(
      position: index,
      delay: const Duration(milliseconds: 100),
      child: SlideAnimation(
        horizontalOffset: 30,
        verticalOffset: 300,
        duration: const Duration(milliseconds: 2500),
        curve: Curves.fastLinearToSlowEaseIn,
        child: FlipAnimation(
          duration: const Duration(milliseconds: 3000),
          curve: Curves.fastLinearToSlowEaseIn,
          flipAxis: FlipAxis.y,
          child: FadeInUp(
            from: index * 10,
            duration: const Duration(milliseconds: 100),
            delay: const Duration(milliseconds: 100),
            animate: true,
            curve: Curves.bounceIn,
            child: InkWell(
              highlightColor: AppPallete.lightBlue,
              customBorder: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              onTap: () {
                Navigator.pushNamed(context, PostDetailPage.routeName,
                    arguments: post.id);
              },
              child: Card(
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  height: size.width / 1.8,
                  width: size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      PostOwner(
                        post: post,
                        created_at: changeToTimeAgo(
                          "${post.created_at}",
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  post.post_title,
                                  maxLines: 1,
                                ),
                                SizedBox(height: size.width / 30),
                                Text(
                                  post.post_body,
                                  maxLines: 3,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: size.width / 30),
                          Expanded(
                            flex: 1,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: CachedNetworkImage(
                                imageUrl: post.image,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ],
                      ),
                      InkWell(
                          highlightColor: AppPallete.lightBlue,
                          customBorder: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          onTap: () {
                            Navigator.pushNamed(
                                context, CommentListPage.routeName,
                                arguments: post);
                          },
                          child: ReactAndCommentBar(post: post)),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ).animate(delay: const Duration(seconds: 2)).shimmer(),
    );
  }
}
