import 'package:dakos/core/config/config.dart';
import 'package:dakos/core/providers/app_config_provider.dart';
import 'package:dakos/core/services/secure_token_storage_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AuthTokenService {
  final SecureTokenStorageService storageService;
  final AppConfig appConfig;
  AuthTokenService({required this.appConfig, required this.storageService});

  Future<void> saveToken(String token) async {
    return await storageService.set(appConfig.userAuthJwtTokenKey, token);
  }

  Future<String?> getToken() async {
    return await storageService.read(appConfig.userAuthJwtTokenKey);
  }

  Future<void> deleteToken() async {
    await storageService.delete(appConfig.userAuthJwtTokenKey);
  }
}

final authTokenServiceProvider = Provider<AuthTokenService>((ref) {
  return AuthTokenService(
    appConfig: ref.watch(appConfigProvider),
    storageService: ref.watch(secureTokenStorageServiceProvider),
  );
});
