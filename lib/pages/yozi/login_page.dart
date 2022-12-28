import 'package:flutter/material.dart';
import 'package:gadgetinaja/pages/yozi/Login/login_form.dart';
import 'package:gadgetinaja/pages/yozi/Login/login_screen_top_image.dart';
import 'package:gadgetinaja/services/styles.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Warna().primer,
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const <Widget>[
              LoginScreenTopImage(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25),
                child: LoginForm(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
