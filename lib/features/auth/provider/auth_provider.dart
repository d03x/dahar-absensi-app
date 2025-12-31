import 'package:dakos/features/auth/services/auth_token_service.dart';
import 'package:dakos/features/auth/state/login_state.dart';
import 'package:dakos/features/auth/view_model/login_view_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AuthProvider extends AsyncNotifier<bool> {
  @override
  Future<bool> build() async {
    final tokenProvider = ref.watch(authTokenServiceProvider);
    ref.listen(loginViewModel, (prev, next) async {
      if (next is LoginSuccessState) {
        await tokenProvider.saveToken(next.user.jwt.token);
        setLogin();
      }
    });
    final token = await tokenProvider.getToken();
    return token != null;
  }

  void setLogin() {
    state = AsyncData(true);
  }

  void logout() {
    state = AsyncData(false);
  }
}

final authProvider = AsyncNotifierProvider<AuthProvider, bool>(() {
  return AuthProvider();
});
