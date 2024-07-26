import 'package:flutter/material.dart';
import 'package:finalproject/viewmodel/restuarents/restuarents.dart';

class Restuarentscreen extends StatelessWidget {
  const Restuarentscreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Restuarents",
          style: TextStyle(
            fontSize: screenSize.width * 0.06,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 2, 73, 86),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              itemBuilder: (context, index) {
                return Restaurants(text: "Book");
              },
              separatorBuilder: (context, index) => SizedBox(height: screenSize.height * 0.025),
              itemCount: 7,
            ),
          )
        ],
      ),
    );
  }
}