import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simplebankingapp/src/utils/constant.dart';
import 'package:simplebankingapp/src/views/pages/Auth/auth_screen.dart';
import 'package:simplebankingapp/src/views/pages/Dashboard/dashboard.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SharedPreferences? prefs;
  String? phoneNumber;

  @override
  void initState() {
    changeScreen();
    super.initState();
  }

  changeScreen() async {
    prefs = await SharedPreferences.getInstance();
    var checkNumber = prefs!.getString(USER_NUMBER);

    Timer(const Duration(milliseconds: 4000), () {
      if (checkNumber != null) {
        phoneNumber = checkNumber;
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => DashboardScreen(
                      number: phoneNumber,
                    )),
            (route) => false);
      } else {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const AuthScreen()),
            (route) => false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/veegil.png',
                  fit: BoxFit.cover,
                  height: 100,
                  width: 100,
                ),
              ],
            ),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            margin: const EdgeInsets.only(bottom: 30),
            child: SpinKitFadingCube(
              color: const Color(0xFF2c2c54).withOpacity(0.7),
              size: 35.0,
            ),
          )
        ]),
      ),
    ));
  }
}
