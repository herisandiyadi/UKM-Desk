
import 'package:bloc/bloc.dart';
import 'package:enforcea/model/request/login_request.dart';
import 'package:enforcea/model/response/login_response.dart';
import 'package:enforcea/repository/login_repository.dart';
import 'package:enforcea/repository/network_exception.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginRepository _loginRepository;

  LoginCubit(this._loginRepository) : super(LoginInitial());

  Future<void> login(String username, String password) async {
    try {
      emit(new LoginLoading());
      final request = LoginRequest(email: username, password: password);
      final loginResponse = await _loginRepository
          .login(request);
      emit(new LoginLoaded(loginResponse));
    } on NetworkException catch(e) {
      emit(LoginError(e.message));
    }
  }
}
