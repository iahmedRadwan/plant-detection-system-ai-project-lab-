import 'package:ai_project_lab_pannon/shared/style/colors_manager.dart';
import 'package:ai_project_lab_pannon/shared/style/images_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../../shared/services/local/cache_helper.dart';
import '../../../auth/view/screens/auth_sign_in_screen.dart';
import '../../model/onBoarding_model.dart';
import '../components/custom_button.dart';
import '../components/custom_onboarding_animated_widget.dart';
import '../components/custom_skip_onboarding_button.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({Key? key}) : super(key: key);

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  final PageController _pageController = PageController(); //PageViewController
  int _currentIndex = 0; //PageViewCurrentIndex
  final List<BoardingModel> _boardingItems = [
    BoardingModel(
        title: "Diagnose Plant Health Instantly",
        subtitle:
            "Snap a photo of your plant, and our AI will identify diseases and provide actionable advice in seconds.",
        image: ImagesManagerHelper.onBoarding1),
    BoardingModel(
        title: "Ask and Learn Effortlessly",
        subtitle:
            "Type or speak your questions about plant care and get expert answers powered by advanced AI models.",
        image: ImagesManagerHelper.onBoarding2),
    BoardingModel(
        title: "Break Language Barriers",
        subtitle:
            "Get responses in your preferred language, making plant care accessible no matter where you are.",
        image: ImagesManagerHelper.onBoarding3),
  ]; //PageViewItems
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _currentIndex == 2
                ? CustomButton(
                    onPressed: () {
                      CacheHelper.saveData(key: "onBoarding", value: true)
                          .then((value) {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AuthSignInPage()),
                          (route) => false,
                        );
                      });
                    },
                    buttonText: "Get Started",
                  )
                : Row(
                    children: [
                      SmoothPageIndicator(
                        controller: _pageController,
                        count: _boardingItems.length,
                        effect: const ExpandingDotsEffect(
                          spacing: 6.0,
                          radius: 10.0,
                          dotWidth: 10.0,
                          dotHeight: 10.0,
                          expansionFactor: 3.8,
                          dotColor: Colors.grey,
                          activeDotColor: ColorManagerHelper.kMainColor,
                        ),
                      ),
                      const Spacer(),
                      FloatingActionButton(
                        onPressed: () {
                          _pageController.nextPage(
                            duration: const Duration(seconds: 2),
                            curve: Curves.fastLinearToSlowEaseIn,
                          );
                        },
                        backgroundColor: ColorManagerHelper.kMainColor,
                        child: const Icon(
                          IconlyBroken.arrowRight,
                          size: 18,
                          color: ColorManagerHelper.kWhiteColor,
                        ),
                      ),
                    ],
                  ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: ColorManagerHelper.kWhiteColor,
        elevation: 0.0,
        actions: [
          if (_currentIndex != 2)
            const Padding(
              padding: EdgeInsetsDirectional.only(end: 10),
              child: CustomSkipOnBoardingButton(),
            ),
        ],
      ),
      body: SafeArea(
        child: PageView.builder(
          physics: const BouncingScrollPhysics(),
          controller: _pageController,
          itemCount: _boardingItems.length,
          onPageChanged: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          itemBuilder: (context, index) {
            return Center(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),
                    CustomOnBoardingAnimatedWidget(
                      index: index,
                      delay: 200,
                      child: Image.asset(
                        _boardingItems[index].image,
                        width: size.width * 0.8,
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(height: 20),
                    CustomOnBoardingAnimatedWidget(
                      index: index,
                      delay: 800,
                      child: Text(
                        _boardingItems[index].title,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: ColorManagerHelper.kMainColor,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    CustomOnBoardingAnimatedWidget(
                      index: index,
                      delay: 1200,
                      child: Text(
                        _boardingItems[index].subtitle,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: ColorManagerHelper.kGreyColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
