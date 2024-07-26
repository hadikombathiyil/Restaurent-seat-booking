import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'homecubit_state.dart';

class HomecubitCubit extends Cubit<HomecubitState> {
  HomecubitCubit() : super(HomecubitInitial());

  Future<void> loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final String username = prefs.getString('username') ?? "User";
    final String? profileImage = prefs.getString('profile_image');
    emit(HomeUserDataLoaded(username: username, profileImage: profileImage));
  }
}