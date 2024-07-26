part of 'profilecubit_cubit.dart';

@immutable
abstract class ProfilecubitState {}

class ProfilecubitInitial extends ProfilecubitState {}

class ProfileLoaded extends ProfilecubitState {
  final String username;
  final String? profileImage;

  ProfileLoaded({required this.username, this.profileImage});
}