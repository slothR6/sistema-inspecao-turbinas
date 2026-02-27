import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> uploadInspectionImage({
    required String inspectionId,
    required File file,
    required String fileName,
  }) async {
    final ref = _storage.ref('inspecoes/$inspectionId/fotos/$fileName');
    await ref.putFile(file);
    return ref.getDownloadURL();
  }
}
