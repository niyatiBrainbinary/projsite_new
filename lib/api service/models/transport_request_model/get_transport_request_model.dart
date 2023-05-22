
import 'dart:convert';

GetTransportRequestModel getTransportRequestModelFromJson(String str) => GetTransportRequestModel.fromJson(json.decode(str));

String getTransportRequestModelToJson(GetTransportRequestModel data) => json.encode(data.toJson());

class GetTransportRequestModel {
  GetTransportRequestModel({
    this.success,
    this.result,
  });

  bool? success;
  Result? result;

  factory GetTransportRequestModel.fromJson(Map<String, dynamic> json) => GetTransportRequestModel(
    success: json["success"],
    result: json["result"] == null ? null : Result.fromJson(json["result"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "result": result?.toJson(),
  };
}

class Result {
  Result({
    this.id,
    this.projectId,
    this.requestFromDateTime,
    this.requestToDateTime,
    this.responsiblePersonId,
    this.checkoutsArray,
    this.createdBy,
    this.status,
    this.requestType,
    this.organizationId,
    this.subProjectId,
    this.unloadingZoneId,
    this.description,
    this.isHidden,
    this.unbooked,
    this.updatedAt,
    this.createdAt,
    this.transportStatus,
    this.arrivedAt,
    this.inProgressAt,
    this.unloadedAt,
    this.terminalId,
    this.subProjectName,
    this.checkoutsList,
  });

  String? id;
  String? projectId;
  DateTime? requestFromDateTime;
  DateTime? requestToDateTime;
  String? responsiblePersonId;
  List<String>? checkoutsArray;
  String? createdBy;
  String? status;
  String? requestType;
  String? organizationId;
  String? subProjectId;
  String? unloadingZoneId;
  String? description;
  dynamic isHidden;
  dynamic unbooked;
  String? updatedAt;
  String? createdAt;
  String? transportStatus;
  String? arrivedAt;
  String? inProgressAt;
  String? unloadedAt;
  String? terminalId;
  String? subProjectName;
  List<CheckoutsList>? checkoutsList;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["_id"],
    projectId: json["project_id"],
    requestFromDateTime: DateTime.parse(json["request_from_date_time"]),
    requestToDateTime: DateTime.parse(json["request_to_date_time"]),
    responsiblePersonId: json["responsible_person_id"],
    checkoutsArray: json["checkouts_array"] == null ? [] : List<String>.from(json["checkouts_array"]!.map((x) => x)),
    createdBy: json["created_by"],
    status: json["status"],
    requestType: json["request_type"],
    organizationId: json["organization_id"],
    subProjectId: json["sub_project_id"],
    unloadingZoneId: json["unloading_zone_id"],
    description: json["description"],
    isHidden: json["is_hidden"],
    unbooked: json["unbooked"],
    updatedAt: json["updated_at"],
    createdAt: json["created_at"],
    transportStatus: json["transport_status"],
    arrivedAt: json["arrived_at"],
    inProgressAt: json["in_progress_at"],
    unloadedAt: json["unloaded_at"],
    terminalId: json["terminal_id"],
    subProjectName: json["sub_project_name"],
    checkoutsList: json["checkouts_list"] == null ? [] : List<CheckoutsList>.from(json["checkouts_list"]!.map((x) => CheckoutsList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "project_id": projectId,
    "request_from_date_time": requestFromDateTime,
    "request_to_date_time": requestToDateTime,
    "responsible_person_id": responsiblePersonId,
    "checkouts_array": checkoutsArray == null ? [] : List<dynamic>.from(checkoutsArray!.map((x) => x)),
    "created_by": createdBy,
    "status": status,
    "request_type": requestType,
    "organization_id": organizationId,
    "sub_project_id": subProjectId,
    "unloading_zone_id": unloadingZoneId,
    "description": description,
    "is_hidden": isHidden,
    "unbooked": unbooked,
    "updated_at": updatedAt,
    "created_at": createdAt,
    "transport_status": transportStatus,
    "arrived_at": arrivedAt,
    "in_progress_at": inProgressAt,
    "unloaded_at": unloadedAt,
    "terminal_id": terminalId,
    "sub_project_name": subProjectName,
    "checkouts_list": checkoutsList == null ? [] : List<dynamic>.from(checkoutsList!.map((x) => x.toJson())),
  };
}

class CheckoutsList {
  CheckoutsList({
    this.id,
    this.logisticId,
    this.releaseDate,
    this.releaseQuantity,
    this.currentStock,
    this.status,
    this.createdBy,
    this.updatedAt,
    this.createdAt,
    this.dateRequested,
    this.itemName,
    this.terminalName,
    this.entreprenuerName,
    this.createdByPersonName,
  });

  String? id;
  String? logisticId;
  DateTime? releaseDate;
  String? releaseQuantity;
  String? currentStock;
  String? status;
  String? createdBy;
  String? updatedAt;
  String? createdAt;
  String? dateRequested;
  String? itemName;
  String? terminalName;
  String? entreprenuerName;
  String? createdByPersonName;

  factory CheckoutsList.fromJson(Map<String, dynamic> json) => CheckoutsList(
    id: json["_id"],
    logisticId: json["logistic_id"],
    releaseDate: json["release_date"] == null ? null : DateTime.parse(json["release_date"]),
    releaseQuantity: json["release_quantity"],
    currentStock: json["current_stock"],
    status: json["status"],
    createdBy: json["created_by"],
    updatedAt: json["updated_at"],
    createdAt: json["created_at"],
    dateRequested: json["date_requested"],
    itemName: json["item_name"],
    terminalName: json["terminal_name"],
    entreprenuerName: json["entreprenuer_name"],
    createdByPersonName: json["created_by_person_name"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "logistic_id": logisticId,
    "release_date": "${releaseDate!.year.toString().padLeft(4, '0')}-${releaseDate!.month.toString().padLeft(2, '0')}-${releaseDate!.day.toString().padLeft(2, '0')}",
    "release_quantity": releaseQuantity,
    "current_stock": currentStock,
    "status": status,
    "created_by": createdBy,
    "updated_at": updatedAt,
    "created_at": createdAt,
    "date_requested": dateRequested,
    "item_name": itemName,
    "terminal_name": terminalName,
    "entreprenuer_name": entreprenuerName,
    "created_by_person_name": createdByPersonName,
  };
}
