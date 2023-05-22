// To parse this JSON data, do
//
//     final subProjectListModel = subProjectListModelFromJson(jsonString);

import 'dart:convert';

SubProjectListModel subProjectListModelFromJson(String str) => SubProjectListModel.fromJson(json.decode(str));

String subProjectListModelToJson(SubProjectListModel data) => json.encode(data.toJson());

class SubProjectListModel {
  bool? success;
  List<SubProject>? subProjects;
  ProjectInfo? projectInfo;

  SubProjectListModel({
    this.success,
    this.subProjects,
    this.projectInfo,
  });

  factory SubProjectListModel.fromJson(Map<String, dynamic> json) => SubProjectListModel(
    success: json["success"],
    subProjects: json["sub_projects"] == null ? [] : List<SubProject>.from(json["sub_projects"]!.map((x) => SubProject.fromJson(x))),
    projectInfo: json["project_info"] == null ? null : ProjectInfo.fromJson(json["project_info"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "sub_projects": subProjects == null ? [] : List<dynamic>.from(subProjects!.map((x) => x.toJson())),
    "project_info": projectInfo?.toJson(),
  };
}

class ProjectInfo {
  String? id;
  String? projectName;
  String? organizationId;
  String? projectLocation;
  String? fromDate;
  String? toDate;
  bool? status;
  String? latitude;
  String? longitude;
  DateTime? updatedAt;
  DateTime? createdAt;
  Map<String, bool>? projectSettings;
  MailSmsSettings? mailSmsSettings;
  String? wasteLogoId;
  bool? hasLogisticsModule;
  bool? hasShipmentModule;
  String? placeId;
  bool? checkpoint;
  String? checkpointLocation;
  String? checkpointLatitude;
  String? checkpointLongitude;
  String? checkpointPlaceId;
  List<String>? projectTerminals;

  ProjectInfo({
    this.id,
    this.projectName,
    this.organizationId,
    this.projectLocation,
    this.fromDate,
    this.toDate,
    this.status,
    this.latitude,
    this.longitude,
    this.updatedAt,
    this.createdAt,
    this.projectSettings,
    this.mailSmsSettings,
    this.wasteLogoId,
    this.hasLogisticsModule,
    this.hasShipmentModule,
    this.placeId,
    this.checkpoint,
    this.checkpointLocation,
    this.checkpointLatitude,
    this.checkpointLongitude,
    this.checkpointPlaceId,
    this.projectTerminals,
  });

  factory ProjectInfo.fromJson(Map<String, dynamic> json) => ProjectInfo(
    id: json["_id"],
    projectName: json["project_name"],
    organizationId: json["organization_id"],
    projectLocation: json["project_location"],
    fromDate: json["from_date"],
    toDate: json["to_date"],
    status: json["status"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    projectSettings: Map.from(json["project_settings"]!).map((k, v) => MapEntry<String, bool>(k, v)),
    mailSmsSettings: json["mail_sms_settings"] == null ? null : MailSmsSettings.fromJson(json["mail_sms_settings"]),
    wasteLogoId: json["waste_logo_id"],
    hasLogisticsModule: json["has_logistics_module"],
    hasShipmentModule: json["has_shipment_module"],
    placeId: json["place_id"],
    checkpoint: json["checkpoint"],
    checkpointLocation: json["checkpoint_location"],
    checkpointLatitude: json["checkpoint_latitude"],
    checkpointLongitude: json["checkpoint_longitude"],
    checkpointPlaceId: json["checkpoint_placeId"],
    projectTerminals: json["project_terminals"] == null ? [] : List<String>.from(json["project_terminals"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "project_name": projectName,
    "organization_id": organizationId,
    "project_location": projectLocation,
    "from_date": fromDate,
    "to_date": toDate,
    "status": status,
    "latitude": latitude,
    "longitude": longitude,
    "updated_at": updatedAt?.toIso8601String(),
    "created_at": createdAt?.toIso8601String(),
    "project_settings": Map.from(projectSettings!).map((k, v) => MapEntry<String, dynamic>(k, v)),
    "mail_sms_settings": mailSmsSettings?.toJson(),
    "waste_logo_id": wasteLogoId,
    "has_logistics_module": hasLogisticsModule,
    "has_shipment_module": hasShipmentModule,
    "place_id": placeId,
    "checkpoint": checkpoint,
    "checkpoint_location": checkpointLocation,
    "checkpoint_latitude": checkpointLatitude,
    "checkpoint_longitude": checkpointLongitude,
    "checkpoint_placeId": checkpointPlaceId,
    "project_terminals": projectTerminals == null ? [] : List<dynamic>.from(projectTerminals!.map((x) => x)),
  };
}

class MailSmsSettings {
  bool? mail;
  bool? sms;

  MailSmsSettings({
    this.mail,
    this.sms,
  });

  factory MailSmsSettings.fromJson(Map<String, dynamic> json) => MailSmsSettings(
    mail: json["mail"],
    sms: json["sms"],
  );

  Map<String, dynamic> toJson() => {
    "mail": mail,
    "sms": sms,
  };
}

class SubProject {
  String? id;
  String? subProjectName;
  String? projectId;
  String? organizationId;
  bool? isDeleted;
  DateTime? updatedAt;
  DateTime? createdAt;

  SubProject({
    this.id,
    this.subProjectName,
    this.projectId,
    this.organizationId,
    this.isDeleted,
    this.updatedAt,
    this.createdAt,
  });

  factory SubProject.fromJson(Map<String, dynamic> json) => SubProject(
    id: json["_id"],
    subProjectName: json["sub_project_name"],
    projectId: json["project_id"],
    organizationId: json["organization_id"],
    isDeleted: json["is_deleted"],
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "sub_project_name": subProjectName,
    "project_id": projectId,
    "organization_id": organizationId,
    "is_deleted": isDeleted,
    "updated_at": updatedAt?.toIso8601String(),
    "created_at": createdAt?.toIso8601String(),
  };
}
