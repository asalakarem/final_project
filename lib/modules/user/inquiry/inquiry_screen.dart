import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled1/modules/user/inquiry/accepted/accepted_screen.dart';
import 'package:untitled1/modules/user/inquiry/in_progress/in_progress_screen.dart';
import 'package:untitled1/modules/user/inquiry/mission_done/mission_done_screen.dart';
import 'package:untitled1/shared/components/components.dart';

class InquiryScreen extends StatelessWidget {
  const InquiryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.only(
                  top: 20.0,
                  bottom: 20.0,
                  start: 10.0,
                  end: 10.0,
                ),
                child: Text(
                  'Inquiry',
                  style: GoogleFonts.aclonica(
                    fontSize: 40.0,
                    color: const Color(0xff6C2C2C),
                  ),
                ),
              ),
              myDivider(color: const Color(0xff6C2C2C)),
            ],
          ),
          Padding(
            padding: const EdgeInsetsDirectional.only(top: 25.0, start: 10.0, end: 10.0),
            child: Column(
              spacing: 15.0,
              children: [
                InkWell(
                  onTap: () {
                    navigateTo(context, const InProgressScreen());
                  },
                  child: SizedBox(
                    height: 170.0,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomEnd,
                      children: [
                        Container(
                          width: double.infinity,
                          height: 90.0,
                          padding: const EdgeInsetsDirectional.only(
                            start: 25.0,
                            top: 10.0,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            color: const Color(0xffC79E9E),
                          ),
                          child: Align(
                            alignment: AlignmentDirectional.centerStart,
                            child: Text(
                              'In Progress',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.alata(
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xff6C2C2C),
                              ),
                            ),
                          ),
                        ),
                        Image.asset(
                          'assets/images/dog_progress.png',
                          width: 150.0,
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    navigateTo(context, const AcceptedScreen());
                  },
                  child: SizedBox(
                    height: 170.0,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomStart,
                      children: [
                        Container(
                          width: double.infinity,
                          height: 90.0,
                          padding: const EdgeInsetsDirectional.only(
                            end: 25.0,
                            top: 10.0,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            color: const Color(0xffB5C18E),
                          ),
                          child: Align(
                            alignment: AlignmentDirectional.centerEnd,
                            child: Text(
                              'Accepted Requests',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.alata(
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xff6C2C2C),
                              ),
                            ),
                          ),
                        ),
                        Image.asset('assets/images/rejected_dog.png'),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    navigateTo(context, const MissionDoneScreen());
                  },
                  child: SizedBox(
                    height: 170.0,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomEnd,
                      children: [
                        Container(
                          width: double.infinity,
                          height: 90.0,
                          padding: const EdgeInsetsDirectional.only(
                            start: 25.0,
                            top: 10.0,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            color: const Color(0xffDED5C4),
                          ),
                          child: Align(
                            alignment: AlignmentDirectional.centerStart,
                            child: Text(
                              'Mission Done',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.alata(
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xff6C2C2C),
                              ),
                            ),
                          ),
                        ),
                        Image.asset('assets/images/done_dog.png'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
