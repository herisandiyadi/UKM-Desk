import 'package:bloc/bloc.dart';
import 'package:enforcea/repository/network_exception.dart';
import 'package:enforcea/repository/profile_repository.dart';
import 'package:meta/meta.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepository _profileRepository;

  ProfileCubit(this._profileRepository) : super(ProfileInitial());

  Future<void> profile() async {
    try {
      emit(new ProfileLoading());
      final profileData = await _profileRepository.profile();
      emit(new ProfileLoaded(profileData));
    } on NetworkException catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  Future<void> updatePassword(String email) async{
    try{
      emit(new UpdateLoading());
      final isSuccess = await _profileRepository.updatePassword(email);
      emit(new UpdateLoaded(isSuccess));
    } on NetworkException catch (e) {
      emit(ProfileError(e.toString()));
    }
  }
}
