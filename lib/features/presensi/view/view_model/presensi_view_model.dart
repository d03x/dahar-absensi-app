import 'dart:async';

import 'package:dakos/features/presensi/provider/presensi_history_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import "../state/presensi_state.dart";

export "../../provider/presensi_history_provider.dart";
export "../../provider/presensi_provider.dart";

class PresensiViewModel extends AsyncNotifier<PresensiState> {
  @override
  FutureOr<PresensiState> build() async {
    return PresensiState();
  }

  /// FUNGSI MENTIMPAN PRESENSI
  Future<void> present() async {
    state = AsyncValue.loading();
    try {
      await Future.delayed(const Duration(seconds: 2));
      state = AsyncValue.data(PresensiState());
      ref.invalidate(presensiHistoryProvider);
    } catch (e) {
      state = AsyncValue.error(e.toString(), StackTrace.current);
    }
  }
}

//presensi view model provider
final presensiViewModel =
    AsyncNotifierProvider<PresensiViewModel, PresensiState>(() {
      return PresensiViewModel();
    });
