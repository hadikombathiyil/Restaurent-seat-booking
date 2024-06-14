import 'package:finalproject/sizedbox.dart';
import 'package:finalproject/viewmodel/bottombar.dart';
import 'package:finalproject/viewmodel/profilecontainer/profilecontainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Bookingscreen extends StatelessWidget {
  const Bookingscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const Bottombar(),
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
                    width: 2, color: const Color.fromARGB(190, 2, 74, 86)),
                image: const DecorationImage(
                  image: AssetImage(
                    "assets/download.jpeg",
                  ),
                )),
          ),
          10.hBox,
          const Row(
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Paragon ",
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(190, 2, 74, 86)),
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
                "Vellayil,Kozhikode",
                style: TextStyle(color: Color.fromARGB(190, 2, 74, 86)),
              )
            ],
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Select date ",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(190, 2, 74, 86)),
            ),
          ),
          Center(
            child: InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return const AlertDialog(
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [],
                      ),
                    );
                  },
                );
              },
              child: InkWell(onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return const AlertDialog(
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [],
                      ),
                    );
                  },
                );
              },
                child: Profilecontainer(
                    text: "Select your date",
                    icon: Icons.calendar_month_outlined),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Select Slot ",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(190, 2, 74, 86)),
            ),
          ),
          Center(
            child:
                Profilecontainer(text: "Select your slot", icon: Icons.timer),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Select seat ",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(190, 2, 74, 86)),
            ),
          ),
          Center(
            child: Profilecontainer(
                text: "Select your Seat", icon: Icons.chair_alt),
          ),
          20.hBox,
          Center(
            child: Container(
              height: 35,
              width: 100,
              decoration: BoxDecoration(
                color: const Color.fromARGB(190, 2, 74, 86),
                borderRadius: BorderRadius.circular(30),
              ),
              child: const Center(
                  child: Text(
                "Book",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              )),
            ),
          )
        ],
      )),
    );
  }
}
