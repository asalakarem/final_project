import 'package:auto_size_text_plus/auto_size_text_plus.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled1/shared/components/components.dart';

class DonationScreen extends StatelessWidget {
  const DonationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: defaultAppBar(
        context: context,
        backgroundColor: const Color(0xffF2EFEA),
      ),
      body: Column(
        spacing: 20.0,
        children: [
          Expanded(
            child: Column(
              spacing: 20,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Container(
                    width: double.infinity,
                    height: 130.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      color: const Color(0xff815B5B),
                    ),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Image.asset('assets/images/donate.png', fit: BoxFit.cover),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 26.0),
                  child: Text(
                    'End the suffering of a street dog',
                    style: GoogleFonts.aclonica(
                      fontSize: 24.0,
                      color: const Color(0xff627254),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      Image.asset('assets/images/dog2.png', height: 61.0, width: 79.0),
                      Text(
                        'Every day, Animal',
                        style: GoogleFonts.alata(
                          fontSize: 24.0,
                          color: const Color(0xff6C2C2C),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: AutoSizeText(
                      'Protection Foundation (APF) is called upon to rescue animals from abuse, abandonment, sickness or injury. Every day there are dogs in need of life-saving medical treatment or urgent surgery, none of it is possible without your support.\nMake it a MONTHLY gift,it can save lives.\nThe life of street dogs can often be a cruel one.\nWith no food, water or shelter – every day can be a struggle and for many of them it can turn violent or deadly.\nWithout any government funding, YOU are their only hope for survival of the atrocities they endure every day on the streets.',
                      style: GoogleFonts.alata(
                        fontSize: 24.0,
                        color: const Color(0xff6C2C2C),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          defaultButton(
            function: () {
              launchInBrowser(Uri.parse('https://www.internationalanimalrescue.org/donate?gclid=CNDOn4CxhdMCFQwmvQodk10DuA'));
            },
            text: 'Donate now...',
            backgroundColor: const Color(0xff627254),
          ),
          const SizedBox(height: 10.0),
        ],
      ),
    );
  }
}
