import 'package:finalproject/view/screens/splashscreen/splashscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:finalproject/view/screens/h/homescreen/homescreen.dart';
import 'registercubit_state.dart';

class RegistercubitCubit extends Cubit<RegistercubitState> {
  RegistercubitCubit() : super(RegistercubitInitial());

  final TextEditingController username = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  Future<void> register(BuildContext context) async {
    if (email.text.isNotEmpty &&
        password.text.isNotEmpty &&
        username.text.isNotEmpty) {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: email.text.trim(), password: password.text.trim());

        if (userCredential.user != null) {
          // Store user data in Firestore
          await FirebaseFirestore.instance
              .collection("users")
              .doc(userCredential.user!.uid)
              .set({
            "user_name": username.text,
            "email": email.text,
            "user_id": userCredential.user!.uid,
          });

          // Store username in SharedPreferences
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('username', username.text);

          emit(RegisterSuccess());

          // Navigate to Home screen
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => SplashScreen(),
          ));
        }
      } on FirebaseAuthException catch (e) {
        emit(RegisterFailure(e.message ?? "An error occurred"));
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error: ${e.message}")),
        );
      }
    } else {
      emit(RegisterFailure("Please fill all fields"));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill all fields")),
      );
    }
  }
}
