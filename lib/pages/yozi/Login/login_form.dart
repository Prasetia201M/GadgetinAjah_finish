// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:gadgetinaja/API/json_future/json_future.dart';
import 'package:gadgetinaja/API/object_class/auth.dart';
import 'package:gadgetinaja/homepage/integrate.dart';
import 'package:gadgetinaja/services/local_storages.dart';
import 'package:gadgetinaja/services/styles.dart';
//import 'package:gadgetinaja/homepage/homepage.dart';
import 'package:gadgetinaja/pages/yozi/register_page.dart';
import 'package:page_transition/page_transition.dart';
import 'package:wave_transition/wave_transition.dart';
import '../../../services/already_have_an_account_acheck.dart';
import 'package:gadgetinaja/services/icon_assets.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool obscureText = true;
  @override
  void initState() {
    email.text = Storages.getEmail();
    password.text = Storages.getPassword();
    super.initState();
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          TextFormField(
            controller: email,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            cursorColor: Warna().font,
            style: Font.style(),
            onChanged: (value) async {
              if (value.isEmpty) {
                await Storages().setEmail(email: value);
                await Storages().setPassword(password: value);
              }
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              hintText: "Email",
              hintStyle: Font.style(fontSize: 16, color: Colors.grey),
              prefixIcon: Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: Assets.registerIcon('sms'),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: TextFormField(
              controller: password,
              textInputAction: TextInputAction.done,
              obscureText: obscureText,
              cursorColor: Warna().first,
              style: Font.style(),
              onChanged: (value) async {
                if (value.isEmpty) {
                  await Storages().setEmail(email: value);
                  await Storages().setPassword(password: value);
                }
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                hintText: "Password",
                hintStyle: Font.style(fontSize: 16, color: Colors.grey),
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      obscureText = !obscureText;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(defaultPadding),
                    child: Assets.registerIcon(
                        obscureText != true ? 'eye' : 'eyeoff'),
                  ),
                ),
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: Assets.registerIcon('lock'),
                ),
              ),
            ),
          ),
          const SizedBox(height: defaultPadding),
          Hero(
            tag: "login_btn",
            child: ElevatedButton(
              onPressed: () async {
                Login login = await JsonFuture()
                    .login(email: email.text, password: password.text);
                snackBar(context, text: login.info!);
                if (login.info == 'Login Berhasil') {
                  await Notifikasi.notif(
                    title: 'Login Akun',
                    body: 'Login ke Akun ${login.data!.user!.email!} Berhasil',
                  );
                  await Storages().setPassword(password: password.text);
                  Navigator.pushReplacement(
                    context,
                    WaveTransition(
                      duration: const Duration(milliseconds: 100),
                      child: const IntegrateAPI(),
                      center: const FractionalOffset(0.5, 0),
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                backgroundColor: Warna().icon,
                fixedSize: const Size(500, 50),
              ),
              child: Text(
                "Masuk".toUpperCase(),
                style: Font.style(
                  fontSize: 15,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: defaultPadding * 2),
          AlreadyHaveAnAccountCheck(
            press: () {
              Navigator.push(
                context,
                PageTransition(type: PageTransitionType.leftToRight, child: SignUpScreen())
                
              );
            },
          ),
        ],
      ),
    );
  }
}
