import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

class FileManager {
  final int id;
  final String url;
  final String name;
  final String format;
  FileManager(
      {required this.id,
      required this.url,
      required this.name,
      required this.format});
}

class FileDownloader {
  Future<bool> fileDownloader(
      List<FileManager> fileList, bool isModelTarget) async {
    FirebaseStorage storage = FirebaseStorage.instance;
    final appDocDir = await getApplicationDocumentsDirectory();
    for (var fileManager in fileList) {
      final httpsRef = storage.refFromURL(fileManager.url);

      final String type = isModelTarget ? "model" : "image";
      final filePath =
          "${appDocDir.path}/$type/${fileManager.name}${fileManager.id}.${fileManager.format}";
      final file = File(filePath);

      if (!File(filePath).existsSync()) {
        if (!File("${appDocDir.path}/$type").existsSync()) {
          try {
            await Directory("${appDocDir.path}/$type").create();
          } catch (e) {
            debugPrint("$e");
            return false;
          }
          debugPrint("filePath:${appDocDir.path}/$type保存用ディレクトリを作成");
        }
        try {
          httpsRef.writeToFile(file);
        } catch (e) {
          debugPrint("$e");
          return false;
        }
        debugPrint("filePath:{$filePath}ダウンロード完了(問題なし)");
      } else {
        debugPrint("{$filePath}は存在(問題なし)");
      }
    }
    return true;
  }

  Future<List<FileManager>> getfileURL(
      List<int> modelIDList, bool isModelTarget) async {
    final String col = isModelTarget ? "models" : "images";
    final String id = isModelTarget ? "modelID" : "imageID";
    final String url = isModelTarget ? "modelURL" : "imageURL";
    final String name = isModelTarget ? "modelName" : "imageName";
    FirebaseFirestore store = FirebaseFirestore.instance;
    final colRef = store.collection(col);
    List<FileManager> modelManagerList =
        List<FileManager>.empty(growable: true);
    final query = colRef.where(id, whereIn: modelIDList);
    final querySnapshot = await query.get();
    final queryDocumentSnapshot = querySnapshot.docs;
    debugPrint("${queryDocumentSnapshot.length}");
    if (modelIDList.length != queryDocumentSnapshot.length) {
      modelManagerList = List.generate(
          queryDocumentSnapshot.length,
          (int index) => FileManager(
              id: index, url: "$index", name: "$index", format: "$index"));
      return modelManagerList;
    }
    for (var snapShot in queryDocumentSnapshot) {
      final data = snapShot.data();
      final convertedData = FileManager(
          id: data[id] as int,
          url: data[url].toString(),
          name: data[name].toString(),
          format: data["fileFormat"]);
      debugPrint(convertedData.name);
      modelManagerList.add(convertedData);
    }
    // var aaa = modelManagerList.isNotEmpty ? true : false;
    return modelManagerList;
  }

  Future<bool> checkFilesExist(
      List<int> modelIDList, List<int> imageIDList) async {
    final modelFileList = await getfileURL(modelIDList, true);
    final imageFileList = await getfileURL(imageIDList, false);
    final appDocDir = await getApplicationDocumentsDirectory();

    for (var fileManager in modelFileList) {
      final filePath =
          "${appDocDir.path}/model/${fileManager.name}${fileManager.id}.${fileManager.format}";
      if (!File(filePath).existsSync()) {
        debugPrint("filePath:{$filePath}が存在しません");
        return false;
      }
    }
    for (var fileManager in imageFileList) {
      final filePath =
          "${appDocDir.path}/image/${fileManager.name}${fileManager.id}.${fileManager.format}";
      if (!File(filePath).existsSync()) {
        debugPrint("filePath:{$filePath}が存在しません");
        return false;
      }
    }
    return true;
  }
}
