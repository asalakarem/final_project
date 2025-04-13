import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/layout/cubit/cubit.dart';
import 'package:untitled1/layout/cubit/states.dart';
import 'package:untitled1/layout/org/org_activity.dart';
import 'package:untitled1/layout/user/user_activity.dart';
import 'package:untitled1/modules/org/cubit/cubit.dart';
import 'package:untitled1/modules/select/select_screen.dart';
import 'package:untitled1/modules/user/login/login_screen.dart';
import 'package:untitled1/shared/network/remote/dio_helper.dart';
import 'package:untitled1/shared/style/theme.dart';

import 'shared/bloc_observer.dart';
import 'shared/network/local/cache_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await CacheHelper.init();
  DioHelper.init();
  Bloc.observer = MyBlocObserver();
  Widget startWidget;
  final bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
  final int? userId = CacheHelper.getData(key: 'userId');
  final int? orgId = CacheHelper.getData(key: 'orgId');
  if (orgId != null) {
    startWidget = const OrgActivity();
  } else {
    if (onBoarding == null) {
      startWidget = const SelectScreen();
    } else if (userId != null) {
      startWidget = const UserActivity();
    } else {
      startWidget = LoginScreen();
    }
  }
  runApp(MyApp(startWidget: startWidget));
}

class MyApp extends StatelessWidget {
  final Widget? startWidget;

  const MyApp({super.key, required this.startWidget});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create:
              (context) =>
                  MainCubit()
                    ..initYoutubeController()
                    ..getUserData(),
        ),
        BlocProvider(create: (context) => OrgCubit()),
      ],
      child: BlocConsumer<MainCubit, MainStates>(
        listener: (BuildContext context, MainStates state) {},
        builder: (BuildContext context, MainStates state) {
          final MaterialTheme theme = MaterialTheme();
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: startWidget,
            theme: theme.light(),
            darkTheme: theme.dark(),
            themeMode: ThemeMode.light,
          );
        },
      ),
    );
  }
}
