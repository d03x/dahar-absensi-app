import 'package:dakos/features/presensi/provider/presensi_history_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

export "../provider/presensi_history_provider.dart";
export "../provider/presensi_provider.dart";

final presensiViewModel = Provider<AsyncValue<dynamic>>((ref) {
  final histories = ref.watch(presensiHistoryProvider);
  if (histories.isLoading) {
    return AsyncValue.loading();
  } else if (histories.hasError) {
    return AsyncValue.loading();
  } else {
    return AsyncValue.data(histories);
  }
});
