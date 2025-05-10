import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/modules/org/cubit/cubit.dart';
import 'package:untitled1/modules/org/cubit/states.dart';

class OrgActivity extends StatelessWidget {
  const OrgActivity({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrgCubit, OrgStates>(
      bloc: OrgCubit.get(context)..checkOrgActiveStatus(context),
      builder: (BuildContext context, OrgStates state) {
        final cubit = OrgCubit.get(context);
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
              CurvedNavigationBarItem(
                child: Image.asset(
                  'assets/images/home.png',
                  color: Colors.black,
                  height: 24.0,
                  width: 24.0,
                ),
              ),
              CurvedNavigationBarItem(
                child: Image.asset(
                  'assets/images/done.png',
                  color: Colors.black,
                  height: 24.0,
                  width: 24.0,
                ),
              ),
              CurvedNavigationBarItem(
                child: Image.asset(
                  'assets/images/complete.png',
                  color: Colors.black,
                  height: 24.0,
                  width: 24.0,
                ),
              ),
              CurvedNavigationBarItem(
                child: Image.asset(
                  'assets/images/user.png',
                  color: Colors.black,
                  height: 24.0,
                  width: 24.0,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
