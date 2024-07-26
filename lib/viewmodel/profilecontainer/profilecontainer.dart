import 'package:flutter/material.dart';

class Profilecontainer extends StatelessWidget {
  Profilecontainer({super.key, required this.text, required this.icon});

  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    
    return Container(
      height: size.height * 0.075,
      width: size.width * 0.9,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 2, 73, 86),
        borderRadius: BorderRadius.circular(size.width * 0.05),
      ),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(left: size.width * 0.05),
            child: Icon(
              icon,
              color: Colors.white,
              size: size.width * 0.06,
            ),
          ),
          SizedBox(width: size.width * 0.075),
          Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: size.width * 0.055,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          Padding(
            padding: EdgeInsets.all(size.width * 0.02),
            child: Icon(
              Icons.navigate_next,
              color: Colors.white,
              size: size.width * 0.085,
            ),
          )
        ],
      ),
    );
  }
}