import 'package:dakos/features/auth/model/user_model.dart';
import 'package:dakos/features/auth/services/user_services.dart';
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

class LoginViewModel extends Notifier<LoginState> {
  @override
  LoginState build() {
    return LoginState(isLoggedIn: false, loginError: '', isLoading: false);
  }

  Future<void> login({required String email, required String password}) async {
    final userService = ref.watch(userServiceProvider);
    state = state.copyWith(isLoggedIn: false, isLoading: true);
    try {
      final UserModel user = await userService.login(
        email: email.trim(),
        password: password.trim(),
      );
      print(user.jwt.token);
      state = state.copyWith(
        isLoggedIn: false,
        isLoading: false,
        loginError: '',
      );
    } on DioException catch (e) {
      if (e.response?.statusCode == 422) {
        final response = e.response!.data;
        state = state.copyWith(
          isLoggedIn: false,
          isLoading: false,
          loginError: response['message'],
        );
      }
    } catch (e) {
      state = state.copyWith(
        isLoggedIn: false,
        isLoading: false,
        loginError: e.toString(),
      );
    } finally {
      state.copyWith(isLoading: false);
    }
    state = state.copyWith(isLoggedIn: false, isLoading: false);
  }
}

final loginViewModel = NotifierProvider.autoDispose<LoginViewModel, LoginState>(
  () {
    return LoginViewModel();
  },
);
