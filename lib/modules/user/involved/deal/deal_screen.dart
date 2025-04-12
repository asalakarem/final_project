import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled1/layout/cubit/cubit.dart';
import 'package:untitled1/layout/cubit/states.dart';
import 'package:untitled1/shared/components/components.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class DealScreen extends StatelessWidget {
  const DealScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, MainStates>(
      listener: (BuildContext context, MainStates state) {},
      builder: (BuildContext context, MainStates state) {
        var cubit = MainCubit.get(context);
        return Scaffold(
          appBar: defaultAppBar(
            context: context,
            backgroundColor: const Color(0xffF2EFEA),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 190.0,
                  child: Stack(
                    alignment: AlignmentDirectional.bottomEnd,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Container(
                          width: double.infinity,
                          height: 110.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            color: const Color(0xff815B5B),
                          ),
                          child: Padding(
                            padding: const EdgeInsetsDirectional.only(
                              start: 25.0,
                            ),
                            child: Align(
                              alignment: AlignmentDirectional.centerStart,
                              child: Text(
                                'How to deal with a\npoisoned dog',
                                maxLines: 2,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.alata(
                                  fontSize: 20.0,
                                  color: const Color(0xffDED5C4),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Image.asset('assets/images/deal_dog2.png'),
                    ],
                  ),
                ),
                const SizedBox(height: 20.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Column(
                    spacing: 20.0,
                    children: [
                      Text(
                        'If you suspect your dog has been poisoned:',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.alata(
                          fontSize: 24.0,
                          color: const Color(0xff6C2C2C),
                        ),
                      ),
                      Text(
                        '1. Identify the poison if possible and remove access to it.',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.alata(
                          fontSize: 24.0,
                          color: const Color(0xff526344),
                        ),
                      ),
                      Text(
                        '2. Contact a vet immediately and\nprovide details about the\nsubstance and symptoms.',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.alata(
                          fontSize: 22.0,
                          color: const Color(0xff526344),
                        ),
                      ),
                      Text(
                        '3. Do not induce vomiting unless\ninstructed by a vet.',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.alata(
                          fontSize: 22.0,
                          color: const Color(0xff526344),
                        ),
                      ),
                      Text(
                        '4. Keep your dog calm and hydrated.',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.alata(
                          fontSize: 24.0,
                          color: const Color(0xff526344),
                        ),
                      ),
                      Text(
                        '5. Seek emergency veterinary care for proper treatment.',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.alata(
                          fontSize: 24.0,
                          color: const Color(0xff526344),
                        ),
                      ),
                      Text(
                        'Prevention is key: keep toxins out of reach and supervise your dog.',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.alata(
                          fontSize: 24.0,
                          color: const Color(0xffaf6b58),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(20.0),
                        child: YoutubePlayer(
                          controller: cubit.youtubeController3,
                          showVideoProgressIndicator: true,
                        ),
                      ),
                    ],
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
