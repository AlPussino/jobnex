import 'package:photo_manager/photo_manager.dart';

Future<List<AssetPathEntity>> loadPhotoAlbums(RequestType requestType) async {
  return await PhotoManager.getAssetPathList(type: requestType, onlyAll: false);
}
