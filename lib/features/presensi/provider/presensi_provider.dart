import 'package:dakos/features/presensi/provider/presensi_history_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PresensiState {
  final bool isLoading;
  final String? errorMessage;

  PresensiState({this.isLoading = false, this.errorMessage});
}

class PresensiProvider extends Notifier<PresensiState> {
  @override
  PresensiState build() {
    return PresensiState(errorMessage: null, isLoading: false);
  }

  Future<void> present() async {
    state = PresensiState(isLoading: true, errorMessage: null);
    try {
      // Simulasi proses presensi
      await Future.delayed(Duration(seconds: 2));
      ref.invalidate(presensiHistoryProvider);
      state = PresensiState(isLoading: false, errorMessage: null);
    } catch (e) {
      state = PresensiState(isLoading: false, errorMessage: e.toString());
    }
  }
}

final presensiProvider =
    NotifierProvider.autoDispose<PresensiProvider, PresensiState>(() {
      return PresensiProvider();
    });
