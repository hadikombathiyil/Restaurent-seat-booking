import 'package:flutter/material.dart';

class Restaurents extends StatelessWidget {
  const Restaurents({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 120,
          width: 400,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: Color.fromARGB(190, 2, 74, 86),
              )),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 120,
                  width: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color.fromARGB(190, 2, 74, 86),
                      image: DecorationImage(
                          image: AssetImage(
                            "assets/download.jpeg",
                          ),
                          fit: BoxFit.fill)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 40),
                child: Text(
                  "Paragon",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Color.fromARGB(190, 2, 74, 86)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 120, top: 60),
                child: Container(
                  height: 40,
                  width: 80,
                  decoration: BoxDecoration(
                      color: Color.fromARGB(190, 2, 74, 86),
                      borderRadius: BorderRadius.circular(20)),
                  child: Center(
                      child: Text(
                    "Book",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                  )),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
