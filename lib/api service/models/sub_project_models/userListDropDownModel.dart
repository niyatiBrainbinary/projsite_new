// To parse this JSON data, do
//
//     final userListDropDownModel = userListDropDownModelFromJson(jsonString);

import 'dart:convert';

UserListDropDownModel userListDropDownModelFromJson(String str) => UserListDropDownModel.fromJson(json.decode(str));

String userListDropDownModelToJson(UserListDropDownModel data) => json.encode(data.toJson());

class UserListDropDownModel {
  bool? success;
  List<Role>? roles;
  List<User>? users;

  UserListDropDownModel({
    this.success,
    this.roles,
    this.users,
  });

  factory UserListDropDownModel.fromJson(Map<String, dynamic> json) => UserListDropDownModel(
    success: json["success"],
    roles: json["roles"] == null ? [] : List<Role>.from(json["roles"]!.map((x) => Role.fromJson(x))),
    users: json["users"] == null ? [] : List<User>.from(json["users"]!.map((x) => User.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "roles": roles == null ? [] : List<dynamic>.from(roles!.map((x) => x.toJson())),
    "users": users == null ? [] : List<dynamic>.from(users!.map((x) => x.toJson())),
  };
}

class Role {
  String? id;
  String? role;
  bool? hasManageAccess;
  bool? hasApprovalAcccess;
  bool? hasCheckpointAccess;

  Role({
    this.id,
    this.role,
    this.hasManageAccess,
    this.hasApprovalAcccess,
    this.hasCheckpointAccess,
  });

  factory Role.fromJson(Map<String, dynamic> json) => Role(
    id: json["_id"],
    role: json["role"],
    hasManageAccess: json["has_manage_access"],
    hasApprovalAcccess: json["has_approval_acccess"],
    hasCheckpointAccess: json["has_checkpoint_access"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "role": role,
    "has_manage_access": hasManageAccess,
    "has_approval_acccess": hasApprovalAcccess,
    "has_checkpoint_access": hasCheckpointAccess,
  };
}

class User {
  String? id;
  String? organizationId;
  String? userId;
  String? roleId;
  DateTime? updatedAt;
  DateTime? createdAt;
  List<String?>? projects;
  List<String>? adminProjects;
  bool? emailNotify;
  bool? smsNotify;
  bool? weekdayNotification;
  String? firstName;
  String? lastName;
  String? phone;
  String? email;
  String? language;
  List<ProjectInfo>? projectInfos;
  String? roleName;
  bool? status;
  String? companyId;
  String? companyName;

  User({
    this.id,
    this.organizationId,
    this.userId,
    this.roleId,
    this.updatedAt,
    this.createdAt,
    this.projects,
    this.adminProjects,
    this.emailNotify,
    this.smsNotify,
    this.weekdayNotification,
    this.firstName,
    this.lastName,
    this.phone,
    this.email,
    this.language,
    this.projectInfos,
    this.roleName,
    this.status,
    this.companyId,
    this.companyName,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["_id"],
    organizationId: json["organization_id"],
    userId: json["user_id"],
    roleId: json["role_id"],
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    projects: json["projects"] == null ? [] : List<String?>.from(json["projects"]!.map((x) => x)),
    adminProjects: json["admin_projects"] == null ? [] : List<String>.from(json["admin_projects"]!.map((x) => x)),
    emailNotify: json["email_notify"],
    smsNotify: json["sms_notify"],
    weekdayNotification: json["weekday_notification"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    phone: json["phone"],
    email: json["email"],
    language: json["language"],
    projectInfos: json["project_infos"] == null ? [] : List<ProjectInfo>.from(json["project_infos"]!.map((x) => ProjectInfo.fromJson(x))),
    roleName: json["role_name"],
    status: json["status"],
    companyId: json["company_id"],
    companyName: json["company_name"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "organization_id": organizationId,
    "user_id": userId,
    "role_id": roleId,
    "updated_at": updatedAt?.toIso8601String(),
    "created_at": createdAt?.toIso8601String(),
    "projects": projects == null ? [] : List<dynamic>.from(projects!.map((x) => x)),
    "admin_projects": adminProjects == null ? [] : List<dynamic>.from(adminProjects!.map((x) => x)),
    "email_notify": emailNotify,
    "sms_notify": smsNotify,
    "weekday_notification": weekdayNotification,
    "first_name": firstName,
    "last_name": lastName,
    "phone": phone,
    "email": email,
    "language": language,
    "project_infos": projectInfos == null ? [] : List<dynamic>.from(projectInfos!.map((x) => x.toJson())),
    "role_name": roleName,
    "status": status,
    "company_id": companyId,
    "company_name": companyName,
  };
}

class ProjectInfo {
  String? id;
  String? projectName;
  String? organizationId;

  ProjectInfo({
    this.id,
    this.projectName,
    this.organizationId,
  });

  factory ProjectInfo.fromJson(Map<String, dynamic> json) => ProjectInfo(
    id: json["id"],
    projectName: json["project_name"],
    organizationId: json["organization_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "project_name": projectName,
    "organization_id": organizationId,
  };
}
