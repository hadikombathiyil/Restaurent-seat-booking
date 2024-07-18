import 'package:finalproject/view/screens/bookingscreen/cubit/bookingcubit_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';



class BookingCubit extends Cubit<BookingState> {
  BookingCubit() : super(BookingState(
    selectedDate: DateTime.now(),
    selectedTime: TimeOfDay.now(),
      tables: List.generate(16, (index) => index + 1)
   
  ));

  void selectDate(DateTime date) {
    emit(state.copyWith(selectedDate: date));
  }

  void selectTime(TimeOfDay time) {
    emit(state.copyWith(selectedTime: time));
  }

  void selectTable(int table) {
    emit(state.copyWith(selectedTable:table));
}
}

