import 'package:dakos/features/splash/view_model/splash_view_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AuthProvider extends AsyncNotifier<bool> {
  @override
  bool build() {
    return false;
  }

  void setLogin() {
    state = AsyncData(true);
  }

  Future<void> checkLoginStatus() async {
    // 1. Mulai Loading
    state = const AsyncValue.loading();

    // Ambil notifier pesan biar bisa di-update
    final messageNotifier = ref.read(splashMessageProvider.notifier);

    try {
      // --- TAHAP 1: Cek Koneksi ---
      messageNotifier.state = State(
        show: true,
        message: "Menghubungkan ke server Lugwa...",
      );
      await Future.delayed(const Duration(seconds: 1));

      messageNotifier.state = State(
        show: true,
        message: "Memeriksa pembaruan...",
      );
      await Future.delayed(const Duration(milliseconds: 800));

      messageNotifier.state = State(
        show: true,
        message: "Verifikasi sesi pengguna...",
      );
      await Future.delayed(const Duration(milliseconds: 800));
      messageNotifier.state = State(show: false, message: "Suceesss...");
      await Future.delayed(const Duration(milliseconds: 900));
    } catch (e, stack) {
      messageNotifier.state = State(show: false, message: "Gagal terhubung.");
      state = AsyncValue.error(e, stack);
    }
  }
}

final authProvider = AsyncNotifierProvider<AuthProvider, bool>(() {
  return AuthProvider();
});
