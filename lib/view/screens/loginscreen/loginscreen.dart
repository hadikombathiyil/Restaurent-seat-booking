import 'package:finalproject/sizedbox.dart';
import 'package:finalproject/view/screens/homescreen/homescreen.dart';
import 'package:finalproject/view/screens/loginscreen/cubit/logincubit_cubit.dart';
import 'package:finalproject/view/screens/registerscreen/registerscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Loginscreen extends StatelessWidget {
  const Loginscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   toolbarHeight: 70,
        //   title: const Padding(
        //     padding: EdgeInsets.only(top: 12),
        //     child: Column(
        //       mainAxisAlignment: MainAxisAlignment.start,
        //       crossAxisAlignment: CrossAxisAlignment.start,
        //       children: [],
        //     ),
        //   ),
        // ),
        body: BlocProvider(
      create: (context) => LogincubitCubit(context),
      child: BlocBuilder<LogincubitCubit, LogincubitState>(
        builder: (context, state) {
          final cubit = context.read<LogincubitCubit>();
          return SingleChildScrollView(
              child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 120),
            child: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // const Padding(
                    //   padding: EdgeInsets.only(left: 10),
                    //   child: Text("Hello",
                    //       style: TextStyle(
                    //           fontSize: 30,
                    //           color: Color.fromARGB(190, 2, 74, 86))),
                    // ),
                    // const Padding(
                    //   padding: EdgeInsets.only(left: 10),
                    //   child: Text("Welcome",
                    //       style: TextStyle(
                    //           fontWeight: FontWeight.bold,
                    //           fontSize: 50,
                    //           color: Color.fromARGB(190, 2, 74, 86))),
                    // ),
                    Center(
                      child: Container(
                          height: 280,
                          width: 280,
                          child: Image.asset(
                              "assets/2008.i511.023_acquaintance_romantic_set_flat-02-removebg.png")),
                    ),
                    Center(
                      child: Container(
                        width: 320,
                        child: TextFormField(
                          controller: cubit.email,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                              labelText: "Email",
                              labelStyle: const TextStyle(color: Colors.white),
                              filled: true,
                              fillColor: const Color.fromARGB(190, 2, 74, 86),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50))),
                        ),
                      ),
                    ),
                    20.hBox,
                    Center(
                      child: Container(
                        width: 320,
                        child: TextFormField(
                          controller: cubit.password,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                              labelText: "Password",
                              labelStyle: const TextStyle(color: Colors.white),
                              filled: true,
                              fillColor: const Color.fromARGB(190, 2, 74, 86),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50))),
                        ),
                      ),
                    ),
                    20.hBox,
                    Center(
                      child: ElevatedButton(
                          style: const ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll(
                                  Color.fromARGB(189, 2, 74, 86))),
                          onPressed: () {
                            cubit.login();
                          },
                          child: const Text(
                            "Login",
                            style: TextStyle(color: Colors.white),
                          )),
                    ),
                    10.hBox,
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
                                  color: Color.fromARGB(190, 2, 74, 86),
                                  fontWeight: FontWeight.bold),
                            )))
                  ]),
            ),
          ));
        },
      ),
    ));
  }
}
