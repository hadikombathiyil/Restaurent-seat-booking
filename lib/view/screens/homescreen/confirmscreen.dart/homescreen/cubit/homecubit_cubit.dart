import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finalproject/view/screens/loginscreen/cubit/logincubit_cubit.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'homecubit_state.dart';

class HomecubitCubit extends Cubit<HomecubitState> {
  HomecubitCubit(this.context,this.username) : super(HomecubitInitial());
   BuildContext context;
    final String username;

homeCubit()async{
  FirebaseFirestore.instance.collection("home").doc(token).collection("user").add({
    "username":username,
});
}
}

