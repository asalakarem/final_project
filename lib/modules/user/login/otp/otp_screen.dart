import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled1/layout/cubit/cubit.dart';
import 'package:untitled1/layout/cubit/states.dart';
import 'package:untitled1/modules/user/login/new_password/new_password_screen.dart';
import 'package:untitled1/shared/components/components.dart';

class OtpScreen extends StatelessWidget {
  final TextEditingController otpController1 = TextEditingController();
  final TextEditingController otpController2 = TextEditingController();
  final TextEditingController otpController3 = TextEditingController();
  final TextEditingController otpController4 = TextEditingController();
  final String email;

  // Create FocusNodes for each OTP field
  final FocusNode focusNode1 = FocusNode();
  final FocusNode focusNode2 = FocusNode();
  final FocusNode focusNode3 = FocusNode();
  final FocusNode focusNode4 = FocusNode();

  OtpScreen({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, MainStates>(
      listener: (BuildContext context, MainStates state) {
        if (state is MainVerifyOtpSuccessState) {
          navigateTo(context, NewPasswordScreen(email: email,));
        }
      },
      builder: (BuildContext context, MainStates state) {
        return Scaffold(
          backgroundColor: const Color(0xff627254),
          appBar: defaultAppBar(
            context: context,
            backgroundColor: const Color(0xff627254),
          ),
          body: SingleChildScrollView(
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
                          'Now you need to enter OTP',
                          maxLines: 2,
                          style: GoogleFonts.aclonica(
                            fontSize: 34.0,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        Text(
                          'Enter 4 digit verification code sent to your registered email address.',
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
                          'OTP',
                          style: TextStyle(
                            fontSize: 26.0,
                            color: Color(0xff6C2C2C),
                          ),
                        ),
                        const SizedBox(height: 15.0),
                        Row(
                          spacing: 15.0,
                          children: [
                            _buildOtpField(otpController1, focusNode1, focusNode2, context),
                            _buildOtpField(otpController2, focusNode2, focusNode3, context),
                            _buildOtpField(otpController3, focusNode3, focusNode4, context),
                            _buildOtpField(otpController4, focusNode4, null, context),
                          ],
                        ),
                        const SizedBox(height: 40.0),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text(
                            'resend code in 00:23sec',
                            style: GoogleFonts.inter(
                              fontSize: 16.0,
                              color: const Color(0xff635C5C),
                            ),
                          ),
                        ),
                        const SizedBox(height: 40.0),
                        defaultButton(
                          function: () {
                            String otpString = otpController1.text + otpController2.text + otpController3.text + otpController4.text;
                            if (otpString.length == 4) {
                              int otp = int.tryParse(otpString) ?? 0;
                              MainCubit.get(context).verifyOtp(otp: otp, email: email);
                            } else {
                              return "Please enter a valid OTP";
                            }
                          },
                          text: 'Reset Password...',
                          fontSize: 25.0,
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
        );
      },
    );
  }

  Widget _buildOtpField(TextEditingController controller, FocusNode focusNode, FocusNode? nextFocusNode, context) {
    return Expanded(
      child: SizedBox(
        height: 70.0,
        child: Neumorphic(
          style: NeumorphicStyle(
            depth: -5,
            intensity: 0.8,
            color: const Color(0xffE7E8D8),
            boxShape: NeumorphicBoxShape.roundRect(
              BorderRadius.circular(12),
            ),
          ),
          child: TextFormField(
            controller: controller,
            keyboardType: TextInputType.number,
            maxLength: 1,
            focusNode: focusNode, // Set the focus node
            decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
            onChanged: (value) {
              if (value.isNotEmpty && nextFocusNode != null) {
                // Move focus to the next field
                FocusScope.of(context).requestFocus(nextFocusNode);
              }
            },
          ),
        ),
      ),
    );
  }
}
