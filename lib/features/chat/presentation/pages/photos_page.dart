import 'dart:io';
import 'dart:isolate';
import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';

class PhotosPage extends StatefulWidget {
  static const routeName = '/photos-page';

  const PhotosPage({super.key});

  @override
  State<PhotosPage> createState() => _PhotosPageState();
}

class _PhotosPageState extends State<PhotosPage> {
  List<String> imageFilePaths = [];

  @override
  void initState() {
    super.initState();
    loadImages();
  }

  Future<void> loadImagesInIsolate(SendPort sendPort) async {
    final albums = await PhotoManager.getAssetPathList();
    final recentAlbum = albums.first;
    final images = await recentAlbum.getAssetListRange(start: 0, end: 100);
    final filePaths = images.map((asset) => asset.id).toList();
    sendPort.send(filePaths);
  }

  Future<void> loadImages() async {
    final receivePort = ReceivePort();
    await Isolate.spawn(loadImagesInIsolate, receivePort.sendPort);
    final imageFilePathsFromIsolate = await receivePort.first as List<String>;
    setState(() {
      imageFilePaths = imageFilePathsFromIsolate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Grid'),
      ),
      body: GridView.builder(
        itemCount: imageFilePaths.length,
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
        itemBuilder: (context, index) {
          return Image(
            image: FileImage(File(imageFilePaths[index])),
          );
        },
      ),
    );
  }
}
