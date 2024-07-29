import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'historycubit_state.dart';

class HistorycubitCubit extends Cubit<HistorycubitState> {
  HistorycubitCubit() : super(HistorycubitInitial());
}
