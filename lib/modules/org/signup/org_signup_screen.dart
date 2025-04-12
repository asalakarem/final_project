import 'package:auto_size_text_plus/auto_size_text_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled1/layout/cubit/cubit.dart';
import 'package:untitled1/layout/cubit/states.dart';
import 'package:untitled1/modules/org/cubit/cubit.dart';
import 'package:untitled1/modules/org/cubit/states.dart';
import 'package:untitled1/modules/org/map/org_map_screen.dart';
import 'package:untitled1/modules/user/login/login_screen.dart';
import 'package:untitled1/shared/components/components.dart';

class OrgSignupScreen extends StatelessWidget {
  OrgSignupScreen({super.key});

  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OrgCubit, OrgStates>(
      listener: (BuildContext context, OrgStates state) {
        if (state is MainRegisterSuccessState) {
          navigateAndFinish(context, LoginScreen());
        }
      },
      builder: (BuildContext context, OrgStates state) {
        var cubit = OrgCubit.get(context);
        return Scaffold(
          backgroundColor: const Color(0xff627254),
          appBar: defaultAppBar(
            context: context,
            backgroundColor: const Color(0xff627254),
          ),
          body: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: SingleChildScrollView(
                    child: AutoSizeText(
                      'Please Enter your Organization information below',
                      style: GoogleFonts.aclonica(
                        fontSize: 32.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 3,
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
                      child: Form(
                        key: formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Organization Name',
                              style: TextStyle(
                                fontSize: 26.0,
                                color: Color(0xff6C2C2C),
                              ),
                            ),
                            const SizedBox(height: 15.0),
                            Neumorphic(
                              style: NeumorphicStyle(
                                depth: -5,
                                // التأثير الغائر
                                intensity: 0.8,
                                color: const Color(0xffE7E8D8),
                                // لون الخلفية
                                boxShape: NeumorphicBoxShape.roundRect(
                                  BorderRadius.circular(12),
                                ),
                              ),
                              child: TextFormField(
                                controller: nameController,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter your name';
                                  }
                                  return null;
                                },
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 12,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20.0),
                            const Text(
                              'Phone Number',
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
                                controller: phoneController,
                                keyboardType: TextInputType.phone,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter your phone number';
                                  }
                                  return null;
                                },
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 12,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 15.0),
                            const Text(
                              'Email',
                              style: TextStyle(
                                fontSize: 26.0,
                                color: Color(0xff6C2C2C),
                              ),
                            ),
                            const SizedBox(height: 15.0),
                            Neumorphic(
                              style: NeumorphicStyle(
                                depth: -5, // التأثير الغائر
                                intensity: 0.8,
                                color: const Color(0xffE7E8D8), // لون الخلفية
                                boxShape: NeumorphicBoxShape.roundRect(
                                  BorderRadius.circular(12),
                                ),
                              ),
                              child: TextFormField(
                                controller: emailController,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter your email';
                                  }
                                  return null;
                                },
                                autofillHints: const [AutofillHints.email],
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 12,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20.0),
                            const Text(
                              'password',
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
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter your password';
                                  }
                                  return null;
                                },
                                obscureText: cubit.isShowPassword['signUp']!,
                                decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      cubit.changePasswordVisibility('signUp');
                                    },
                                    icon: Icon(
                                      cubit.isShowPassword['signUp']!
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
                            const SizedBox(height: 20.0),
                            defaultButton(
                              function: () {
                                if (formKey.currentState!.validate()) {
                                  navigateTo(context, MapScreen(
                                    name: nameController.text,
                                    email: emailController.text,
                                    phone: phoneController.text,
                                    password: passwordController.text,
                                  ));
                                }
                              },
                              text: 'Lets get started...',
                              fontSize: 30.0,
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
              ),
            ],
          ),
        );
      },
    );
  }
}
