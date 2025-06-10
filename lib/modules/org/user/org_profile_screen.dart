import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled1/modules/org/cubit/cubit.dart';
import 'package:untitled1/modules/org/cubit/states.dart';
import 'package:untitled1/modules/select/select_screen.dart';
import 'package:untitled1/shared/components/components.dart';
import 'package:untitled1/shared/network/local/cache_helper.dart';

class OrgProfileScreen extends StatelessWidget {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  OrgProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrgCubit, OrgStates>(
      builder: (BuildContext context, OrgStates state) {
        final cubit = OrgCubit.get(context);
        final profile = cubit.loginModel;
        nameController.text = profile!.name!;
        emailController.text = profile.email!;
        phoneController.text = profile.phoneNumber.toString();
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50.0,
              backgroundColor: const Color(0xffDED5C4),
              child: Image.asset(
                'assets/images/org_profile.png',
                width: 64.0,
                height: 64.0,
              ),
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
                            'Organization Name',
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
                    Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: TextButton.icon(
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
                                        borderRadius: BorderRadius.circular(5.0),
                                      ),
                                    ),
                                    onPressed: () {
                                      CacheHelper.removeData(key: 'orgId').then((
                                        value,
                                      ) {
                                        navigateAndFinish(
                                          context,
                                          const SelectScreen(),
                                        );
                                        cubit.currentIndex = 0;
                                      });
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('yes'),
                                  ),
                                  TextButton(
                                    style: TextButton.styleFrom(
                                      backgroundColor: const Color(0xffAF6B58),
                                      foregroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5.0),
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
                        icon: const Icon(Icons.logout, color: Colors.black),
                        label: const Text(
                          'Logout',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff6C2C2C),
                          ),
                        ),
                      ),
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
