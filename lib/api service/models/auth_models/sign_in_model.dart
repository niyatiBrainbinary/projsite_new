// To parse this JSON data, do
//
//     final signInModel = signInModelFromJson(jsonString);

import 'dart:convert';

SignInModel signInModelFromJson(String str) => SignInModel.fromJson(json.decode(str));

String signInModelToJson(SignInModel data) => json.encode(data.toJson());

class SignInModel {
  UserInfo? userInfo;
  Role? role;
  List<UserOrganization>? userOrganization;
  String? token;
  bool? success;

  SignInModel({
    this.userInfo,
    this.role,
    this.userOrganization,
    this.token,
    this.success,
  });

  factory SignInModel.fromJson(Map<String, dynamic> json) => SignInModel(
    userInfo: json["user_info"] == null ? null : UserInfo.fromJson(json["user_info"]),
    role: json["role"] == null ? null : Role.fromJson(json["role"]),
    userOrganization: json["user_organization"] == null ? [] : List<UserOrganization>.from(json["user_organization"]!.map((x) => UserOrganization.fromJson(x))),
    token: json["token"],
    success: json["success"],
  );

  Map<String, dynamic> toJson() => {
    "user_info": userInfo?.toJson(),
    "role": role?.toJson(),
    "user_organization": userOrganization == null ? [] : List<dynamic>.from(userOrganization!.map((x) => x.toJson())),
    "token": token,
    "success": success,
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

class UserInfo {
  String? id;
  String? firstName;
  String? lastName;
  String? phone;
  String? email;
  String? organizationId;
  DateTime? updatedAt;
  DateTime? createdAt;
  String? companyId;
  String? roleId;
  String? language;
  String? locale;
  List<String>? userTerminals;
  String? userId;
  String? mobileOrganizationId;
  List<String>? projects;
  List<String>? adminProjects;
  bool? isAdmin;
  bool? isProjectAdmin;

  UserInfo({
    this.id,
    this.firstName,
    this.lastName,
    this.phone,
    this.email,
    this.organizationId,
    this.updatedAt,
    this.createdAt,
    this.companyId,
    this.roleId,
    this.language,
    this.locale,
    this.userTerminals,
    this.userId,
    this.mobileOrganizationId,
    this.projects,
    this.adminProjects,
    this.isAdmin,
    this.isProjectAdmin,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
    id: json["_id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    phone: json["phone"],
    email: json["email"],
    organizationId: json["organization_id"],
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    companyId: json["company_id"],
    roleId: json["role_id"],
    language: json["language"],
    locale: json["locale"],
    userTerminals: json["user_terminals"] == null ? [] : List<String>.from(json["user_terminals"]!.map((x) => x)),
    userId: json["user_id"],
    mobileOrganizationId: json["mobile_organization_id"],
    projects: json["projects"] == null ? [] : List<String>.from(json["projects"]!.map((x) => x)),
    adminProjects: json["admin_projects"] == null ? [] : List<String>.from(json["admin_projects"]!.map((x) => x)),
    isAdmin: json["is_admin"],
    isProjectAdmin: json["is_project_admin"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "first_name": firstName,
    "last_name": lastName,
    "phone": phone,
    "email": email,
    "organization_id": organizationId,
    "updated_at": updatedAt?.toIso8601String(),
    "created_at": createdAt?.toIso8601String(),
    "company_id": companyId,
    "role_id": roleId,
    "language": language,
    "locale": locale,
    "user_terminals": userTerminals == null ? [] : List<dynamic>.from(userTerminals!.map((x) => x)),
    "user_id": userId,
    "mobile_organization_id": mobileOrganizationId,
    "projects": projects == null ? [] : List<dynamic>.from(projects!.map((x) => x)),
    "admin_projects": adminProjects == null ? [] : List<dynamic>.from(adminProjects!.map((x) => x)),
    "is_admin": isAdmin,
    "is_project_admin": isProjectAdmin,
  };
}

class UserOrganization {
  String? organizationId;
  String? organizationName;

  UserOrganization({
    this.organizationId,
    this.organizationName,
  });

  factory UserOrganization.fromJson(Map<String, dynamic> json) => UserOrganization(
    organizationId: json["organization_id"],
    organizationName: json["organization_name"],
  );

  Map<String, dynamic> toJson() => {
    "organization_id": organizationId,
    "organization_name": organizationName,
  };
}
