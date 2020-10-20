import 'package:inote_project/modules/home/view/home_screen.dart';
import 'package:inote_project/modules/login/login.dart';
import 'package:inote_project/modules/page1/page1.dart';
import 'package:inote_project/modules/splash/splash_screen.dart';

part 'app_routes.dart';

// ignore: avoid_classes_with_only_static_members
class AppPages {
  static const INITIAL = AppRoutes.SPLASH;

  static final routes = [
    Page1Screen.route,
    SplashScreen.route,
    HomeScreen.route,
    LoginScreen.route
  ];
}
