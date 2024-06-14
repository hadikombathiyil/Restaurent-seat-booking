// ignore_for_file: prefer_const_constructors

import 'package:carousel_slider/carousel_slider.dart';
import 'package:finalproject/sizedbox.dart';
import 'package:finalproject/viewmodel/bottombar.dart';
import 'package:finalproject/viewmodel/imageslider/imageslider.dart';
import 'package:finalproject/viewmodel/restuarents/restuarents.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Homescreen extends StatelessWidget {
  Homescreen({super.key});
  List<String> images = [
    "assets/Safe Food.png",
    "assets/download.jpeg",
    "assets/sagar.jpeg",
    "assets/hoy punjab.png"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Bottombar(),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(190, 2, 74, 86),
        title: Text("Hadi",
            style: TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.bold)),
        actions: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: CircleAvatar(),
          )
        ],
      ),
      body: Column(
        children: [
          Text(
            "Top Dealers",
            style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(190, 2, 74, 86)),
          ),
          10.hBox,
          CarouselSlider(
            items: images.map((image) {
              return Imageslider(img: image);
            }).toList(),
            options: CarouselOptions(
              height: 200,
              enlargeCenterPage: true,
              autoPlay: true,
              aspectRatio: 16 / 9,
              autoPlayCurve: Curves.fastOutSlowIn,
              enableInfiniteScroll: true,
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              viewportFraction: 0.8,
            ),
          ),
          15.hBox,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Explore Restuarents",
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(190, 2, 74, 86)),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "See All>",
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(190, 2, 74, 86)),
                ),
              )
            ],
          ),
          Expanded(
            child: ListView.separated(
                itemBuilder: (context, index) {
                  return Restaurents();
                },
                separatorBuilder: (context, index) => 7.hBox,
                itemCount: 6),
          )
        ],
      ),
    );
  }
}
