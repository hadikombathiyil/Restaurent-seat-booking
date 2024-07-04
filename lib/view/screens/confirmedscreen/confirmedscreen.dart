import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Confirmedscreen extends StatelessWidget {
  const Confirmedscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: Icon(
            Icons.done,
            size: 100,
            color: Color.fromARGB(255, 2, 73, 86),
          )),
          Text(
            "Your booking has been confirmed",
            style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 2, 73, 86)),
          )
        ],
      ),
    );
  }
}
