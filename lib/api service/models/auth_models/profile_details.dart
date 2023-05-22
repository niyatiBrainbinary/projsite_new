class ProfileDetailsModel {
  ProfileDetailsModel({
    this.success,
    this.roles,
    this.user,
  });

  bool? success;
  List<Roles>? roles;
  User? user;

  factory ProfileDetailsModel.fromJson(Map<String, dynamic> json) => ProfileDetailsModel(
    success: json["success"] == null ? null : json["success"],
    roles: json["roles"] == null ? null : List<Roles>.from(json["roles"].map((x) => Roles.fromJson(x))),
    user: json["user"] == null ? null : User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success == null ? null : success,
    "roles": roles == null ? null : List<dynamic>.from(roles!.map((x) => x.toJson())),
    "user": user == null ? null : user!.toJson(),
  };
}

class Roles {
  Roles({
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

  factory Roles.fromJson(Map<String, dynamic> json) => Roles(
    id: json["_id"] == null ? null : json["_id"],
    role: json["role"] == null ? null : json["role"],
    hasManageAccess: json["has_manage_access"] == null ? null : json["has_manage_access"],
    hasApprovalAcccess: json["has_approval_acccess"] == null ? null : json["has_approval_acccess"],
    hasCheckpointAccess: json["has_checkpoint_access"] == null ? null : json["has_checkpoint_access"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id == null ? null : id,
    "role": role == null ? null : role,
    "has_manage_access": hasManageAccess == null ? null : hasManageAccess,
    "has_approval_acccess": hasApprovalAcccess == null ? null : hasApprovalAcccess,
    "has_checkpoint_access": hasCheckpointAccess == null ? null : hasCheckpointAccess,
  };
}

class User {
  User({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.password,
    this.roleId,
    this.organizationId,
    this.updatedAt,
    this.createdAt,
    this.phone,
    this.language,
    this.isForgotPasswordIntitiated,
    this.companyId,
    this.locale,
    this.status,
    this.projects,
    this.adminProjects,
    this.projectInfos,
  });

  String? id;
  String? firstName;
  String? lastName;
  String? email;
  String? password;
  String? roleId;
  String? organizationId;
  DateTime? updatedAt;
  DateTime? createdAt;
  String? phone;
  String? language;
  bool? isForgotPasswordIntitiated;
  String? companyId;
  String? locale;
  dynamic status;
  List<String>? projects;
  dynamic adminProjects;
  List<ProjectInfo>? projectInfos;

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["_id"] == null ? null : json["_id"],
    firstName: json["first_name"] == null ? null : json["first_name"],
    lastName: json["last_name"] == null ? "null" : json["last_name"],
    email: json["email"] == null ? null : json["email"],
    password: json["password"] == null ? null : json["password"],
    roleId: json["role_id"] == null ? null : json["role_id"],
    organizationId: json["organization_id"] == null ? null : json["organization_id"],
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    phone: json["phone"] == null ? null : json["phone"],
    language: json["language"] == null ? null : json["language"],
    isForgotPasswordIntitiated: json["is_forgot_password_intitiated"] == null ? null : json["is_forgot_password_intitiated"],
    companyId: json["company_id"] == null ? null : json["company_id"],
    locale: json["locale"] == null ? null : json["locale"],
    status: json["status"],
    projects: json["projects"] == null ? null : List<String>.from(json["projects"].map((x) => x)),
    adminProjects: json["admin_projects"],
    projectInfos: json["project_infos"] == null ? null : List<ProjectInfo>.from(json["project_infos"].map((x) => ProjectInfo.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "_id": id == null ? null : id,
    "first_name": firstName == null ? null : firstName,
    "last_name": lastName == null ? null : lastName,
    "email": email == null ? null : email,
    "password": password == null ? null : password,
    "role_id": roleId == null ? null : roleId,
    "organization_id": organizationId == null ? null : organizationId,
    "updated_at": updatedAt == null ? null : updatedAt,
    "created_at": createdAt == null ? null : createdAt,
    "phone": phone == null ? null : phone,
    "language": language == null ? null : language,
    "is_forgot_password_intitiated": isForgotPasswordIntitiated == null ? null : isForgotPasswordIntitiated,
    "company_id": companyId == null ? null : companyId,
    "locale": locale == null ? null : locale,
    "status": status,
    "projects": projects == null ? null : List<dynamic>.from(projects!.map((x) => x)),
    "admin_projects": adminProjects,
    "project_infos": projectInfos == null ? null : List<dynamic>.from(projectInfos!.map((x) => x.toJson())),
  };
}

class ProjectInfo {
  ProjectInfo({
    this.id,
    this.projectName,
    this.organizationId,
  });

  String? id;
  String? projectName;
  String? organizationId;

  factory ProjectInfo.fromJson(Map<String, dynamic> json) => ProjectInfo(
    id: json["id"] == null ? null : json["id"],
    projectName: json["project_name"] == null ? null : json["project_name"],
    organizationId: json["organization_id"] == null ? null : json["organization_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "project_name": projectName == null ? null : projectName,
    "organization_id": organizationId == null ? null : organizationId,
  };
}
