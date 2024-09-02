import 'dart:io';
import 'dart:isolate';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:freezed_example/core/common/enum/message_type_enum.dart';
import 'package:freezed_example/core/common/widget/loading.dart';
import 'package:freezed_example/core/util/load_photo_albums.dart';
import 'package:freezed_example/core/util/load_photos_of_an_album.dart';
import 'package:freezed_example/features/chat/presentation/bloc/chat_bloc.dart';
import 'package:freezed_example/features/chat/presentation/provider/media_provider.dart';
import 'package:freezed_example/features/chat/presentation/widgets/videos_grid.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:provider/provider.dart';

class SelectVideosPage extends StatefulWidget {
  static const routeName = '/select-videos-page';

  final Map<String, dynamic> receiverData;

  const SelectVideosPage({super.key, required this.receiverData});

  @override
  State<SelectVideosPage> createState() => _SelectVideosPageState();
}

class _SelectVideosPageState extends State<SelectVideosPage> {
  ReceivePort? receivePort;
  AssetPathEntity? selectedAlbum;
  List<AssetPathEntity> albumList = [];
  List<AssetEntity> videos = [];
  List<Uint8List> selectedList = [];

  @override
  void initState() {
    super.initState();
    loadVideos();
  }

  Future<void> loadVideos() async {
    await loadPhotoAlbums(RequestType.video).then(
      (value) {
        setState(() {
          albumList = value;
          selectedAlbum = value[1];
        });
        loadPhotosOfAnAlbum(selectedAlbum!).then(
          (value) async {
            receivePort = ReceivePort();
            await Isolate.spawn(processVideos, [receivePort!.sendPort, value]);

            final processedVideos =
                await receivePort!.first as List<AssetEntity>;
            setState(() {
              videos = processedVideos;
            });
          },
        );
      },
    );

    // Now process the images in an isolate
  }

  static void processVideos(List<dynamic> args) {
    final sendPort = args[0] as SendPort;
    final List<AssetEntity> videos = args[1] as List<AssetEntity>;

    // Process images if needed, for now we simply send them back
    sendPort.send(videos);
  }

  void sendVideos(BuildContext context) async {
    List<File> selectedFiles = [];
    List<AssetEntity> selectedVideos =
        context.read<MediaProvider>().selectedVideos;
    for (AssetEntity video in selectedVideos) {
      File? videoFile = await video.file;
      selectedFiles.add(videoFile!);
    }
    context.read<ChatBloc>().add(ChatSendFileMessage(
          widget.receiverData['user_id'],
          selectedFiles,
          MessageTypeEnum.video,
        ));

    context.read<MediaProvider>().selectedVideos.clear();
    Navigator.pop(context);
  }

  @override
  void dispose() {
    videos.clear();
    receivePort!.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MediaProvider(),
      builder: (context, child) {
        return Scaffold(
          appBar: AppBar(
            title: DropdownButton(
              isExpanded: true,
              isDense: true,
              icon: null,
              underline: const SizedBox(),
              padding: const EdgeInsets.symmetric(horizontal: 0),
              value: selectedAlbum,
              items: albumList.map((e) {
                return DropdownMenuItem(
                  alignment: Alignment.centerLeft,
                  value: e,
                  child: FutureBuilder(
                    future: e.assetCountAsync,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else {
                        return Text(
                          "${e.name} (${snapshot.data})",
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                        );
                      }
                    },
                  ),
                );
              }).toList(),
              onChanged: (AssetPathEntity? value) async {
                setState(() {
                  selectedAlbum = value;
                  videos = [];
                });
                await loadPhotosOfAnAlbum(selectedAlbum!).then(
                  (value) async {
                    receivePort = ReceivePort();
                    await Isolate.spawn(
                        processVideos, [receivePort!.sendPort, value]);

                    final processedVideos =
                        await receivePort!.first as List<AssetEntity>;
                    setState(() {
                      videos = processedVideos;
                    });
                  },
                );
              },
            ),
            actions: [
              IconButton(
                onPressed: () {
                  sendVideos(context);
                },
                icon: const Icon(
                  Iconsax.send_2_bold,
                ),
              )
            ],
          ),
          body: videos.isEmpty
              ? const LoadingWidget()
              : VideosGridPage(assetList: videos),
        );
      },
    );
  }
}
