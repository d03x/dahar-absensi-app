import 'package:dakos/features/auth/provider/auth_provider.dart';
import 'package:equatable/equatable.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LoginState extends Equatable {
  final bool isLoggedIn;
  final bool isLoading;
  const LoginState({this.isLoggedIn = false, required this.isLoading});

  LoginState copyWith({bool? isLoggedIn, bool? isLoading}) {
    return LoginState(
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List get props => [isLoggedIn, isLoading];
}

class LoginViewModel extends Notifier<LoginState> {
  @override
  LoginState build() {
    return LoginState(isLoggedIn: false, isLoading: false);
  }

  Future<void> login({required String email, required String password}) async {
    state = state.copyWith(isLoading: true);
    await Future.delayed(const Duration(seconds: 2)).whenComplete(() {
      ref.read(authProvider.notifier).setLogin();
    });
    state = state.copyWith(isLoggedIn: true, isLoading: false);
  }
}

final loginViewModel = NotifierProvider.autoDispose<LoginViewModel, LoginState>(
  () {
    return LoginViewModel();
  },
);
