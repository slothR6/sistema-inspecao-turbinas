class OfflineSyncService {
  int _pendingOperations = 0;

  int get pendingOperations => _pendingOperations;

  Future<void> queueOperation() async {
    _pendingOperations++;
  }

  Future<void> flushQueue() async {
    _pendingOperations = 0;
  }
}
