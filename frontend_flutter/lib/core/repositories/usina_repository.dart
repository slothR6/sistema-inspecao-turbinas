import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/usina.dart';
import '../services/firestore_service.dart';

class UsinaRepository {
  UsinaRepository({FirestoreService? firestoreService})
      : _firestoreService = firestoreService ?? FirestoreService();

  final FirestoreService _firestoreService;

  Stream<List<Usina>> watchAll() {
    return _firestoreService.collection('usinas').snapshots().map(
          (snapshot) => snapshot.docs
              .map((doc) => Usina.fromMap(doc.id, doc.data()))
              .toList(growable: false),
        );
  }

  Future<void> create(Usina usina) =>
      _firestoreService.collection('usinas').doc(usina.id).set(usina.toMap());

  Future<void> update(Usina usina) =>
      _firestoreService.collection('usinas').doc(usina.id).update(usina.toMap());

  Future<void> delete(String id) => _firestoreService.collection('usinas').doc(id).delete();
}
