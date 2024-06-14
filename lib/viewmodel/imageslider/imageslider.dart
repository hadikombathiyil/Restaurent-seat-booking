import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Imageslider extends StatelessWidget {
  Imageslider({super.key, required this.img});
  final String img;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Color.fromARGB(190, 2, 74, 86), width: 4),
          color: Colors.white,
          image: DecorationImage(image: AssetImage(img), fit: BoxFit.fill)),
    );
  }
}
