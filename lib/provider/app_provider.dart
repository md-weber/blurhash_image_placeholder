import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';

class AppProvider extends ChangeNotifier {
  Future<void> uploadImage(File image) async {
    var fileName = Uuid().v4();
    var firebaseRef = FirebaseStorage(
            storageBucket: "gs://hashblur-image-placeholder.appspot.com")
        .ref()
        .child("image/$fileName.png");
    var uploadRef = firebaseRef.putFile(image);
    var finished = await uploadRef.onComplete;
    await finished.ref.getDownloadURL();

    notifyListeners();
  }
}
