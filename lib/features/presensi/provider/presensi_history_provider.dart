import 'package:dakos/features/presensi/repo/presensi_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PresensiHistoryProvider extends AsyncNotifier<String> {
  @override
  Future<String> build() async {
    return fetchPresensiHistory();
  }

  Future<String> fetchPresensiHistory() async {
    final repo = ref.watch(presensiRepositoryProvider);
    state = AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      return await repo.fetchHistoryPresensiToday();
    });
    return "Presensi History Data";
  }
}

final presensiHistoryProvider =
    AsyncNotifierProvider.autoDispose<PresensiHistoryProvider, String>(() {
      return PresensiHistoryProvider();
    });
