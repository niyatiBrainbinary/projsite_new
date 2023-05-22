// To parse this JSON data, do
//
//     final resourceListModel = resourceListModelFromJson(jsonString);

import 'dart:convert';

ResourceListModel resourceListModelFromJson(String str) => ResourceListModel.fromJson(json.decode(str));

String resourceListModelToJson(ResourceListModel data) => json.encode(data.toJson());

class ResourceListModel {
  ResourceListModel({
    required this.success,
    required this.resources,
  });

  bool success;
  List<Resource>? resources;

  factory ResourceListModel.fromJson(Map<String, dynamic> json) => ResourceListModel(
    success: json["success"] == null ? null : json["success"],
    resources: json["resources"] == null ? null : List<Resource>.from(json["resources"].map((x) => Resource.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success == null ? null : success,
    "resources": resources == null ? null : List<dynamic>.from(resources!.map((x) => x.toJson())),
  };
}

class Resource {
  Resource({
    required this.id,
    required this.resourceName,
    required this.projectId,
    required this.resourcePattern,
    required this.organizationId,
    required this.isDeleted,
    required this.updatedAt,
    required this.createdAt,
    required this.projectName,
  });

  String id;
  String resourceName;
  String projectId;
  String resourcePattern;
  String organizationId;
  bool isDeleted;
  DateTime? updatedAt;
  DateTime? createdAt;
  String projectName;

  factory Resource.fromJson(Map<String, dynamic> json) => Resource(
    id: json["_id"] == null ? null : json["_id"],
    resourceName: json["resource_name"] == null ? null : json["resource_name"],
    projectId: json["project_id"] == null ? null : json["project_id"],
    resourcePattern: json["resource_pattern"] == null ? null : json["resource_pattern"],
    organizationId: json["organization_id"] == null ? null : json["organization_id"],
    isDeleted: json["is_deleted"] == null ? null : json["is_deleted"],
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    projectName: json["project_name"] == null ? null : json["project_name"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id == null ? null : id,
    "resource_name": resourceName == null ? null : resourceName,
    "project_id": projectId == null ? null : projectId,
    "resource_pattern": resourcePattern == null ? null : resourcePattern,
    "organization_id": organizationId == null ? null : organizationId,
    "is_deleted": isDeleted == null ? null : isDeleted,
    "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
    "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
    "project_name": projectName == null ? null : projectName,
  };
}
