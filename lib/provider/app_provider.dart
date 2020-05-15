import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:blurhash/blurhash.dart';
import 'package:blurhashimageplaceholder/models/blur_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class AppProvider extends ChangeNotifier {
  List<BlurImage> _blurImages = [];

  AppProvider(List<String> stringList) {
    _blurImages = stringList.map((value) {
      var json = jsonDecode(value);
      return BlurImage.fromJson(json);
    }).toList();
  }

  List<BlurImage> get blurImages => _blurImages;

  Future<void> uploadImage(File image) async {
    var fileName = Uuid().v4();
    var firebaseRef = FirebaseStorage(
            storageBucket: "gs://hashblur-image-placeholder.appspot.com")
        .ref()
        .child("image/$fileName.png");
    var uploadRef = firebaseRef.putFile(image);
    var finished = await uploadRef.onComplete;
    var uploadedPath = await finished.ref.getDownloadURL();

    // Create a blurhash and add it to the map of images.
    var blurImage = await addFileToMap(uploadedPath, image, fileName);

    // Save the BlurImage into the sharedPreferences for later usage.
    addToSharedPreferences(blurImage);
    notifyListeners();
  }

  Future<BlurImage> addFileToMap(
      String imageDownloadUrl, File image, String fileName) async {
    Uint8List pixels = await image.readAsBytes();
    var blurHash = await BlurHash.encode(pixels, 2, 2);

    var blurImage =
        BlurImage(filePath: fileName, hash: blurHash, url: imageDownloadUrl);
    _blurImages.add(blurImage);

    return blurImage;
  }

  Future<void> addToSharedPreferences(BlurImage blurImage) async {
    var imageString = jsonEncode(blurImage.toJson());
    var pref = await SharedPreferences.getInstance();
    var list = pref.getStringList("blurHashs");

    if (list == null) {
      list = []..add(imageString);
    } else {
      list.add(imageString);
    }
    pref.setStringList("blurHashs", list);
  }
}
