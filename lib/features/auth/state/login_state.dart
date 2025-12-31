import 'package:dakos/features/auth/model/user_model.dart';
import 'package:dakos/features/auth/state/auth_state.dart';

class LoginFailedState extends AuthState {
  final String error;
  LoginFailedState({required this.error});

  factory LoginFailedState.fromJson(Map<String, dynamic> json) {
    return LoginFailedState(error: json['message'] ?? "Error Guys");
  }
}

class LoginLoadingState extends AuthState {}

class LoginSuccessState extends AuthState {
  final UserModel user;
  LoginSuccessState({required this.user});
}
