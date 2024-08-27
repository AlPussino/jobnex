import 'package:photo_manager/photo_manager.dart';

Future<List<AssetEntity>> loadPhotosOfAnAlbum(
    AssetPathEntity selectedAlbum) async {
  return await selectedAlbum.getAssetListRange(
    start: 0,
    end: await selectedAlbum.assetCountAsync,
  );
}
