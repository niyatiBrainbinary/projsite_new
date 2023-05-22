// To parse this JSON data, do
//
//     final assignUserModel = assignUserModelFromJson(jsonString);

import 'dart:convert';

AssignUserModel assignUserModelFromJson(String str) => AssignUserModel.fromJson(json.decode(str));

String assignUserModelToJson(AssignUserModel data) => json.encode(data.toJson());

class AssignUserModel {
  bool? success;
  UserData? userData;

  AssignUserModel({
    this.success,
    this.userData,
  });

  factory AssignUserModel.fromJson(Map<String, dynamic> json) => AssignUserModel(
    success: json["success"],
    userData: json["user_data"] == null ? null : UserData.fromJson(json["user_data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "user_data": userData?.toJson(),
  };
}

class UserData {
  String? subProjectId;
  String? userId;
  String? organizationId;
  DateTime? updatedAt;
  DateTime? createdAt;
  String? id;
  String? firstName;
  String? lastName;

  UserData({
    this.subProjectId,
    this.userId,
    this.organizationId,
    this.updatedAt,
    this.createdAt,
    this.id,
    this.firstName,
    this.lastName,
  });

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
    subProjectId: json["sub_project_id"],
    userId: json["user_id"],
    organizationId: json["organization_id"],
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    id: json["_id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
  );

  Map<String, dynamic> toJson() => {
    "sub_project_id": subProjectId,
    "user_id": userId,
    "organization_id": organizationId,
    "updated_at": updatedAt?.toIso8601String(),
    "created_at": createdAt?.toIso8601String(),
    "_id": id,
    "first_name": firstName,
    "last_name": lastName,
  };
}
