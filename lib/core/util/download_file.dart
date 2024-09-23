import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_file_dialog/flutter_file_dialog.dart';
import 'package:JobNex/core/util/show_snack_bar.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:toastification/toastification.dart';
import 'package:uuid/uuid.dart';

Future<void> downloadFile(BuildContext context, String downloadUrl) async {
  await requestPermission();
  try {
    // Get temporary directory
    final dir = await getTemporaryDirectory();

    // Create an file name
    final fileId = const Uuid().v1();
    var filename = '${dir.path}/$fileId';

    // Save to filesystem
    final file = File(filename);
    // SnackBars.showToastification(
    //     context, "Downloading...", ToastificationType.success);

    // Download pdf
    final http.Response response = await http.get(Uri.parse(downloadUrl));
    await file.writeAsBytes(response.bodyBytes);
    // Ask the user to save it
    final params = SaveFileDialogParams(sourceFilePath: file.path);
    final finalPath = await FlutterFileDialog.saveFile(params: params);

    if (finalPath != null) {
      // SnackBars.showToastification(
      //     context, "Downloaded file.", ToastificationType.success);
    }
  } catch (e) {
    log(e.toString());
    SnackBars.showToastification(context, "$e", ToastificationType.error);
  }
}

Future<void> requestPermission() async {
  var status = await Permission.storage.request();
  log(status.toString());
  if (status.isGranted) {
  } else if (status.isDenied) {
  } else if (status.isPermanentlyDenied) {
    log("Permission permanently denied");
    openAppSettings();
  }
}
