import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'bottomcubit_state.dart';

class BottomcubitCubit extends Cubit<BottomcubitState> {
  BottomcubitCubit() : super(BottomcubitInitial());
}
