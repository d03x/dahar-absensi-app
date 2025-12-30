part of 'config.dart';

class AppConfig extends Equatable {
  final String baseURL;
  final String appName;
  final String tileUrlLayoutMaps;
  const AppConfig({
    required this.baseURL,
    required this.tileUrlLayoutMaps,
    required this.appName,
  });

  factory AppConfig.fromEnv() {
    return AppConfig(
      baseURL: dotenv.get("BASE_URL"),
      appName: dotenv.get("APP_NAME"),
      tileUrlLayoutMaps: dotenv.get('TILE_URL_LAYOUT_MAPS'),
    );
  }

  @override
  List<String> get props => [baseURL, appName];
}
