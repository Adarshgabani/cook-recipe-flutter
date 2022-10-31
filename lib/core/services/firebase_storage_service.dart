import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageService {
  static Future<String?> storeImage(String path) async {
    final ref = FirebaseStorage.instance.ref().child("Images");
    final fileName = "${DateTime.now().millisecondsSinceEpoch.toString()}_${path.split('/').last}";
    File file = File(path);
    final imageRef = ref.child(fileName);
    try {
      var task = await imageRef.putFile(file);
      var x = await task.ref.getDownloadURL();

      return x;
    } catch (e) {
      print("ErrorLLL:: $e");
    }
  }
}
