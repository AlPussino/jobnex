import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_reaction_button/flutter_reaction_button.dart';
import 'package:freezed_example/core/theme/app_pallete.dart';
import 'package:freezed_example/core/util/show_snack_bar.dart';
import 'package:freezed_example/features/post/data/model/react.dart';
import 'package:freezed_example/features/post/presentation/bloc/post_bloc.dart';
import 'package:freezed_example/features/post/presentation/pages/comment_list_page.dart';
import 'package:freezed_example/features/post/presentation/widgets/react_icons.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:toastification/toastification.dart';
import '../../data/model/post.dart';

class ReactAndCommentBar extends StatelessWidget {
  final Post post;
  const ReactAndCommentBar({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    final fireAuth = FirebaseAuth.instance;
    List<React> existedReactList = post.reacts;
    bool isReacted = false;
    String userReact = '';
    for (React react in existedReactList) {
      if (react.react_owner_id == fireAuth.currentUser!.uid) {
        isReacted = true;
        userReact = react.react;
        break;
      }
    }

    void reactOrUnReactPost({required String emoji}) {
      if (isReacted) {
        existedReactList
            .removeWhere((e) => e.react_owner_id == fireAuth.currentUser!.uid);
        if (userReact != emoji) {
          existedReactList.add(
              React(react_owner_id: fireAuth.currentUser!.uid, react: emoji));
        }
      } else {
        existedReactList.add(
            React(react_owner_id: fireAuth.currentUser!.uid, react: emoji));
      }

      context.read<PostBloc>().add(PostReactPost(post.id, existedReactList));
    }

    return BlocListener<PostBloc, PostState>(
      listenWhen: (previous, current) => current is PostFailure,
      listener: (context, state) {
        if (state is PostFailure) {
          SnackBars.showToastification(
              context, state.message, ToastificationType.error);
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, CommentListPage.routeName,
                    arguments: post);
              },
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("${post.reacts.length}"),
                  Text("${post.comments.length} comments"),
                ],
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ReactionButton(
                  isChecked: true,
                  toggle: true,
                  animateBox: true,
                  boxAnimationDuration: const Duration(milliseconds: 200),
                  boxPadding: const EdgeInsets.all(2),
                  hoverDuration: const Duration(milliseconds: 200),
                  itemsSpacing: 0,
                  itemAnimationDuration: const Duration(milliseconds: 200),
                  itemSize: const Size(80, 80),
                  boxColor: Theme.of(context).canvasColor,
                  onReactionChanged: (value) {
                    reactOrUnReactPost(emoji: value!.value);
                  },
                  itemScale: 0.9,
                  reactions: [
                    ReactionIcons.reaction(
                      value: 'like',
                      icon: AntDesign.like_fill,
                      color: AppPallete.lightBlue,
                    ),
                    ReactionIcons.reaction(
                      value: 'dislike',
                      icon: AntDesign.dislike_fill,
                      color: AppPallete.lightBlue,
                    ),
                    ReactionIcons.reaction(
                      value: 'love',
                      icon: AntDesign.heart_fill,
                      color: AppPallete.pink,
                    ),
                    ReactionIcons.reaction(
                      value: 'happy',
                      icon: AntDesign.smile_fill,
                      color: AppPallete.yellow,
                    ),
                    ReactionIcons.reaction(
                      value: 'sad',
                      icon: AntDesign.frown_fill,
                      color: AppPallete.yellow,
                    ),
                  ],
                  child: IconButton(
                    onPressed: () => reactOrUnReactPost(emoji: 'like'),
                    icon: UserReactIcon(isReacted: isReacted, react: userReact),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, CommentListPage.routeName,
                        arguments: post);
                  },
                  icon: const Icon(Iconsax.message_2_outline),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class UserReactIcon extends StatelessWidget {
  final bool isReacted;
  final String react;
  const UserReactIcon(
      {super.key, required this.isReacted, required this.react});

  @override
  Widget build(BuildContext context) {
    Icon icon = checkIcon(react);
    return isReacted ? icon : const Icon(AntDesign.like_outline);
  }

  Icon checkIcon(String react) {
    switch (react) {
      case 'love':
        return const Icon(AntDesign.heart_fill, color: AppPallete.pink);
      case 'like':
        return const Icon(AntDesign.like_fill, color: AppPallete.lightBlue);
      case 'dislike':
        return const Icon(AntDesign.dislike_fill, color: AppPallete.lightBlue);
      case 'happy':
        return const Icon(AntDesign.smile_fill, color: AppPallete.yellow);
      case 'sad':
        return const Icon(AntDesign.frown_fill, color: AppPallete.yellow);
      default:
        break;
    }
    return const Icon(AntDesign.heart_outline);
  }
}
