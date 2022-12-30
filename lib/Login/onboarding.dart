// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';
import 'package:gadgetinaja/Login/login_page.dart';
import 'package:gadgetinaja/services/local_storages.dart';
import 'package:gadgetinaja/services/styles.dart';
import 'package:wave_transition/wave_transition.dart';

class OnBoarding extends StatelessWidget {
  const OnBoarding({super.key});

  @override
  Widget build(BuildContext context) {
    // final Color kDarkBlueColor = Color(0xFF053149);

    return OnBoardingSlider(
      finishButtonText: 'Mulai',
      finishButtonTextStyle: Font.style(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      indicatorAbove: true,
      onFinish: () async {
        await Storages().setIntroSlider();
        Navigator.pushReplacement(
          context,
          WaveTransition(
            duration: const Duration(milliseconds: 500),
            child: const LoginScreen(),
            center: const FractionalOffset(0.5, 0),
          ),
        );
      },
      skipTextButton: Text(
        'Skip',
        style: Font.style(
          fontSize: 16,
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
      controllerColor: Colors.white,
      finishButtonColor: Colors.white54,
      totalPage: 3,
      headerBackgroundColor: Warna().first,
      pageBackgroundColor: Warna().first,
      background: [
        Container(
          margin: const EdgeInsets.only(top: 60),
          child:
              lottieAsset('onboard1', width: MediaQuery.of(context).size.width),
        ),
        Container(
          margin: const EdgeInsets.only(top: 60),
          child: lottieAsset('onboard2',
              width: MediaQuery.of(context).size.width * 0.9),
        ),
        Container(
          margin: const EdgeInsets.only(top: 40),
          child:
              lottieAsset('onboard3', width: MediaQuery.of(context).size.width),
        ),
      ],
      speed: 1,
      pageBodies: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Expanded(child: Container()),
              Text('Selamat Datang !',
                  textAlign: TextAlign.center,
                  style: Font.style(
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                      color: Colors.white)),
              const SizedBox(
                height: 20,
              ),
              Text('Dapatkan semua gadget berkualisan dan murah di GadgetinAja',
                  textAlign: TextAlign.center,
                  style: Font.style(
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
                      color: Colors.white)),
              const SizedBox(
                height: 20,
              )
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(child: Container()),
              Text('Berkualitas dan Lengkap',
                  textAlign: TextAlign.center,
                  style: Font.style(
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                      color: Colors.white)),
              const SizedBox(
                height: 20,
              ),
              Text('Hanya disini, Semua ada dan juga dijamin berkualitas',
                  textAlign: TextAlign.center,
                  style: Font.style(
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
                      color: Colors.white)),
              const SizedBox(
                height: 20,
              )
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(child: Container()),
              Text('Pengiriman Cepan dan Aman',
                  textAlign: TextAlign.center,
                  style: Font.style(
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                      color: Colors.white)),
              const SizedBox(
                height: 20,
              ),
              Text('Pengiriman memiliki waktu yang cepat dan aman',
                  textAlign: TextAlign.center,
                  style: Font.style(
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
                      color: Colors.white)),
              const SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ],
    );
  }
}
