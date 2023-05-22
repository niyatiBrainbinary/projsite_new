
class LogisticRequestDataModel {
  LogisticRequestDataModel({
    this.success,
    this.result,
  });

  bool? success;
  Result? result;

  factory LogisticRequestDataModel.fromJson(Map<String, dynamic> json) => LogisticRequestDataModel(
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
    this.terminalId,
    this.requestFromDateTime,
    this.requestToDateTime,
    this.resourceArray,
    this.responsiblePersonId,
    this.checkoutsArray,
    this.createdBy,
    this.status,
    this.requestType,
    this.organizationId,
    this.transportStatus,
    this.unloadingZoneId,
    this.description,
    this.subProjectId,
    this.isHidden,
    this.unbooked,
    this.deliverySupplier,
    this.loadWeight,
    this.drivingDistance,
    this.isReturn,
    this.addresses,
    this.ntmDataFullRoute,
    this.isHiddenEnvironment,
    this.updatedAt,
    this.createdAt,
    this.subProjectName,
    this.checkoutsList,
  });

  String? id;
  String? projectId;
  String? terminalId;
  DateTime? requestFromDateTime;
  DateTime? requestToDateTime;
  List<String>? resourceArray;
  String? responsiblePersonId;
  List<String>? checkoutsArray;
  String? createdBy;
  String? status;
  String? requestType;
  String? organizationId;
  String? transportStatus;
  String? unloadingZoneId;
  dynamic description;
  String? subProjectId;
  bool? isHidden;
  bool? unbooked;
  String? deliverySupplier;
  String? loadWeight;
  String? drivingDistance;
  String? isReturn;
  List<dynamic>? addresses;
  dynamic ntmDataFullRoute;
  bool? isHiddenEnvironment;
  DateTime? updatedAt;
  DateTime? createdAt;
  String? subProjectName;
  List<CheckoutsList>? checkoutsList;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["_id"] == null ? null : json["_id"],
    projectId: json["project_id"] == null ? null : json["project_id"],
    terminalId: json["terminal_id"] == null ? null : json["terminal_id"],
    requestFromDateTime: json["request_from_date_time"] == null ? null : DateTime.parse(json["request_from_date_time"]),
    requestToDateTime: json["request_to_date_time"] == null ? null : DateTime.parse(json["request_to_date_time"]),
    resourceArray: json["resource_array"] == null ? null : List<String>.from(json["resource_array"].map((x) => x)),
    responsiblePersonId: json["responsible_person_id"] == null ? null : json["responsible_person_id"],
    checkoutsArray: json["checkouts_array"] == null ? null : List<String>.from(json["checkouts_array"].map((x) => x)),
    createdBy: json["created_by"] == null ? null : json["created_by"],
    status: json["status"] == null ? null : json["status"],
    requestType: json["request_type"] == null ? null : json["request_type"],
    organizationId: json["organization_id"] == null ? null : json["organization_id"],
    transportStatus: json["transport_status"] == null ? null : json["transport_status"],
    unloadingZoneId: json["unloading_zone_id"] == null ? null : json["unloading_zone_id"],
    description: json["description"],
    subProjectId: json["sub_project_id"] == null ? null : json["sub_project_id"],
    isHidden: json["is_hidden"] == null ? null : json["is_hidden"],
    unbooked: json["unbooked"] == null ? null : json["unbooked"],
    deliverySupplier: json["delivery_supplier"] == null ? null : json["delivery_supplier"],
    loadWeight: json["load_weight"] == null ? null : json["load_weight"],
    drivingDistance: json["driving_distance"] == null ? null : json["driving_distance"],
    isReturn: json["is_return"] == null ? null : json["is_return"],
    addresses: json["addresses"] == null ? null : List<dynamic>.from(json["addresses"].map((x) => x)),
    ntmDataFullRoute: json["ntm_data_full_route"],
    isHiddenEnvironment: json["is_hidden_environment"] == null ? null : json["is_hidden_environment"],
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    subProjectName: json["sub_project_name"] == null ? null : json["sub_project_name"],
    checkoutsList: json["checkouts_list"] == null ? null : List<CheckoutsList>.from(json["checkouts_list"].map((x) => CheckoutsList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "_id": id == null ? null : id,
    "project_id": projectId == null ? null : projectId,
    "terminal_id": terminalId == null ? null : terminalId,
    "request_from_date_time": requestFromDateTime == null ? null : requestFromDateTime,
    "request_to_date_time": requestToDateTime == null ? null : requestToDateTime,
    "resource_array": resourceArray == null ? null : List<dynamic>.from(resourceArray!.map((x) => x)),
    "responsible_person_id": responsiblePersonId == null ? null : responsiblePersonId,
    "checkouts_array": checkoutsArray == null ? null : List<dynamic>.from(checkoutsArray!.map((x) => x)),
    "created_by": createdBy == null ? null : createdBy,
    "status": status == null ? null : status,
    "request_type": requestType == null ? null : requestType,
    "organization_id": organizationId == null ? null : organizationId,
    "transport_status": transportStatus == null ? null : transportStatus,
    "unloading_zone_id": unloadingZoneId == null ? null : unloadingZoneId,
    "description": description,
    "sub_project_id": subProjectId == null ? null : subProjectId,
    "is_hidden": isHidden == null ? null : isHidden,
    "unbooked": unbooked == null ? null : unbooked,
    "delivery_supplier": deliverySupplier == null ? null : deliverySupplier,
    "load_weight": loadWeight == null ? null : loadWeight,
    "driving_distance": drivingDistance == null ? null : drivingDistance,
    "is_return": isReturn == null ? null : isReturn,
    "addresses": addresses == null ? null : List<dynamic>.from(addresses!.map((x) => x)),
    "ntm_data_full_route": ntmDataFullRoute,
    "is_hidden_environment": isHiddenEnvironment == null ? null : isHiddenEnvironment,
    "updated_at": updatedAt == null ? null : updatedAt,
    "created_at": createdAt == null ? null : createdAt,
    "sub_project_name": subProjectName == null ? null : subProjectName,
    "checkouts_list": checkoutsList == null ? null : List<dynamic>.from(checkoutsList!.map((x) => x.toJson())),
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
    this.isHidden,
  });

  String? id;
  String? logisticId;
  DateTime? releaseDate;
  String? releaseQuantity;
  String? currentStock;
  String? status;
  String? createdBy;
  DateTime? updatedAt;
  DateTime? createdAt;
  DateTime? dateRequested;
  String? itemName;
  String? terminalName;
  String? entreprenuerName;
  String? createdByPersonName;
  bool? isHidden;

  factory CheckoutsList.fromJson(Map<String, dynamic> json) => CheckoutsList(
    id: json["_id"] == null ? null : json["_id"],
    logisticId: json["logistic_id"] == null ? null : json["logistic_id"],
    releaseDate: json["release_date"] == null ? null : DateTime.parse(json["release_date"]),
    releaseQuantity: json["release_quantity"] == null ? null : json["release_quantity"],
    currentStock: json["current_stock"] == null ? null : json["current_stock"],
    status: json["status"] == null ? null : json["status"],
    createdBy: json["created_by"] == null ? null : json["created_by"],
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    dateRequested: json["date_requested"] == null ? null : DateTime.parse(json["date_requested"]),
    itemName: json["item_name"] == null ? null : json["item_name"],
    terminalName: json["terminal_name"] == null ? null : json["terminal_name"],
    entreprenuerName: json["entreprenuer_name"] == null ? null : json["entreprenuer_name"],
    createdByPersonName: json["created_by_person_name"] == null ? null : json["created_by_person_name"],
    isHidden: json["is_hidden"] == null ? null : json["is_hidden"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id == null ? null : id,
    "logistic_id": logisticId == null ? null : logisticId,
    "release_date": releaseDate == null ? null : "${releaseDate!.year.toString().padLeft(4, '0')}-${releaseDate!.month.toString().padLeft(2, '0')}-${releaseDate!.day.toString().padLeft(2, '0')}",
    "release_quantity": releaseQuantity == null ? null : releaseQuantity,
    "current_stock": currentStock == null ? null : currentStock,
    "status": status == null ? null : status,
    "created_by": createdBy == null ? null : createdBy,
    "updated_at": updatedAt == null ? null : updatedAt,
    "created_at": createdAt == null ? null : createdAt,
    "date_requested": dateRequested == null ? null : dateRequested,
    "item_name": itemName == null ? null : itemName,
    "terminal_name": terminalName == null ? null : terminalName,
    "entreprenuer_name": entreprenuerName == null ? null : entreprenuerName,
    "created_by_person_name": createdByPersonName == null ? null : createdByPersonName,
    "is_hidden": isHidden == null ? null : isHidden,
  };
}
