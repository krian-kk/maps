import 'dart:collection';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:maps/routing/AppRouter.dart';

Future<void> main() async {
  // runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        routerConfig: AppRouter().goRouter);
  }
}

Future<void> main1() async {
  File file = File("path");
  FileManager manager = FileManager(file: file);
  FileMetadata metadata = FileMetadata(file: file);
  ImageManager imageManager = ImageManager(file: file);
  EncryptionManager encryptionManager = EncryptionManager(file: file);
  UploadManager uploadManager = UploadManager(file: file);

  HashMap<String, bool> statusMap = HashMap();

  Set<String> order = {};
  order.add(Status.gif.toString());
  order.add(Status.metadata.toString());
  order.add(Status.hash.toString());
  order.add(Status.thumbnail.toString());

  order.forEach((orderName) async {
    switch (orderName) {
      case Status.gif:
        {
          if (statusMap[Status.gif] != true) {
            manager.status = Status.gif.toString();
            await imageManager.convertToGif(file);
          }
        }
      case Status.metadata:
        {
          if (statusMap[Status.metadata] != true) {
            statusMap[Status.metadata.toString()] = true;
            manager.status = Status.metadata.toString();
            metadata.getMetaData();
          }
        }
      case Status.hash:
        {}
    }
  });

  if (statusMap[Status.metadata] != true) {
    statusMap[Status.metadata.toString()] = true;
    manager.status = Status.metadata.toString();
    metadata.getMetaData();
  }

  manager.status = Status.hash.toString();
  manager.computeHash();

  manager.status = Status.thumbnail.toString();
  await imageManager.convertToThumbnail(file);

  manager.status = Status.gif.toString();
  await imageManager.convertToGif(file);

  manager.status = Status.mpeg.toString();
  await imageManager.convertToMpeg(file);

  manager.status = Status.encrypt.toString();
  await encryptionManager.encrypt(file);

  manager.status = Status.decrypt.toString();
  await encryptionManager.decrypt(file);

  manager.status = Status.upload.toString();
  uploadManager.uploadToServer();

  manager.status = Status.completed.toString();
}

class FileManager extends ComputeHash {
  String? status;
  File file;

  FileManager({required this.file});

  @override
  void computeHash() {
    print("compute hash");
  }

  void setStatus(String status) {
    //save to persistance
    this.status = status;
  }

  String? getStatus() {
    // get status from persistance
    return status;
  }
}

class FileMetadata {
  File file;

  FileMetadata({required this.file});

  void getMetaData() {
    print("getting metadata");
  }
}

abstract class ComputeHash {
  void computeHash();
}

class ImageManager extends ImageConversion {
  File file;

  ImageManager({required this.file});

  @override
  Future<void> convertToGif(File file) async {
    Future.delayed(const Duration(milliseconds: 2000));
    print("converting to gif");
  }

  @override
  Future<void> convertToThumbnail(File file) async {
    Future.delayed(const Duration(milliseconds: 2000));

    print("converting to thumbnail");
  }

  @override
  Future<void> convertToMpeg(File file) async {
    Future.delayed(const Duration(milliseconds: 2000));

    print("converting to thumbnail");
  }
}

abstract class ImageConversion {
  Future<void> convertToThumbnail(File file);

  Future<void> convertToGif(File file);

  Future<void> convertToMpeg(File file);
}

class EncryptionManager extends CryptoGraphy {
  File file;

  EncryptionManager({required this.file});

  @override
  Future<void> decrypt(File file) async {
    Future.delayed(const Duration(milliseconds: 2000));
    print("decrypting");
  }

  @override
  Future<void> encrypt(File file) async {
    Future.delayed(const Duration(milliseconds: 2000));
    print("encrypting");
  }
}

abstract class CryptoGraphy {
  Future<void> encrypt(File file);

  Future<void> decrypt(File file);
}

class UploadManager {
  File file;

  UploadManager({required this.file});

  Future<void> uploadToServer() async {
    Future.delayed(const Duration(milliseconds: 2000));

    print("uploading to server");
  }
}

enum Status {
  metadata,
  hash,
  thumbnail,
  gif,
  mpeg,
  encrypt,
  decrypt,
  upload,
  completed
}