import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

Future<String> getFileURL(String videoPath) async {
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  String downloadUrl = await storage.ref(videoPath).getDownloadURL();
  return downloadUrl;
}
