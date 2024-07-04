import 'package:finalproject/sizedbox.dart';

import 'package:finalproject/viewmodel/restuarents/restuarents.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Restuarentscreen extends StatelessWidget {
  const Restuarentscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Restuarents",
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
                  return Restaurents(text: "Book");
                },
                separatorBuilder: (context, index) => 20.hBox,
                itemCount: 7),
          )
        ],
      ),
      // bottomNavigationBar: Bottombar(),
    );
  }
}
