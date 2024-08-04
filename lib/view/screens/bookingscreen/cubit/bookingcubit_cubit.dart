import 'package:finalproject/view/screens/bookingscreen/cubit/bookingcubit_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BookingCubit extends Cubit<BookingState> {
  BookingCubit()
      : super(BookingState(
          selectedDate: DateTime.now(),
          selectedTime: TimeOfDay.now(),
          tables: List.generate(10, (index) => index + 1),
          numberOfSeats: 1,
        ));

  void selectDate(DateTime date) {
    emit(state.copyWith(selectedDate: date));
  }

  void selectTime(TimeOfDay time) {
    emit(state.copyWith(selectedTime: time));
  }

  void selectTable(int table) {
    emit(state.copyWith(selectedTable: table));
  }

  void selectNumberOfSeats(int seats) {
    emit(state.copyWith(numberOfSeats: seats));
  }
Future<void> bookRestaurant(String userId) async {
  final bookingData = {
    'userId': userId,
    'restaurantId': state.restaurantId,
    'restaurantName': state.restaurantName,
    'restaurantLocation': state.restaurantLocation,
    'restaurantImageUrl': state.restaurantImageUrl,
    'date': state.selectedDate,
    'time': '${state.selectedTime.hour}:${state.selectedTime.minute}',
    'table': state.selectedTable + 1,
    'seats': state.numberOfSeats,
  };

  print("Booking data being saved: $bookingData"); // Debug print

  try {
    await FirebaseFirestore.instance.collection('bookings').add(bookingData);
    print("Booking saved successfully");
  } catch (e) {
    print('Error booking restaurant: $e');
    // Handle the error appropriately
  }
}
  void setRestaurantDetails(
      String id, String name, String location, String imageUrl) {
    emit(state.copyWith(
      restaurantId: id,
      restaurantName: name,
      restaurantLocation: location,
      restaurantImageUrl: imageUrl,
    ));
  }
}