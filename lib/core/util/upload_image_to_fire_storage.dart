import 'dart:developer';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

Future<String> UploadImageToFireStorage({
  required File imageFile,
  required String ref,
  required FirebaseStorage firebaseStorage,
}) async {
  UploadTask uploadTask = firebaseStorage.ref().child(ref).putFile(imageFile);
  TaskSnapshot taskSnapshot = await uploadTask;
  String downloadUrl = await taskSnapshot.ref.getDownloadURL();
  log("Upload image done");
  return downloadUrl;
}
