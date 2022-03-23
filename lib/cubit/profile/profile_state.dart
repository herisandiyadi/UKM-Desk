part of 'profile_cubit.dart';

@immutable
abstract class ProfileState {
  const ProfileState();
}

class ProfileInitial extends ProfileState {
  const ProfileInitial();
}

class UpdateLoading extends ProfileState {
  const UpdateLoading();
}

class UpdateLoaded extends ProfileState {
  final bool isSuccess;

  const UpdateLoaded(this.isSuccess);
}

class ProfileLoading extends ProfileState {
  const ProfileLoading();
}

class ProfileLoaded extends ProfileState {
  final String profileData;

  const ProfileLoaded(this.profileData);
}

class ProfileError extends ProfileState {
  final String message;

  const ProfileError(this.message);
}
