import 'package:dakos/core/app.dart';
import 'package:dakos/core/config/config.dart';
import 'package:dakos/core/providers/app_config_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  await initializeDateFormatting('id_ID', null);
  await dotenv.load(fileName: '.env');
  runApp(
    ProviderScope(
      overrides: [appConfigProvider.overrideWithValue(AppConfig.fromEnv())],
      child: App(),
    ),
  );
}
