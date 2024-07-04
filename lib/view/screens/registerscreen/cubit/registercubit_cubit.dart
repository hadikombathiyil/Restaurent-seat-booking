import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finalproject/view/screens/homescreen/confirmscreen.dart/homescreen/cubit/homecubit_cubit.dart';
import 'package:finalproject/view/screens/homescreen/confirmscreen.dart/homescreen/homescreen.dart';
import 'package:finalproject/view/screens/localstorege/localstorage.dart';
import 'package:finalproject/view/screens/loginscreen/cubit/logincubit_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'registercubit_state.dart';

class RegistercubitCubit extends Cubit<RegistercubitState> {
  RegistercubitCubit(this.context) : super(RegistercubitInitial());
  BuildContext context;
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  register() async {
    if (email.text.isNotEmpty && password.text.isNotEmpty) {
      try {
        UserCredential? user = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: email.text.trim(), password: password.text.trim());
        if (user.user != null) {
          LocalStorage data = LocalStorage();
          LocalStorage.setPostData(user.user!.uid);
          token = user!.user!.uid;
          await FirebaseFirestore.instance.collection("user").add({
            "user_name": username.text,
            "email": email.text,
            "user_id": user.user!.uid,
          });
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => Homescreen(),
          ));
        }
      } on FirebaseException catch (e) {
        print(e.code);
      }
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("something went wrong")));
}
}

}
