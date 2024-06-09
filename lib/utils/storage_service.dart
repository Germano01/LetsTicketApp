import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';

class StorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String?> uploadImage(File imageFile) async {
    try {
      String fileName = basename(imageFile.path);
      Reference ref = _storage.ref().child('images/$fileName');
      await ref.putFile(imageFile);
      String downloadURL = await ref.getDownloadURL();
      return downloadURL;
    } catch (e) {
      print('Error uploading image: $e');
      return null;
    }
  }
}
