import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_story_view/flutter_story_view.dart';
import 'package:flutter_story_view/models/story_item.dart';
import 'package:flutter_story_view/models/user_info.dart';
import '../../data/model/story_body.dart';

class ViewStoryPage extends StatefulWidget {
  static const routeName = '/view-story-page';

  final List<StoryBody> storyBodies;
  final String story_owner_name;
  final String story_owner_profile;
  const ViewStoryPage({
    super.key,
    required this.storyBodies,
    required this.story_owner_name,
    required this.story_owner_profile,
  });

  @override
  State<ViewStoryPage> createState() => _ViewStoryPageState();
}

class _ViewStoryPageState extends State<ViewStoryPage> {
  int initialIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlutterStoryView(
        showReplyButton: false,
        showBackIcon: false,
        showMenuIcon: false,
        createdAt: widget.storyBodies[initialIndex].created_at,
        enableOnHoldHide: true,
        userInfo: UserInfo(
          username: widget.story_owner_name,
          profileUrl: widget.story_owner_profile,
        ),
        storyItems: [
          ...widget.storyBodies.map(
            (e) => StoryItem(
              url: e.image,
              type: StoryItemType.image,
              duration: 3,
            ),
          )
        ],
        onComplete: () {
          log("Completed");
          Navigator.pop(context);
        },
        onPageChanged: (index) {
          if (initialIndex != index) {
            setState(() {
              initialIndex = index;
            });
          }
        },
      ),
    );
  }
}
