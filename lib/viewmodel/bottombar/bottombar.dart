import 'package:finalproject/view/screens/historyscreen/historyscreen.dart';
import 'package:finalproject/view/screens/homescreen/confirmscreen.dart/homescreen/homescreen.dart';
import 'package:finalproject/view/screens/profilescreen/profilescreen.dart';
import 'package:finalproject/view/screens/restuarentscreen/restuarentscreen.dart';
import 'package:finalproject/viewmodel/bottombar/cubit/bottomcubit_cubit.dart';
import 'package:finalproject/viewmodel/bottombar/cubit/bottomcubit_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BottomcubitCubit(),
      child: BlocBuilder<BottomcubitCubit, BottomcubitState>(
        builder: (context, state) {
          final cubit = context.read<BottomcubitCubit>();
          return Scaffold(
            backgroundColor: const Color.fromARGB(190, 2, 74, 86),
            body: _getScreen(state.currentIndex),
            bottomNavigationBar: Theme(
              data: Theme.of(context).copyWith(
                canvasColor: const Color.fromARGB(190, 2, 74, 86),
              ),
              child: BottomNavigationBar(
                items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.restaurant),
                    label: 'Restaurants',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.summarize),
                    label: 'Bookings',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.person),
                    label: 'Profile',
                  ),
                ],
                currentIndex: state.currentIndex,
                selectedItemColor: Colors.white,
                unselectedItemColor: Colors.white,
                onTap: (index) {
                  cubit.changeIndex(index);
                },
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _getScreen(int index) {
    switch (index) {
      case 0:
        return Homescreen();
      case 1:
        return const Restuarentscreen();
      case 2:
        return const Historyscreen();
      case 3:
        return const Profilescreen();
      default:
        return const SizedBox.shrink();
    }
  }
}