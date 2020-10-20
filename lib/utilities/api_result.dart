import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:inote_project/utilities/network_exception.dart';

part 'api_result.freezed.dart';

@freezed
abstract class ApiResult<T> with _$ApiResult<T> {
  const factory ApiResult.success({@required T data}) = Success<T>;
  const factory ApiResult.failure({@required NetworkExceptions error}) =
      Failure<T>;
}
