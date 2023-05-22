
class UserSubProjectListModel {
  UserSubProjectListModel({
    this.success,
    this.userSubProjects,
    this.subProjects,
  });

  bool? success;
  List<dynamic>? userSubProjects;
  List<SubProject>? subProjects;

  factory UserSubProjectListModel.fromJson(Map<String, dynamic> json) => UserSubProjectListModel(
    success: json["success"] == null ? null : json["success"],
    userSubProjects: json["user_sub_projects"] == null ? null : List<dynamic>.from(json["user_sub_projects"].map((x) => x)),
    subProjects: json["sub_projects"] == null ? null : List<SubProject>.from(json["sub_projects"].map((x) => SubProject.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success == null ? null : success,
    "user_sub_projects": userSubProjects == null ? null : List<dynamic>.from(userSubProjects!.map((x) => x)),
    "sub_projects": subProjects == null ? null : List<dynamic>.from(subProjects!.map((x) => x.toJson())),
  };
}

class SubProject {
  SubProject({
    this.id,
    this.subProjectName,
    this.projectId,
    this.organizationId,
    this.isDeleted,
    this.updatedAt,
    this.createdAt,
  });

  String? id;
  String? subProjectName;
  String? projectId;
  String? organizationId;
  bool? isDeleted;
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
    "updated_at": updatedAt == null ? null : updatedAt,
    "created_at": createdAt == null ? null : createdAt,
  };
}
