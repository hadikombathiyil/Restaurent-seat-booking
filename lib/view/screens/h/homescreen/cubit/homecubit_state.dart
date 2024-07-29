part of 'homecubit_cubit.dart';

@immutable
abstract class HomecubitState {}

class HomecubitInitial extends HomecubitState {}

class HomeUserDataLoaded extends HomecubitState {
  final String username;
  final String? profileImage;

  HomeUserDataLoaded({required this.username, this.profileImage});
}