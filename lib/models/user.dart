import 'package:json_annotation/json_annotation.dart';
part 'user.g.dart';

@JsonSerializable()
class User {
  int id;
  String name;
  String email;
  String gender;
  String status;
  String createdAt;
  String updatedAt;
  User(
      {this.id,
      this.name,
      this.email,
      this.gender,
      this.status,
      this.createdAt,
      this.updatedAt});

  static User fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
