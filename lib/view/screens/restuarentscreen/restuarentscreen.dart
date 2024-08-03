import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:finalproject/viewmodel/restuarents/restuarents.dart';

class Restuarentscreen extends StatelessWidget {
  const Restuarentscreen({Key? key}) : super(key: key);

  Future<String> getDownloadURL(String? gsUrl) async {
    if (gsUrl == null || gsUrl.isEmpty) {
      print("Error: gsUrl is null or empty");
      return '';
    }
    try {
      final ref = FirebaseStorage.instance.refFromURL(gsUrl);
      final downloadURL = await ref.getDownloadURL();
      return downloadURL;
    } catch (e) {
      print("Error getting download URL: $e");
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final CollectionReference restuarants =
        FirebaseFirestore.instance.collection('restuarants');

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "Restuarents",
          style: TextStyle(
            fontSize: screenSize.width * 0.06,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 2, 73, 86),
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: restuarants.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text("No restaurants found"));
          }

          return Column(
            children: [
              Expanded(
                child: ListView.separated(
                  itemCount: snapshot.data!.docs.length,
                  separatorBuilder: (context, index) =>
                      SizedBox(height: screenSize.height * 0.025),
                  itemBuilder: (context, index) {
                    final DocumentSnapshot restuarentsnap =
                        snapshot.data!.docs[index];
                    final String? gsUrl = restuarentsnap['image'] as String?;
                    final String restaurantId = restuarentsnap.id;

                    if (restaurantId.isEmpty) {
                      print("Warning: Empty restaurant ID for index $index");
                      return SizedBox.shrink(); // Skip this item
                    }

                    return FutureBuilder<String>(
                      future: getDownloadURL(gsUrl),
                      builder: (context, urlSnapshot) {
                        if (urlSnapshot.connectionState == ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        }

                        final String imageUrl = urlSnapshot.data ?? '';
                        print("Restaurant $restaurantId image URL: $imageUrl");

                        return Restaurants(
                          text: "Book",
                          text2: restuarentsnap['name'] as String? ?? 'Unknown Restaurant',
                          location: restuarentsnap['location'] as String? ?? 'Unknown Location',
                          imageUrl: imageUrl,
                          restaurantId: restaurantId,
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}