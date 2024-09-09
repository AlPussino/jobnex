import 'package:comment_tree/widgets/comment_tree_widget.dart';
import 'package:comment_tree/widgets/tree_theme_data.dart';
import 'package:flutter/material.dart';
import 'package:freezed_example/core/theme/app_pallete.dart';
import 'package:freezed_example/features/post/data/model/comment.dart';
import 'package:freezed_example/features/post/presentation/widgets/owner_and_comment_or_reply_text_widget.dart';
import 'package:freezed_example/features/post/presentation/widgets/comment_owner_profile_widget.dart';
import '../../data/model/reply.dart';

class CommentAndRepliesWidget extends StatefulWidget {
  final TextEditingController textFieldController;
  final Comment comment;
  final String post_id;
  const CommentAndRepliesWidget({
    super.key,
    required this.textFieldController,
    required this.comment,
    required this.post_id,
  });

  @override
  State<CommentAndRepliesWidget> createState() =>
      _CommentAndRepliesWidgetState();
}

class _CommentAndRepliesWidgetState extends State<CommentAndRepliesWidget> {
  bool showReplies = false;

  void showOrNotReplies() {
    setState(() {
      showReplies = !showReplies;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CommentTreeWidget<Comment, Reply>(
      widget.comment,
      avatarRoot: (context, value) {
        return PreferredSize(
          preferredSize: const Size.fromRadius(20),
          child: CommentOrReplyOwnerProfileWidget(
            owner_id: widget.comment.comment_owner_id,
          ),
        );
      },
      contentRoot: (context, value) {
        return OwnerAndCommentOrReplyTextWidget(
          owner_id: widget.comment.comment_owner_id,
          commentOrReply: widget.comment.comment,
          textFieldController: widget.textFieldController,
          post_id: widget.post_id,
          comment_id: widget.comment.comment_id,
          isComment: true,
          showOrNotReplies: showOrNotReplies,
          showReplies: showReplies,
          replies: widget.comment.replies,
          created_at: widget.comment.created_at,
        );
      },
      showReplies
          ? [
              ...widget.comment.replies.map(
                (e) => e,
              ),
            ]
          : [],
      avatarChild: (context, value) {
        return PreferredSize(
          preferredSize: const Size.fromRadius(20),
          child: CommentOrReplyOwnerProfileWidget(
            owner_id: value.reply_owner_id,
          ),
        );
      },
      contentChild: (context, value) {
        return OwnerAndCommentOrReplyTextWidget(
          owner_id: value.reply_owner_id,
          commentOrReply: value.reply,
          textFieldController: widget.textFieldController,
          post_id: widget.post_id,
          comment_id: widget.comment.comment_id,
          isComment: false,
          showOrNotReplies: showOrNotReplies,
          showReplies: showReplies,
          replies: widget.comment.replies,
          created_at: value.created_at,
        );
      },
      treeThemeData:
          const TreeThemeData(lineWidth: 0.5, lineColor: AppPallete.lightBlue),
    );
  }
}
