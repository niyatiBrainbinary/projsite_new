// To parse this JSON data, do
//
//     final updateOrganizationModel = updateOrganizationModelFromJson(jsonString);

import 'dart:convert';

UpdateOrganizationModel updateOrganizationModelFromJson(String str) => UpdateOrganizationModel.fromJson(json.decode(str));

String updateOrganizationModelToJson(UpdateOrganizationModel data) => json.encode(data.toJson());

class UpdateOrganizationModel {
  UpdateOrganizationModel({
    this.success,
    this.editResult,
    this.userInfo,
    this.role,
  });

  bool? success;
  int? editResult;
  UserInfo? userInfo;
  Role? role;

  factory UpdateOrganizationModel.fromJson(Map<String, dynamic> json) => UpdateOrganizationModel(
    success: json["success"],
    editResult: json["edit_result"],
    userInfo: UserInfo.fromJson(json["user_info"]),
    role: Role.fromJson(json["role"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "edit_result": editResult,
    "user_info": userInfo!.toJson(),
    "role": role!.toJson(),
  };
}

class Role {
  Role({
    this.id,
    this.role,
    this.hasManageAccess,
    this.hasApprovalAcccess,
    this.hasCheckpointAccess,
  });

  String? id;
  String? role;
  bool? hasManageAccess;
  bool? hasApprovalAcccess;
  bool? hasCheckpointAccess;

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
  UserInfo({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.organizationId,
    this.updatedAt,
    this.createdAt,
    this.locale,
    this.language,
    this.phone,
    this.roleId,
    this.isForgotPasswordIntitiated,
    this.userTerminals,
    this.companyId,
    this.mobileOrganizationId,
    this.userId,
    this.hasShipmentModule,
    this.hasLogisticsModule,
    this.projects,
    this.adminProjects,
    this.isAdmin,
    this.isProjectAdmin,
  });

  String? id;
  String? firstName;
  dynamic lastName;
  String? email;
  String? organizationId;
  DateTime? updatedAt;
  DateTime? createdAt;
  String? locale;
  String? language;
  String? phone;
  String? roleId;
  bool? isForgotPasswordIntitiated;
  List<String>? userTerminals;
  String? companyId;
  String? mobileOrganizationId;
  String? userId;
  bool? hasShipmentModule;
  bool? hasLogisticsModule;
  List<String>? projects;
  List<dynamic>? adminProjects;
  bool? isAdmin;
  bool? isProjectAdmin;

  factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
    id: json["_id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    email: json["email"],
    organizationId: json["organization_id"],
    updatedAt: DateTime.parse(json["updated_at"]),
    createdAt: DateTime.parse(json["created_at"]),
    locale: json["locale"],
    language: json["language"],
    phone: json["phone"],
    roleId: json["role_id"],
    isForgotPasswordIntitiated: json["is_forgot_password_intitiated"],
    userTerminals: List<String>.from(json["user_terminals"].map((x) => x)),
    companyId: json["company_id"],
    mobileOrganizationId: json["mobile_organization_id"],
    userId: json["user_id"],
    hasShipmentModule: json["has_shipment_module"],
    hasLogisticsModule: json["has_logistics_module"],
    projects: List<String>.from(json["projects"].map((x) => x)),
    adminProjects: List<dynamic>.from(json["admin_projects"].map((x) => x)),
    isAdmin: json["is_admin"],
    isProjectAdmin: json["is_project_admin"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "first_name": firstName,
    "last_name": lastName,
    "email": email,
    "organization_id": organizationId,
    "updated_at": updatedAt!.toIso8601String(),
    "created_at": createdAt!.toIso8601String(),
    "locale": locale,
    "language": language,
    "phone": phone,
    "role_id": roleId,
    "is_forgot_password_intitiated": isForgotPasswordIntitiated,
    "user_terminals": List<dynamic>.from(userTerminals!.map((x) => x)),
    "company_id": companyId,
    "mobile_organization_id": mobileOrganizationId,
    "user_id": userId,
    "has_shipment_module": hasShipmentModule,
    "has_logistics_module": hasLogisticsModule,
    "projects": List<dynamic>.from(projects!.map((x) => x)),
    "admin_projects": List<dynamic>.from(adminProjects!.map((x) => x)),
    "is_admin": isAdmin,
    "is_project_admin": isProjectAdmin,
  };
}
