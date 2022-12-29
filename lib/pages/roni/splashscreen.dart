import 'package:flutter/material.dart';
import 'package:gadgetinaja/pages/yozi/login_page.dart';
import 'package:gadgetinaja/services/icon_assets.dart';
import 'package:gadgetinaja/services/local_storages.dart';
import 'package:gadgetinaja/services/styles.dart';
import 'package:page_transition/page_transition.dart';
import 'onboarding.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Warna().first,
      body: SafeArea(
        child: 
        Container(
          margin: const EdgeInsets.all(30),
          padding: const EdgeInsets.all(50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Assets.logo(),
              SizedBox(
                height: MediaQuery.of(context).size.height / 4,
                child: lottieAsset('loading', controller: _controller,
                    onLoaded: (compos) {
                  _controller
                    ..duration = const Duration(seconds: 4)
                    ..forward().then((value) {
                      Navigator.pushReplacement(
                          context,
                          PageTransition(
                            type: PageTransitionType.fade,
                            child: Storages.getIntroSlider() == false
                                ? const OnBoarding()
                                : const LoginScreen(),
                          ));
                    });
                }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
