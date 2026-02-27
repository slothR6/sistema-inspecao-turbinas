import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  FirestoreService() {
    FirebaseFirestore.instance.settings = const Settings(
      persistenceEnabled: true,
      cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
    );
  }

  CollectionReference<Map<String, dynamic>> collection(String path) {
    return FirebaseFirestore.instance.collection(path);
  }
}
