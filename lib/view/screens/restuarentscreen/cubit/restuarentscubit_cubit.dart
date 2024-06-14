import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'restuarentscubit_state.dart';

class RestuarentscubitCubit extends Cubit<RestuarentscubitState> {
  RestuarentscubitCubit() : super(RestuarentscubitInitial());
}
