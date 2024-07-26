import 'package:finalproject/view/screens/bookingscreen/bookingscreen.dart';
import 'package:finalproject/viewmodel/color/colors.dart';
import 'package:flutter/material.dart';

class Restaurants extends StatelessWidget {
  const Restaurants({super.key, required this.text});
  final String text;
  
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double paddingFactor = size.width * 0.02;
    
    return Column(
      children: [
        Container(
          height: size.height * 0.15,
          width: size.width * 0.95,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(size.width * 0.04),
            border: Border.all(
              color: const Color.fromARGB(255, 2, 73, 86),
            ),
          ),
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.all(paddingFactor),
                child: Container(
                  height: size.height * 0.13,
                  width: size.width * 0.25,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(size.width * 0.025),
                    color: const Color.fromARGB(255, 2, 73, 86),
                    image: const DecorationImage(
                      image: AssetImage("assets/download.jpeg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: paddingFactor),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Paragon",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: size.width * 0.05,
                          color: Color.fromARGB(255, 2, 73, 86),
                        ),
                      ),
                      SizedBox(height: size.height * 0.01),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            color: Colors.red,
                            size: size.width * 0.04,
                          ),
                          SizedBox(width: size.width * 0.01),
                          Text(
                            "Hilite Mall",
                            style: TextStyle(
                              color: mainclr,
                              fontSize: size.width * 0.035,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: paddingFactor),
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const Bookingscreen(),
                    ));
                  },
                  child: Container(
                    height: size.height * 0.05,
                    width: size.width * 0.2,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 2, 73, 86),
                      borderRadius: BorderRadius.circular(size.width * 0.05),
                    ),
                    child: Center(
                      child: Text(
                        text,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: size.width * 0.035,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}