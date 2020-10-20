import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:inote_project/models/generic_pagination.dart';
import 'package:inote_project/models/user.dart';
import 'package:inote_project/utilities/api_result.dart';
import 'package:inote_project/utilities/network_exception.dart';

class PageRepository {
  final dio = Get.find<Dio>();
  Future<ApiResult<GenericPagination<User>>> getAllListNews() async {
    try {
      Response response = await dio.get("public-api/users");
      final obj =
          GenericPagination<User>.fromJson(response.data, User.fromJson);
      print(response.data);
      return ApiResult.success(data: obj);
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  Future<GenericPagination<User>> getAllListNewsFailed() async {
    Response response = await dio.get("public-api/users");
    final obj = GenericPagination<User>.fromJson(response.data, User.fromJson);
    return obj;
  }

  Future<GenericPagination<User>> postData() async {
    Response response = await dio.post("public-api/users");
    final obj = GenericPagination<User>.fromJson(response.data, User.fromJson);
    return obj;
  }
}
