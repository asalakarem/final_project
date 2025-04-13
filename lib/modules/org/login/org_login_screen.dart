import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled1/layout/org/org_activity.dart';
import 'package:untitled1/modules/org/cubit/cubit.dart';
import 'package:untitled1/modules/org/cubit/states.dart';
import 'package:untitled1/modules/org/login/forget_password/org_forget_password_screen.dart';
import 'package:untitled1/modules/org/signup/org_signup_screen.dart';
import 'package:untitled1/shared/components/components.dart';
import 'package:untitled1/shared/components/constants.dart';
import 'package:untitled1/shared/network/local/cache_helper.dart';

class OrgLoginScreen extends StatelessWidget {
  OrgLoginScreen({super.key});

  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OrgCubit, OrgStates>(
      listener: (BuildContext context, OrgStates state) {
        if (state is OrgLoginSuccessState) {
          if (state.loginModel.ngoId != null) {
            CacheHelper.saveData(
              key: 'orgId',
              value: state.loginModel.ngoId!,
            ).then((value) {
              orgId = state.loginModel.ngoId!;
              navigateAndFinish(context, const OrgActivity());
            });
          }
        }
        if (state is OrgLoginErrorState) {
          OrgCubit.get(context).snackBar(
            context: context,
            title: 'Login Failed',
            message: 'Email or password is wrong',
            type: ContentType.failure,
          );
        }
      },
      builder: (BuildContext context, OrgStates state) {
        final cubit = OrgCubit.get(context);
        return Scaffold(
          backgroundColor: const Color(0xff627254),
          appBar: defaultAppBar(
            backgroundColor: const Color(0xff627254),
            context: context,
          ),
          body: Form(
            key: formKey,
            child: Column(
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
                          const SizedBox(height: 5.0),
                          Text(
                            'Enter your information or login with your social media account',
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
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
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
                                depth: -5,
                                intensity: 0.8,
                                color: const Color(0xffE7E8D8),
                                boxShape: NeumorphicBoxShape.roundRect(
                                  BorderRadius.circular(12),
                                ),
                              ),
                              child: TextFormField(
                                controller: emailController,
                                validator: (String? value) {
                                  if (value!.isEmpty) {
                                    return 'email must not be empty';
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
                            const SizedBox(height: 30.0),
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
                                obscureText: cubit.isShowPassword['login']!,
                                validator: (String? value) {
                                  if (value!.isEmpty) {
                                    return 'password must not be empty';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      cubit.changePasswordVisibility('login');
                                    },
                                    icon: Icon(
                                      cubit.isShowPassword['login']!
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
                            const SizedBox(height: 15.0),
                            Align(
                              alignment: AlignmentDirectional.centerEnd,
                              child: TextButton(
                                onPressed: () {
                                  navigateTo(context, OrgForgetPasswordScreen());
                                },
                                child: const Text(
                                  'Forget Password?',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Color(0xff635C5C),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 30.0),
                            Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  IconButton(
                                    onPressed: () {},
                                    icon: Image.asset(
                                      'assets/images/google.png',
                                      height: 24.0,
                                      width: 24.0,
                                      color: const Color(0xff627254),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 30.0),
                            defaultButton(
                              function: () {
                                if (formKey.currentState!.validate()) {
                                  cubit.orgLogin(
                                    email: emailController.text,
                                    password: passwordController.text,
                                  );
                                }
                              },
                              text: 'Login..',
                              fontSize: 30.0,
                              backgroundColor: const Color(
                                0xffb27362,
                              ).withValues(alpha: 0.9),
                            ),
                            const SizedBox(height: 15.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'Not a Member?',
                                  style: TextStyle(fontSize: 18.0),
                                ),
                                TextButton(
                                  onPressed: () {
                                    navigateTo(context, OrgSignupScreen());
                                  },
                                  child: const Text(
                                    'Register now',
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      color: Color(0xff635C5C),
                                    ),
                                  ),
                                ),
                              ],
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
        );
      },
    );
  }
}
