import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:JobNex/core/common/widget/error.dart';
import 'package:JobNex/core/common/widget/loading.dart';
import 'package:JobNex/core/theme/app_pallete.dart';
import 'package:JobNex/core/util/change_to_time_ago.dart';
import 'package:JobNex/features/post/data/model/reply.dart';
import 'package:JobNex/features/post/domain/usecase/get_post_owner_info.dart';
import 'package:JobNex/features/post/presentation/bloc/post_owner_bloc.dart';
import 'package:JobNex/features/post/presentation/bloc/post_owner_event.dart';
import 'package:JobNex/features/post/presentation/bloc/post_owner_state.dart';
import 'package:JobNex/features/post/presentation/provider/reply_text_field_provider.dart';
import 'package:JobNex/features/profile/presentation/pages/profile_page.dart';

class OwnerAndCommentOrReplyTextWidget extends StatefulWidget {
  final String owner_id;
  final String commentOrReply;
  final String post_id;
  final String comment_id;
  final bool isComment;
  final bool showReplies;
  final List<Reply> replies;
  final VoidCallback showOrNotReplies;
  final DateTime created_at;
  final TextEditingController textFieldController;
  final FocusNode textFieldFocusNode;

  const OwnerAndCommentOrReplyTextWidget({
    super.key,
    required this.owner_id,
    required this.commentOrReply,
    required this.post_id,
    required this.comment_id,
    required this.isComment,
    required this.showOrNotReplies,
    required this.showReplies,
    required this.replies,
    required this.created_at,
    required this.textFieldController,
    required this.textFieldFocusNode,
  });

  @override
  State<OwnerAndCommentOrReplyTextWidget> createState() =>
      _OwnerAndCommentOrReplyTextWidgetState();
}

class _OwnerAndCommentOrReplyTextWidgetState
    extends State<OwnerAndCommentOrReplyTextWidget> {
  late bool is_replies_showed;

  @override
  void initState() {
    is_replies_showed = widget.showReplies;
    widget.textFieldController.addListener(
      () {
        widget.textFieldController.text.isEmpty
            ? context.read<ReplyTextFieldProvider>().clearCommentId()
            : null;
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return BlocProvider(
      create: (context) =>
          PostOwnerBloc(postOwnerRepository: GetPostOwnerInfo())
            ..add(FetchPostOwner(widget.owner_id)),
      lazy: false,
      key: Key(widget.owner_id),
      child: BlocBuilder<PostOwnerBloc, PostOwnerState>(
        buildWhen: (previous, current) => current is PostOwnerLoaded,
        builder: (context, state) {
          // Loading
          if (state is PostOwnerLoading) {
            return const Scaffold(body: LoadingWidget());
          }

          // Failure
          if (state is PostOwnerError) {
            return Scaffold(body: ErrorWidgets(errorMessage: state.message));
          }

          // Success
          if (state is PostOwnerLoaded) {
            return StreamBuilder(
              stream: state.postOwnerData,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: LoadingWidget());
                } else if (snapshot.hasError) {
                  return Center(child: Text("${snapshot.error}"));
                }
                final user = snapshot.data!.data()!;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Card(
                      borderOnForeground: true,
                      child: Container(
                        alignment: Alignment.centerLeft,
                        margin: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                    highlightColor: AppPallete.lightBlue,
                                    customBorder: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, ProfilePage.routeName,
                                          arguments: user['user_id']);
                                    },
                                    child: Text("${user['name']}")),
                                Text(changeToTimeAgo("${widget.created_at}")),
                              ],
                            ),
                            Text(widget.commentOrReply),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () {
                              widget.textFieldFocusNode.requestFocus();
                              context
                                  .read<ReplyTextFieldProvider>()
                                  .replyToComment(widget.comment_id);
                              widget.textFieldController.text =
                                  '${user['name']} :';
                            },
                            child: const Text("reply"),
                          ),
                          SizedBox(width: size.width / 10),
                          if (widget.isComment && widget.replies.isNotEmpty)
                            InkWell(
                              onTap: () {
                                widget.showOrNotReplies();
                                setState(() {
                                  is_replies_showed = !is_replies_showed;
                                });
                              },
                              child: Text(
                                is_replies_showed
                                    ? "hide replies"
                                    : "show replies",
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            );
          }

          // No Avtive staet
          return const SizedBox();
        },
      ),
    );
  }
}
