
import 'dart:convert';

LogisticDetailsModel logisticDetailsModelFromJson(String str) => LogisticDetailsModel.fromJson(json.decode(str));

String logisticDetailsModelToJson(LogisticDetailsModel data) => json.encode(data.toJson());

class LogisticDetailsModel {
  LogisticDetailsModel({
    required this.success,
    required this.result,
    required this.checkOuts,
  });

  bool success;
  Result? result;
  List<CheckOut>? checkOuts;

  factory LogisticDetailsModel.fromJson(Map<String, dynamic> json) => LogisticDetailsModel(
    success: json["success"] == null ? null : json["success"],
    result: json["result"] == null ? null : Result.fromJson(json["result"]),
    checkOuts: json["check_outs"] == null ? null : List<CheckOut>.from(json["check_outs"].map((x) => CheckOut.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success == null ? null : success,
    "result": result == null ? null : result?.toJson(),
    "check_outs": checkOuts == null ? null : List<dynamic>.from(checkOuts!.map((x) => x.toJson())),
  };
}

class CheckOut {
  CheckOut({
    required this.id,
    required this.logisticId,
    required this.releaseDate,
    required this.releaseQuantity,
    required this.currentStock,
    required this.status,
    required this.createdBy,
    required this.isHidden,
    required this.updatedAt,
    required this.createdAt,
    required this.createdByPersonName,
    required this.requestUrl,
    required this.requestId,
    required this.bookedBetween,
    required this.statusOutput,
    required this.dateApproved,
    required this.dateRequested,
  });

  String id;
  String logisticId;
  String releaseDate;
  String releaseQuantity;
  String currentStock;
  String status;
  String createdBy;
  bool isHidden;
  DateTime? updatedAt;
  DateTime? createdAt;
  String createdByPersonName;
  String requestUrl;
  String requestId;
  String bookedBetween;
  String statusOutput;
  String dateApproved;
  String dateRequested;

  factory CheckOut.fromJson(Map<String, dynamic> json) => CheckOut(
    id: json["_id"] == null ? null : json["_id"],
    logisticId: json["logistic_id"] == null ? null : json["logistic_id"],
    releaseDate: json["release_date"] == null ? null : json["release_date"],
    releaseQuantity: json["release_quantity"] == null ? null : json["release_quantity"],
    currentStock: json["current_stock"] == null ? null : json["current_stock"],
    status: json["status"] == null ? null : json["status"],
    createdBy: json["created_by"] == null ? null : json["created_by"],
    isHidden: json["is_hidden"] == null ? null : json["is_hidden"],
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    createdByPersonName: json["created_by_person_name"] == null ? null : json["created_by_person_name"],
    requestUrl: json["request_url"] == null ? null : json["request_url"],
    requestId: json["request_id"] == null ? null : json["request_id"],
    bookedBetween: json["booked_between"] == null ? null : json["booked_between"],
    statusOutput: json["status_output"] == null ? null : json["status_output"],
    dateApproved: json["date_approved"] == null ? null : json["date_approved"],
    dateRequested: json["date_requested"] == null ? null : json["date_requested"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id == null ? null : id,
    "logistic_id": logisticId == null ? null : logisticId,
    "release_date": releaseDate == null ? null : releaseDate,
    "release_quantity": releaseQuantity == null ? null : releaseQuantity,
    "current_stock": currentStock == null ? null : currentStock,
    "status": status == null ? null : status,
    "created_by": createdBy == null ? null : createdBy,
    "is_hidden": isHidden == null ? null : isHidden,
    "updated_at": updatedAt == null ? null : updatedAt?.toIso8601String(),
    "created_at": createdAt == null ? null : createdAt?.toIso8601String(),
    "created_by_person_name": createdByPersonName == null ? null : createdByPersonName,
    "request_url": requestUrl == null ? null : requestUrl,
    "requestId": requestId == null ? null : requestId,
    "booked_between": bookedBetween == null ? null : bookedBetween,
    "status_output": statusOutput == null ? null : statusOutput,
    "date_approved": dateApproved == null ? null : dateApproved,
    "date_requested": dateRequested == null ? null : dateRequested,
  };
}

class Result {
  Result({
    required this.id,
    required this .projectId,
    required this.arrivalDate,
    required this.itemName,
    required this.subProjectId,
    required this.noOfPallets,
    required this.inStock,
    required this.description,
    required this.createdBy,
    required this.companyId,
    required this.address,
    required this.status,
    required this.organizationId,
    required this.isActive,
    required this.isHidden,
    required this.requestId,
    required this.logisticNumber,
    required this.updatedAt,
    required this.createdAt,
    required this.subProjectDetails,
    required this.companyDetails,
    required this.terminalId,
  });

  String id;
  String projectId;
  DateTime? arrivalDate;
  String itemName;
  String subProjectId;
  String noOfPallets;
  String inStock;
  String description;
  String createdBy;
  String companyId;
  String address;
  String status;
  String organizationId;
  bool isActive;
  bool isHidden;
  String requestId;
  int logisticNumber;
  DateTime? updatedAt;
  DateTime? createdAt;
  SubProjectDetails? subProjectDetails;
  CompanyDetails? companyDetails;
  String? terminalId;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["_id"] == null ? null : json["_id"],
    projectId: json["project_id"] == null ? null : json["project_id"],
    arrivalDate: json["arrival_date"] == null ? null : DateTime.parse(json["arrival_date"]),
    itemName: json["item_name"] == null ? null : json["item_name"],
    subProjectId: json["sub_project_id"] == null ? null : json["sub_project_id"],
    noOfPallets: json["no_of_pallets"] == null ? null : json["no_of_pallets"],
    inStock: json["in_stock"] == null ? null : json["in_stock"],
    description: json["description"] == null ? null : json["description"],
    createdBy: json["created_by"] == null ? null : json["created_by"],
    companyId: json["company_id"] == null ? null : json["company_id"],
    address: json["address"] == null ? null : json["address"],
    status: json["status"] == null ? null : json["status"],
    organizationId: json["organization_id"] == null ? null : json["organization_id"],
    isActive: json["is_active"] == null ? null : json["is_active"],
    isHidden: json["is_hidden"] == null ? null : json["is_hidden"],
    requestId: json["request_id"] == null ? null : json["request_id"],
    logisticNumber: json["logistic_number"] == null ? null : json["logistic_number"],
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    subProjectDetails: json["sub_project_details"] == null ? null : SubProjectDetails.fromJson(json["sub_project_details"]),
    companyDetails: json["company_details"] == null ? null : CompanyDetails.fromJson(json["company_details"]),
    terminalId: json["terminal_id"] == null ? null : json["terminal_id"],

  );

  Map<String, dynamic> toJson() => {
    "_id": id == null ? null : id,
    "project_id": projectId == null ? null : projectId,
    "arrival_date": arrivalDate == null ? null : "${arrivalDate?.year.toString().padLeft(4, '0')}-${arrivalDate?.month.toString().padLeft(2, '0')}-${arrivalDate?.day.toString().padLeft(2, '0')}",
    "item_name": itemName == null ? null : itemName,
    "sub_project_id": subProjectId == null ? null : subProjectId,
    "no_of_pallets": noOfPallets == null ? null : noOfPallets,
    "in_stock": inStock == null ? null : inStock,
    "description": description == null ? null : description,
    "created_by": createdBy == null ? null : createdBy,
    "company_id": companyId == null ? null : companyId,
    "address": address == null ? null : address,
    "status": status == null ? null : status,
    "organization_id": organizationId == null ? null : organizationId,
    "is_active": isActive == null ? null : isActive,
    "is_hidden": isHidden == null ? null : isHidden,
    "request_id": requestId == null ? null : requestId,
    "logistic_number": logisticNumber == null ? null : logisticNumber,
    "updated_at": updatedAt == null ? null : updatedAt?.toIso8601String(),
    "created_at": createdAt == null ? null : createdAt?.toIso8601String(),
    "sub_project_details": subProjectDetails == null ? null : subProjectDetails?.toJson(),
    "company_details": companyDetails == null ? null : companyDetails?.toJson(),
    "terminal_id": terminalId == null ? null : terminalId,
  };
}

class CompanyDetails {
  CompanyDetails({
    required this.id,
    required this.companyName,
    required this.organizationId,
    required this.updatedAt,
    required this.createdAt,
    required this.isDeleted,
  });

  String id;
  String companyName;
  String organizationId;
  DateTime? updatedAt;
  DateTime? createdAt;
  bool isDeleted;

  factory CompanyDetails.fromJson(Map<String, dynamic> json) => CompanyDetails(
    id: json["_id"] == null ? null : json["_id"],
    companyName: json["company_name"] == null ? null : json["company_name"],
    organizationId: json["organization_id"] == null ? null : json["organization_id"],
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    isDeleted: json["is_deleted"] == null ? null : json["is_deleted"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id == null ? null : id,
    "company_name": companyName == null ? null : companyName,
    "organization_id": organizationId == null ? null : organizationId,
    "updated_at": updatedAt == null ? null : updatedAt?.toIso8601String(),
    "created_at": createdAt == null ? null : createdAt?.toIso8601String(),
    "is_deleted": isDeleted == null ? null : isDeleted,
  };
}

class SubProjectDetails {
  SubProjectDetails({
    required this.id,
    required this.subProjectName,
    required this.projectId,
    required this.organizationId,
    required this.isDeleted,
    required this.updatedAt,
    required this.createdAt,
  });

  String id;
  String subProjectName;
  String projectId;
  String organizationId;
  bool isDeleted;
  DateTime? updatedAt;
  DateTime? createdAt;

  factory SubProjectDetails.fromJson(Map<String, dynamic> json) => SubProjectDetails(
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
    "updated_at": updatedAt == null ? null : updatedAt?.toIso8601String(),
    "created_at": createdAt == null ? null : createdAt?.toIso8601String(),
  };
}
