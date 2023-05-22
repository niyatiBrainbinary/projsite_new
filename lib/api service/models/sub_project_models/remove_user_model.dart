

import 'dart:convert';

RemoveUserModel removeUserModelFromJson(String str) => RemoveUserModel.fromJson(json.decode(str));

String removeUserModelToJson(RemoveUserModel data) => json.encode(data.toJson());

class RemoveUserModel {
  bool? success;
  int? userData;

  RemoveUserModel({
    this.success,
    this.userData,
  });

  factory RemoveUserModel.fromJson(Map<String, dynamic> json) => RemoveUserModel(
    success: json["success"],
    userData: json["user_data"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "user_data": userData,
  };
}
