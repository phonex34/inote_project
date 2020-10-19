import 'package:get/get.dart';
import 'package:inote_project/repository/dio_repository.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> configureDependencies() async {
  //  register injection here

  //SharedPreferences [<SharedPreferences>]
  await Get.putAsync<SharedPreferences>(() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('counter', 12345);
    return prefs;
  });

  //Dio repository
  // Get.put(DioRepository().dio, permanent: true);
  Get.put(DioRepository().dio, permanent: true);
  //Logger [<SharedPreferences>,], [PrettyPrinter]
  Get.lazyPut<Logger>(
      () => Logger(printer: PrettyPrinter(colors: GetPlatform.isAndroid)),
      fenix: true);
}
