import 'package:equatable/equatable.dart';

abstract class HistorycubitState extends Equatable {
  const HistorycubitState();

  @override
  List<Object> get props => [];
}

class HistorycubitInitial extends HistorycubitState {}

class BookingsLoading extends HistorycubitState {}

class BookingsLoaded extends HistorycubitState {
  final List<Map<String, dynamic>> bookings;

  const BookingsLoaded(this.bookings);

  @override
  List<Object> get props => [bookings];
}

class BookingHistoryError extends HistorycubitState {
  final String message;

  const BookingHistoryError(this.message);

  @override
  List<Object> get props => [message];
}