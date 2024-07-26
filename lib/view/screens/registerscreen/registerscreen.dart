import 'package:finalproject/viewmodel/color/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:finalproject/view/screens/loginscreen/loginscreen.dart';
import 'package:finalproject/view/screens/registerscreen/cubit/registercubit_cubit.dart';
import 'package:finalproject/view/screens/registerscreen/cubit/registercubit_state.dart';

class Registerscreen extends StatelessWidget {
  const Registerscreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: BlocProvider(
        create: (context) => RegistercubitCubit(),
        child: BlocConsumer<RegistercubitCubit, RegistercubitState>(
          listener: (context, state) {
            if (state is RegisterFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.error)),
              );
            }
          },
          builder: (context, state) {
            final cubit = context.read<RegistercubitCubit>();
            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: screenSize.height * 0.12),
                  Center(
                    child: Container(
                      height: screenSize.width * 0.7,
                      width: screenSize.width * 0.7,
                      child: Image.asset(
                        "assets/2008.i511.023_acquaintance_romantic_set_flat-02-removebg.png",
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      width: screenSize.width * 0.8,
                      child: TextFormField(
                        controller: cubit.username,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          labelText: "Username",
                          labelStyle: const TextStyle(color: Colors.white),
                          filled: true,
                          fillColor: mainclr,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(screenSize.width * 0.125),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: screenSize.height * 0.025),
                  Center(
                    child: Container(
                      width: screenSize.width * 0.8,
                      child: TextFormField(
                        controller: cubit.email,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          labelText: "Email",
                          labelStyle: const TextStyle(color: Colors.white),
                          filled: true,
                          fillColor: mainclr,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(screenSize.width * 0.125),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: screenSize.height * 0.025),
                  Center(
                    child: Container(
                      width: screenSize.width * 0.8,
                      child: TextFormField(
                        controller: cubit.password,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          labelText: "Password",
                          labelStyle: const TextStyle(color: Colors.white),
                          filled: true,
                          fillColor:  mainclr,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(screenSize.width * 0.125),
                          ),
                        ),
                        obscureText: true,
                      ),
                    ),
                  ),
                  SizedBox(height: screenSize.height * 0.025),
                  Center(
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(mainclr),
                        padding: MaterialStateProperty.all(EdgeInsets.symmetric(
                          horizontal: screenSize.width * 0.1,
                          vertical: screenSize.height * 0.015,
                        )),
                      ),
                      onPressed: () {
                        cubit.register(context);
                      },
                      child: Text(
                        "Signup",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: screenSize.width * 0.04,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: screenSize.height * 0.015),
                  Center(
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const Loginscreen(),
                        ));
                      },
                      child: Text(
                        "Already have an account?  ",
                        style: TextStyle(
                          color:mainclr,
                          fontWeight: FontWeight.bold,
                          fontSize: screenSize.width * 0.04,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}