import 'package:bloc/bloc.dart';
import 'package:finalproject/view/screens/homescreen/homescreen/homescreen.dart';
import 'package:finalproject/view/screens/localstorege/localstorage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'logincubit_state.dart';

String? token;

class LogincubitCubit extends Cubit<LogincubitState> {
  LogincubitCubit(this.context) : super(LogincubitInitial());
  BuildContext context;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  login() async {
    if (email.text.isNotEmpty && password.text.isNotEmpty) {
      try {
        UserCredential? User = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: email.text.trim(), password: password.text.trim());
        if (User.user != null) {
          LocalStorage data = LocalStorage();
          LocalStorage.setPostData(User.user!.uid.toString());
          token = User.user!.uid;
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => Homescreen(),
          ));
        }
      } on FirebaseException catch (e) {
        print(e.code);
      }
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Somthing error")));
    }
  }
}
