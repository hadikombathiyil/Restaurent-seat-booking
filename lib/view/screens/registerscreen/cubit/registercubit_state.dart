import 'package:flutter/foundation.dart';

@immutable
abstract class RegistercubitState {}

class RegistercubitInitial extends RegistercubitState {}

class RegisterSuccess extends RegistercubitState {}

class RegisterFailure extends RegistercubitState {
  final String error;

  RegisterFailure(this.error);
}
