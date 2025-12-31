import 'package:dakos/features/auth/model/user_model.dart';
import 'package:dakos/features/auth/services/user_services.dart';
import 'package:dakos/features/auth/state/auth_state.dart';
import 'package:dakos/features/auth/state/login_state.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LoginState extends Equatable {
  final bool isLoggedIn;
  final bool isLoading;
  final String loginError;
  const LoginState({
    this.isLoggedIn = false,
    required this.loginError,
    required this.isLoading,
  });

  LoginState copyWith({bool? isLoggedIn, String? loginError, bool? isLoading}) {
    return LoginState(
      loginError: loginError ?? this.loginError,
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List get props => [isLoggedIn, isLoading, loginError];
}

class LoginViewModel extends Notifier<AuthState> {
  @override
  AuthState build() {
    return AuthState();
  }

  Future<void> login({required String email, required String password}) async {
    final userService = ref.watch(userServiceProvider);
    state = LoginLoadingState();
    try {
      final UserModel user = await userService.login(
        email: email.trim(),
        password: password.trim(),
      );
      state = LoginSuccessState(user: user);
    } on DioException catch (e) {
      if (e.response!.statusCode == 422) {
        state = LoginFailedState.fromJson(e.response!.data);
      }
    } catch (e) {
      state = LoginFailedState(error: e.toString());
    }
  }
}

final loginViewModel = NotifierProvider.autoDispose<LoginViewModel, AuthState>(
  () {
    return LoginViewModel();
  },
);
