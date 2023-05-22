// To parse this JSON data, do
//
//     final projectDetailsModel = projectDetailsModelFromJson(jsonString);

import 'dart:convert';

ProjectDetailsModel projectDetailsModelFromJson(String str) => ProjectDetailsModel.fromJson(json.decode(str));

String projectDetailsModelToJson(ProjectDetailsModel data) => json.encode(data.toJson());

class ProjectDetailsModel {
  ProjectDetailsModel({
    this.success,
    this.projectDetails,
    this.organizationDetails,
    this.clients,
    this.organizations,
  });

  bool? success;
  ProjectDetails? projectDetails;
  OrganizationDetails? organizationDetails;
  List<dynamic>? clients;
  List<Organizations>? organizations;

  factory ProjectDetailsModel.fromJson(Map<String, dynamic> json) => ProjectDetailsModel(
    success: json["success"],
    projectDetails: ProjectDetails.fromJson(json["project_details"]),
    organizationDetails: OrganizationDetails.fromJson(json["organization_details"]),
    clients: List<dynamic>.from(json["clients"].map((x) => x)),
    organizations: List<Organizations>.from(json["organizations"].map((x) => Organizations.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "project_details": projectDetails,
    "organization_details": organizationDetails,
    "clients": List<dynamic>.from(clients!.map((x) => x)),
    "organizations": List<dynamic>.from(organizations!.map((x) => x.toJson())),
  };
}

class OrganizationDetails {
  OrganizationDetails({
    this.id,
    this.organizationName,
    this.firstName,
    this.email,
    this.password,
    this.roleId,
    this.hasLogisticsModule,
    this.hasShipmentModule,
    this.lastName,
    this.updatedAt,
    this.createdAt,
    this.marketplaceEnabled,
  });

  String? id;
  String? organizationName;
  String? firstName;
  String? email;
  String? password;
  String? roleId;
  bool? hasLogisticsModule;
  bool? hasShipmentModule;
  dynamic? lastName;
  DateTime? updatedAt;
  DateTime? createdAt;
  bool? marketplaceEnabled;

  factory OrganizationDetails.fromJson(Map<String, dynamic> json) => OrganizationDetails(
    id: json["_id"],
    organizationName: json["organization_name"],
    firstName: json["first_name"],
    email: json["email"],
    password: json["password"],
    roleId: json["role_id"],
    hasLogisticsModule: json["has_logistics_module"],
    hasShipmentModule: json["has_shipment_module"],
    lastName: json["last_name"],
    updatedAt: DateTime.parse(json["updated_at"]),
    createdAt: DateTime.parse(json["created_at"]),
    marketplaceEnabled: json["marketplace_enabled"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "organization_name": organizationName,
    "first_name": firstName,
    "email": email,
    "password": password,
    "role_id": roleId,
    "has_logistics_module": hasLogisticsModule,
    "has_shipment_module": hasShipmentModule,
    "last_name": lastName,
    "updated_at": updatedAt,
    "created_at": createdAt,
    "marketplace_enabled": marketplaceEnabled,
  };
}

class Organizations {
  Organizations({
    this.id,
    this.organizationName,
    this.firstName,
    this.email,
    this.lastName,
    this.createdAt,
    this.status,
  });

  String? id;
  String? organizationName;
  String? firstName;
  String? email;
  String? lastName;
  DateTime? createdAt;
  bool? status;

  factory Organizations.fromJson(Map<String, dynamic> json) => Organizations(
    id: json["_id"],
    organizationName: json["organization_name"],
    firstName: json["first_name"],
    email: json["email"],
    lastName: json["last_name"],
    createdAt: DateTime.parse(json["created_at"]),
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "organization_name": organizationName,
    "first_name": firstName,
    "email": email,
    "last_name": lastName,
    "created_at": createdAt,
    "status": status,
  };
}

class ProjectDetails {
  ProjectDetails({
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
  });

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
  String? wasteLogoId;
  String? placeId;

  factory ProjectDetails.fromJson(Map<String, dynamic> json) => ProjectDetails(
    id: json["_id"],
    projectName: json["project_name"],
    organizationId: json["organization_id"],
    projectLocation: json["project_location"],
    fromDate: json["from_date"],
    toDate: json["to_date"],
    status: json["status"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    updatedAt: DateTime.parse(json["updated_at"]),
    createdAt: DateTime.parse(json["created_at"]),
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
    "updated_at": updatedAt,
    "created_at": createdAt,
    "waste_logo_id": wasteLogoId,
    "place_id": placeId,
  };
}


