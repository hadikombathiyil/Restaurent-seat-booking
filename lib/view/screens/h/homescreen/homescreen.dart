import 'package:carousel_slider/carousel_slider.dart';
import 'package:finalproject/view/screens/h/homescreen/cubit/homecubit_cubit.dart';
import 'package:finalproject/view/screens/restuarentscreen/restuarentscreen.dart';
import 'package:finalproject/viewmodel/imageslider/imageslider.dart';
import 'package:finalproject/viewmodel/restuarents/restuarents.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:convert';

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
    return BlocProvider(
      create: (context) => HomecubitCubit()..loadUserData(),
      child: _HomescreenContent(images: images),
    );
  }
}

class _HomescreenContent extends StatelessWidget {
  const _HomescreenContent({
    required this.images,
  });

  final List<String> images;

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return BlocBuilder<HomecubitCubit, HomecubitState>(
      builder: (context, state) {
        if (state is HomeUserDataLoaded) {
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: const Color.fromARGB(255, 2, 73, 86),
              title: Text(
                state.username,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: screenSize.width * 0.06,
                  fontWeight: FontWeight.bold,
                ),
              ),
              actions: [
                Padding(
                  padding: EdgeInsets.all(screenSize.width * 0.02),
                  child: CircleAvatar(
                    radius: screenSize.width * 0.04,
                    backgroundImage: state.profileImage != null
                        ? MemoryImage(base64Decode(state.profileImage!))
                        : null,
                    child: state.profileImage == null
                        ? Icon(Icons.person, size: screenSize.width * 0.06)
                        : null,
                  ),
                )
              ],
            ),
            body: Column(
              children: [
                Text(
                  "Top Dealers",
                  style: TextStyle(
                    fontSize: screenSize.width * 0.06,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 2, 73, 86),
                  ),
                ),
                SizedBox(height: screenSize.height * 0.015),
                CarouselSlider(
                  items: images.map((image) {
                    return Imageslider(img: image);
                  }).toList(),
                  options: CarouselOptions(
                    height: screenSize.height * 0.25,
                    enlargeCenterPage: true,
                    autoPlay: true,
                    aspectRatio: 16 / 9,
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enableInfiniteScroll: true,
                    autoPlayAnimationDuration:
                        const Duration(milliseconds: 800),
                    viewportFraction: 0.8,
                  ),
                ),
                SizedBox(height: screenSize.height * 0.02),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(screenSize.width * 0.02),
                      child: Text(
                        "Explore Restuarents",
                        style: TextStyle(
                          fontSize: screenSize.width * 0.06,
                          fontWeight: FontWeight.bold,
                          color: const Color.fromARGB(255, 2, 73, 86),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(screenSize.width * 0.02),
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const Restuarentscreen(),
                          ));
                        },
                        child: Text(
                          "See All>",
                          style: TextStyle(
                            fontSize: screenSize.width * 0.03,
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 2, 73, 86),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                Expanded(
                  child: ListView.separated(
                    itemBuilder: (context, index) {
                      return const Restaurants(
                        text: "Book",
                      );
                    },
                    separatorBuilder: (context, index) =>
                        SizedBox(height: screenSize.height * 0.01),
                    itemCount: 6,
                  ),
                )
              ],
            ),
          );
        }
        return const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
