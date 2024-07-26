import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:convert';

part 'profilecubit_state.dart';

class ProfilecubitCubit extends Cubit<ProfilecubitState> {
  ProfilecubitCubit() : super(ProfilecubitInitial());

  Future<void> loadProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final String username = prefs.getString('username') ?? "User";
    final String? profileImage = prefs.getString('profile_image');
    emit(ProfileLoaded(username: username, profileImage: profileImage));
  }

  Future<void> updateName(String username) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', username);
    final currentState = state as ProfileLoaded;
    emit(ProfileLoaded(username: username, profileImage: currentState.profileImage));
  }

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final bytes = await File(pickedFile.path).readAsBytes();
      final base64Image = base64Encode(bytes);
      
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('profile_image', base64Image);

      final currentState = state as ProfileLoaded;
      emit(ProfileLoaded(username: currentState.username, profileImage: base64Image));
    }
  }
}