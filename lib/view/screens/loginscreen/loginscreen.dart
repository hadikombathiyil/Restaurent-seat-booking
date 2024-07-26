import 'package:finalproject/view/screens/loginscreen/cubit/logincubit_cubit.dart';
import 'package:finalproject/view/screens/registerscreen/registerscreen.dart';
import 'package:finalproject/viewmodel/color/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Loginscreen extends StatelessWidget {
  const Loginscreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: BlocProvider(
        create: (context) => LogincubitCubit(context),
        child: BlocBuilder<LogincubitCubit, LogincubitState>(
          builder: (context, state) {
            final cubit = context.read<LogincubitCubit>();
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: size.height * 0.15),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          height: size.height * 0.3,
                          width: size.width * 0.7,
                          child: Image.asset(
                            "assets/2008.i511.023_acquaintance_romantic_set_flat-02-removebg.png",
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      SizedBox(height: size.height * 0.03),
                      Center(
                        child: Container(
                          width: size.width * 0.8,
                          child: TextFormField(
                            controller: cubit.email,
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              labelText: "Email",
                              labelStyle: const TextStyle(color: Colors.white),
                              filled: true,
                              fillColor: mainclr,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: size.height * 0.025),
                      Center(
                        child: Container(
                          width: size.width * 0.8,
                          child: TextFormField(
                            controller: cubit.password,
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              labelText: "Password",
                              labelStyle: TextStyle(color: Colors.white),
                              filled: true,
                              fillColor: mainclr,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: size.height * 0.025),
                      Center(
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(
                              mainclr,
                            ),
                          ),
                          onPressed: () {
                            cubit.login();
                          },
                          child: const Text(
                            "Login",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(height: size.height * 0.015),
                      Center(
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => Registerscreen(),
                            ));
                          },
                          child: Text(
                            "Create an account  ",
                            style: TextStyle(
                              color: mainclr,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
