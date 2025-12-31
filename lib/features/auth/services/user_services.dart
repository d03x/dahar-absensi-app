import 'package:dakos/core/network/dio_client.dart';
import 'package:dakos/features/auth/model/user_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class UserServices {
  DioClient dio;
  UserServices({required this.dio});
  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    try {
      final user = await dio.instance.post(
        '?endpoint=api/auth/login',
        data: {'email': email, 'password': password},
      );
      print("USER $user");
      return UserModel.fromLoginApi(user.data['data']);
    } catch (e) {
      rethrow;
    }
  }
}

final userServiceProvider = Provider<UserServices>((ref) {
  final dio = ref.watch(dioProvider);
  return UserServices(dio: dio);
});
