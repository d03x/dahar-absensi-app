import 'package:dakos/features/presensi/repo/presensi_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PresensiDashboardState {}

class PresensiProvider extends AsyncNotifier<PresensiDashboardState> {
  @override
  Future<PresensiDashboardState> build() async {
    return _fetchAllData();
  }

  Future<PresensiDashboardState> _fetchAllData() async {
    Future.wait([loadHistoryPresensiToday()]);
    return PresensiDashboardState();
  }

  Future<void> loadHistoryPresensiToday() async {
    final pres = ref.read(presensiRepositoryProvider);
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await pres.fetchHistoryPresensiToday();
      return PresensiDashboardState();
    });
  }
}

final presensiProvider =
    AsyncNotifierProvider.autoDispose<PresensiProvider, PresensiDashboardState>(
      () {
        return PresensiProvider();
      },
    );
