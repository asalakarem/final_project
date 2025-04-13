import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/layout/cubit/cubit.dart';
import 'package:untitled1/layout/cubit/states.dart';

class UserActivity extends StatelessWidget {
  const UserActivity({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, MainStates>(
      listener: (BuildContext context, MainStates state) {},
      builder: (BuildContext context, MainStates state) {
        final cubit = MainCubit.get(context);
        return Scaffold(
          appBar: AppBar(toolbarHeight: 0.0,),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: CurvedNavigationBar(
            color: const Color(0xffAF6B58),
            buttonBackgroundColor: const Color(0xffDED5C4),
            backgroundColor: Colors.transparent,
            index: cubit.currentIndex,
            onTap: (index) => cubit.changeIndex(index),
            items: [
              CurvedNavigationBarItem(child: Image.asset('assets/images/home.png', height: 24.0, width: 24.0,)),
              CurvedNavigationBarItem(child: Image.asset('assets/images/involved.png', height: 24.0, width: 24.0,)),
              CurvedNavigationBarItem(child: Image.asset('assets/images/inquiry.png', height: 24.0, width: 24.0,)),
              CurvedNavigationBarItem(child: Image.asset('assets/images/user.png', height: 24.0, width: 24.0,)),
            ],
          ),
        );
      },
    );
  }
}
