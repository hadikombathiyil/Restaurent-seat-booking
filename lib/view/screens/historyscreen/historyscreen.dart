import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'cubit/historycubit_cubit.dart';
import 'cubit/historycubit_state.dart';
import 'package:finalproject/viewmodel/color/colors.dart';

class Historyscreen extends StatelessWidget {
  const Historyscreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return BlocProvider(
      create: (context) => HistorycubitCubit()..loadBookings(),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            "Booking History",
            style: TextStyle(
              fontSize: screenSize.width * 0.06,
              fontWeight: FontWeight.bold,
              color: const Color.fromARGB(255, 2, 73, 86),
            ),
          ),
        ),
        body: BlocBuilder<HistorycubitCubit, HistorycubitState>(
          builder: (context, state) {
            if (state is BookingsLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is BookingsLoaded) {
              return state.bookings.isEmpty
                  ? Center(child: Text('No bookings found'))
                  : Padding(
                      padding: EdgeInsets.all(screenSize.width * 0.02),
                      child: ListView.separated(
                        itemCount: state.bookings.length,
                        separatorBuilder: (context, index) => SizedBox(height: 20),
                        itemBuilder: (context, index) {
                          final booking = state.bookings[index];
                          return BookingCard(booking: booking, screenSize: screenSize);
                        },
                      ),
                    );
            } else if (state is BookingHistoryError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Error: ${state.message}'),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () => context.read<HistorycubitCubit>().loadBookings(),
                      child: Text('Retry'),
                    ),
                  ],
                ),
              );
            }
            return const Center(child: Text('Something went wrong'));
          },
        ),
      ),
    );
  }
}

class BookingCard extends StatelessWidget {
  final Map<String, dynamic> booking;
  final Size screenSize;

  const BookingCard({Key? key, required this.booking, required this.screenSize}) : super(key: key);

  Future<String> getDownloadURL(String gsUrl) async {
    try {
      final ref = FirebaseStorage.instance.refFromURL(gsUrl);
      final downloadURL = await ref.getDownloadURL();
      print("Download URL: $downloadURL");
      return downloadURL;
    } catch (e) {
      print("Error getting download URL: $e");
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final dateTime = (booking['date'] as Timestamp).toDate();
    final formattedDate = DateFormat('MMM d, yyyy').format(dateTime);
    final formattedTime = booking['time'] ?? 'N/A';
    
    print("Restaurant Image URL: ${booking['restaurantImageUrl']}");

    return Container(
      height: screenSize.height * 0.2,
      width: screenSize.width * 0.95,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: const Color.fromARGB(255, 2, 73, 86),
        ),
      ),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.all(screenSize.width * 0.02),
            child: Container(
              height: screenSize.height * 0.15,
              width: screenSize.width * 0.25,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color.fromARGB(255, 2, 73, 86),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: booking['restaurantImageUrl'] != null && booking['restaurantImageUrl'].isNotEmpty
                    ? FutureBuilder<String>(
                        future: getDownloadURL(booking['restaurantImageUrl']),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          }
                          if (snapshot.hasError || !snapshot.hasData || snapshot.data!.isEmpty) {
                            return Icon(Icons.restaurant, color: Colors.white, size: screenSize.width * 0.1);
                          }
                          return Image.network(
                            snapshot.data!,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              print("Error loading image: $error");
                              return Icon(Icons.restaurant, color: Colors.white, size: screenSize.width * 0.1);
                            },
                          );
                        },
                      )
                    : Icon(Icons.restaurant, color: Colors.white, size: screenSize.width * 0.1),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: screenSize.height * 0.01),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    booking['restaurantName'] ?? "Unknown",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: screenSize.width * 0.05,
                      color: const Color.fromARGB(255, 2, 73, 86),
                    ),
                  ),
                  Row(
                    children: [
                      Icon(Icons.location_on, color: Colors.red, size: screenSize.width * 0.04),
                      Text(
                        booking['restaurantLocation'] ?? "N/A",
                        style: TextStyle(
                          color: mainclr,
                          fontSize: screenSize.width * 0.035,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "Date: $formattedDate",
                    style: TextStyle(fontSize: screenSize.width * 0.035),
                  ),
                  Text(
                    "Time: $formattedTime",
                    style: TextStyle(fontSize: screenSize.width * 0.035),
                  ),
                  Text(
                    "Table: ${booking['table']} | Seats: ${booking['seats']}",
                    style: TextStyle(fontSize: screenSize.width * 0.035),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              right: screenSize.width * 0.02,
              bottom: screenSize.height * 0.01,
            ),
            child: ElevatedButton(
              onPressed: () {
                context.read<HistorycubitCubit>().cancelBooking(booking['id']);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: mainclr,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text(
                "Cancel",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: screenSize.width * 0.035,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}