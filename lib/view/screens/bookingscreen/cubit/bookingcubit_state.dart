import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class BookingState extends Equatable {
  final DateTime selectedDate;
  final TimeOfDay selectedTime;
  final int selectedTable;
  final List<int> tables;
  final int numberOfSeats;
  final String restaurantId;
  final String restaurantName;
  final String restaurantLocation;
  final String restaurantImageUrl;
  const BookingState(
      {this.restaurantId = '',
      this.restaurantName = '',
      this.restaurantLocation = '',
      this.restaurantImageUrl = '',
      required this.selectedDate,
      required this.selectedTime,
      this.selectedTable = -1,
      required this.tables,
      this.numberOfSeats = 1});

  BookingState copyWith({
    DateTime? selectedDate,
    TimeOfDay? selectedTime,
    int? selectedTable,
    List<int>? tables,
    int? numberOfSeats,
    String? restaurantId,
    String? restaurantName,
    String? restaurantLocation,
    String? restaurantImageUrl,
  }) {
    return BookingState(
      selectedDate: selectedDate ?? this.selectedDate,
      selectedTime: selectedTime ?? this.selectedTime,
      selectedTable: selectedTable ?? this.selectedTable,
      tables: tables ?? this.tables,
      numberOfSeats: numberOfSeats ?? this.numberOfSeats,
      restaurantId: restaurantId ?? this.restaurantId,
      restaurantName: restaurantName ?? this.restaurantName,
      restaurantLocation: restaurantLocation ?? this.restaurantLocation,
      restaurantImageUrl: restaurantImageUrl ?? this.restaurantImageUrl,
    );
  }

  @override
  List<Object?> get props =>
      [selectedDate, selectedTime, selectedTable, tables, numberOfSeats,restaurantId,
        restaurantName,
        restaurantLocation,
        restaurantImageUrl,];
}