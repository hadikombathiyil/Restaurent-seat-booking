import 'package:finalproject/sizedbox.dart';
import 'package:finalproject/viewmodel/color/colors.dart';
import 'package:flutter/material.dart';

class Historyscreen extends StatelessWidget {
  const Historyscreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      
      appBar: AppBar(
        title: Text(
          "Booking History",
          style: TextStyle(
              fontSize: screenSize.width * 0.06,
              fontWeight: FontWeight.bold,
              color: const Color.fromARGB(255, 2, 73, 86)),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(screenSize.width * 0.02),
        child: Column(
          children: [
            Expanded(
              child: ListView.separated(
                  itemBuilder: (context, index) {
                    return Container(
                      height: screenSize.height * 0.15,
                      width: screenSize.width * 0.95,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            color: const Color.fromARGB(255, 2, 73, 86),
                          )),
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(screenSize.width * 0.02),
                            child: Container(
                              height: screenSize.height * 0.15,
                              width: screenSize.width * 0.25,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: const Color.fromARGB(255, 2, 73, 86),
                                  image: const DecorationImage(
                                      image: AssetImage(
                                        "assets/download.jpeg",
                                      ),
                                      fit: BoxFit.fill)),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: screenSize.height * 0.025),
                            child: Column(
                              children: [
                                Text(
                                  "Paragon",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: screenSize.width * 0.05,
                                      color: const Color.fromARGB(255, 2, 73, 86)),
                                ),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.location_on,
                                      color: Colors.red,
                                    ),
                                    Text(
                                      "Hilite Mall",
                                      style: TextStyle(
                                          color: mainclr,
                                          fontSize: screenSize.width * 0.04,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: screenSize.width * 0.19,
                              top: screenSize.height * 0.075,
                            ),
                            child: Container(
                              height: screenSize.height * 0.05,
                              width: screenSize.width * 0.2,
                              decoration: BoxDecoration(
                                  color: mainclr,
                                  borderRadius: BorderRadius.circular(20)),
                              child: Center(
                                  child: Text(
                                "Cancel",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: screenSize.width * 0.035),
                              )),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => 20.hBox,
                  itemCount: 1),
            )
          ],
        ),
      ),
    );
  }
}