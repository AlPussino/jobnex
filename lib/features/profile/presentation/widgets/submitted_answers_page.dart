import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:freezed_example/features/profile/presentation/widgets/answer_quiz_page.dart';
import 'package:freezed_example/features/profile/presentation/widgets/view_detail_answers_page.dart';
import 'package:page_transition/page_transition.dart';

class SubmittedAnswers extends StatefulWidget {
  final List<Quiz> quizList;
  const SubmittedAnswers({super.key, required this.quizList});

  @override
  State<SubmittedAnswers> createState() => _SubmittedAnswersState();
}

class _SubmittedAnswersState extends State<SubmittedAnswers> {
  bool isLoading = true;
  double score = 0;
  @override
  void initState() {
    score = checkScore(widget.quizList);
    setState(() {
      isLoading = false;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const Center(child: CupertinoActivityIndicator())
          : Column(
              children: [
                Expanded(
                    child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 20),
                        margin: const EdgeInsets.symmetric(vertical: 20),
                        color: Colors.transparent,
                        child: ListTile(
                          horizontalTitleGap: 0,
                          title: Row(
                            children: [
                              Text(
                                "TO PASS ",
                                textScaler: TextScaler.noScaling,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .copyWith(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white),
                              ),
                              Text(
                                "80% or Higher",
                                textScaler: TextScaler.noScaling,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .copyWith(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: const Color(0xff666666)),
                              ),
                            ],
                          ),
                          subtitle: Row(
                            children: [
                              Text(
                                "Grade -",
                                textScaler: TextScaler.noScaling,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .copyWith(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white),
                              ),
                              Text(
                                " $score%",
                                textScaler: TextScaler.noScaling,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .copyWith(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: const Color(0xff2ABB7F)),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: Row(
                          children: [
                            Text(
                              "Latest attempt grade ",
                              textScaler: TextScaler.noScaling,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                            Text(
                              "(we keep your highest score)",
                              textScaler: TextScaler.noScaling,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          '$score%',
                          textScaler: TextScaler.noScaling,
                          style:
                              Theme.of(context).textTheme.titleSmall!.copyWith(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                        ),
                      ),
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: widget.quizList.length,
                        itemBuilder: (context, index) {
                          final quiz = widget.quizList[index];
                          return Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: const Color(0xffBFBFBF)),
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Question ${index + 1}/${widget.quizList.length}",
                                      textScaler: TextScaler.noScaling,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall!
                                          .copyWith(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                              color: const Color(0xff666666)),
                                    ),
                                    Text(
                                      checkAnswer(quiz)
                                          ? "1/1 point"
                                          : "0/1 point",
                                      textScaler: TextScaler.noScaling,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall!
                                          .copyWith(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                              color: const Color(0xff666666)),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 20),
                                  child: Text(
                                    quiz.quizName,
                                    textScaler: TextScaler.noScaling,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall!
                                        .copyWith(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.white),
                                  ),
                                ),
                                ListTile(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8)),
                                  tileColor: checkAnswer(quiz)
                                      ? const Color(0xffEAF5EF)
                                      : const Color(0xffFDEFED),
                                  leading: checkAnswer(quiz)
                                      ? const Icon(
                                          Icons.check_circle,
                                          color: Color(0xff2ABB7F),
                                        )
                                      : const Icon(
                                          Icons.cancel,
                                          color: Color(0xffEF5C48),
                                        ),
                                  title: Text(
                                    checkAnswer(quiz) ? "Correct" : "Incorrect",
                                    textScaler: TextScaler.noScaling,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall!
                                        .copyWith(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: checkAnswer(quiz)
                                                ? const Color(0xff227143)
                                                : const Color(0xffEF5C48)),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                )),
                Container(
                  color: Colors.transparent,
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            PageTransition(
                              type: PageTransitionType.rightToLeft,
                              child: const AnswerQuizPage(),
                            ),
                          );
                        },
                        child: const Text(
                          "Try again",
                          style: TextStyle(color: Colors.deepPurple),
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          maximumSize: const Size(120, 50),
                          minimumSize: const Size(120, 50),
                          backgroundColor: Colors.deepPurple,
                        ),
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            PageTransition(
                              type: PageTransitionType.rightToLeft,
                              child: ViewDetailAnswersPage(
                                quizList: widget.quizList,
                              ),
                            ),
                          );
                        },
                        child: const Text("Details"),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}

bool checkAnswer(Quiz quiz) {
  final rightAnswerIndexList = [];
  final userAnswerIndexList = [];

  final righAnswertList =
      quiz.answers.where((element) => element.isCorrect).toList();

  for (Answer ans in righAnswertList) {
    rightAnswerIndexList.add(ans.answerId);
  }
  for (Answer ans in quiz.userAnswers) {
    userAnswerIndexList.add(ans.answerId);
  }

  final result =
      Set.from(rightAnswerIndexList).containsAll(userAnswerIndexList) &&
          Set.from(userAnswerIndexList).containsAll(rightAnswerIndexList);

  return result;
}

double checkScore(List<Quiz> quizList) {
  double score = 0;
  for (Quiz quiz in quizList) {
    final rightAnswerIndexList = [];
    final userAnswerIndexList = [];

    final righAnswertList =
        quiz.answers.where((element) => element.isCorrect).toList();

    for (Answer ans in righAnswertList) {
      rightAnswerIndexList.add(ans.answerId);
    }
    for (Answer ans in quiz.userAnswers) {
      userAnswerIndexList.add(ans.answerId);
    }

    final result =
        Set.from(rightAnswerIndexList).containsAll(userAnswerIndexList) &&
            Set.from(userAnswerIndexList).containsAll(rightAnswerIndexList);

    result ? score++ : null;
  }
  final percent = score / quizList.length * 100;
  return percent;
}
