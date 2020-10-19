import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:inote_project/models/generic_pagination.dart';
import 'package:inote_project/models/user.dart';
import 'package:inote_project/repository/dio_repository.dart';

class PageRepository {
  final dio = Get.find<Dio>();
  Future<GenericPagination<User>> getAllListNews() async {
    Response response = await dio.get("public-api/users");
    final obj = GenericPagination<User>.fromJson(response.data, User.fromJson);
    print(response.data);
    return obj;
  }
}
