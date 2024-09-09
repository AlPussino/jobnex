import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_example/core/common/widget/error.dart';
import 'package:freezed_example/core/common/widget/loading.dart';
import 'package:freezed_example/core/common/widget/text_form_fields.dart';
import 'package:freezed_example/core/util/change_to_time_ago.dart';
import 'package:freezed_example/features/post/data/model/reply.dart';
import 'package:freezed_example/features/post/domain/usecase/get_post_owner_info.dart';
import 'package:freezed_example/features/post/presentation/bloc/post_bloc.dart';
import 'package:freezed_example/features/post/presentation/bloc/post_owner_bloc.dart';
import 'package:freezed_example/features/post/presentation/bloc/post_owner_event.dart';
import 'package:freezed_example/features/post/presentation/bloc/post_owner_state.dart';
import 'package:freezed_example/features/post/presentation/provider/reply_text_field_provider.dart';

class OwnerAndCommentOrReplyTextWidget extends StatefulWidget {
  final String owner_id;
  final String commentOrReply;
  final TextEditingController textFieldController;
  final String post_id;
  final String comment_id;
  final bool isComment;
  final bool showReplies;
  final List<Reply> replies;
  final VoidCallback showOrNotReplies;
  final DateTime created_at;
  const OwnerAndCommentOrReplyTextWidget({
    super.key,
    required this.owner_id,
    required this.commentOrReply,
    required this.textFieldController,
    required this.post_id,
    required this.comment_id,
    required this.isComment,
    required this.showOrNotReplies,
    required this.showReplies,
    required this.replies,
    required this.created_at,
  });

  @override
  State<OwnerAndCommentOrReplyTextWidget> createState() =>
      _OwnerAndCommentOrReplyTextWidgetState();
}

class _OwnerAndCommentOrReplyTextWidgetState
    extends State<OwnerAndCommentOrReplyTextWidget> {
  late bool is_replies_showed;
  final TextEditingController replyController = TextEditingController();
  bool showReplyTextField = false;

  @override
  void initState() {
    is_replies_showed = widget.showReplies;
    super.initState();
  }

  void replyComment() {
    context.read<PostBloc>().add(PostReplyComment(
        widget.post_id, widget.comment_id, replyController.text));
    replyController.clear();
    setState(() {
      showReplyTextField = !showReplyTextField;
    });
    context.read<ReplyTextFieldProvider>().toggleReplyTextField();
  }

  void toggleReplyTextField(BuildContext context) {
    context.read<ReplyTextFieldProvider>().toggleReplyTextField();
    setState(() {
      showReplyTextField = !showReplyTextField;
    });
  }

  @override
  void dispose() {
    replyController.dispose();
    super.dispose();
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
                    SizedBox(height: size.height / 60),
                    Card(
                      child: Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("${user['name']}"),
                                Text(changeToTimeAgo("${widget.created_at}")),
                              ],
                            ),
                            Text(widget.commentOrReply),
                          ],
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        InkWell(
                            onTap: () => toggleReplyTextField(context),
                            child:
                                Text(!showReplyTextField ? "reply" : "close")),
                        SizedBox(width: size.width / 20),
                        if (widget.isComment && widget.replies.isNotEmpty)
                          InkWell(
                              onTap: () {
                                widget.showOrNotReplies();
                                setState(() {
                                  is_replies_showed = !is_replies_showed;
                                });
                              },
                              child: Text(is_replies_showed
                                  ? "show less"
                                  : "show more")),
                      ],
                    ),
                    if (showReplyTextField)
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextFormFields(
                                hintText: 'Write reply...',
                                controller: replyController,
                                isObscureText: false,
                              ),
                            ),
                            IconButton(
                              onPressed: replyComment,
                              icon: const Icon(Icons.send),
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
