import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:untitled1/modules/user/login/login_screen.dart';
import 'package:untitled1/shared/components/components.dart';
import 'package:untitled1/shared/network/local/cache_helper.dart';

class BoardingModel {
  final Color? firstColor;
  final Color? secondColor;
  final String image;
  final String title;
  final String body;

  BoardingModel({
    required this.title,
    required this.image,
    required this.body,
    required this.firstColor,
    required this.secondColor,
  });
}

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  OnBoardingScreenState createState() => OnBoardingScreenState();
}

class OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardController = PageController();

  List<BoardingModel> boarding = [
    BoardingModel(
      firstColor: const Color(0xffAF6B58),
      secondColor: const Color(0xffD9D9D9),
      image: 'assets/images/onBoarding1.png',
      title: 'Congratulations, Rescue Ranger!',
      body:
          'You’ve taken your first step in saving a dog’s life! Now, just snap a photo of the dog, and we’ll handle the rest. getting them to the right place where they’ll be safe and cared for. Thank you for making a difference!',
    ),
    BoardingModel(
      firstColor: const Color(0xffA5B68D),
      secondColor: const Color(0xffD9D9D9),
      image: 'assets/images/onBoarding2.png',
      title: 'Thinking about adopting a dog?',
      body:
          'We’re here for you! We’ll provide helpful tips before adoption and even more guidance to make sure you’re ready for anything. Let’s make this journey amazing together!',
    ),
    BoardingModel(
      firstColor: const Color(0xffAF6B58),
      secondColor: const Color(0xffA5B68D),
      image: 'assets/images/onBoarding3.png',
      title: 'Can’t adopt right now?',
      body:
          'No worries! You can still make a difference by donating. Every contribution helps us care for more dogs in need. Together, we can make a big impact!',
    ),
  ];

  bool isLast = false;

  void submit() {
    CacheHelper.saveData(key: 'onBoarding', value: true).then((value) {
      if (value) {
        navigateAndFinish(context, LoginScreen());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 15.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                physics: const BouncingScrollPhysics(),
                controller: boardController,
                onPageChanged: (int index) {
                  if (index == boarding.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    setState(() {
                      isLast = false;
                    });
                  }
                },
                itemBuilder:
                    (context, index) => buildBoardingItem(boarding[index]),
                itemCount: boarding.length,
              ),
            ),
            const SizedBox(height: 40.0),
            SmoothPageIndicator(
              controller: boardController,
              effect: const ExpandingDotsEffect(
                dotHeight: 10,
                expansionFactor: 4,
                dotWidth: 10,
                spacing: 5.0,
                activeDotColor: Color(0xffAF6B58),
              ),
              count: boarding.length,
            ),
            const SizedBox(height: 40.0),
            Align(
              alignment: AlignmentDirectional.bottomEnd,
              child: FloatingActionButton(
                onPressed: () {
                  if (isLast) {
                    submit();
                  } else {
                    boardController.nextPage(
                      duration: const Duration(milliseconds: 750),
                      curve: Curves.fastLinearToSlowEaseIn,
                    );
                  }
                },
                child: const Icon(Icons.arrow_forward_ios),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBoardingItem(BoardingModel model) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 30.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 175.0,
              backgroundColor: model.firstColor,
              child: CircleAvatar(
                radius: 110.0,
                backgroundColor: model.secondColor,
                child: Image(
                  image: AssetImage(model.image),
                  height: 200.0,
                  width: 200.0,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 30.0),
        Text(
          model.title,
          style: const TextStyle(fontSize: 20.0, color: Color(0xff6C2C2C)),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 30.0),
        Text(
          model.body,
          style: const TextStyle(fontSize: 14.0, color: Color(0xff6C2C2C)),
          maxLines: 4,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    ),
  );
}
