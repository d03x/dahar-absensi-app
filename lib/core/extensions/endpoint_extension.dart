import 'package:dakos/core/config/config.dart';

extension EndpointExtension on String {
  String get toApiUrl {
    final config = AppConfig.fromEnv();
    return "${config.baseURL}/api/${split(".").join("/")}";
  }
}
