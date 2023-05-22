// To parse this JSON data, do
//
//     final getBookingFormModel = getBookingFormModelFromJson(jsonString);

import 'dart:convert';

GetBookingFormModel getBookingFormModelFromJson(String str) => GetBookingFormModel.fromJson(json.decode(str));

String getBookingFormModelToJson(GetBookingFormModel data) => json.encode(data.toJson());

class GetBookingFormModel {
  bool? success;
  ProjectInfo? projectInfo;

  GetBookingFormModel({
    this.success,
    this.projectInfo,
  });

  factory GetBookingFormModel.fromJson(Map<String, dynamic> json) => GetBookingFormModel(
    success: json["success"],
    projectInfo: json["project_info"] == null ? null : ProjectInfo.fromJson(json["project_info"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
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
  String? organizationName;

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
    this.organizationName,
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
    organizationName: json["organization_name"],
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
    "organization_name": organizationName,
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
