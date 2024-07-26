import 'package:flutter/material.dart';

class Imageslider extends StatelessWidget {
  const Imageslider({super.key, required this.img});
  final String img;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    
    return Container(
      height: size.height * 0.06, // Adjust this factor as needed
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size.width * 0.04),
        border: Border.all(
          color: const Color.fromARGB(255, 2, 73, 86),
          width: size.width * 0.01,
        ),
        color: Colors.white,
        image: DecorationImage(
          image: AssetImage(img),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}