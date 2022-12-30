import 'package:flutter/material.dart';
import 'package:gadgetinaja/services/styles.dart';
import 'package:gadgetinaja/services/icon_assets.dart';

class LoginScreenTopImage extends StatelessWidget {
  const LoginScreenTopImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: defaultPadding * 10),
        Row(
          children: [
            Expanded(
              child: Center(
                child: Assets.logo(
                  width: MediaQuery.of(context).size.width / 2,
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Text(
            "Login Page",
            textAlign: TextAlign.center,
            style: Font.style(fontSize: 16, fontWeight: FontWeight.bold),
            maxLines: 2,
            overflow: TextOverflow.clip,
          ),
        ),
        const SizedBox(height: defaultPadding),
      ],
    );
  }
}
