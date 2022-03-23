part of 'login_cubit.dart';

@immutable
abstract class LoginState {
  const LoginState();
}

class LoginInitial extends LoginState {
  const LoginInitial();
}

class LoginLoading extends LoginState {
  const LoginLoading();
}

class LoginLoaded extends LoginState {
  final LoginResponse loginResponse;
  const LoginLoaded(this.loginResponse);
}

class LoginError extends LoginState {
  final String message;
  const LoginError(this.message);
}
