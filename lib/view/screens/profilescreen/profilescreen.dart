import 'package:finalproject/view/screens/loginscreen/loginscreen.dart';
import 'package:finalproject/view/screens/profilescreen/cubit/profilecubit_cubit.dart';
import 'package:finalproject/viewmodel/color/colors.dart';
import 'package:flutter/material.dart';
import 'package:finalproject/viewmodel/profilecontainer/profilecontainer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:convert';

class Profilescreen extends StatelessWidget {
  const Profilescreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfilecubitCubit()..loadProfile(),
      child: _ProfilescreenContent(),
    );
  }
}

class _ProfilescreenContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: BlocBuilder<ProfilecubitCubit, ProfilecubitState>(
        builder: (context, state) {
          if (state is ProfileLoaded) {
            return Column(
              children: [
                Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: screenSize.height * 0.075),
                    child: InkWell(
                      onTap: () => context.read<ProfilecubitCubit>().pickImage(),
                      child: Container(
                        height: screenSize.width * 0.3,
                        width: screenSize.width * 0.3,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(screenSize.width * 0.15),
                          border: Border.all(
                            width: screenSize.width * 0.01,
                            color: const Color.fromARGB(255, 2, 73, 86),
                          ),
                        ),
                        child: state.profileImage != null
                            ? CircleAvatar(
                                backgroundImage: MemoryImage(base64Decode(state.profileImage!)),
                              )
                            : const CircleAvatar(),
                      ),
                    ),
                  ),
                ),
                Text(
                  state.username,
                  style: TextStyle(
                    color: const Color.fromARGB(255, 2, 73, 86),
                    fontSize: screenSize.width * 0.06,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: screenSize.height * 0.025),
                InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext dialogContext) {
                        String newUsername = state.username;
                        return AlertDialog(
                          title: Column(
                            children: [
                              Icon(Icons.edit,
                                  color: const Color.fromARGB(255, 2, 73, 86),
                                  size: screenSize.width * 0.08),
                              TextFormField(
                                initialValue: state.username,
                                decoration: const InputDecoration(hintText: "Username"),
                                onChanged: (value) {
                                  newUsername = value;
                                },
                              ),
                              SizedBox(height: screenSize.height * 0.0125),
                              ElevatedButton(
                                onPressed: () {
                                  context.read<ProfilecubitCubit>().updateName(newUsername);
                                  Navigator.of(dialogContext).pop();
                                },
                                child: Text("Update Username"),
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
                SizedBox(height: screenSize.height * 0.025),
                Profilecontainer(
                  icon: Icons.privacy_tip,
                  text: "Privacy & Policy",
                ),
                SizedBox(height: screenSize.height * 0.025),
                Profilecontainer(
                  icon: Icons.star,
                  text: "Rate us",
                ),
                SizedBox(height: screenSize.height * 0.025),
                InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          backgroundColor: mainclr,
                          title: const Text(
                            "Logout",
                            style: TextStyle(color: Colors.white),
                          ),
                          content: const Text(
                            "Logout of your account?",
                            style: TextStyle(color: Colors.white),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const Loginscreen())),
                              child: const Text('OK',
                                  style: TextStyle(color: Colors.white)),
                            ),
                            InkWell(
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text("Cancel",
                                    style: TextStyle(color: Colors.white)))
                          ],
                        );
                      },
                    );
                  },
                  child: Container(
                    height: screenSize.height * 0.06,
                    width: screenSize.width * 0.33,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 2, 73, 86),
                      borderRadius:
                          BorderRadius.circular(screenSize.width * 0.06),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Logout",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: screenSize.width * 0.05,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Icon(
                          Icons.logout_rounded,
                          color: Colors.white,
                          size: screenSize.width * 0.05,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}