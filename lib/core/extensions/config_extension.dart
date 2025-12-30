import 'package:dakos/core/config/config.dart';
import 'package:dakos/core/providers/app_config_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

extension ConfigExtension on BuildContext {
  AppConfig get config {
    return AppConfig.fromEnv();
  }
}

extension ConfigProvider on WidgetRef {
  AppConfig get configs {
    return watch(appConfigProvider);
  }
}

extension ConfigProviderRef on Ref {
  AppConfig get configs {
    return watch(appConfigProvider);
  }
}
