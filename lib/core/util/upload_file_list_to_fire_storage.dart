import 'dart:developer';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

Future<List<String>> UploadFileListToFireStorage({
  required List<File> fileList,
  required String ref,
  required FirebaseStorage firebaseStorage,
}) async {
  List<String> fileStringList = [];
  for (File file in fileList) {
    final fileId = const Uuid().v1();
    UploadTask uploadTask =
        firebaseStorage.ref().child("$ref$fileId").putFile(file);
    TaskSnapshot taskSnapshot = await uploadTask;
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    log(downloadUrl);
    fileStringList.add(downloadUrl);
  }
  return fileStringList;
}
