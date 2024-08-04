import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'historycubit_state.dart';

class HistorycubitCubit extends Cubit<HistorycubitState> {
  HistorycubitCubit() : super(HistorycubitInitial());
Future<void> loadBookings() async {
  try {
    emit(BookingsLoading());
    
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      emit(BookingHistoryError('User not authenticated'));
      return;
    }

    final bookingsSnapshot = await FirebaseFirestore.instance
        .collection('bookings')
        .where('userId', isEqualTo: user.uid)
        .get();

    final bookings = bookingsSnapshot.docs.map((doc) {
      final data = doc.data();
      data['id'] = doc.id;
      return data;
    }).toList();

    // Debug print
    print("Loaded bookings: $bookings");

    bookings.sort((a, b) {
      final aDate = (a['date'] as Timestamp).toDate();
      final bDate = (b['date'] as Timestamp).toDate();
      return bDate.compareTo(aDate);
    });

    emit(BookingsLoaded(bookings));
  } catch (e) {
    emit(BookingHistoryError(e.toString()));
  }
}

  Future<void> cancelBooking(String bookingId) async {
    try {
      await FirebaseFirestore.instance.collection('bookings').doc(bookingId).delete();
      loadBookings(); // Reload bookings after cancellation
    } catch (e) {
      emit(BookingHistoryError('Failed to cancel booking: $e'));
    }
  }
}