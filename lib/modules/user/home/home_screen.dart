import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled1/models/home/home_model.dart';
import 'package:untitled1/modules/user/home/adopt/adopt_screen.dart';
import 'package:untitled1/modules/user/home/donation/donation_screen.dart';
import 'package:untitled1/modules/user/home/dump/dump_screen.dart';
import 'package:untitled1/modules/user/home/request/request_screen.dart';
import 'package:untitled1/shared/components/components.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final List<HomeModel> items = [
    HomeModel(
      image: 'assets/images/list1.png',
      urlLink: 'https://www.youtube.com/',
    ),
    HomeModel(
      image: 'assets/images/list2.png',
      urlLink: 'https://www.youtube.com/',
    ),
    HomeModel(
      image: 'assets/images/list3.png',
      urlLink: 'https://www.youtube.com/',
    ),
    HomeModel(
      image: 'assets/images/list4.png',
      urlLink: 'https://www.youtube.com/',
    ),
    HomeModel(
      image: 'assets/images/list5.png',
      urlLink: 'https://www.youtube.com/',
    ),
    HomeModel(
      image: 'assets/images/list6.png',
      urlLink: 'https://www.youtube.com/',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        spacing: 20.0,
        children: [
          SizedBox(
            height: 201.0,
            child: Stack(
              alignment: AlignmentDirectional.bottomEnd,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: Container(
                    height: 170.0,
                    width: double.infinity,
                    padding: const EdgeInsetsDirectional.only(top: 20.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: const Color(0xff305973),
                    ),
                    child: Align(
                      alignment: AlignmentDirectional.topStart,
                      child: Text(
                        'Guide them to\na better life',
                        textAlign: TextAlign.start,
                        style: GoogleFonts.aclonica(
                          fontSize: 24.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                Image.asset('assets/images/hug.png', fit: BoxFit.cover),
              ],
            ),
          ),
          SizedBox(
            height: 80.0,
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemBuilder: (context, index) => buildItem(items[index]),
              itemCount: items.length,
            ),
          ),
          InkWell(
            onTap: ()
            {
              navigateTo(context, RequestScreen());
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Container(
                width: double.infinity,
                height: 150.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  color: const Color(0xffC79E9E),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(
                      width: 10.0,
                    ),
                    Text(
                      textAlign: TextAlign.center,
                      'Create a request to\nsend them to a better\nplace',
                      style: GoogleFonts.alata(
                        fontSize: 20.0,
                        color: const Color(0xff6C2C2C),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Image.asset(
                        'assets/images/dog.png',
                        height: 120.0,
                        width: 120.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          InkWell(
            onTap: (){
              navigateTo(context, const DonationScreen());
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Container(
                width: double.infinity,
                height: 150.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  color: const Color(0xffB5C18E),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(
                      width: 10.0,
                    ),
                    Column(
                      spacing: 10.0,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          textAlign: TextAlign.center,
                          'Want to help ??',
                          style: GoogleFonts.alata(
                            fontSize: 22.0,
                            color: const Color(0xff6C2C2C),
                          ),
                        ),
                        Text(
                          textAlign: TextAlign.center,
                          'By donating money to shelters,',
                          style: GoogleFonts.alata(
                            fontSize: 16.0,
                            color: const Color(0xff6C2C2C),
                          ),
                        ),
                        Text(
                          textAlign: TextAlign.center,
                          'you can help saving lives of animals',
                          style: GoogleFonts.alata(
                            fontSize: 16.0,
                            color: const Color(0xff6C2C2C),
                          ),
                        ),
                      ],
                    ),
                    Image.asset('assets/images/hearts.png'),
                  ],
                ),
              ),
            ),
          ),
          InkWell(
            onTap: ()
            {
              navigateTo(context, const AdoptScreen());
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Container(
                width: double.infinity,
                height: 150.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  color: const Color(0xffDED5C4),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(
                      width: 10.0,
                    ),
                    Text(
                      textAlign: TextAlign.center,
                      'If you want to adopt\nand tips for after\nadoption',
                      style: GoogleFonts.alata(
                        fontSize: 20.0,
                        color: const Color(0xff6C2C2C),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Image.asset(
                        'assets/images/hand_of_dog.png',
                        height: 120.0,
                        width: 120.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          InkWell(
            onTap: ()
            {
              navigateTo(context, const DumpScreen());
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Container(
                width: double.infinity,
                height: 150.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  color: const Color(0xffE7B49C),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(
                      width: 10.0,
                    ),
                    Text(
                      textAlign: TextAlign.center,
                      'Things to know before\nadopting a dog',
                      style: GoogleFonts.alata(
                        fontSize: 20.0,
                        color: const Color(0xff6C2C2C),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Image.asset(
                        'assets/images/food.png',
                        height: 120.0,
                        width: 120.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 30.0),
        ],
      ),
    );
  }

  Widget buildItem(HomeModel model) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: InkWell(
        onTap: () {
          launchInBrowser(Uri.parse(model.urlLink));
        },
        child: Container(
          padding: const EdgeInsets.all(12.0),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xffDED5C4),
          ),
          child: Image.asset(model.image, height: 32.0, width: 32.0),
        ),
      ),
    );
  }
}
