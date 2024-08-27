import 'dart:async';
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
import 'package:freezed_example/features/chat/presentation/widgets/images_grid.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:provider/provider.dart';

class SelectPhotosPage extends StatefulWidget {
  static const routeName = '/select-photos-page';

  final Map<String, dynamic> receiverData;

  const SelectPhotosPage({super.key, required this.receiverData});

  @override
  State<SelectPhotosPage> createState() => _SelectPhotosPageState();
}

class _SelectPhotosPageState extends State<SelectPhotosPage> {
  ReceivePort? receivePort;
  bool showDropDownButton = false;
  AssetPathEntity? selectedAlbum;
  List<AssetPathEntity> albumList = [];
  List<AssetEntity> _images = [];
  List<Uint8List> selectedList = [];

  @override
  void initState() {
    super.initState();
    _loadImages();
  }

  Future<void> _loadImages() async {
    await loadPhotoAlbums(RequestType.image).then(
      (value) {
        setState(() {
          albumList = value;
          selectedAlbum = value[1];
        });
        loadPhotosOfAnAlbum(selectedAlbum!).then(
          (value) async {
            receivePort = ReceivePort();
            await Isolate.spawn(_processImages, [receivePort!.sendPort, value]);

            final processedImages =
                await receivePort!.first as List<AssetEntity>;
            setState(() {
              _images = processedImages;
            });
          },
        );
      },
    );

    // Now process the images in an isolate
  }

  static void _processImages(List<dynamic> args) {
    final sendPort = args[0] as SendPort;
    final List<AssetEntity> photos = args[1] as List<AssetEntity>;

    // Process images if needed, for now we simply send them back
    sendPort.send(photos);
  }

  void sendImages(BuildContext context) async {
    List<File> selectedFiles = [];
    List<AssetEntity> selectedImages =
        context.read<MediaProvider>().selectedImages;
    for (AssetEntity image in selectedImages) {
      File? imageFile = await image.file;
      selectedFiles.add(imageFile!);
    }
    context.read<ChatBloc>().add(ChatSendFileMessage(
          widget.receiverData['user_id'],
          selectedFiles,
          MessageTypeEnum.image,
        ));

    context.read<MediaProvider>().selectedImages.clear();
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _images.clear();
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
                          style: const TextStyle(fontSize: 12),
                        );
                      }
                    },
                  ),
                );
              }).toList(),
              onChanged: (AssetPathEntity? value) async {
                setState(() {
                  selectedAlbum = value;
                  _images = [];
                });
                await loadPhotosOfAnAlbum(selectedAlbum!).then(
                  (value) async {
                    receivePort = ReceivePort();
                    await Isolate.spawn(
                        _processImages, [receivePort!.sendPort, value]);

                    final processedImages =
                        await receivePort!.first as List<AssetEntity>;
                    setState(() {
                      _images = processedImages;
                    });
                  },
                );
              },
            ),
            actions: [
              IconButton(
                onPressed: () {
                  sendImages(context);
                },
                icon: const Icon(
                  Iconsax.send_2_bold,
                ),
              )
            ],
          ),
          body: _images.isEmpty
              ? const LoadingWidget(caption: "Loading...")
              : ImagesGridPage(assetList: _images),
        );
      },
    );
  }
}
