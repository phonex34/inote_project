import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inote_project/router/app_pages.dart';

class SplashScreen extends StatelessWidget {
  // static Route route() {
  //   return MaterialPageRoute<void>(builder: (_) => SplashScreen());
  // }

  static GetPage get route {
    return GetPage(name: AppRoutes.SPLASH, page: () => SplashScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("SplashScreen")
          // Image.asset(
          //   'assets/bloc_logo_small.png',
          //   width: 150,
          // ),
          ),
    );
  }
}
