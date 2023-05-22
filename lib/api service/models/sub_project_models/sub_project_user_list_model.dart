// To parse this JSON data, do
//
//     final subProjectUserListModel = subProjectUserListModelFromJson(jsonString);

import 'dart:convert';

SubProjectUserListModel subProjectUserListModelFromJson(String str) => SubProjectUserListModel.fromJson(json.decode(str));

String subProjectUserListModelToJson(SubProjectUserListModel data) => json.encode(data.toJson());

class SubProjectUserListModel {
  bool? success;
  List<SubProjectUser>? subProjectUsers;

  SubProjectUserListModel({
    this.success,
    this.subProjectUsers,
  });

  factory SubProjectUserListModel.fromJson(Map<String, dynamic> json) => SubProjectUserListModel(
    success: json["success"],
    subProjectUsers: List<SubProjectUser>.from(json["sub_project_users"].map((x) => SubProjectUser.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "sub_project_users": List<dynamic>.from(subProjectUsers!.map((x) => x.toJson())),
  };
}

class SubProjectUser {
  String? id;
  String? subProjectId;
  String? userId;
  String? organizationId;
  DateTime? updatedAt;
  DateTime? createdAt;
  String? firstName;
  String? lastName;

  SubProjectUser({
    this.id,
    this.subProjectId,
    this.userId,
    this.organizationId,
    this.updatedAt,
    this.createdAt,
    this.firstName,
    this.lastName,
  });

  factory SubProjectUser.fromJson(Map<String, dynamic> json) => SubProjectUser(
    id: json["_id"],
    subProjectId: json["sub_project_id"],
    userId: json["user_id"],
    organizationId: json["organization_id"],
    updatedAt: DateTime.parse(json["updated_at"]),
    createdAt: DateTime.parse(json["created_at"]),
    firstName: json["first_name"],
    lastName: json["last_name"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "sub_project_id": subProjectId,
    "user_id": userId,
    "organization_id": organizationId,
    "updated_at": updatedAt!.toIso8601String(),
    "created_at": createdAt!.toIso8601String(),
    "first_name": firstName,
    "last_name": lastName,
  };
}
