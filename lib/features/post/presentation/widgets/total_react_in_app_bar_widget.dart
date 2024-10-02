import 'package:flutter/material.dart';
import 'package:JobNex/core/theme/app_pallete.dart';
import 'package:JobNex/core/util/reaction_icons.dart';
import 'package:JobNex/features/post/data/model/post.dart';
import 'package:JobNex/features/post/presentation/pages/reacts_owners_list_page.dart';

class TotalReactInAppBarWidget extends StatelessWidget {
  final Post post;
  const TotalReactInAppBarWidget({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    final Set<String> uniqueReactions =
        post.reacts.map((reaction) => reaction.react).toSet();

    //
    return post.reacts.isNotEmpty
        ? InkWell(
            highlightColor: AppPallete.lightBlue,
            customBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            onTap: () {
              Navigator.pushNamed(context, ReactsOwnersListPage.routeName,
                  arguments: post);
            },
            child: Row(
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: uniqueReactions
                      .where((reaction) =>
                          Reaction.reactionIcons.containsKey(reaction))
                      .map((reaction) => Reaction.reactionIcons[reaction]!)
                      .toList(),
                ),
                const Icon(Icons.arrow_forward_ios)
              ],
            ),
          )
        : Container();
  }
}
