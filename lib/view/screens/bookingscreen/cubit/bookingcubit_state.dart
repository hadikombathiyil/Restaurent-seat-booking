import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class BookingState extends Equatable {
  final DateTime selectedDate;
  final TimeOfDay selectedTime;
  final int selectedTable;
  final List<int> tables;


  const BookingState({
    required this.selectedDate,
    required this.selectedTime,
        this.selectedTable = -1,
    required this.tables,

 
  });

  BookingState copyWith({
    DateTime? selectedDate,
    TimeOfDay? selectedTime,
        int? selectedTable,
    List<int>? tables,


  }) {
    return BookingState(
      selectedDate: selectedDate ?? this.selectedDate,
      selectedTime: selectedTime ?? this.selectedTime,
         selectedTable: selectedTable ?? this.selectedTable,
      tables: tables ?? this.tables,

      
    );
  }

  @override
  List<Object?> get props => [selectedDate, selectedTime,selectedTable,tables];
}