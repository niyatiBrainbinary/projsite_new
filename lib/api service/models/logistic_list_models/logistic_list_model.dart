// To parse this JSON data, do
//
//     final logisticListModel = logisticListModelFromJson(jsonString);

import 'dart:convert';

LogisticListModel logisticListModelFromJson(String str) => LogisticListModel.fromJson(json.decode(str));

String logisticListModelToJson(LogisticListModel data) => json.encode(data.toJson());

class LogisticListModel {
  LogisticListModel({
    this.success,
    this.logisticList,
  });

  bool? success;
  List<LogisticList>? logisticList;

  factory LogisticListModel.fromJson(Map<String, dynamic> json) => LogisticListModel(
    success: json["success"],
    logisticList: json["logistic_list"] == null ? [] : List<LogisticList>.from(json["logistic_list"]!.map((x) => LogisticList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "logistic_list": logisticList == null ? [] : List<dynamic>.from(logisticList!.map((x) => x.toJson())),
  };
}

class LogisticList {
  LogisticList({
    this.id,
    this.projectId,
    this.arrivalDate,
    this.itemName,
    this.subProjectId,
    this.noOfPallets,
    this.inStock,
    this.description,
    this.createdBy,
    this.companyId,
    this.address,
    this.status,
    this.organizationId,
    this.isActive,
    this.isHidden,
    this.logisticNumber,
    this.updatedAt,
    this.createdAt,
    this.terminalId,
    this.projectDetails,
    this.companyDetails,
    this.terminal,
    this.requestId,
    this.salvegeCategoryModelIds,
    this.inSalvege,
    this.itemImage,
    this.subProjectDetails,
  });

  String? id;
  String? projectId;
  String? arrivalDate;
  String? itemName;
  String? subProjectId;
  String? noOfPallets;
  dynamic inStock;
  String? description;
  String? createdBy;
  String? companyId;
  String? address;
  String? status;
  String? organizationId;
  bool? isActive;
  bool? isHidden;
  int? logisticNumber;
  String? updatedAt;
  String? createdAt;
  String? terminalId;
  ProjectDetails? projectDetails;
  CompanyDetails? companyDetails;
  Terminal? terminal;
  String? requestId;
  List<String>? salvegeCategoryModelIds;
  int? inSalvege;
  String? itemImage;
  SubProjectDetails? subProjectDetails;

  factory LogisticList.fromJson(Map<String, dynamic> json) => LogisticList(
    id: json["_id"],
    projectId: json["project_id"],
    arrivalDate: json["arrival_date"],
    itemName: json["item_name"],
    subProjectId: json["sub_project_id"],
    noOfPallets: json["no_of_pallets"],
    inStock: json["in_stock"],
    description: json["description"],
    createdBy: json["created_by"],
    companyId: json["company_id"],
    address: json["address"],
    status: json["status"],
    organizationId: json["organization_id"],
    isActive: json["is_active"],
    isHidden: json["is_hidden"],
    logisticNumber: json["logistic_number"],
    updatedAt: json["updated_at"],
    createdAt: json["created_at"],
    terminalId: json["terminal_id"],
    projectDetails: json["project_details"] == null ? null : ProjectDetails.fromJson(json["project_details"]),
    companyDetails: json["company_details"] == null ? null : CompanyDetails.fromJson(json["company_details"]),
    terminal: json["terminal"] == null ? null : Terminal.fromJson(json["terminal"]),
    requestId: json["request_id"],
    salvegeCategoryModelIds: json["salvege_category_model_ids"] == null ? [] : List<String>.from(json["salvege_category_model_ids"]!.map((x) => x)),
    inSalvege: json["in_salvege"],
    itemImage: json["item_image"],
    subProjectDetails: json["sub_project_details"] == null ? null : SubProjectDetails.fromJson(json["sub_project_details"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "project_id": projectId,
    "arrival_date": arrivalDate,
    "item_name": itemName,
    "sub_project_id": subProjectId,
    "no_of_pallets": noOfPallets,
    "in_stock": inStock,
    "description": description,
    "created_by": createdBy,
    "company_id": companyId,
    "address": address,
    "status": status,
    "organization_id": organizationId,
    "is_active": isActive,
    "is_hidden": isHidden,
    "logistic_number": logisticNumber,
    "updated_at": updatedAt,
    "created_at": createdAt,
    "terminal_id": terminalId,
    "project_details": projectDetails?.toJson(),
    "company_details": companyDetails?.toJson(),
    "terminal": terminal?.toJson(),
    "request_id": requestId,
    "salvege_category_model_ids": salvegeCategoryModelIds == null ? [] : List<dynamic>.from(salvegeCategoryModelIds!.map((x) => x)),
    "in_salvege": inSalvege,
    "item_image": itemImage,
    "sub_project_details": subProjectDetails?.toJson(),
  };
}

class CompanyDetails {
  CompanyDetails({
    this.id,
    this.companyName,
    this.organizationId,
    this.updatedAt,
    this.createdAt,
    this.isDeleted,
  });

  String? id;
  String? companyName;
  String? organizationId;
  String? updatedAt;
  String? createdAt;
  bool? isDeleted;

  factory CompanyDetails.fromJson(Map<String, dynamic> json) => CompanyDetails(
    id: json["_id"],
    companyName: json["company_name"],
    organizationId: json["organization_id"],
    updatedAt: json["updated_at"],
    createdAt: json["created_at"],
    isDeleted: json["is_deleted"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "company_name": companyName,
    "organization_id": organizationId,
    "updated_at": updatedAt,
    "created_at": createdAt,
    "is_deleted": isDeleted,
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
    this.wasteLogoId,
    this.hasLogisticsModule,
    this.hasShipmentModule,
    this.placeId,
    this.checkpoint,
    this.checkpointLocation,
    this.checkpointLatitude,
    this.checkpointLongitude,
    this.checkpointPlaceId,
    this.projectSettings,
    this.mailSmsSettings,
    this.projectTerminals,
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
  String? updatedAt;
  String? createdAt;
  String? wasteLogoId;
  bool? hasLogisticsModule;
  bool? hasShipmentModule;
  String? placeId;
  dynamic checkpoint;
  dynamic checkpointLocation;
  dynamic checkpointLatitude;
  dynamic checkpointLongitude;
  dynamic checkpointPlaceId;
  ProjectSettings? projectSettings;
  MailSmsSettings? mailSmsSettings;
  List<String>? projectTerminals;

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
    updatedAt: json["updated_at"],
    createdAt: json["created_at"],
    wasteLogoId: json["waste_logo_id"],
    hasLogisticsModule: json["has_logistics_module"],
    hasShipmentModule: json["has_shipment_module"],
    placeId: json["place_id"],
    checkpoint: json["checkpoint"],
    checkpointLocation: json["checkpoint_location"],
    checkpointLatitude: json["checkpoint_latitude"],
    checkpointLongitude: json["checkpoint_longitude"],
    checkpointPlaceId: json["checkpoint_placeId"],
    projectSettings: json["project_settings"] == null ? null : ProjectSettings.fromJson(json["project_settings"]),
    mailSmsSettings: json["mail_sms_settings"] == null ? null : MailSmsSettings.fromJson(json["mail_sms_settings"]),
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
    "updated_at": updatedAt,
    "created_at": createdAt,
    "waste_logo_id": wasteLogoId,
    "has_logistics_module": hasLogisticsModule,
    "has_shipment_module": hasShipmentModule,
    "place_id": placeId,
    "checkpoint": checkpoint,
    "checkpoint_location": checkpointLocation,
    "checkpoint_latitude": checkpointLatitude,
    "checkpoint_longitude": checkpointLongitude,
    "checkpoint_placeId": checkpointPlaceId,
    "project_settings": projectSettings?.toJson(),
    "mail_sms_settings": mailSmsSettings?.toJson(),
    "project_terminals": projectTerminals == null ? [] : List<dynamic>.from(projectTerminals!.map((x) => x)),
  };
}

class MailSmsSettings {
  MailSmsSettings({
    this.mail,
    this.sms,
  });

  bool? mail;
  bool? sms;

  factory MailSmsSettings.fromJson(Map<String, dynamic> json) => MailSmsSettings(
    mail: json["mail"],
    sms: json["sms"],
  );

  Map<String, dynamic> toJson() => {
    "mail": mail,
    "sms": sms,
  };
}

class ProjectSettings {
  ProjectSettings({
    this.resource,
    this.zone,
    this.contractor,
    this.responsiblePerson,
    this.zonesSimultaneously,
    this.deliverySupplier,
    this.typeOfVehicle,
    this.euroClass,
    this.autoApproval,
  });

  bool? resource;
  bool? zone;
  bool? contractor;
  bool? responsiblePerson;
  bool? zonesSimultaneously;
  bool? deliverySupplier;
  bool? typeOfVehicle;
  bool? euroClass;
  bool? autoApproval;

  factory ProjectSettings.fromJson(Map<String, dynamic> json) => ProjectSettings(
    resource: json["resource"],
    zone: json["zone"],
    contractor: json["contractor"],
    responsiblePerson: json["responsible_person"],
    zonesSimultaneously: json["zones_simultaneously"],
    deliverySupplier: json["delivery_supplier"],
    typeOfVehicle: json["type_of_vehicle"],
    euroClass: json["euro_class"],
    autoApproval: json["auto_approval"],
  );

  Map<String, dynamic> toJson() => {
    "resource": resource,
    "zone": zone,
    "contractor": contractor,
    "responsible_person": responsiblePerson,
    "zones_simultaneously": zonesSimultaneously,
    "delivery_supplier": deliverySupplier,
    "type_of_vehicle": typeOfVehicle,
    "euro_class": euroClass,
    "auto_approval": autoApproval,
  };
}

class SubProjectDetails {
  SubProjectDetails({
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
  String? updatedAt;
  String? createdAt;

  factory SubProjectDetails.fromJson(Map<String, dynamic> json) => SubProjectDetails(
    id: json["_id"],
    subProjectName: json["sub_project_name"],
    projectId: json["project_id"],
    organizationId: json["organization_id"],
    isDeleted: json["is_deleted"],
    updatedAt: json["updated_at"],
    createdAt: json["created_at"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "sub_project_name": subProjectName,
    "project_id": projectId,
    "organization_id": organizationId,
    "is_deleted": isDeleted,
    "updated_at": updatedAt,
    "created_at": createdAt,
  };
}

class Terminal {
  Terminal({
    this.id,
    this.name,
    this.address,
    this.latitude,
    this.longitude,
    this.placeId,
    this.defaultProject,
    this.createdBy,
    this.status,
    this.updatedAt,
    this.createdAt,
    this.terminalProjects,
  });

  String? id;
  String? name;
  dynamic address;
  dynamic latitude;
  dynamic longitude;
  dynamic placeId;
  String? defaultProject;
  String? createdBy;
  bool? status;
  String? updatedAt;
  String? createdAt;
  List<String>? terminalProjects;

  factory Terminal.fromJson(Map<String, dynamic> json) => Terminal(
    id: json["_id"],
    name: json["name"],
    address: json["address"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    placeId: json["place_id"],
    defaultProject: json["default_project"],
    createdBy: json["created_by"],
    status: json["status"],
    updatedAt: json["updated_at"],
    createdAt: json["created_at"],
    terminalProjects: json["terminal_projects"] == null ? [] : List<String>.from(json["terminal_projects"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "address": address,
    "latitude": latitude,
    "longitude": longitude,
    "place_id": placeId,
    "default_project": defaultProject,
    "created_by": createdBy,
    "status": status,
    "updated_at": updatedAt,
    "created_at": createdAt,
    "terminal_projects": terminalProjects == null ? [] : List<dynamic>.from(terminalProjects!.map((x) => x)),
  };
}
