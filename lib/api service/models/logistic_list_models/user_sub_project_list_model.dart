

import 'dart:convert';

UserSubProjectListModel userSubProjectListModelFromJson(String str) => UserSubProjectListModel.fromJson(json.decode(str));

String userSubProjectListModelToJson(UserSubProjectListModel data) => json.encode(data.toJson());

class UserSubProjectListModel {
  UserSubProjectListModel({
    required this.success,
    required this.userSubProjects,
    required this.subProjects,
  });

  bool success;
  List<UserSubProject>? userSubProjects;
  List<SubProject>? subProjects;

  factory UserSubProjectListModel.fromJson(Map<String, dynamic> json) => UserSubProjectListModel(
    success: json["success"] == null ? null : json["success"],
    userSubProjects: json["user_sub_projects"] == null ? null : List<UserSubProject>.from(json["user_sub_projects"].map((x) => UserSubProject.fromJson(x))),
    subProjects: json["sub_projects"] == null ? null : List<SubProject>.from(json["sub_projects"].map((x) => SubProject.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success == null ? null : success,
    "user_sub_projects": userSubProjects == null ? null : List<dynamic>.from(userSubProjects!.map((x) => x.toJson())),
    "sub_projects": subProjects == null ? null : List<dynamic>.from(subProjects!.map((x) => x.toJson())),
  };
}

class SubProject {
  SubProject({
    required this.id,
    required this.subProjectName,
    required this.projectId,
    required this.organizationId,
    required this.isDeleted,
    required this.updatedAt,
    required this.createdAt,
  });

  String id;
  String subProjectName;
  String projectId;
  String organizationId;
  bool isDeleted;
  DateTime? updatedAt;
  DateTime? createdAt;

  factory SubProject.fromJson(Map<String, dynamic> json) => SubProject(
    id: json["_id"] == null ? null : json["_id"],
    subProjectName: json["sub_project_name"] == null ? null : json["sub_project_name"],
    projectId: json["project_id"] == null ? null : json["project_id"],
    organizationId: json["organization_id"] == null ? null : json["organization_id"],
    isDeleted: json["is_deleted"] == null ? null : json["is_deleted"],
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id == null ? null : id,
    "sub_project_name": subProjectName == null ? null : subProjectName,
    "project_id": projectId == null ? null : projectId,
    "organization_id": organizationId == null ? null : organizationId,
    "is_deleted": isDeleted == null ? null : isDeleted,
    "updated_at": updatedAt == null ? null : updatedAt?.toIso8601String(),
    "created_at": createdAt == null ? null : createdAt?.toIso8601String(),
  };
}

class UserSubProject {
  UserSubProject({
    required this.id,
    required this.subProjectId,
    required this.userId,
    required this.organizationId,
    required this.updatedAt,
    required this.createdAt,
    required this.subProjectName,
  });

  String id;
  String subProjectId;
  String userId;
  String organizationId;
  DateTime? updatedAt;
  DateTime? createdAt;
  String subProjectName;

  factory UserSubProject.fromJson(Map<String, dynamic> json) => UserSubProject(
    id: json["_id"] == null ? null : json["_id"],
    subProjectId: json["sub_project_id"] == null ? null : json["sub_project_id"],
    userId: json["user_id"] == null ? null : json["user_id"],
    organizationId: json["organization_id"] == null ? null : json["organization_id"],
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    subProjectName: json["sub_project_name"] == null ? null : json["sub_project_name"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id == null ? null : id,
    "sub_project_id": subProjectId == null ? null : subProjectId,
    "user_id": userId == null ? null : userId,
    "organization_id": organizationId == null ? null : organizationId,
    "updated_at": updatedAt == null ? null : updatedAt?.toIso8601String(),
    "created_at": createdAt == null ? null : createdAt?.toIso8601String(),
    "sub_project_name": subProjectName == null ? null : subProjectName,
  };
}
