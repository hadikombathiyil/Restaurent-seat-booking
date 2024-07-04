import 'package:finalproject/sizedbox.dart';

import 'package:finalproject/viewmodel/profilecontainer/profilecontainer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Profilescreen extends StatelessWidget {
  const Profilescreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 60),
              child: Container(
                height: 120,
                width: 120,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(80),
                    border: Border.all(
                        width: 4, color: const Color.fromARGB(255, 2, 73, 86))),
              ),
            ),
          ),
          const Text(
            "Hadi",
            style: TextStyle(
                color: Color.fromARGB(255, 2, 73, 86),
                fontSize: 25,
                fontWeight: FontWeight.bold),
          ),
          20.hBox,
          InkWell(
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Column(
                      children: [
                        Icon(Icons.camera_alt_rounded,
                            color: Color.fromARGB(255, 2, 73, 86)),
                        TextFormField(
                          decoration: InputDecoration(hintText: "Username"),
                        ),
                        10.hBox,
                        Container(
                          height: 50,
                          width: 130,
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 2, 73, 86),
                              borderRadius: BorderRadius.circular(25)),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Submit",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
            child: Profilecontainer(
              icon: Icons.edit,
              text: "Account Settings",
            ),
          ),
          20.hBox,
          Profilecontainer(
            icon: Icons.privacy_tip,
            text: "Privacy and Policy",
          ),
          20.hBox,
          Profilecontainer(
            icon: Icons.star,
            text: "Rate us",
          ),
          20.hBox,
          Container(
            height: 50,
            width: 130,
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 2, 73, 86),
                borderRadius: BorderRadius.circular(25)),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Logout",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                Icon(
                  Icons.logout_rounded,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ],
      ),
      // bottomNavigationBar: Bottombar()
    );
  }
}
