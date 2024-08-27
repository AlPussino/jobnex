import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';

class MediaProvider with ChangeNotifier {
  List<AssetEntity> _selectedImages = [];
  List<AssetEntity> get selectedImages => _selectedImages;

  List<AssetEntity> _selectedVideos = [];
  List<AssetEntity> get selectedVideos => _selectedVideos;

  void selectImage(AssetEntity image) {
    _selectedImages.contains(image)
        ? _selectedImages.remove(image)
        : _selectedImages.add(image);
    log(selectedImages.length.toString());
    notifyListeners();
  }

  void selectVideo(AssetEntity video) {
    _selectedVideos.contains(video)
        ? _selectedVideos.remove(video)
        : _selectedVideos.add(video);
    log(selectedVideos.length.toString());
    notifyListeners();
  }
}
