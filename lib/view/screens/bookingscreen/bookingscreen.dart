import 'package:finalproject/sizedbox.dart';

import 'package:finalproject/viewmodel/profilecontainer/profilecontainer.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

class Bookingscreen extends StatelessWidget {
  const Bookingscreen({super.key});

  Future<TimeOfDay?> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 10, minute: 0),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: Colors.white,
              onPrimary: Color.fromARGB(255, 2, 73, 86),
              surface: Color.fromARGB(255, 2, 73, 86),
              onSurface: Colors.white,
            ),
            buttonTheme: const ButtonThemeData(
              textTheme: ButtonTextTheme.primary,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      if (picked.hour < 10 || picked.hour > 22) {
        // Show an alert if the time is outside the desired range
        await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Invalid Time'),
            content:
                const Text('Please select a time between 10 AM and 10 PM.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('OK'),
              ),
            ],
          ),
        );
        return null;
      }
    }

    return picked;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: SingleChildScrollView(
        child: Column(
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
            const Row(
              children: [
                Padding(
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
              ],
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
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        backgroundColor: Color.fromARGB(255, 2, 73, 86),
                        content: SingleChildScrollView(
                          child: Column(
                            children: [
                              Theme(
                                data: ThemeData.light().copyWith(
                                  colorScheme: const ColorScheme.light(
                                    primary: Color.fromARGB(255, 2, 73, 86),
                                    onPrimary: Colors.white,
                                    onSurface: Color.fromARGB(255, 2, 73, 86),
                                  ),
                                  dialogBackgroundColor: Colors.white,
                                ),
                                child: DatePickerDialog(
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime.now()
                                      .add(const Duration(days: 3)),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
                child: Profilecontainer(
                  text: "Select your date",
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
                onTap: () async {
                  final TimeOfDay? picked = await _selectTime(context);
                  if (picked != null) {
                    // Handle the selected time here
                    print('Selected time: ${picked.format(context)}');
                  }
                },
                child: Profilecontainer(
                  text: "Select your slot",
                  icon: Icons.timer,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Select seat",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 2, 73, 86),
                ),
              ),
            ),
            Center(
              child: InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        backgroundColor: const Color.fromARGB(255, 2, 73, 86),
                        content: SingleChildScrollView(
                          child: Column(
                            children: [
                              NumberPicker(
                                selectedTextStyle: const TextStyle(
                                    color: Colors.red, fontSize: 24),
                                textStyle: const TextStyle(color: Colors.white),
                                axis: Axis.horizontal,
                                minValue: 2,
                                maxValue: 10,
                                value: 4,
                                onChanged: (value) {},
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
                child: Profilecontainer(
                  text: "Select your Seat",
                  icon: Icons.chair_alt,
                ),
              ),
            ),
            20.hBox,
            Center(
              child: Container(
                height: 35,
                width: 100,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 2, 73, 86),
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
          ],
        ),
      ),
    );
  }
}
