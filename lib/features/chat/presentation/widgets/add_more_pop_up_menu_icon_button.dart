import 'dart:developer';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:JobNex/core/common/enum/message_type_enum.dart';
import 'package:JobNex/core/common/widget/loading.dart';
import 'package:JobNex/core/util/get_current_location.dart';
import 'package:JobNex/features/chat/presentation/bloc/chat_bloc.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:provider/provider.dart';
import '../../../../core/util/get_current_address.dart';
import '../pages/select_videos_page.dart';

class AddMorePopUpMenuIconButton extends StatefulWidget {
  final Map<String, dynamic> receiverData;

  const AddMorePopUpMenuIconButton({super.key, required this.receiverData});

  @override
  State<AddMorePopUpMenuIconButton> createState() =>
      _AddMorePopUpMenuIconButtonState();
}

class _AddMorePopUpMenuIconButtonState
    extends State<AddMorePopUpMenuIconButton> {
  //
  void sendFilesMessage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      File file = File(result.files.single.path!);

      context.read<ChatBloc>().add(ChatSendFileMessage(
            widget.receiverData['user_id'],
            [file],
            MessageTypeEnum.file,
          ));
    } else {
      // User canceled the picker
    }
  }

  void sendVideosMessage() async {
    var status = await Permission.videos.request();

    if (status.isGranted) {
      log("Permission granted");
      final PermissionState ps = await PhotoManager.requestPermissionExtend();
      PhotoManager.setIgnorePermissionCheck(true);

      log(ps.toString());
      log(ps.isAuth.toString());
      if (ps.isAuth) {
        Navigator.pushNamed(context, SelectVideosPage.routeName,
            arguments: widget.receiverData);
      } else if (ps.hasAccess) {
      } else {}
    } else if (status.isDenied) {
      var st = await Permission.storage.request();
      if (st.isGranted) {
        Navigator.pushNamed(context, SelectVideosPage.routeName,
            arguments: widget.receiverData);
      }
    } else if (status.isPermanentlyDenied) {
      log("Permission permanently denied");
      openAppSettings();
    }
  }

  Future<String> getLocation() async {
    return getCurrentLocation().then((value) async => await getCurrentAddress(
        latitude: value.latitude, longitude: value.longitude));
  }

  void sendLocationMessage() {
    getCurrentLocation().then(
      (currentLocation) => getCurrentAddress(
        latitude: currentLocation.latitude,
        longitude: currentLocation.longitude,
      ).then(
        (currentAddress) => context.read<ChatBloc>().add(
              ChatSendTextMessage(
                widget.receiverData['user_id'],
                "${currentLocation.latitude}@${currentLocation.longitude}@$currentAddress",
                MessageTypeEnum.location,
                null,
              ),
            ),
      ),
    );
    Navigator.pop(context);
  }

  void showMapBottomSheet() async {
    showBottomSheet(
      enableDrag: true,
      showDragHandle: true,
      sheetAnimationStyle: AnimationStyle(
        curve: Curves.easeInOut,
        reverseCurve: Curves.easeInOutBack,
      ),
      context: context,
      builder: (context) {
        return SizedBox(
          width: MediaQuery.sizeOf(context).width,
          height: MediaQuery.sizeOf(context).height / 2,
          child: Center(
            child: FutureBuilder(
              future: getLocation(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const LoadingWidget();
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
                final currentAddress = snapshot.data;

                final address = currentAddress!.split(",");
                return Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: address.length,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 4),
                            child: Text(address[index]),
                          );
                        },
                      ),
                      ElevatedButton(
                        onPressed: sendLocationMessage,
                        child: const Text("Send location"),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        );

        //
      },
    );

    //
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: const Icon(Iconsax.add_circle_bold),
      onSelected: (String fileType) {
        switch (fileType) {
          case "File":
            sendFilesMessage();
            break;
          case "Video":
            sendVideosMessage();
            break;
          case "Map":
            showMapBottomSheet();
            break;
          default:
            null;
        }
      },
      itemBuilder: (BuildContext context) => [
        const PopupMenuItem(
          value: "File",
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(Iconsax.folder_open_bold),
              Text("File"),
            ],
          ),
        ),
        const PopupMenuItem(
          value: "Map",
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(Iconsax.map_1_bold),
              Text("Map"),
            ],
          ),
        ),
        const PopupMenuItem(
          value: "Video",
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(Iconsax.video_circle_bold),
              Text("Video"),
            ],
          ),
        ),
      ],
    );
  }
}
