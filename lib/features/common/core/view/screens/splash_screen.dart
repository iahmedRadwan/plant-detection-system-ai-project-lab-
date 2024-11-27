import 'package:ai_project_lab_pannon/shared/style/fonts_manager.dart';
import 'package:flutter/material.dart';

import '../../../../../shared/style/images_manager.dart';
import 'onbording_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const OnBoardingPage()));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(14.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Spacer(),
                Image(
                  image: AssetImage(ImagesManagerHelper.signIn),
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.contain,
                ),
                Spacer(),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 30.0),
                  child: Text(
                    "Powered By Ahmed Radwan",
                    style: FontsManagerHelper.caption,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
