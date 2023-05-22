// To parse this JSON data, do
//
//     final notificationModel = notificationModelFromJson(jsonString);

import 'dart:convert';

NotificationModel notificationModelFromJson(String str) => NotificationModel.fromJson(json.decode(str));

String notificationModelToJson(NotificationModel data) => json.encode(data.toJson());

class NotificationModel {
  NotificationModel({
    required this.success,
    required this.account,
  });

  bool success;
  ProfileSettingData? account;

  factory NotificationModel.fromJson(Map<String, dynamic> json) => NotificationModel(
    success: json["success"] == null ? null : json["success"],
    account: json["account"] == null ? null : ProfileSettingData.fromJson(json["account"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success == null ? null : success,
    "account": account == null ? null : account?.toJson(),
  };
}

class ProfileSettingData {
  ProfileSettingData({
    required this.id,
    required this.organizationId,
    required this.userId,
    required this.roleId,
    required this.updatedAt,
    required this.createdAt,
    required this.projects,
    required this.companyId,
    required this.emailNotify,
    required this.smsNotify,
  });

  String id;
  String organizationId;
  String userId;
  String roleId;
  DateTime? updatedAt;
  DateTime? createdAt;
  List<String>? projects;
  String companyId;
  bool emailNotify;
  bool smsNotify;

  factory ProfileSettingData.fromJson(Map<String, dynamic> json) => ProfileSettingData(
    id: json["_id"] == null ? null : json["_id"],
    organizationId: json["organization_id"] == null ? null : json["organization_id"],
    userId: json["user_id"] == null ? null : json["user_id"],
    roleId: json["role_id"] == null ? null : json["role_id"],
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    projects: json["projects"] == null ? null : List<String>.from(json["projects"].map((x) => x)),
    companyId: json["company_id"] == null ? null : json["company_id"],
    emailNotify: json["email_notify"] == null ? null : json["email_notify"],
    smsNotify: json["sms_notify"] == null ? null : json["sms_notify"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id == null ? null : id,
    "organization_id": organizationId == null ? null : organizationId,
    "user_id": userId == null ? null : userId,
    "role_id": roleId == null ? null : roleId,
    "updated_at": updatedAt == null ? null : updatedAt?.toIso8601String(),
    "created_at": createdAt == null ? null : createdAt?.toIso8601String(),
    "projects": projects == null ? null : List<dynamic>.from(projects!.map((x) => x)),
    "company_id": companyId == null ? null : companyId,
    "email_notify": emailNotify == null ? null : emailNotify,
    "sms_notify": smsNotify == null ? null : smsNotify,
  };
}
