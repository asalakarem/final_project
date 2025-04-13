import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled1/layout/cubit/cubit.dart';
import 'package:untitled1/layout/cubit/states.dart';
import 'package:untitled1/modules/select/select_screen.dart';
import 'package:untitled1/shared/components/components.dart';
import 'package:untitled1/shared/network/local/cache_helper.dart';

class UserScreen extends StatelessWidget {

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit,MainStates>(
      listener: (BuildContext context, MainStates state) {},
      builder: (BuildContext context, MainStates state) {
        final cubit = MainCubit.get(context);
        // nameController.text =
        //     '${cubit.loginModel!.firstName ?? ''} ${cubit.loginModel!.lastName ?? ''}'.trim();
        // emailController.text = cubit.loginModel!.email!;
        // phoneController.text = cubit.loginModel!.phoneNumber!;
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/user_profile.png',
              width: 80.0,
              height: 80.0,
            ),
            const SizedBox(height: 50.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: SingleChildScrollView(
                child: Column(
                  spacing: 30.0,
                  children: [
                    Neumorphic(
                      style: NeumorphicStyle(
                        depth: 0,
                        intensity: 0.8,
                        color: const Color(0xffD19E9E).withValues(alpha: 0.41),
                        boxShape: NeumorphicBoxShape.roundRect(
                          BorderRadius.circular(12),
                        ),
                      ),
                      child: TextFormField(
                        controller: nameController,
                        decoration: const InputDecoration(
                          label: Text(
                            'Name',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff6C2C2C),
                            ),
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                        ),
                      ),
                    ),
                    Neumorphic(
                      style: NeumorphicStyle(
                        depth: 0,
                        intensity: 0.8,
                        color: const Color(0xffD19E9E).withValues(alpha: 0.41),
                        boxShape: NeumorphicBoxShape.roundRect(
                          BorderRadius.circular(12),
                        ),
                      ),
                      child: TextFormField(
                        controller: emailController,
                        decoration: const InputDecoration(
                          label: Text(
                            'Email',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff6C2C2C),
                            ),
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                        ),
                      ),
                    ),
                    Neumorphic(
                      style: NeumorphicStyle(
                        depth: 0,
                        intensity: 0.8,
                        color: const Color(0xffD19E9E).withValues(alpha: 0.41),
                        boxShape: NeumorphicBoxShape.roundRect(
                          BorderRadius.circular(12),
                        ),
                      ),
                      child: TextFormField(
                        controller: phoneController,
                        decoration: const InputDecoration(
                          label: Text(
                            'Phone Number',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff6C2C2C),
                            ),
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextButton(
                            onPressed: () {
                              showDialog<void>(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    backgroundColor: const Color(
                                      0xffD19E9E,
                                    ).withValues(alpha: 0.95),
                                    content: Text(
                                      'Are you sure you want to log out?',
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.inter(
                                        fontSize: 24.0,
                                        color: const Color(0xff6C2C2C),
                                      ),
                                    ),
                                    actions: [
                                      TextButton(
                                        style: TextButton.styleFrom(
                                          backgroundColor: const Color(0xffB8BB84),
                                          foregroundColor: Colors.white,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(5.0),
                                          ),
                                        ),
                                        onPressed: () {
                                          CacheHelper.removeData(key: 'userId').then((value){
                                            navigateAndFinish(context, const SelectScreen());
                                            cubit.currentIndex = 0;
                                          });
                                          CacheHelper.removeData(key: 'onBoarding');
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text('yes'),
                                      ),
                                      TextButton(
                                        style: TextButton.styleFrom(
                                          backgroundColor: const Color(0xffAF6B58),
                                          foregroundColor: Colors.white,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(5.0),
                                          ),
                                        ),
                                        child: const Text('cancel'),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            child: const Row(
                              spacing: 10.0,
                              children: [
                                Icon(Icons.logout, color: Colors.black),
                                Text(
                                  'Logout',
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xffC79E9E),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: TextButton(
                            onPressed: () {},
                            child: const Text(
                              'Edit Profile',
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                color: Color(0xffC79E9E),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
