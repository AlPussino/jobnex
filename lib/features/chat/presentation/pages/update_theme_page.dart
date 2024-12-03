import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_circle_color_picker/flutter_circle_color_picker.dart';
import 'package:JobNex/core/common/widget/error.dart';
import 'package:JobNex/core/common/widget/loading.dart';
import 'package:JobNex/core/theme/app_pallete.dart';
import 'package:JobNex/core/util/show_snack_bar.dart';
import 'package:JobNex/features/chat/presentation/bloc/chat_bloc.dart';
import 'package:toastification/toastification.dart';

class UpdateThemePage extends StatefulWidget {
  static const routeName = '/update-theme-page';

  final Map<String, dynamic> receiverData;
  final Map<String, dynamic> chatListData;

  const UpdateThemePage({
    super.key,
    required this.receiverData,
    required this.chatListData,
  });

  @override
  State<UpdateThemePage> createState() => _UpdateThemePageState();
}

class _UpdateThemePageState extends State<UpdateThemePage> {
  late CircleColorPickerController controller;

  @override
  void initState() {
    controller = CircleColorPickerController(
        initialColor: Color(widget.chatListData['theme']));
    super.initState();
  }

  void updateTheme() {
    context.read<ChatBloc>().add(ChatUpdateTheme(
        widget.receiverData['user_id'], controller.color.value));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Theme"),
        actions: [
          if (Color(widget.chatListData['theme']) != controller.color)
            IconButton(
              onPressed: updateTheme,
              icon: const Icon(Icons.check),
            ),
        ],
      ),
      body: BlocConsumer<ChatBloc, ChatState>(
        listener: (context, state) {
          if (state is ChatUpdateThemeSuccess) {
            SnackBars.showToastification(context, "Changed theme successfully.",
                ToastificationType.success);
            Navigator.pop(context);
          }
          if (state is ChatFailure) {
            SnackBars.showToastification(
                context, state.message, ToastificationType.error);
          }
        },
        builder: (context, state) {
          if (state is ChatLoading) {
            return const LoadingWidget();
          }
          if (state is ChatFailure) {
            return ErrorWidgets(errorMessage: state.message);
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Card(
                  child: Container(
                    margin: const EdgeInsets.all(20),
                    alignment: Alignment.topRight,
                    child: ListView(
                      physics: const BouncingScrollPhysics(),
                      children: [
                        BubbleSpecialThree(
                          text: "What's your name?",
                          color: controller.color,
                          tail: false,
                          isSender: true,
                        ),
                        const BubbleSpecialThree(
                          text: "What?",
                          color: Color(0xFF1B97F3),
                          tail: false,
                          isSender: false,
                        ),
                        BubbleSpecialThree(
                          text: "What is your name?",
                          color: controller.color,
                          tail: false,
                          isSender: true,
                        ),
                        const BubbleSpecialThree(
                          text: "Oak Oak",
                          color: Color(0xFF1B97F3),
                          tail: false,
                          isSender: false,
                        ),
                        BubbleSpecialThree(
                          text: "Hello Oak",
                          color: controller.color,
                          tail: false,
                          isSender: true,
                        ),
                        const BubbleSpecialThree(
                          text: "World!",
                          color: Color(0xFF1B97F3),
                          tail: false,
                          isSender: false,
                        ),
                        const BubbleSpecialThree(
                          text: "What's your name too?",
                          color: Color(0xFF1B97F3),
                          tail: false,
                          isSender: false,
                        ),
                        BubbleSpecialThree(
                          text: "Steven",
                          color: controller.color,
                          tail: false,
                          isSender: true,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: CircleColorPicker(
                    textStyle: const TextStyle(color: AppPallete.transparent),
                    controller: controller,
                    onChanged: (color) {
                      setState(() {
                        controller.color = color;
                      });
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
