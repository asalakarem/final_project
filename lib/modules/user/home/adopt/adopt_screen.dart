import 'package:auto_size_text_plus/auto_size_text_plus.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled1/shared/components/components.dart';

class AdoptScreen extends StatelessWidget {
  const AdoptScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: defaultAppBar(
        context: context,
        backgroundColor: const Color(0xffF2EFEA),
      ),
      body: Column(
        spacing: 20,
        children: [
          Expanded(
            child: Column(
              children: [
                SizedBox(
                  height: 170.0,
                  child: Stack(
                    alignment: Alignment.bottomCenter,
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
                        ),
                      ),
                      Image.asset('assets/images/cute_dog.png'),
                    ],
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Image.asset('assets/images/puppy.png', height: 50.0, width: 50.0),
                    const SizedBox(width: 5.0),
                    AutoSizeText(
                      'Be a Responsible Pet Owner',
                      style: GoogleFonts.alata(
                        fontSize: 22.0,
                        color: const Color(0xff6C2C2C),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: AutoSizeText(
                      'Take care of your companion animals, because they cannot take care of themselves.',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 8,
                      style: GoogleFonts.alata(
                        color: const Color(0xffD19E9E),
                        fontSize: 22.0,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: AutoSizeText(
                      'Spay and neuter your companion animals (this can be done as early as four months of age). It will keep them from creating unwanted babies, plus sterilized pets are',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 8,
                      style: GoogleFonts.alata(
                        color: const Color(0xffB5C18E),
                        fontSize: 22.0,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: AutoSizeText(
                      'Treat pets like family members. Let them live indoors. Keep a dog in a puppy-proofed, warm, safe room in the house if he is not yet trained. Don\'t leave pets in a parked car, because they can die from the heat.',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 8,
                      style: GoogleFonts.alata(
                        color: const Color(0xffeaa989),
                        fontSize: 22.0,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: AutoSizeText(
                      'Clean up after your dog - it\'s easy.',
                      maxLines: 8,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.alata(
                        color: const Color(0xffd3a3a3),
                        fontSize: 22.0,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: AutoSizeText(
                      'Keep your furry family members healthy. Have them vaccinated against rabies and other diseases. Go to the vet every year - preventing illness costs less than treating it! Plus illness can cause behavioral problems.',
                      maxLines: 8,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.alata(
                        color: const Color(0xffB5C18E),
                        fontSize: 22.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          defaultButton(
            function: () {
              launchInBrowser(Uri.parse('https://www.leafanimals.com/friends/dahabanimalwelfare'));
            },
            text: 'Adopt now..',
            backgroundColor: const Color(0xff627254),
          ),
          const SizedBox(
            height: 10.0,
          ),
        ],
      ),
    );
  }
}
