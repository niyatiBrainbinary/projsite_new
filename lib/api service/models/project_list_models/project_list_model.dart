
import 'dart:convert';

ProjectListModel projectListModelFromJson(String str) => ProjectListModel.fromJson(json.decode(str));

String projectListModelToJson(ProjectListModel data) => json.encode(data.toJson());

class ProjectListModel {
  ProjectListModel({
     this.success,
     this.projectsList,
     this.organizations,
     this.clients,
  });

  bool? success;
  List<ProjectsList>? projectsList;
  List<Organization>? organizations;
  List<dynamic>? clients;

  factory ProjectListModel.fromJson(Map<String, dynamic> json) => ProjectListModel(
    success: json["success"] == null ? null : json["success"],
    projectsList: json["projects_list"] == null ? null : List<ProjectsList>.from(json["projects_list"].map((x) => ProjectsList.fromJson(x))),
    organizations: json["organizations"] == null ? null : List<Organization>.from(json["organizations"].map((x) => Organization.fromJson(x))),
    clients: json["clients"] == null ? null : List<dynamic>.from(json["clients"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "success": success == null ? null : success,
    "projects_list": projectsList == null ? null : List<dynamic>.from(projectsList!.map((x) => x.toJson())),
    "organizations": organizations == null ? null : List<dynamic>.from(organizations!.map((x) => x.toJson())),
    "clients": clients == null ? null : List<dynamic>.from(clients!.map((x) => x)),
  };
}

class Organization {
  Organization({
    required this.id,
    required this.organizationName,
    required this.firstName,
    required this.email,
    required this.lastName,
    required this.createdAt,
    required this.status,
  });

  String id;
  String organizationName;
  String firstName;
  String email;
  dynamic lastName;
  DateTime? createdAt;
  dynamic status;

  factory Organization.fromJson(Map<String, dynamic> json) => Organization(
    id: json["_id"] == null ? null : json["_id"],
    organizationName: json["organization_name"] == null ? null : json["organization_name"],
    firstName: json["first_name"] == null ? null : json["first_name"],
    email: json["email"] == null ? null : json["email"],
    lastName: json["last_name"] == null ? null : json["last_name"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    status: json["status"] == null ? null : json["status"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id == null ? null : id,
    "organization_name": organizationName == null ? null : organizationName,
    "first_name": firstName == null ? null : firstName,
    "email": email == null ? null : email,
    "last_name": lastName == null ? null : lastName,
    "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
    "status": status == null ? null : status,
  };
}

class ProjectsList {
  ProjectsList({
    required this.id,
     required this.projectName,
     required this.organizationId,
     required this.projectLocation,
     required this.fromDate,
     required this.toDate,
     required this.status,
     required this.hasLogisticsModule,
     required this.hasShipmentModule,
     required this.latitude,
     required this.longitude,
     required this.placeId,
     required this.checkpoint,
     required this.checkpointLocation,
     required this.checkpointLatitude,
     required this.checkpointLongitude,
     required this.checkpointPlaceId,
     required this.updatedAt,
     required this.createdAt,
     required this.projectSettings,
     required this.mailSmsSettings,
     required this.terminalLatitude,
     required this.terminalLocation,
     required this.terminalLongitude,
     required this.terminalPlaceId,
     required this.projectTerminals,
  });

  String id;
  String projectName;
  String organizationId;
  String projectLocation;
  String fromDate;
  String toDate;
  bool status;
  bool hasLogisticsModule;
  bool hasShipmentModule;
  String latitude;
  String longitude;
  String placeId;
  String checkpoint;
  String checkpointLocation;
  String checkpointLatitude;
  String checkpointLongitude;
  String checkpointPlaceId;
  DateTime? updatedAt;
  DateTime? createdAt;
  Map<dynamic, dynamic>? projectSettings;
  MailSmsSettings? mailSmsSettings;
  dynamic terminalLatitude;
  dynamic terminalLocation;
  dynamic terminalLongitude;
  dynamic terminalPlaceId;
  List<String>? projectTerminals;

  factory ProjectsList.fromJson(Map<String, dynamic> json) => ProjectsList(
    id: json["_id"] == null ? null : json["_id"],
    projectName: json["project_name"] == null ? null : json["project_name"],
    organizationId: json["organization_id"] == null ? null : json["organization_id"],
    projectLocation: json["project_location"] == null ? null : json["project_location"],
    fromDate: json["from_date"] == null ? null : json["from_date"],
    toDate: json["to_date"] == null ? null : json["to_date"],
    status: json["status"] == null ? null : json["status"],
    hasLogisticsModule: json["has_logistics_module"] == null ? null : json["has_logistics_module"],
    hasShipmentModule: json["has_shipment_module"] == null ? null : json["has_shipment_module"],
    latitude: json["latitude"] == null ? null : json["latitude"],
    longitude: json["longitude"] == null ? null : json["longitude"],
    placeId: json["place_id"] == null ? null : json["place_id"],
    checkpoint: json["checkpoint"] == null ? null : json["checkpoint"],
    checkpointLocation: json["checkpoint_location"] == null ? null : json["checkpoint_location"],
    checkpointLatitude: json["checkpoint_latitude"] == null ? null : json["checkpoint_latitude"],
    checkpointLongitude: json["checkpoint_longitude"] == null ? null : json["checkpoint_longitude"],
    checkpointPlaceId: json["checkpoint_place_id"] == null ? null : json["checkpoint_place_id"],
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    projectSettings: json["project_settings"] == null ? null : Map.from(json["project_settings"]).map((k, v) => MapEntry<dynamic, dynamic>(k, v)),
    mailSmsSettings: json["mail_sms_settings"] == null ? null : MailSmsSettings.fromJson(json["mail_sms_settings"]),
    terminalLatitude: json["terminal_latitude"],
    terminalLocation: json["terminal_location"],
    terminalLongitude: json["terminal_longitude"],
    terminalPlaceId: json["terminal_place_id"],
    projectTerminals: json["project_terminals"] == null ? null : List<String>.from(json["project_terminals"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "_id": id == null ? null : id,
    "project_name": projectName == null ? null : projectName,
    "organization_id": organizationId == null ? null : organizationId,
    "project_location": projectLocation == null ? null : projectLocation,
    "from_date": fromDate == null ? null : fromDate,
    "to_date": toDate == null ? null : toDate,
    "status": status == null ? null : status,
    "has_logistics_module": hasLogisticsModule == null ? null : hasLogisticsModule,
    "has_shipment_module": hasShipmentModule == null ? null : hasShipmentModule,
    "latitude": latitude == null ? null : latitude,
    "longitude": longitude == null ? null : longitude,
    "place_id": placeId == null ? null : placeId,
    "checkpoint": checkpoint == null ? null : checkpoint,
    "checkpoint_location": checkpointLocation == null ? null : checkpointLocation,
    "checkpoint_latitude": checkpointLatitude == null ? null : checkpointLatitude,
    "checkpoint_longitude": checkpointLongitude == null ? null : checkpointLongitude,
    "checkpoint_place_id": checkpointPlaceId == null ? null : checkpointPlaceId,
    "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
    "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
    "project_settings": projectSettings == null ? null : Map.from(projectSettings!).map((k, v) => MapEntry<dynamic, dynamic>(k, v)),
    "mail_sms_settings": mailSmsSettings == null ? null : mailSmsSettings!.toJson(),
    "terminal_latitude": terminalLatitude,
    "terminal_location": terminalLocation,
    "terminal_longitude": terminalLongitude,
    "terminal_place_id": terminalPlaceId,
    "project_terminals": projectTerminals == null ? null : List<dynamic>.from(projectTerminals!.map((x) => x)),
  };
}

class MailSmsSettings {
  MailSmsSettings({
    required this.mail,
    required this.sms,
  });

  dynamic mail;
  dynamic sms;

  factory MailSmsSettings.fromJson(Map<String, dynamic> json) => MailSmsSettings(
    mail: json["mail"] == null ? null : json["mail"],
    sms: json["sms"] == null ? null : json["sms"],
  );

  Map<String, dynamic> toJson() => {
    "mail": mail == null ? null : mail,
    "sms": sms == null ? null : sms,
  };
}
