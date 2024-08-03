import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finalproject/view/screens/h/homescreen/cubit/homecubit_cubit.dart';
import 'package:finalproject/view/screens/restuarentscreen/restuarentscreen.dart';
import 'package:finalproject/viewmodel/imageslider/imageslider.dart';
import 'package:finalproject/viewmodel/restuarents/restuarents.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:convert';
import 'package:firebase_storage/firebase_storage.dart';

class Homescreen extends StatelessWidget {
  Homescreen({super.key});

  final List<String> images = [
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

  Future<String> getDownloadURL(String gsUrl) async {
    try {
      if (gsUrl.isEmpty) {
        print("Warning: Empty gsUrl provided");
        return '';
      }
      print("Attempting to get download URL for: $gsUrl");
      final ref = FirebaseStorage.instance.refFromURL(gsUrl);
      final downloadURL = await ref.getDownloadURL();
      print("Successfully retrieved download URL: $downloadURL");
      return downloadURL;
    } catch (e) {
      print("Error getting download URL for $gsUrl: $e");
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final CollectionReference restuarants =
        FirebaseFirestore.instance.collection('restuarants');

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
            body: StreamBuilder<QuerySnapshot>(
              stream: restuarants.snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                return Column(
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
                        separatorBuilder: (context, index) =>
                            SizedBox(height: screenSize.height * 0.01),
                        itemCount: snapshot.data?.docs.length ?? 0,
                        itemBuilder: (context, index) {
                          if (snapshot.hasData &&
                              index < snapshot.data!.docs.length) {
                            final DocumentSnapshot restuarentsnap =
                                snapshot.data!.docs[index];
                            print(restuarentsnap);
                            final String gsUrl = restuarentsnap['image'] ?? '';
                            print("Restaurant $index image gsUrl: $gsUrl");

                            return FutureBuilder<String>(
                              future: getDownloadURL(gsUrl),
                              builder: (context, urlSnapshot) {
                                if (urlSnapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                }
                                if (urlSnapshot.hasError) {
                                  print(
                                      "Error in FutureBuilder for restaurant $index: ${urlSnapshot.error}");
                                  return Text(
                                      "Error loading image for restaurant $index");
                                }
                                final String imageUrl = urlSnapshot.data ?? '';
                                final String restaurantId = restuarentsnap.id;
                                print(
                                    "Restaurant $index final imageUrl: $imageUrl");

                                return Restaurants(
                                  text: "Book",
                                  text2: restuarentsnap['name'] ??
                                      'Unknown Restaurant',
                                  location: restuarentsnap['location'] ??
                                      'Unknown Location',
                                  imageUrl: imageUrl,
                                  restaurantId: restaurantId,
                                );
                              },
                            );
                          } else {
                            print("No data available for index $index");
                            return const SizedBox.shrink();
                          }
                        },
                      ),
                    ),
                  ],
                );
              },
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
