
class UserListModel {
  UserListModel({
    this.success,
    this.roles,
    this.users,
    this.companyName,
  });

  bool? success;
  List<Role>? roles;
  List<User>? users;
  String? companyName;

  factory UserListModel.fromJson(Map<String, dynamic> json) => UserListModel(
    success: json["success"] == null ? null : json["success"],
    roles: json["roles"] == null ? null : List<Role>.from(json["roles"].map((x) => Role.fromJson(x))),
    users: json["users"] == null ? null : List<User>.from(json["users"].map((x) => User.fromJson(x))),
    companyName: json["company_name"] == null ? null : json["company_name"],
  );

  Map<String, dynamic> toJson() => {
    "success": success == null ? null : success,
    "roles": roles == null ? null : List<dynamic>.from(roles!.map((x) => x.toJson())),
    "users": users == null ? null : List<dynamic>.from(users!.map((x) => x.toJson())),
    "company_name": companyName == null ? null : companyName,
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
    this.organizationId,
    this.userId,
    this.status,
    this.roleId,
    this.projects,
    this.companyId,
    this.updatedAt,
    this.createdAt,
    this.emailNotify,
    this.smsNotify,
    this.weekdayNotification,
    this.firstName,
    this.lastName,
    this.phone,
    this.email,
    this.language,
    this.companyName,
    this.projectInfos,
    this.roleName,
  });

  String? id;
  String? organizationId;
  String? userId;
  bool? status;
  String? roleId;
  List<String>? projects;
  String? companyId;
  DateTime? updatedAt;
  DateTime? createdAt;
  bool? emailNotify;
  bool? smsNotify;
  bool? weekdayNotification;
  String? firstName;
  String? lastName;
  String? phone;
  String? email;
  String? language;
  String? companyName;
  List<ProjectInfo>? projectInfos;
  String? roleName;

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["_id"] == null ? null : json["_id"],
    organizationId: json["organization_id"] == null ? null : json["organization_id"],
    userId: json["user_id"] == null ? null : json["user_id"],
    status: json["status"] == null ? null : json["status"],
    roleId: json["role_id"] == null ? null : json["role_id"],
    projects: json["projects"] == null ? null : List<String>.from(json["projects"].map((x) => x)),
    companyId: json["company_id"] == null ? null : json["company_id"],
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    emailNotify: json["email_notify"] == null ? null : json["email_notify"],
    smsNotify: json["sms_notify"] == null ? null : json["sms_notify"],
    weekdayNotification: json["weekday_notification"] == null ? null : json["weekday_notification"],
    firstName: json["first_name"] == null ? null : json["first_name"],
    lastName: json["last_name"] == null ? null : json["last_name"],
    phone: json["phone"] == null ? null : json["phone"],
    email: json["email"] == null ? null : json["email"],
    language: json["language"] == null ? null : json["language"],
    companyName: json["company_name"] == null ? null : json["company_name"],
    projectInfos: json["project_infos"] == null ? null : List<ProjectInfo>.from(json["project_infos"].map((x) => ProjectInfo.fromJson(x))),
    roleName: json["role_name"] == null ? null : json["role_name"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id == null ? null : id,
    "organization_id": organizationId == null ? null : organizationId,
    "user_id": userId == null ? null : userId,
    "status": status == null ? null : status,
    "role_id": roleId == null ? null : roleId,
    "projects": projects == null ? null : List<dynamic>.from(projects!.map((x) => x)),
    "company_id": companyId == null ? null : companyId,
    "updated_at": updatedAt == null ? null : updatedAt,
    "created_at": createdAt == null ? null : createdAt,
    "email_notify": emailNotify == null ? null : emailNotify,
    "sms_notify": smsNotify == null ? null : smsNotify,
    "weekday_notification": weekdayNotification == null ? null : weekdayNotification,
    "first_name": firstName == null ? null : firstName,
    "last_name": lastName == null ? null : lastName,
    "phone": phone == null ? null : phone,
    "email": email == null ? null : email,
    "language": language == null ? null : language,
    "company_name": companyName == null ? null : companyName,
    "project_infos": projectInfos == null ? null : List<dynamic>.from(projectInfos!.map((x) => x.toJson())),
    "role_name": roleName == null ? null : roleName,
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
