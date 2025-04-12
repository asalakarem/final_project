import 'package:auto_size_text_plus/auto_size_text_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled1/layout/cubit/cubit.dart';
import 'package:untitled1/layout/cubit/states.dart';
import 'package:untitled1/shared/components/components.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class DumpScreen extends StatelessWidget {
  const DumpScreen({super.key});

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
                  height: 150.0,
                  child: Stack(
                    alignment: AlignmentDirectional.bottomEnd,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Container(
                          width: double.infinity,
                          height: 100.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            color: const Color(0xff815B5B),
                            image: const DecorationImage(
                              image: AssetImage('assets/images/foods.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Image.asset('assets/images/golden_dog.png'),
                    ],
                  ),
                ),
                const SizedBox(height: 20.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 26.0),
                  child: Text(
                    'Don\'t Dump Your Dog',
                    style: GoogleFonts.aclonica(
                      fontSize: 24.0,
                      color: const Color(0xff627254),
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 26.0),
                  child: AutoSizeText(
                    'When you get a dog, it is not like getting a car loan.\n\nWhen your dog misbehaves, you can’t just trade him in, find a trainer.\n\nIf he gets sick, it is your job to help him get well. If you are having a baby and don\'t have time for a dog, dogs and kids can actually be a great combination if handled correctly.\n\nIf you have exhausted all of your options and really cannot keep your dog, Abandonment is NEVER acceptable. You are responsible for finding the best home possible for your dog.\n\nIf circumstances in your home environment change, you must consider the toll it will take on your dog and make every effort to help him along.',
                    style: GoogleFonts.alata(
                      fontSize: 24.0,
                      color: const Color(0xff6C2C2C),
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                Container(
                  padding: const EdgeInsets.all(20.0),
                  child: YoutubePlayer(
                    controller: cubit.youtubeController1,
                    showVideoProgressIndicator: true,
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
