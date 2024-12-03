import 'dart:developer';
import 'dart:isolate';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';

class PhotosUsingIsolate extends StatefulWidget {
  const PhotosUsingIsolate({super.key});

  @override
  State<PhotosUsingIsolate> createState() => _PhotosUsingIsolateState();
}

class _PhotosUsingIsolateState extends State<PhotosUsingIsolate> {
  List<AssetPathEntity> albums = [];

  @override
  void initState() {
    fetchAlbums();
    super.initState();
  }

  Future<void> fetchAlbums() async {
    final PermissionState permissionState =
        await PhotoManager.requestPermissionExtend();

    if (permissionState.isAuth) {
      // Fetch albums (folders)
      List<AssetPathEntity> fetchedAlbums = await PhotoManager.getAssetPathList(
        type: RequestType.image,
        filterOption: FilterOptionGroup(),
      );

      setState(() {
        albums = fetchedAlbums;
        log(albums.length.toString());
      });
    } else {
      // Handle permission denial
    }
  }

  Future<Uint8List?> loadImageThumbnail(AssetEntity entity) async {
    final receivePort = ReceivePort();
    await Isolate.spawn(_loadThumbnail, [receivePort.sendPort, entity]);

    return await receivePort.first as Uint8List?;
  }

  void _loadThumbnail(List<dynamic> args) async {
    final sendPort = args[0] as SendPort;
    final entity = args[1] as AssetEntity;

    final thumbnail =
        await entity.thumbnailDataWithSize(const ThumbnailSize(200, 200));
    sendPort.send(thumbnail);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Photo Gallery")),
      body: albums.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: albums.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(albums[index].name),
                );
              },
            ),
    );
  }
}
