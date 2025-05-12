import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:untitled1/layout/cubit/cubit.dart';
import 'package:untitled1/layout/cubit/states.dart';
import 'package:untitled1/modules/user/login/otp/otp_screen.dart';
import 'package:untitled1/shared/components/components.dart';

class ForgetPasswordScreen extends StatelessWidget {

  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();

  ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, MainStates>(
      listener: (BuildContext context, MainStates state) {
        if (state is MainSendEmailSuccessState) {
          navigateTo(context, OtpScreen(email: emailController.text,));
        }
      },
      builder: (BuildContext context, MainStates state) {
        final cubit = MainCubit.get(context);
        if (state is MainSendEmailLoadingState) {
          return Scaffold(
            backgroundColor: const Color(0xff627254),
            body: Center(
              child: LoadingAnimationWidget.discreteCircle(
                color: Colors.white, // أو استخدم color كما في حالتك إذا تم تعريفه مسبقًا
                size: 50, // حجم أوضح لعنصر التحميل
              ),
            ),
          );
        }
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
                            'Forgot password ?',
                            maxLines: 2,
                            style: GoogleFonts.aclonica(
                              fontSize: 34.0,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 20.0),
                          Text(
                            'No problem, you only need to enter your organization email and we will send OTP code',
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
                  Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.6,
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
                      child: Column(
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
                          const SizedBox(height: 60.0),
                          defaultButton(
                            function: () {
                              if (formKey.currentState!.validate()) {
                                cubit.sendEmail(email: emailController.text);
                              }
                            },
                            text: 'Submit...',
                            fontSize: 30.0,
                            backgroundColor: const Color(
                              0xffb27362,
                            ).withValues(alpha: 0.9),
                          ),
                        ],
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
