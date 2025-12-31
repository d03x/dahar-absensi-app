part of 'config.dart';

class AppConfig extends Equatable {
  final String baseURL;
  final String userAuthJwtTokenKey;
  final String userAuthJwtRefreshTokenKey;

  final String appName;
  final String tileUrlLayoutMaps;
  const AppConfig({
    required this.userAuthJwtRefreshTokenKey,
    required this.userAuthJwtTokenKey,
    required this.baseURL,
    required this.tileUrlLayoutMaps,
    required this.appName,
  });

  factory AppConfig.fromEnv() {
    return AppConfig(
      userAuthJwtRefreshTokenKey: dotenv.get("USER_JWT_REFRESH_TOKEN_KEY"),
      userAuthJwtTokenKey: dotenv.get('USER_JWT_TOKEN_KEY'),
      baseURL: dotenv.get("BASE_URL"),
      appName: dotenv.get("APP_NAME"),
      tileUrlLayoutMaps: dotenv.get('TILE_URL_LAYOUT_MAPS'),
    );
  }

  @override
  List<String> get props => [baseURL, appName];
}
