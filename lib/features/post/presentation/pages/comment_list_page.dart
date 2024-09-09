import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_example/core/common/widget/error.dart';
import 'package:freezed_example/core/common/widget/loading.dart';
import 'package:freezed_example/core/common/widget/text_form_fields.dart';
import 'package:freezed_example/features/post/data/model/comment.dart';
import 'package:freezed_example/features/post/presentation/bloc/post_bloc.dart';
import 'package:freezed_example/features/post/presentation/provider/reply_text_field_provider.dart';
import 'package:freezed_example/features/post/presentation/widgets/comment_and_replies_widget.dart';
import 'package:provider/provider.dart';
import '../../data/model/post.dart';

class CommentListPage extends StatefulWidget {
  static const routeName = '/comment-list-page';

  final Post post;
  const CommentListPage({super.key, required this.post});

  @override
  State<CommentListPage> createState() => _CommentListPageState();
}

class _CommentListPageState extends State<CommentListPage> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController textFieldController = TextEditingController();
    final fireStore = FirebaseFirestore.instance;

    void commentPost(List<Comment> existedCommentList) {
      context
          .read<PostBloc>()
          .add(PostCommentPost(widget.post.id, textFieldController.text));
      textFieldController.clear();
    }

    //

    return StreamBuilder(
      stream: fireStore.collection('posts').doc(widget.post.id).snapshots(),
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
        return Scaffold(
          appBar: AppBar(),
          body: ChangeNotifierProvider(
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
                        return CommentAndRepliesWidget(
                            textFieldController: textFieldController,
                            comment: commentList[index],
                            post_id: widget.post.id);
                      },
                    ),
                  ),
                  if (!context
                      .watch<ReplyTextFieldProvider>()
                      .showReplyTextField)
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: TextFormFields(
                              hintText: 'Write comment...',
                              controller: textFieldController,
                              isObscureText: false,
                            ),
                          ),
                          IconButton(
                            onPressed: () => commentPost(commentList),
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
