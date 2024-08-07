import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finalproject/view/screens/historyscreen/historyscreen.dart';
import 'package:finalproject/viewmodel/bottombar/bottombar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:finalproject/view/screens/bookingscreen/cubit/bookingcubit_cubit.dart';
import 'package:finalproject/view/screens/bookingscreen/cubit/bookingcubit_state.dart';
import 'package:finalproject/viewmodel/color/colors.dart';
import 'package:finalproject/viewmodel/profilecontainer/profilecontainer.dart';

class Bookingscreen extends StatelessWidget {
   final String restaurantId;

  const Bookingscreen({Key? key, required this.restaurantId}) : super(key: key);

  Future<String> getDownloadURL(String gsUrl) async {
    try {
      if (gsUrl.isEmpty) {
        print("Warning: Empty gsUrl provided");
        return '';
      }
      print("Attempting to get download URL for: $gsUrl");
      final ref = FirebaseStorage.instance.refFromURL(gsUrl);
      final downloadURL = await ref.getDownloadURL();
      print("Successfully retrieved download URL: $downloadURL");
      return downloadURL;
    } catch (e) {
      print("Error getting download URL for $gsUrl: $e");
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
  final restaurantRef = FirebaseFirestore.instance.collection('restuarants').doc(restaurantId);


    return Scaffold(
      body: StreamBuilder<DocumentSnapshot>(
        stream: restaurantRef.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } if (!snapshot.hasData || !snapshot.data!.exists) {
            return Center(child: Text('Restaurant not found'));
          }


            final restaurantData = snapshot.data!.data() as Map<String, dynamic>;
          final String name = restaurantData['name'] ?? 'Unknown Restaurant';
          final String location = restaurantData['location'] ?? 'Unknown Location';
          final String gsUrl = restaurantData['image'] ?? '';


          return SingleChildScrollView(
            child: BlocProvider(
             create: (context) => BookingCubit()..setRestaurantDetails(restaurantId, name, location, gsUrl),
              child: BlocBuilder<BookingCubit, BookingState>(
                builder: (context, state) { context.read<BookingCubit>().setRestaurantDetails(restaurantId, name, location, gsUrl);

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FutureBuilder<String>(
                        future: getDownloadURL(gsUrl),
                        builder: (context, urlSnapshot) {
                          if (urlSnapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Container(
                              height: screenSize.height * 0.3,
                              width: double.infinity,
                              child: Center(child: CircularProgressIndicator()),
                            );
                          }
                          if (urlSnapshot.hasError) {
                            return Container(
                              height: screenSize.height * 0.3,
                              width: double.infinity,
                              child: Center(child: Text("Error loading image")),
                            );
                          }
                          final String imageUrl = urlSnapshot.data ?? '';
                          return Container(
                            height: screenSize.height * 0.3,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                bottomLeft:
                                    Radius.circular(screenSize.width * 0.08),
                                bottomRight:
                                    Radius.circular(screenSize.width * 0.08),
                              ),
                              border: Border.all(
                                width: 2,
                                color: const Color.fromARGB(255, 2, 73, 86),
                              ),
                              image: DecorationImage(
                                image: NetworkImage(imageUrl),
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        },
                      ),
                      SizedBox(height: screenSize.height * 0.02),
                      Padding(
                        padding: EdgeInsets.all(screenSize.width * 0.02),
                        child: Text(
                         name,
                          style: TextStyle(
                            fontSize: screenSize.width * 0.06,
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 2, 73, 86),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.location_pin,
                            color: Colors.red,
                            size: screenSize.width * 0.05,
                          ),
                          Text(
                            location,
                            style: TextStyle(
                              color: const Color.fromARGB(255, 2, 73, 86),
                              fontSize: screenSize.width * 0.04,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.all(screenSize.width * 0.02),
                        child: Text(
                          "Select date",
                          style: TextStyle(
                            fontSize: screenSize.width * 0.05,
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 2, 73, 86),
                          ),
                        ),
                      ),
                      Center(
                        child: InkWell(
                          onTap: () => _selectDate(context),
                          child: Profilecontainer(
                            text: DateFormat.yMMMd().format(state.selectedDate),
                            icon: Icons.calendar_month_outlined,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(screenSize.width * 0.02),
                        child: Text(
                          "Select slot",
                          style: TextStyle(
                            fontSize: screenSize.width * 0.05,
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 2, 73, 86),
                          ),
                        ),
                      ),
                      Center(
                        child: InkWell(
                          onTap: () => _selectTime(context),
                          child: Profilecontainer(
                            text: state.selectedTime.format(context),
                            icon: Icons.av_timer_sharp,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(screenSize.width * 0.02),
                        child: Text(
                          "Select seat",
                          style: TextStyle(
                            fontSize: screenSize.width * 0.05,
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 2, 73, 86),
                          ),
                        ),
                      ),
                      Center(
                        child: SizedBox(
                          height: screenSize.height * 0.15,
                          width: screenSize.width * 0.9,
                          child: CupertinoPicker(
                            magnification: 1.2,
                            selectionOverlay:
                                const CupertinoPickerDefaultSelectionOverlay(),
                            itemExtent: 32,
                            onSelectedItemChanged: (int index) {
                              context
                                  .read<BookingCubit>()
                                  .selectNumberOfSeats(index + 1);
                            },
                            children: List<Widget>.generate(10, (index) {
                              return Center(
                                child: Text(
                                  '${index + 1}',
                                  style: TextStyle(
                                      fontSize: screenSize.width * 0.05,
                                      fontWeight: FontWeight.bold,
                                      color: context
                                                  .read<BookingCubit>()
                                                  .state
                                                  .numberOfSeats ==
                                              index + 1
                                          ? mainclr
                                          : mainclr),
                                ),
                              );
                            }),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(screenSize.width * 0.02),
                        child: Text(
                          "Select table",
                          style: TextStyle(
                            fontSize: screenSize.width * 0.05,
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 2, 73, 86),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: screenSize.height * 0.2,
                        child: Padding(
                          padding: EdgeInsets.all(screenSize.width * 0.02),
                          child: GridView.builder(
                            scrollDirection: Axis.vertical,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: screenSize.height * 0.01,
                              crossAxisSpacing: screenSize.width * 0.02,
                              childAspectRatio: 2,
                            ),
                            itemCount: state.tables.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  context
                                      .read<BookingCubit>()
                                      .selectTable(index);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: state.selectedTable == index
                                        ? Colors.white
                                        : mainclr,
                                    borderRadius: BorderRadius.circular(
                                        screenSize.width * 0.02),
                                  ),
                                  child: Center(
                                    child: Text(
                                      '${state.tables[index]}',
                                      style: TextStyle(
                                        fontSize: screenSize.width * 0.05,
                                        color: state.selectedTable == index
                                            ? mainclr
                                            : Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: screenSize.height * 0.04),
                      Center(
                        child: InkWell(
                          onTap: () => _bookcnfrm(context, ),
                          child: Container(
                            height: screenSize.height * 0.05,
                            width: screenSize.width * 0.25,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 2, 73, 86),
                              borderRadius: BorderRadius.circular(
                                  screenSize.width * 0.08),
                            ),
                            child: Center(
                              child: Text(
                                "Book",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: screenSize.width * 0.05,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: screenSize.height * 0.02),
                    ],
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: context.read<BookingCubit>().state.selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: Colors.white,
              onPrimary: Color.fromARGB(255, 2, 73, 86),
              surface: Color.fromARGB(255, 2, 73, 86),
              onSurface: Colors.white,
            ),
            dialogBackgroundColor: Colors.white,
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      context.read<BookingCubit>().selectDate(picked);
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: context.read<BookingCubit>().state.selectedTime,
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: Colors.white,
              onPrimary: Color.fromARGB(255, 2, 73, 86),
              surface: Color.fromARGB(255, 2, 73, 86),
              onSurface: Colors.white,
            ),
            dialogBackgroundColor: Colors.white,
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      context.read<BookingCubit>().selectTime(picked);
    }
  }

 
  void _bookcnfrm(BuildContext context) {
    final state = context.read<BookingCubit>().state;
    if (state.selectedTable != -1) {
      showDialog(
        context: context,
        builder: (dialogContext) => AlertDialog(
          backgroundColor: mainclr,
          title: const Text('Booking Confirmed', style: TextStyle(color: Colors.white)),
          content: Text(
            'Table ${state.selectedTable + 1} booked at ${state.restaurantName} for ${DateFormat.yMd().format(state.selectedDate)} at ${state.selectedTime.format(context)} with ${state.numberOfSeats} seats',
            style: const TextStyle(color: Colors.white),
          ),
          actions: [
            TextButton(
              onPressed: () async {
                final user = FirebaseAuth.instance.currentUser;
                if (user != null) {
                  await context.read<BookingCubit>().bookRestaurant(user.uid);
                }
                Navigator.of(dialogContext).pop(); // Close the dialog
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => const Bottombar(initialindex: 2),
                ));
              },
              child: const Text('OK', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      );
    }
  }
}

