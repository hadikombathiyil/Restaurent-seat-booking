import 'package:finalproject/sizedbox.dart';

import 'package:finalproject/viewmodel/restuarents/restuarents.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Historyscreen extends StatelessWidget {
  const Historyscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Booking History",
          style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 2, 73, 86)),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
                itemBuilder: (context, index) {
                  return Restaurents(text: "Check");
                },
                separatorBuilder: (context, index) => 20.hBox,
                itemCount: 1),
          )
        ],
      ),
      // bottomNavigationBar: Bottombar(),
    );
  }
}
