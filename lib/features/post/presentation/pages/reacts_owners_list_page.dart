import 'package:flutter/material.dart';
import 'package:JobNex/core/util/reaction_icons.dart';
import 'package:JobNex/features/post/data/model/post.dart';
import 'package:JobNex/features/post/presentation/widgets/reaction_tab_content_widget.dart';

class ReactsOwnersListPage extends StatelessWidget {
  static const routeName = '/reacts-owners-list-page';

  final Post post;

  const ReactsOwnersListPage({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    List<String> uniqueReactionTypes =
        post.reacts.map((reaction) => reaction.react).toSet().toList();

    // Adding the "All" tab at the beginning
    uniqueReactionTypes.insert(0, "All");
    //

    return DefaultTabController(
      length: uniqueReactionTypes.length,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: uniqueReactionTypes.map((reaction) {
              return Tab(
                icon: reaction == "All"
                    ? const Icon(Icons.all_inclusive)
                    : Reaction.reactionIcons[reaction],
                text: reaction,
              );
            }).toList(),
          ),
        ),
        body: TabBarView(
          children: uniqueReactionTypes.map((reaction) {
            return ReactionTabContent(
              reactions: reaction == "All"
                  ? post.reacts
                  : post.reacts.where((r) => r.react == reaction).toList(),
              reactionIcons: Reaction.reactionIcons,
            );
          }).toList(),
        ),
      ),
    );
  }
}
