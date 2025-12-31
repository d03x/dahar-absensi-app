class JWTAuthTokenModel {
  final String token;
  JWTAuthTokenModel({required this.token});

  factory JWTAuthTokenModel.fromJson(Map<String, dynamic> token) {
    return JWTAuthTokenModel(token: token['token']);
  }
}

class UserModel {
  final int id;
  final String name;
  final String email;
  final JWTAuthTokenModel jwt;
  UserModel({
    required this.id,
    required this.email,
    required this.jwt,
    required this.name,
  });

  factory UserModel.fromLoginApi(Map<String, dynamic> user) {
    return UserModel(
      id: user['user']['id'],
      email: user['user']['email'],
      name: user['user']['name'],
      jwt: JWTAuthTokenModel.fromJson(user),
    );
  }
}
