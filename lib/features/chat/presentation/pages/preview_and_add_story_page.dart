import 'dart:io';
import 'package:JobNex/core/common/widget/error.dart';
import 'package:JobNex/core/common/widget/loading.dart';
import 'package:JobNex/core/util/show_snack_bar.dart';
import 'package:JobNex/features/chat/presentation/bloc/chat_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toastification/toastification.dart';

class PreviewAndAddStoryPage extends StatefulWidget {
  static const routeName = '/preview-and-add-story-page';
  final File imageFile;

  const PreviewAndAddStoryPage({super.key, required this.imageFile});

  @override
  State<PreviewAndAddStoryPage> createState() => _PreviewAndAddStoryPageState();
}

class _PreviewAndAddStoryPageState extends State<PreviewAndAddStoryPage> {
  void addStory(String image) {
    context.read<ChatBloc>().add(ChatAddStory(image));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () => addStory(widget.imageFile.path),
            icon: const Icon(Icons.check),
          ),
        ],
      ),
      body: BlocConsumer<ChatBloc, ChatState>(
        listener: (context, state) {
          if (state is ChatFailure) {
            SnackBars.showToastification(
                context, state.message, ToastificationType.error);
          }
          if (state is ChatAddStorySuccess) {
            SnackBars.showToastification(context, "Added Chat successfully.",
                ToastificationType.success);
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          // Loading
          if (state is ChatLoading) {
            return const LoadingWidget();
          }
          // Error
          if (state is ChatFailure) {
            return ErrorWidgets(errorMessage: state.message);
          }
          return Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.file(
                widget.imageFile,
                width: size.width,
                height: size.width,
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }
}
