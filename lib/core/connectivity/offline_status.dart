import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// When non-null, the most recent merchant data on screen came from the
/// local cache because the network failed. Holds the cache timestamp.
class OfflineStatus extends Notifier<DateTime?> {
  @override
  DateTime? build() => null;

  void servedFromCache(DateTime savedAt) {
    final current = state;
    if (current == null || savedAt.isBefore(current)) state = savedAt;
  }

  void online() => state = null;
}

final offlineStatusProvider = NotifierProvider<OfflineStatus, DateTime?>(
  OfflineStatus.new,
);

/// True when the OS reports no network route at all.
final connectivityProvider = StreamProvider<bool>((ref) {
  return Connectivity().onConnectivityChanged.map(
    (results) => results.any((r) => r != ConnectivityResult.none),
  );
});
