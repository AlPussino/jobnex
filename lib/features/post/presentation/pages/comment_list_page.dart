import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:JobNex/core/common/widget/error.dart';
import 'package:JobNex/core/common/widget/loading.dart';
import 'package:JobNex/core/common/widget/text_form_fields.dart';
import 'package:JobNex/features/post/data/model/comment.dart';
import 'package:JobNex/features/post/presentation/bloc/post_bloc.dart';
import 'package:JobNex/features/post/presentation/provider/reply_text_field_provider.dart';
import 'package:JobNex/features/post/presentation/widgets/comment_and_replies_widget.dart';
import 'package:JobNex/features/post/presentation/widgets/total_react_in_app_bar_widget.dart';
import 'package:provider/provider.dart';
import '../../data/model/post.dart';

class CommentListPage extends StatelessWidget {
  static const routeName = '/comment-list-page';

  final Post post;
  const CommentListPage({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    final TextEditingController textFieldController = TextEditingController();
    final FocusNode textFieldFocusNode = FocusNode();
    final fireStore = FirebaseFirestore.instance;

    void commentPost() {
      log(textFieldController.text);
      if (textFieldController.text.isNotEmpty) {
        context
            .read<PostBloc>()
            .add(PostCommentPost(post.id, textFieldController.text));
        textFieldController.clear();
        textFieldFocusNode.unfocus();
      } else {}
    }

    void replyComment(BuildContext context) {
      context.read<PostBloc>().add(
            PostReplyComment(
              post.id,
              context.read<ReplyTextFieldProvider>().comment_id,
              textFieldController.text.split(':')[1].trim(),
            ),
          );
      context.read<ReplyTextFieldProvider>().clearCommentId();
      textFieldController.clear();
      textFieldFocusNode.unfocus();
    }

    //

    return StreamBuilder(
      stream: fireStore.collection('posts').doc(post.id).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingWidget();
        } else if (snapshot.hasError) {
          return ErrorWidgets(errorMessage: snapshot.error.toString());
        }
        final postData = snapshot.data!.data();
        List<dynamic> dynamicList = postData!['comments'];
        List<Comment> commentList =
            dynamicList.map((data) => Comment.fromJson(data)).toList();

        //
        return Scaffold(
          appBar: AppBar(
            title: TotalReactInAppBarWidget(post: post),
            actions: [
              Text("${post.reacts.length} reacts"),
            ],
          ),
          body: ChangeNotifierProvider(
            lazy: true,
            create: (context) => ReplyTextFieldProvider(),
            builder: (context, child) {
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(10),
                      shrinkWrap: true,
                      itemCount: commentList.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: CommentAndRepliesWidget(
                            comment: commentList[index],
                            post_id: post.id,
                            post_owner_id: post.post_owner_id,
                            textFieldController: textFieldController,
                            textFieldFocusNode: textFieldFocusNode,
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: TextFormFields(
                            hintText: 'Write comment...',
                            controller: textFieldController,
                            focusNode: textFieldFocusNode,
                            isObscureText: false,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            context
                                    .read<ReplyTextFieldProvider>()
                                    .comment_id
                                    .isEmpty
                                ? commentPost()
                                : replyComment(context);
                          },
                          icon: const Icon(Icons.send_rounded),
                        ),
                      ],
                    ),
                  )
                ],
              );
            },
          ),
        );
      },
    );
  }
}
