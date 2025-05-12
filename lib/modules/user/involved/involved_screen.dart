import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled1/modules/user/involved/deal/deal_screen.dart';
import 'package:untitled1/modules/user/involved/mad/mad_screen.dart';
import 'package:untitled1/shared/components/components.dart';

class InvolvedScreen extends StatelessWidget {
  const InvolvedScreen({super.key});

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
                  'Get Involved',
                  style: GoogleFonts.aclonica(
                    fontSize: 40.0,
                    color: const Color(0xff6C2C2C),
                  ),
                ),
              ),
              myDivider(color: const Color(0xff6C2C2C)),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.15,
          ),
          Column(
            spacing: 15.0,
            children: [
              InkWell(
                onTap: () {
                  navigateTo(context, const MadScreen());
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
                          alignment: AlignmentDirectional.topStart,
                          child: Text(
                            'What to you do if a mad\ndog bites you?',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.alata(
                              fontSize: 20.0,
                              color: const Color(0xff6C2C2C),
                            ),
                          ),
                        ),
                      ),
                      Image.asset('assets/images/mad_dog.png'),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  navigateTo(context, const DealScreen());
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
                          alignment: AlignmentDirectional.topEnd,
                          child: Text(
                            'How to deal with a\npoisoned dog',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.alata(
                              fontSize: 20.0,
                              color: const Color(0xff6C2C2C),
                            ),
                          ),
                        ),
                      ),
                      Image.asset('assets/images/deal_dog.png'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
