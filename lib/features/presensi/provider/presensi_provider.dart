import 'package:dakos/features/presensi/repo/presensi_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PresensiProvider extends AsyncNotifier {
  @override
  Future<void> build() async {
    return;
  }

  Future<void> present() async {
    final repo = ref.read(presensiRepositoryProvider);

    // 1. Set Loading (Biar UI tau lagi proses kirim)
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      await repo.postAbsensi();
    });
  }
}

final presensiProvider =
    AsyncNotifierProvider.autoDispose<PresensiProvider, void>(() {
      return PresensiProvider();
    });
