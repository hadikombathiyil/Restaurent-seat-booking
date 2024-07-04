import 'package:finalproject/sizedbox.dart';
import 'package:flutter/material.dart';

class Profilecontainer extends StatelessWidget {
  Profilecontainer({super.key, required this.text, required this.icon});

  final String text;
  IconData? icon;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 350,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 2, 73, 86),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 20),
            child: Icon(
              icon,
              color: Colors.white,
            ),
          ),
          30.wBox,
          Text(
            text,
            style: TextStyle(
                color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
          ),
          const Spacer(),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(
              Icons.navigate_next,
              color: Colors.white,
              size: 35,
            ),
          )
        ],
      ),
    );
  }
}
