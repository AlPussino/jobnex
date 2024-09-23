import 'package:flutter/material.dart';
import 'package:JobNex/features/post/data/model/react.dart';
import 'package:JobNex/features/post/presentation/widgets/reation_owners_profile_widget.dart';

class ReactionTabContent extends StatelessWidget {
  final List<React> reactions;
  final Map<String, Icon> reactionIcons;

  const ReactionTabContent(
      {super.key, required this.reactions, required this.reactionIcons});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: reactions.length,
      itemBuilder: (context, index) {
        final react = reactions[index];
        return ReactOwnerProfile(
          react_owner_id: react.react_owner_id,
          reactionIcons: reactionIcons,
          react: react,
        );
      },
    );
  }
}
