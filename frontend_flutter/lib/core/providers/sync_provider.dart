import 'package:flutter/material.dart';

import '../services/offline_sync_service.dart';

class SyncProvider extends ChangeNotifier {
  final OfflineSyncService _service = OfflineSyncService();

  int pending = 0;

  void init() {
    pending = _service.pendingOperations;
  }

  Future<void> syncNow() async {
    await _service.flushQueue();
    pending = _service.pendingOperations;
    notifyListeners();
  }
}
