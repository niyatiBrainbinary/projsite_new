// To parse this JSON data, do
//
//     final terminalRequestDataModel = terminalRequestDataModelFromJson(jsonString);

import 'dart:convert';

TerminalRequestDataModel terminalRequestDataModelFromJson(String str) => TerminalRequestDataModel.fromJson(json.decode(str));

String terminalRequestDataModelToJson(TerminalRequestDataModel data) => json.encode(data.toJson());

class TerminalRequestDataModel {
  TerminalRequestDataModel({
    this.success,
    this.result,
  });

  bool? success;
  Result? result;

  factory TerminalRequestDataModel.fromJson(Map<String, dynamic> json) => TerminalRequestDataModel(
    success: json["success"] == null ? null : json["success"],
    result: json["result"] == null ? null : Result.fromJson(json["result"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success == null ? null : success,
    "result": result == null ? null : result!.toJson(),
  };
}

class Result {
  Result({
    this.id,
    this.projectId,
    this.requestFromDateTime,
    this.requestToDateTime,
    this.contractorId,
    this.responsiblePersonId,
    this.description,
    this.imageName,
    this.createdBy,
    this.organizationId,
    this.terminalId,
    this.itemId,
    this.itemName,
    this.noOfPallets,
    this.subProjectId,
    this.status,
    this.requestType,
    this.isHidden,
    this.unbooked,
    this.resourceArray,
    this.deliverySupplier,
    this.loadWeight,
    this.drivingDistance,
    this.isReturn,
    this.addresses,
    this.ntmDataFullRoute,
    this.isHiddenEnvironment,
    this.transportStatus,
    this.updatedAt,
    this.createdAt,
    this.subProjectName,
  });

  String? id;
  String? projectId;
  DateTime? requestFromDateTime;
  DateTime? requestToDateTime;
  String? contractorId;
  String? responsiblePersonId;
  String? description;
  dynamic imageName;
  String? createdBy;
  String? organizationId;
  String? terminalId;
  String? itemId;
  String? itemName;
  String? noOfPallets;
  String? subProjectId;
  String? status;
  String? requestType;
  bool? isHidden;
  bool? unbooked;
  List<String>? resourceArray;
  String? deliverySupplier;
  String? loadWeight;
  String? drivingDistance;
  String? isReturn;
  dynamic addresses;
  dynamic ntmDataFullRoute;
  bool? isHiddenEnvironment;
  String? transportStatus;
  DateTime? updatedAt;
  DateTime? createdAt;
  String? subProjectName;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["_id"] == null ? null : json["_id"],
    projectId: json["project_id"] == null ? null : json["project_id"],
    requestFromDateTime: json["request_from_date_time"] == null ? null : DateTime.parse(json["request_from_date_time"]),
    requestToDateTime: json["request_to_date_time"] == null ? null : DateTime.parse(json["request_to_date_time"]),
    contractorId: json["contractor_id"] == null ? null : json["contractor_id"],
    responsiblePersonId: json["responsible_person_id"] == null ? null : json["responsible_person_id"],
    description: json["description"] == null ? null : json["description"],
    imageName: json["image_name"],
    createdBy: json["created_by"] == null ? null : json["created_by"],
    organizationId: json["organization_id"] == null ? null : json["organization_id"],
    terminalId: json["terminal_id"] == null ? null : json["terminal_id"],
    itemId: json["item_id"] == null ? null : json["item_id"],
    itemName: json["item_name"] == null ? null : json["item_name"],
    noOfPallets: json["no_of_pallets"] == null ? null : json["no_of_pallets"],
    subProjectId: json["sub_project_id"] == null ? null : json["sub_project_id"],
    status: json["status"] == null ? null : json["status"],
    requestType: json["request_type"] == null ? null : json["request_type"],
    isHidden: json["is_hidden"] == null ? null : json["is_hidden"],
    unbooked: json["unbooked"] == null ? null : json["unbooked"],
    resourceArray: json["resource_array"] == null ? null : List<String>.from(json["resource_array"].map((x) => x)),
    deliverySupplier: json["delivery_supplier"] == null ? null : json["delivery_supplier"],
    loadWeight: json["load_weight"] == null ? null : json["load_weight"],
    drivingDistance: json["driving_distance"] == null ? null : json["driving_distance"],
    isReturn: json["is_return"] == null ? null : json["is_return"],
    addresses: json["addresses"],
    ntmDataFullRoute: json["ntm_data_full_route"],
    isHiddenEnvironment: json["is_hidden_environment"] == null ? null : json["is_hidden_environment"],
    transportStatus: json["transport_status"] == null ? null : json["transport_status"],
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    subProjectName: json["sub_project_name"] == null ? null : json["sub_project_name"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id == null ? null : id,
    "project_id": projectId == null ? null : projectId,
    "request_from_date_time": requestFromDateTime == null ? null : requestFromDateTime,
    "request_to_date_time": requestToDateTime == null ? null : requestToDateTime,
    "contractor_id": contractorId == null ? null : contractorId,
    "responsible_person_id": responsiblePersonId == null ? null : responsiblePersonId,
    "description": description == null ? null : description,
    "image_name": imageName,
    "created_by": createdBy == null ? null : createdBy,
    "organization_id": organizationId == null ? null : organizationId,
    "terminal_id": terminalId == null ? null : terminalId,
    "item_id": itemId == null ? null : itemId,
    "item_name": itemName == null ? null : itemName,
    "no_of_pallets": noOfPallets == null ? null : noOfPallets,
    "sub_project_id": subProjectId == null ? null : subProjectId,
    "status": status == null ? null : status,
    "request_type": requestType == null ? null : requestType,
    "is_hidden": isHidden == null ? null : isHidden,
    "unbooked": unbooked == null ? null : unbooked,
    "resource_array": resourceArray == null ? null : List<dynamic>.from(resourceArray!.map((x) => x)),
    "delivery_supplier": deliverySupplier == null ? null : deliverySupplier,
    "load_weight": loadWeight == null ? null : loadWeight,
    "driving_distance": drivingDistance == null ? null : drivingDistance,
    "is_return": isReturn == null ? null : isReturn,
    "addresses": addresses,
    "ntm_data_full_route": ntmDataFullRoute,
    "is_hidden_environment": isHiddenEnvironment == null ? null : isHiddenEnvironment,
    "transport_status": transportStatus == null ? null : transportStatus,
    "updated_at": updatedAt == null ? null : updatedAt,
    "created_at": createdAt == null ? null : createdAt,
    "sub_project_name": subProjectName == null ? null : subProjectName,
  };
}
