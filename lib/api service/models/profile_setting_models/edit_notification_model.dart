// To parse this JSON data, do
//
//     final editNotificationModel = editNotificationModelFromJson(jsonString);

import 'dart:convert';

EditNotificationModel editNotificationModelFromJson(String str) => EditNotificationModel.fromJson(json.decode(str));

String editNotificationModelToJson(EditNotificationModel data) => json.encode(data.toJson());

class EditNotificationModel {
  EditNotificationModel({
    required this.success,
    required this.account,
  });

  bool success;
  Account? account;

  factory EditNotificationModel.fromJson(Map<String, dynamic> json) => EditNotificationModel(
    success: json["success"] == null ? null : json["success"],
    account: json["account"] == null ? null : Account.fromJson(json["account"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success == null ? null : success,
    "account": account == null ? null : account?.toJson(),
  };
}

class Account {
  Account({
    required this.id,
    required this.userId,
    required this.organizationId,
    required this.roleId,
    required this.updatedAt,
    required this.createdAt,
    required this.emailNotify,
    required this.smsNotify,
  });

  String id;
  String userId;
  String organizationId;
  dynamic roleId;
  DateTime? updatedAt;
  DateTime? createdAt;
  bool emailNotify;
  bool smsNotify;

  factory Account.fromJson(Map<String, dynamic> json) => Account(
    id: json["_id"] == null ? null : json["_id"],
    userId: json["user_id"] == null ? null : json["user_id"],
    organizationId: json["organization_id"] == null ? null : json["organization_id"],
    roleId: json["role_id"],
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    emailNotify: json["email_notify"] == null ? null : json["email_notify"],
    smsNotify: json["sms_notify"] == null ? null : json["sms_notify"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id == null ? null : id,
    "user_id": userId == null ? null : userId,
    "organization_id": organizationId == null ? null : organizationId,
    "role_id": roleId,
    "updated_at": updatedAt == null ? null : updatedAt?.toIso8601String(),
    "created_at": createdAt == null ? null : createdAt?.toIso8601String(),
    "email_notify": emailNotify == null ? null : emailNotify,
    "sms_notify": smsNotify == null ? null : smsNotify,
  };
}
