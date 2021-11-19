import 'package:flutter/material.dart';
import 'package:catweb/Theme/ui_theme.dart';

import 'package:catweb/widgets/onboarding_dialog.dart';

class HomeScreen extends StatelessWidget {
  static const String id = '/home';
  const HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UItheme.richBlackFOGRA29,
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: const [
          Text(
            "CATWEB",
            style: TextStyle(
                fontFamily: 'LED',
                fontSize: 38,
                letterSpacing: 5,
                color: UItheme.viridianGreen,
                fontWeight: FontWeight.bold),
          ),
          OnboardingDialog()
        ],
      )),
    );
  }
}
