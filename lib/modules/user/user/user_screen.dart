import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled1/layout/cubit/cubit.dart';
import 'package:untitled1/layout/cubit/states.dart';
import 'package:untitled1/modules/select/select_screen.dart';
import 'package:untitled1/modules/user/user/edit_profile/edit_profile_screen.dart';
import 'package:untitled1/shared/components/components.dart';
import 'package:untitled1/shared/network/local/cache_helper.dart';

class UserScreen extends StatelessWidget {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainCubit, MainStates>(
      builder: (BuildContext context, MainStates state) {
        final cubit = MainCubit.get(context);
        final loginModel = cubit.loginModel;

        nameController.text =
            '${loginModel?.firstName ?? ''} ${loginModel?.lastName ?? ''}'
                .trim();
        emailController.text = loginModel?.email ?? '';
        phoneController.text = loginModel?.phoneNumber.toString() ?? '';

        return SingleChildScrollView(
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 50.0),
                    Image.asset(
                      'assets/images/user_profile.png',
                      width: 80.0,
                      height: 80.0,
                    ),
                    const SizedBox(height: 50.0),
                    Column(
                      children: [
                        buildNeumorphicField(
                          controller: nameController,
                          label: 'Name',
                        ),
                        const SizedBox(height: 30.0),
                        buildNeumorphicField(
                          controller: emailController,
                          label: 'Email',
                        ),
                        const SizedBox(height: 30.0),
                        buildNeumorphicField(
                          controller: phoneController,
                          label: 'Phone Number',
                        ),
                        const SizedBox(height: 30.0),
                        Row(
                          children: [
                            Expanded(
                              child: TextButton.icon(
                                onPressed: () {
                                  showDialog<void>(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        backgroundColor: const Color(
                                          0xffD19E9E,
                                        ).withOpacity(0.95),
                                        content: Text(
                                          'Are you sure you want to log out?',
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.inter(
                                            fontSize: 24.0,
                                            color: const Color(0xff6C2C2C),
                                          ),
                                        ),
                                        actions: [
                                          Row(
                                            spacing: 15.0,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: TextButton(
                                                  style: TextButton.styleFrom(
                                                    backgroundColor:
                                                        const Color(0xffB8BB84),
                                                    foregroundColor:
                                                        Colors.white,
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            5.0,
                                                          ),
                                                    ),
                                                  ),
                                                  onPressed: () {
                                                    CacheHelper.removeData(
                                                      key: 'userId',
                                                    ).then((value) {
                                                      navigateAndFinish(
                                                        context,
                                                        const SelectScreen(),
                                                      );
                                                      cubit.currentIndex = 0;
                                                    });
                                                    CacheHelper.removeData(
                                                      key: 'onBoarding',
                                                    );
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: const Text(
                                                    'yes',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 20,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: TextButton(
                                                  style: TextButton.styleFrom(
                                                    backgroundColor:
                                                        const Color(0xffAF6B58),
                                                    foregroundColor:
                                                        Colors.white,
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            5.0,
                                                          ),
                                                    ),
                                                  ),
                                                  child: const Text(
                                                    'cancel',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 20,
                                                    ),
                                                  ),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                icon: const Icon(
                                  Icons.logout,
                                  color: Colors.black,
                                ),
                                label: const Text(
                                  'Logout',
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xffC79E9E),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: TextButton(
                                onPressed: () {
                                  navigateTo(context, EditProfileScreen());
                                },
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
                        const SizedBox(height: 50.0),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  // لتقليل التكرار، أنشأنا عنصر خاص بحقول Neumorphic
  Widget buildNeumorphicField({
    required TextEditingController controller,
    required String label,
  }) {
    return Neumorphic(
      style: NeumorphicStyle(
        depth: 0,
        intensity: 0.8,
        color: const Color(0xffD19E9E).withOpacity(0.41),
        boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
      ),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          label: Text(
            label,
            style: const TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Color(0xff6C2C2C),
            ),
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
        ),
      ),
    );
  }
}
