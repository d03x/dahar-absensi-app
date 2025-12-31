import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SecureTokenStorageService {
  final FlutterSecureStorage flutterSecureStorage = FlutterSecureStorage();

  Future<void> set(String key, String value) async {
    await flutterSecureStorage.write(key: key, value: value);
  }

  Future<String?> read(String key) async {
    return await flutterSecureStorage.read(key: key);
  }

  Future<void> delete(String key) async {
    await flutterSecureStorage.delete(key: key);
  }
}

final secureTokenStorageServiceProvider = Provider<SecureTokenStorageService>((
  ref,
) {
  return SecureTokenStorageService();
});
