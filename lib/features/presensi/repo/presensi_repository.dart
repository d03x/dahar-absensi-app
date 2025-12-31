import 'package:dakos/core/network/dio_client.dart';
import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PresensiRepository {
  final Dio dio;
  PresensiRepository({required this.dio});
  Future<String> fetchHistoryPresensiToday() async {
    await dio.get("?endpoint=api/attendance/history_today");
    return "WKWK";
  }

  Future<String> postAbsensi() async {
    // Simulasi pengambilan data presensi dari API atau database
    return "WKWK";
  }
}

final presensiRepositoryProvider = Provider<PresensiRepository>((ref) {
  return PresensiRepository(dio: ref.watch(dioProvider));
});
