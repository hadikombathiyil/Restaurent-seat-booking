import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:finalproject/view/screens/bookingscreen/cubit/bookingcubit_cubit.dart';
import 'package:finalproject/view/screens/bookingscreen/cubit/bookingcubit_state.dart';
import 'package:finalproject/viewmodel/color/colors.dart';
import 'package:finalproject/viewmodel/profilecontainer/profilecontainer.dart';
import 'package:finalproject/sizedbox.dart';

class Bookingscreen extends StatelessWidget {
  const Bookingscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: BlocProvider(
          create: (context) => BookingCubit(),
          child: BlocBuilder<BookingCubit, BookingState>(
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 300,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                      border: Border.all(
                        width: 2,
                        color: const Color.fromARGB(255, 2, 73, 86),
                      ),
                      image: const DecorationImage(
                        image: AssetImage("assets/download.jpeg"),
                      ),
                    ),
                  ),
                  10.hBox,
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Paragon",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 2, 73, 86),
                      ),
                    ),
                  ),
                  const Row(
                    children: [
                      Icon(
                        Icons.location_pin,
                        color: Colors.red,
                      ),
                      Text(
                        "Vellayil, Kozhikode",
                        style: TextStyle(color: Color.fromARGB(255, 2, 73, 86)),
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Select date",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 2, 73, 86),
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
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Select Slot",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 2, 73, 86),
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
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Select seat",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 2, 73, 86),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 150, // Set an appropriate height for the GridView
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GridView.builder(
                        scrollDirection: Axis.vertical,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          mainAxisSpacing: 5,
                          crossAxisSpacing: 8,
                          childAspectRatio: 2,
                        ),
                        itemCount: state.tables.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              context.read<BookingCubit>().selectTable(index);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: state.selectedTable == index
                                    ? Colors.white
                                    : mainclr,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Center(
                                child: Text(
                                  '${state.tables[index]}',
                                  style: TextStyle(
                                    fontSize: 16,
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
                  20.hBox,
                  Center(
                    child: Container(
                      height: 35,
                      width: 100,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 2, 73, 86),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Center(
                        child: Text(
                          "Book",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                  15.hBox,
                ],
              );
            },
          ),
        ),
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
}
