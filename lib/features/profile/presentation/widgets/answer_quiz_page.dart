// import 'package:flutter/material.dart';
// import 'package:freezed_example/features/profile/presentation/widgets/submitted_answers_page.dart';

// class AnswerQuizPage extends StatefulWidget {
//   const AnswerQuizPage({super.key});

//   @override
//   State<AnswerQuizPage> createState() => _AnswerQuizPageState();
// }

// class _AnswerQuizPageState extends State<AnswerQuizPage> {
//   int currentQuizIndex = 0;
//   List<Quiz> quizList = getQuizList();
//   Answer? selectedAnswer;

//   void nextQuiz({required BuildContext ct, Quiz? currentQuiz}) {
//     // log("NEXT QUIZ");
//     if (currentQuiz!.userAnswers.isEmpty) {
//       // log("Please select the answer");
//     } else {
//       if (currentQuizIndex < quizList.length - 1) {
//         setState(() {
//           currentQuizIndex++;
//         });
//       } else {
//         Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(
//                 builder: (context) => SubmittedAnswers(quizList: quizList)));
//       }
//     }

//     //
//   }

//   void previousQuiz({required BuildContext ct}) {
//     // log("PREVIOUS QUIZ");
//     //
//     if (currentQuizIndex != 0) {
//       setState(() {
//         currentQuizIndex--;
//       });
//     } else {
//       null;
//     }

//     //
//   }

//   @override
//   Widget build(BuildContext context) {
//     Quiz currentQuiz = quizList[currentQuizIndex];
//     // log("Current Page Index: $currentQuizIndex && Current Quiz Id: ${currentQuiz.quizId}");

//     return Scaffold(
//       appBar: AppBar(title: const Text("Test Quiz")),
//       body: Padding(
//         padding: const EdgeInsets.all(10),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text("Question ${currentQuizIndex + 1}/${quizList.length}"),
//                 const Text("1 point"),
//               ],
//             ),
//             Text(currentQuiz.quizName),

//             //
//             ListView.builder(
//               shrinkWrap: true,
//               physics: const NeverScrollableScrollPhysics(),
//               itemCount: currentQuiz.answers.length,
//               itemBuilder: (context, index) {
//                 return currentQuiz.quizType == "MULTIPLECHOICE"

//                     //
//                     ? Padding(
//                         padding: const EdgeInsets.symmetric(vertical: 10),
//                         child: InkWell(
//                           onTap: () {
//                             setState(() {
//                               if (currentQuiz.userAnswers
//                                   .contains(currentQuiz.answers[index])) {
//                                 currentQuiz.userAnswers
//                                     .remove(currentQuiz.answers[index]);
//                               } else {
//                                 currentQuiz.userAnswers
//                                     .add(currentQuiz.answers[index]);
//                               }
//                             });
//                           },
//                           child: Container(
//                             decoration: BoxDecoration(
//                                 color: currentQuiz.userAnswers
//                                         .contains(currentQuiz.answers[index])
//                                     ? const Color.fromARGB(255, 240, 236, 247)
//                                     : AppPallete.white,
//                                 borderRadius: BorderRadius.circular(10),
//                                 border: Border.all(
//                                   color: currentQuiz.userAnswers
//                                           .contains(currentQuiz.answers[index])
//                                       ? AppPallete.deepPurple
//                                       : const Color(0xffBEBEBE),
//                                 )),
//                             child: ListTile(
//                               leading: Checkbox(
//                                 value: currentQuiz.userAnswers
//                                     .contains(currentQuiz.answers[index]),
//                                 onChanged: (value) {
//                                   setState(() {
//                                     if (currentQuiz.userAnswers
//                                         .contains(currentQuiz.answers[index])) {
//                                       currentQuiz.userAnswers
//                                           .remove(currentQuiz.answers[index]);
//                                     } else {
//                                       currentQuiz.userAnswers
//                                           .add(currentQuiz.answers[index]);
//                                     }
//                                   });
//                                 },
//                               ),
//                               title: Text(currentQuiz.answers[index].answerName,
//                                   textScaler: TextScaler.noScaling,
//                                   style: Theme.of(context)
//                                       .textTheme
//                                       .titleSmall!
//                                       .copyWith(
//                                         fontSize: 12,
//                                         fontWeight: FontWeight.w400,
//                                         color: currentQuiz.userAnswers.contains(
//                                                 currentQuiz.answers[index])
//                                             ? AppPallete.deepPurple
//                                             : const Color(0xff0D0D0D),
//                                       )),
//                             ),
//                           ),
//                         ),
//                       )

//                     //
//                     : Padding(
//                         padding: const EdgeInsets.symmetric(
//                             vertical: 10, horizontal: 10),
//                         child: InkWell(
//                           onTap: () {
//                             setState(() {
//                               currentQuiz.userAnswers = [
//                                 currentQuiz.answers[index]
//                               ];
//                               selectedAnswer = currentQuiz.userAnswers.first;
//                             });
//                           },
//                           child: Container(
//                             decoration: BoxDecoration(
//                                 color: currentQuiz.userAnswers
//                                         .contains(currentQuiz.answers[index])
//                                     ? const Color.fromARGB(255, 240, 236, 247)
//                                     : AppPallete.white,
//                                 borderRadius: BorderRadius.circular(10),
//                                 border: Border.all(
//                                   color: currentQuiz.userAnswers
//                                           .contains(currentQuiz.answers[index])
//                                       ? AppPallete.deepPurple
//                                       : const Color(0xffBEBEBE),
//                                 )),
//                             child: ListTile(
//                               leading: Radio<Answer>(
//                                 value: currentQuiz.answers[index],
//                                 groupValue: selectedAnswer,
//                                 onChanged: (value) {
//                                   setState(() {
//                                     currentQuiz.userAnswers = [value!];
//                                     selectedAnswer = value;
//                                   });
//                                 },
//                               ),
//                               title: Text(
//                                 currentQuiz.answers[index].answerName,
//                                 textScaler: TextScaler.noScaling,
//                                 style: Theme.of(context)
//                                     .textTheme
//                                     .titleSmall!
//                                     .copyWith(
//                                       fontSize: 12,
//                                       fontWeight: FontWeight.w400,
//                                       color: currentQuiz.userAnswers.contains(
//                                               currentQuiz.answers[index])
//                                           ? AppPallete.deepPurple
//                                           : const Color(0xff0D0D0D),
//                                     ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       );
//               },
//             ),
//             const Spacer(),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 currentQuizIndex == 0
//                     ? const SizedBox.shrink()
//                     : OutlinedButton(
//                         style: OutlinedButton.styleFrom(
//                           shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(10)),
//                           side: const BorderSide(
//                             color: AppPallete.deepPurple,
//                           ),
//                           backgroundColor: AppPallete.white,
//                           foregroundColor: AppPallete.deepPurple,
//                           iconColor: AppPallete.deepPurple,
//                           maximumSize: const Size(150, 60),
//                           minimumSize: const Size(150, 60),
//                         ),
//                         onPressed: () => previousQuiz(ct: context),
//                         child: const Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Icon(Icons.arrow_back),
//                             Text('Previous'),
//                           ],
//                         ),
//                       ),

//                 //
//                 ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: AppPallete.deepPurple,
//                     maximumSize: const Size(120, 60),
//                     minimumSize: const Size(120, 60),
//                   ),
//                   onPressed: () =>
//                       nextQuiz(ct: context, currentQuiz: currentQuiz),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(
//                         currentQuizIndex < quizList.length - 1
//                             ? 'Next'
//                             : 'Submit',
//                       ),
//                       currentQuizIndex < quizList.length - 1
//                           ? const Icon(Icons.arrow_forward)
//                           : const SizedBox.shrink(),
//                     ],
//                   ),
//                 ),
//               ],
//             ),

//             //
//           ],
//         ),
//       ),
//     );
//   }
// }

// class Answer {
//   final int answerId;
//   final String answerName;
//   final bool isCorrect;

//   Answer({
//     required this.answerId,
//     required this.answerName,
//     required this.isCorrect,
//   });
// }

// class Quiz {
//   final int quizId;
//   final String quizName;
//   final List<Answer> answers;
//   final String quizType;
//   List<Answer> userAnswers;

//   Quiz({
//     required this.quizId,
//     required this.quizName,
//     required this.answers,
//     required this.quizType,
//     required this.userAnswers,
//   });
// }

// List<Quiz> getQuizList() {
//   List<Quiz> quizList = [
//     Quiz(
//       quizId: 1,
//       quizName: "This is True/False quiz ",
//       answers: [
//         Answer(answerId: 1, answerName: "This is answer 1", isCorrect: true),
//         Answer(answerId: 2, answerName: "This is answer 2", isCorrect: false),
//       ],
//       quizType: "TRUEFALSE",
//       userAnswers: [],
//     ),
//     Quiz(
//       quizId: 2,
//       quizName: "This is Multiple choice quiz ",
//       answers: [
//         Answer(answerId: 1, answerName: "This is answer 1", isCorrect: true),
//         Answer(answerId: 2, answerName: "This is answer 2", isCorrect: false),
//         Answer(answerId: 3, answerName: "This is answer 3", isCorrect: false),
//         Answer(answerId: 4, answerName: "This is answer 4", isCorrect: true),
//       ],
//       quizType: "MULTIPLECHOICE",
//       userAnswers: [],
//     ),
//   ];
//   return quizList;
// }
