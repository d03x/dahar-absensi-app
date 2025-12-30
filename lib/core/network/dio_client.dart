import "package:dakos/core/config/config.dart";
import "package:dakos/core/providers/app_config_provider.dart";
import "package:dio/dio.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";

class DioClient {
  final AppConfig config;
  DioClient({required this.config});

  Dio get instance {
    return Dio(BaseOptions(baseUrl: config.baseURL));
  }
}

final dioProvider = Provider<DioClient>((ref) {
  final config = ref.watch(appConfigProvider);
  return DioClient(config: config);
});
