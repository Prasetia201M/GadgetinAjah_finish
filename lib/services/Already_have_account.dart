import 'package:flutter/material.dart';
import 'package:gadgetinaja/services/styles.dart';

class AlreadyHaveAnAccountCheck extends StatelessWidget {
  final bool login;
  final Function? press;
  const AlreadyHaveAnAccountCheck({
    Key? key,
    this.login = true,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          login ? "Belum punya akun ? " : "Sudah punya akun ? ",
          style: Font.style(),
        ),
        GestureDetector(
          onTap: press as void Function()?,
          child: Text(
            login ? "Sign Up" : "Sign In",
            style: Font.style(
              color: Warna().icon,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
