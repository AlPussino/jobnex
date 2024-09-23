import 'package:cached_network_image/cached_network_image.dart';
import 'package:comment_tree/widgets/comment_tree_widget.dart';
import 'package:flutter/material.dart';
import 'package:JobNex/core/common/constant/constant.dart';

class TestCommentTree extends StatefulWidget {
  const TestCommentTree({super.key});

  @override
  State<TestCommentTree> createState() => _TestCommentTreeState();
}

class _TestCommentTreeState extends State<TestCommentTree> {
  bool showReplies = false;
  List<Comment> comments = [
    Comment(
      avatar: Constant.jobRecruitmentDetailBackground,
      userName: "User1",
      content: "This is a comment",
      replies: [
        Comment(
          avatar: Constant.jobRecruitmentDetailBackground,
          userName: "User2",
          content: "This is a reply to Uasfdser1",
        ),
        Comment(
          avatar: Constant.jobRecruitmentDetailBackground,
          userName: "HISAhf",
          content: "This issdfasd a reply to Usesdafsdar1",
        ),
        Comment(
          avatar: Constant.jobRecruitmentDetailBackground,
          userName: "HIojp]jSAhf",
          content: "Thispkp[] issdfasd a reply to Usesdokafsdar1",
        ),
      ],
    ),
    Comment(
      avatar: Constant.jobRecruitmentDetailBackground,
      userName: "User4",
      content: "This is another comment",
      replies: [
        Comment(
          avatar: Constant.jobRecruitmentDetailBackground,
          userName: "User2",
          content: "This is a reply to Uasfdser1",
        ),
      ],
    ),
    Comment(
      avatar: Constant.jobRecruitmentDetailBackground,
      userName: "User3",
      content: "This is a reply to User2",
    ),
    Comment(
      avatar: Constant.jobRecruitmentDetailBackground,
      userName: "User3",
      content: "This is a reply to User2",
    ),
    Comment(
      avatar: Constant.jobRecruitmentDetailBackground,
      userName: "User3",
      content: "This is a reply to User2",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Test Comment Tree"),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: ListView.builder(
          itemCount: comments.length,
          itemBuilder: (context, index) {
            final comment = comments[index];
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 0),
              child: CommentTreeWidget(
                comment,
                avatarRoot: (context, value) {
                  return PreferredSize(
                    preferredSize: const Size.fromRadius(15),
                    child: CircleAvatar(
                      backgroundImage: CachedNetworkImageProvider(value.avatar),
                    ),
                  );
                },
                contentRoot: (context, value) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color.fromARGB(255, 55, 55, 55),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(value.userName),
                              Text(value.content),
                            ],
                          ),
                        ),
                      ),
                      const Row(
                        children: [
                          Text("1 hr"),
                          SizedBox(width: 20),
                          Text("reply"),
                        ],
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            showReplies = !showReplies;
                          });
                        },
                        child: Text(showReplies ? "show less" : "show more"),
                      ),
                    ],
                  );
                },
                showReplies
                    ? [
                        ...comment.replies.map(
                          (e) {
                            return e;
                          },
                        ),
                      ]
                    : [],
                avatarChild: (context, value) {
                  return PreferredSize(
                    preferredSize: const Size.fromRadius(25),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 0, vertical: 10),
                      child: CircleAvatar(
                        radius: 15,
                        backgroundImage:
                            CachedNetworkImageProvider(value.avatar),
                      ),
                    ),
                  );
                },
                contentChild: (context, value) {
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color.fromARGB(255, 55, 55, 55),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(value.userName),
                            Text(value.content),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

class Comment {
  final String userName;
  final String content;
  final List<Comment> replies;
  final String avatar;

  Comment({
    required this.userName,
    required this.content,
    this.replies = const [],
    required this.avatar,
  });
}
