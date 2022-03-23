import 'package:bloc/bloc.dart';
import 'package:enforcea/model/request/register_request.dart';
import 'package:enforcea/repository/network_exception.dart';
import 'package:enforcea/repository/register_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final RegisterRepository _registerRepository;

  RegisterCubit(this._registerRepository) : super(RegisterInitial());

  Future<void> register(RegisterRequest request) async{
    try{
      emit(new RegisterLoading());
      final isSuccess = await _registerRepository.register(request);
        emit(new RegisterLoaded(isSuccess));
    } on NetworkException catch (e){
      emit(RegisterError(e.toString()));
    }
  }
}
