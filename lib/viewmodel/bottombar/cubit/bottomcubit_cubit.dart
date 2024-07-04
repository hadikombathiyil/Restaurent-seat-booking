import 'package:finalproject/viewmodel/bottombar/cubit/bottomcubit_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomcubitCubit extends Cubit<BottomcubitState> {
  BottomcubitCubit() : super(BottomcubitInitial(0));

  void changeIndex(int index) {
    emit(BottomcubitInitial(index));
  }
}