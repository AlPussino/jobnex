import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:JobNex/core/common/widget/error.dart';
import 'package:JobNex/core/common/widget/loading.dart';
import 'package:JobNex/core/util/show_snack_bar.dart';
import 'package:JobNex/features/chat/presentation/bloc/chat_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:toastification/toastification.dart';

class AddStoryPage extends StatefulWidget {
  static const routeName = '/add-story-page';

  const AddStoryPage({super.key});

  @override
  State<AddStoryPage> createState() => _AddStoryPageState();
}

class _AddStoryPageState extends State<AddStoryPage> {
  Uint8List? image;
  File? imageFile;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: addStory,
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
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
                OutlinedButton(
                  onPressed: pickImage,
                  child: const Text("Pick Image"),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
  //   return Scaffold(
  //     appBar: AppBar(
  //       actions: [
  //         IconButton(
  //           onPressed: () => askPermission(context),
  //           icon: const Icon(Icons.add),
  //         ),
  //       ],
  //     ),
  //     body: Container(
  //       alignment: Alignment.center,
  //       child: image == null ? const Text("NULL") : Image.memory(image!),
  //     ),
  //   );
  // }

  // Future<Uint8List> convertXFileToUint8List(XFile xfile) async {
  //   // Read the bytes from the XFile
  //   Uint8List imageData = await xfile.readAsBytes();
  //   return imageData;
  // }

  // Future<String> convertUint8ListToFilePath(
  //     Uint8List uint8list, String filename) async {
  //   // Get the directory where the file will be saved
  //   final directory =
  //       await getTemporaryDirectory(); // or getApplicationDocumentsDirectory for permanent storage

  //   // Create the file
  //   final file = File('${directory.path}/$filename');

  //   // Write the Uint8List to the file
  //   await file.writeAsBytes(uint8list);

  //   // Return the file path as a string
  //   return file.path;
  // }

  // void addStory(String image) {
  //   context.read<StoryBloc>().add(StoryAddStory(image));
  // }

  // void askPermission(BuildContext context) async {
  //   await http
  //       .get(Uri.parse(
  //           "https://images.pexels.com/photos/56866/garden-rose-red-pink-56866.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"))
  //       .then(
  //     (value) async {
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(
  //           builder: (context) => ImageEditor(
  //             image: value.bodyBytes,
  //           ),
  //         ),
  //       ).then(
  //         (value) {
  //           setState(() {
  //             image = value;
  //             convertUint8ListToFilePath(image!, 'example.jpg').then(
  //               (value) {
  //                 addStory(value);
  //               },
  //             );
  //           });
  //         },
  //       );
  //     },
  //   );

  void pickImage() async {
    XFile? pickedXFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedXFile != null) {
      setState(() {
        imageFile = File(pickedXFile.path);
      });
    }
  }

  void addStory() {
    context.read<ChatBloc>().add(ChatAddStory(imageFile!.path));
  }
}
