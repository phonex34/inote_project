import 'package:get/get.dart';
import 'package:inote_project/modules/page1/page1.dart';

part 'app_routes.dart';

// ignore: avoid_classes_with_only_static_members
class AppPages {
  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: Routes.HOME,
      page: () => Page1Screen(),
      binding: BindingsBuilder(() => {
            // Get.lazyPut<DetailsController>(() => DetailsController());
          }),
    ),
  ];
}
