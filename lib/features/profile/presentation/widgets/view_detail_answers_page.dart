import 'dart:developer';
import 'package:flutter/material.dart';

import 'answer_quiz_page.dart';

class ViewDetailAnswersPage extends StatefulWidget {
  final List<Quiz> quizList;
  const ViewDetailAnswersPage({super.key, required this.quizList});

  @override
  State<ViewDetailAnswersPage> createState() => _ViewDetailAnswersPageState();
}

class _ViewDetailAnswersPageState extends State<ViewDetailAnswersPage> {
  int currentQuizIndex = 0;

  void nextQuiz({required BuildContext ct}) {
    log("NEXT QUIZ");
    if (currentQuizIndex < widget.quizList.length - 1) {
      setState(() {
        currentQuizIndex++;
      });
    } else {
      Navigator.pop(ct);
    }
    //
  }

  void previousQuiz({required BuildContext ct}) {
    log("PREVIOUS QUIZ");
    //
    if (currentQuizIndex != 0) {
      setState(() {
        currentQuizIndex--;
      });
    } else {
      null;
    }

    //
  }

  @override
  Widget build(BuildContext context) {
    Quiz currentQuiz = widget.quizList[currentQuizIndex];

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Question ${currentQuizIndex + 1}/${widget.quizList.length}",
                  textScaler: TextScaler.noScaling,
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xff0D0D0D)),
                ),
                Text(
                  "1 point",
                  textScaler: TextScaler.noScaling,
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xff0D0D0D)),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              currentQuiz.quizName,
              textScaler: TextScaler.noScaling,
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xff0D0D0D)),
            ),
            const SizedBox(height: 20),
            ListView.builder(
              shrinkWrap: true,
              itemCount: currentQuiz.answers.length,
              itemBuilder: (context, index) {
                return currentQuiz.quizType == "MULTIPLECHOICE"
                    ? Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Container(
                          decoration: BoxDecoration(
                              color: currentQuiz.userAnswers
                                      .contains(currentQuiz.answers[index])
                                  ? currentQuiz.answers[index].isCorrect
                                      ? const Color(0xffEAF5EF)
                                      : const Color(0xffFDEFED)
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(2),
                              border: Border.all(
                                color: currentQuiz.userAnswers
                                        .contains(currentQuiz.answers[index])
                                    ? currentQuiz.answers[index].isCorrect
                                        ? const Color(0xff309F5E)
                                        : const Color(0xffEF5C48)
                                    : const Color(0xffBEBEBE),
                              )),
                          child: ListTile(
                            leading: Checkbox(
                              activeColor: currentQuiz.answers[index].isCorrect
                                  ? const Color(0xff309F5E)
                                  : const Color(0xffEF5C48),
                              value: currentQuiz.userAnswers
                                  .contains(currentQuiz.answers[index]),
                              onChanged: (value) {},
                            ),
                            title: Text(
                              currentQuiz.answers[index].answerName,
                              textScaler: TextScaler.noScaling,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: currentQuiz.userAnswers.contains(
                                            currentQuiz.answers[index])
                                        ? currentQuiz.answers[index].isCorrect
                                            ? const Color(0xff227143)
                                            : const Color(0xffEF5C48)
                                        : const Color(0xff0D0D0D),
                                  ),
                            ),
                          ),
                        ),
                      )

                    //
                    : Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Container(
                          decoration: BoxDecoration(
                              color: currentQuiz.userAnswers
                                      .contains(currentQuiz.answers[index])
                                  ? currentQuiz.userAnswers.first.isCorrect
                                      ? const Color(0xffEAF5EF)
                                      : const Color(0xffFDEFED)
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(2),
                              border: Border.all(
                                color: currentQuiz.userAnswers
                                        .contains(currentQuiz.answers[index])
                                    ? currentQuiz.userAnswers.first.isCorrect
                                        ? const Color(0xff309F5E)
                                        : const Color(0xffEF5C48)
                                    : const Color(0xffBEBEBE),
                              )),
                          child: ListTile(
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 10),
                            leading: Radio<Answer>(
                              activeColor:
                                  currentQuiz.userAnswers.first.isCorrect
                                      ? const Color(0xff309F5E)
                                      : const Color(0xffEF5C48),
                              value: currentQuiz.answers[index],
                              groupValue: currentQuiz.userAnswers.first,
                              onChanged: (value) {},
                            ),
                            title: Text(
                              currentQuiz.answers[index].answerName,
                              textScaler: TextScaler.noScaling,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: currentQuiz.userAnswers.contains(
                                            currentQuiz.answers[index])
                                        ? currentQuiz
                                                .userAnswers.first.isCorrect
                                            ? const Color(0xff227143)
                                            : const Color(0xffEF5C48)
                                        : const Color(0xff0D0D0D),
                                  ),
                            ),
                          ),
                        ),
                      );
              },
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                currentQuizIndex == 0
                    ? const SizedBox.shrink()
                    : OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Color(0xFF227143)),
                          backgroundColor: Colors.white,
                          foregroundColor: const Color(0xFF227143),
                          iconColor: const Color(0xFF227143),
                          maximumSize: const Size(120, 60),
                          minimumSize: const Size(120, 60),
                        ),
                        onPressed: () => previousQuiz(ct: context),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.arrow_back),
                            Text('Previous'),
                          ],
                        ),
                      ),

                //
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF227143),
                    maximumSize: const Size(120, 60),
                    minimumSize: const Size(120, 60),
                  ),
                  onPressed: () => nextQuiz(ct: context),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        currentQuizIndex < widget.quizList.length - 1
                            ? 'Next'
                            : 'Done',
                      ),
                      currentQuizIndex < widget.quizList.length - 1
                          ? const Icon(Icons.arrow_forward)
                          : const SizedBox.shrink(),
                    ],
                  ),
                ),
              ],
            )

            //
          ],
        ),
      ),
    );
  }
}
