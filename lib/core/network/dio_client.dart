import "package:dakos/core/providers/app_config_provider.dart";
import "package:dakos/features/auth/provider/auth_provider.dart";
import "package:dakos/features/auth/services/auth_token_service.dart";
import "package:dio/dio.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";

final dioProvider = Provider<Dio>((ref) {
  final config = ref.watch(appConfigProvider);
  final dio = Dio(
    BaseOptions(
      baseUrl: config.baseURL,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  );
  dio.interceptors.add(
    InterceptorsWrapper(
      onError: (DioException e, handler) async {
        final token = ref.read(authTokenServiceProvider);
        final auth = ref.read(authProvider.notifier);

        if (e.response!.statusCode == 401) {
          await token.deleteToken();
          auth.logout();
          print("DELETED:");
        }
        return handler.next(e);
      },
      onRequest: (options, handler) async {
        final token = await ref.watch(authTokenServiceProvider).getToken();
        if (token != null) {
          options.headers["Authorization"] = "Bearer $token";
        }
        print(token);
        return handler.next(options);
      },
    ),
  );
  return dio;
});
