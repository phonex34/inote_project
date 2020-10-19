import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:inote_project/repository/dio_repository.dart';

class PageRepository {
  final dio = Get.find<Dio>();
  Future<void> getAllListNews(int page, int perPage) async {
    Response response = await dio.get("public-api/users");
    // final obj = NewsPaging.fromJson(response.data);
    print(response.data);
    return;
  }
}
