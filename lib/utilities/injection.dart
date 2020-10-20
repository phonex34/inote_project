import 'package:get/get.dart';
import 'package:inote_project/repository/dio_repository.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:loading_hud/loading_hud.dart';
import 'package:flutter/material.dart';

Future<void> configureDependencies() async {
  //  register injection here

  //SharedPreferences [<SharedPreferences>]
  await Get.putAsync<SharedPreferences>(() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('counter', 12345);
    return prefs;
  });

  //Dio repository
  Get.put(DioRepository().dio, permanent: true);

  //Logger [<SharedPreferences>,], [PrettyPrinter]
  Get.lazyPut<Logger>(
      () => Logger(printer: PrettyPrinter(colors: GetPlatform.isAndroid)),
      fenix: true);

  //LoadingHud [<SharedPreferences>,], [PrettyPrinter]
  Get.lazyPut<LoadingHud<Text>>(
      () => LoadingHud(Get.context,
          cancelable: true, // Cancelable when pressing Android back key
          canceledOnTouchOutside:
              true, // Cancelable when touch outside of the LoadingHud
          dimBackground: true, // Dimming background when LoadingHud is showing
          hudColor: Color(0x99000000), // Color of the ProgressHud
          indicator: DefaultLoadingIndicator(
            color: Colors.white,
          ),
          iconSuccess: Icon(
            // Success icon
            Icons.done,
            color: Colors.white,
          ),
          iconError: Icon(
            // Error icon
            Icons.error,
            color: Colors.white,
          )),
      fenix: true);
}
