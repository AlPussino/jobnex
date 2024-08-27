import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_example/core/common/widget/loading.dart';
import 'package:freezed_example/core/util/show_snack_bar.dart';
import 'package:freezed_example/features/post/data/model/post.dart';
import 'package:freezed_example/features/post/presentation/bloc/post_bloc.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:image_picker/image_picker.dart';
import 'package:toastification/toastification.dart';

class AddPostPage extends StatefulWidget {
  const AddPostPage({super.key});

  @override
  State<AddPostPage> createState() => _AddPostPageState();
}

class _AddPostPageState extends State<AddPostPage> {
  final formKey = GlobalKey<FormState>();
  final textController = TextEditingController();
  File? imageFile;

  void pickImage() async {
    XFile? pickedXFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedXFile != null) {
      setState(() {
        imageFile = File(pickedXFile.path);
      });
    }
  }

  void addPost() {
    context.read<PostBloc>().add(PostAddPost(
          Post(
            text: textController.text,
            image: imageFile!.path,
            created_at: DateTime.now(),
          ),
        ));
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Form(
      key: formKey,
      child: Scaffold(
        appBar: AppBar(title: const Text("Add Post")),
        body: BlocConsumer<PostBloc, PostState>(
          listener: (context, state) {
            if (state is PostFailure) {
              SnackBars.showErrorSnackBar(context, state.message);
            }
            if (state is PostAddPostSuccessState) {
              Navigator.pop(context);
              SnackBars.showToastification(
                  context, "New Post added.", ToastificationType.success);
            }
          },
          builder: (context, state) {
            if (state is PostLoading) {
              return const Center(
                child: LoadingWidget(caption: "Adding..."),
              );
            }
            return Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextFormField(
                            controller: textController,
                            obscureText: false,
                            decoration: const InputDecoration(
                              hintText: "What's on you mind...",
                            ),
                            minLines: 1,
                            maxLines: 5,
                            onTapOutside: (event) =>
                                FocusManager.instance.primaryFocus!.unfocus(),
                          ),
                          SizedBox(height: size.height / 20),
                          if (imageFile != null)
                            InkWell(
                              onTap: pickImage,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.file(
                                  imageFile!,
                                  width: size.width,
                                  height: size.width,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                  IconButton(
                      onPressed: pickImage, icon: const Icon(Icons.image))
                ],
              ),
            );
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (formKey.currentState!.validate()) addPost();
          },
          child: const Icon(Iconsax.send_1_bold),
        ),
      ),
    );
  }
}
