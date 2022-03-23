part of 'register_cubit.dart';

@immutable
abstract class RegisterState {
  const RegisterState();
}

class RegisterInitial extends RegisterState {
  const RegisterInitial();
}

class RegisterLoading extends RegisterState {
  const RegisterLoading();
}

class RegisterLoaded extends RegisterState {
  final bool isRegisterSuccess;

  const RegisterLoaded(this.isRegisterSuccess);
}

class RegisterError extends RegisterState {
  final String message;

  const RegisterError(this.message);
}
