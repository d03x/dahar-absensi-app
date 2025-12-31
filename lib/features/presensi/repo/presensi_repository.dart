import 'package:hooks_riverpod/hooks_riverpod.dart';

class PresensiRepository {
  Future<String> fetchHistoryPresensiToday() async {
    // Simulasi pengambilan data presensi dari API atau database
    await Future.delayed(Duration(seconds: 5));
    return "WKWK";
  }

  Future<String> postAbsensi() async {
    // Simulasi pengambilan data presensi dari API atau database
    await Future.delayed(Duration(seconds: 5));
    return "WKWK";
  }
}

final presensiRepositoryProvider = Provider<PresensiRepository>((ref) {
  return PresensiRepository();
});
