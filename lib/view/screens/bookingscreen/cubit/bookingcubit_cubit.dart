import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'bookingcubit_state.dart';

class BookingcubitCubit extends Cubit<BookingcubitState> {
  BookingcubitCubit() : super(BookingcubitInitial());
}
