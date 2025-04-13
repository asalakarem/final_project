import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled1/layout/cubit/cubit.dart';
import 'package:untitled1/layout/cubit/states.dart';
import 'package:untitled1/modules/user/login/login_screen.dart';
import 'package:untitled1/shared/components/components.dart';

class NewPasswordScreen extends StatelessWidget {
  final String email;
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  NewPasswordScreen({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, MainStates>(
      listener: (BuildContext context, MainStates state) {
        if (state is MainNewPasswordSuccessState) {
          navigateAndFinish(context, LoginScreen());
        }
      },
      builder: (BuildContext context, MainStates state) {
        final cubit = MainCubit.get(context);
        return Scaffold(
          backgroundColor: const Color(0xff627254),
          appBar: defaultAppBar(
            context: context,
            backgroundColor: const Color(0xff627254),
          ),
          body: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Reset Password',
                            maxLines: 2,
                            style: GoogleFonts.aclonica(
                              fontSize: 36.0,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 20.0),
                          Text(
                            'Now you can reset your password',
                            maxLines: 4,
                            style: GoogleFonts.aclonica(
                              fontSize: 20.0,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.6,
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color(0xff6C2C2C),
                          width: 3.0,
                        ),
                        borderRadius: const BorderRadiusDirectional.only(
                          topStart: Radius.circular(50),
                          topEnd: Radius.circular(50),
                        ),
                        color: const Color(0xffF2EFEA),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'New Password',
                                style: TextStyle(
                                  fontSize: 26.0,
                                  color: Color(0xff6C2C2C),
                                ),
                              ),
                              const SizedBox(height: 15.0),
                              Neumorphic(
                                style: NeumorphicStyle(
                                  depth: -5,
                                  intensity: 0.8,
                                  color: const Color(0xffE7E8D8),
                                  boxShape: NeumorphicBoxShape.roundRect(
                                    BorderRadius.circular(12),
                                  ),
                                ),
                                child: TextFormField(
                                  controller: passwordController,
                                  obscureText:
                                      cubit.isShowPassword['newPassword']!,
                                  decoration: InputDecoration(
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        cubit.changePasswordVisibility(
                                          'newPassword',
                                        );
                                      },
                                      icon: Icon(
                                        cubit.isShowPassword['newPassword']!
                                            ? Icons.visibility_off_outlined
                                            : Icons.visibility_outlined,
                                      ),
                                    ),
                                    border: InputBorder.none,
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 12,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 30.0),
                              defaultButton(
                                function: () {
                                  if (formKey.currentState!.validate()) {
                                    cubit.newPassword(
                                      email: email,
                                      password: passwordController.text,
                                    );
                                  }
                                },
                                text: 'Submit...',
                                backgroundColor: const Color(
                                  0xffb27362,
                                ).withValues(alpha: 0.9),
                              ),
                            ],
                          ),
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
    );
  }
}
