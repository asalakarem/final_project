import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled1/layout/cubit/cubit.dart';
import 'package:untitled1/layout/cubit/states.dart';
import 'package:untitled1/modules/user/login/login_screen.dart';
import 'package:untitled1/shared/components/components.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});

  final formKey = GlobalKey<FormState>();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, MainStates>(
      listener: (BuildContext context, MainStates state) {
        if (state is MainRegisterSuccessState) {
          navigateAndFinish(context, LoginScreen());
        }
        if (state is MainRegisterErrorState) {
          MainCubit.get(context).snackBar(
            context: context,
            title: 'Register Failed',
            message: state.error,
            type: ContentType.failure,
          );
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
          body: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hello our Rescue Ranger ,',
                          style: GoogleFonts.aclonica(
                            fontSize: 36.0,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'Enter your information below or sign up with social media account',
                          style: GoogleFonts.aclonica(
                            fontSize: 20.0,
                            color: Colors.white,
                          ),
                        ),
                      ],
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
                            Row(
                              spacing: 20,
                              children: [
                                Expanded(
                                  child: Column(
                                    children: [
                                      const Text(
                                        'First Name',
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
                                          boxShape:
                                              NeumorphicBoxShape.roundRect(
                                                BorderRadius.circular(12),
                                              ),
                                        ),
                                        child: TextFormField(
                                          controller: firstNameController,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'Please enter your first name';
                                            }
                                            return null;
                                          },
                                          decoration: const InputDecoration(
                                            border: InputBorder.none,
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                  horizontal: 16,
                                                  vertical: 12,
                                                ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    children: [
                                      const Text(
                                        'Last Name',
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
                                          boxShape:
                                              NeumorphicBoxShape.roundRect(
                                                BorderRadius.circular(12),
                                              ),
                                        ),
                                        child: TextFormField(
                                          controller: lastNameController,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'Please enter your last name';
                                            }
                                            return null;
                                          },
                                          decoration: const InputDecoration(
                                            border: InputBorder.none,
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                  horizontal: 16,
                                                  vertical: 12,
                                                ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
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
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your email';
                                  }
                                  if (!value.endsWith('@gmail.com')) {
                                    return 'Email must be a @gmail.com address';
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
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your password';
                                  }
                                  if (value.length < 8) {
                                    return 'Password must be at least 8 characters long';
                                  }
                                  if (!RegExp(
                                    r'^(?=.*[a-zA-Z])(?=.*\d)',
                                  ).hasMatch(value)) {
                                    return 'Password must contain both letters and numbers';
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
                                depth: -5, // التأثير الغائر
                                intensity: 0.8,
                                color: const Color(0xffE7E8D8), // لون الخلفية
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
                                  if (value.length < 11) {
                                    return 'phone number must be at least 11 characters long';
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
                            defaultButton(
                              function: () {
                                if (formKey.currentState!.validate()) {
                                  cubit.userRegister(
                                    firstName: firstNameController.text,
                                    lastName: lastNameController.text,
                                    email: emailController.text,
                                    password: passwordController.text,
                                    phone: int.parse(phoneController.text),
                                  );
                                }
                              },
                              text: 'Register...',
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
