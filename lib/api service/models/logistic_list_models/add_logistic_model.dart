
class AddLogisticsModel {
  AddLogisticsModel({
    this.success,
    this.result,
  });

  bool? success;
  Result? result;

  factory AddLogisticsModel.fromJson(Map<String, dynamic> json) => AddLogisticsModel(
    success: json["success"] == null ? null : json["success"],
    result: json["result"] == null ? null : Result.fromJson(json["result"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success == null ? null : success,
    "result": result == null ? null : result,
  };
}

class Result {
  Result({
    this.projectId,
    this.terminalId,
    this.itemName,
    this.noOfPallets,
    this.arrivalDate,
    this.subProjectId,
    this.inStock,
    this.description,
    this.createdBy,
    this.companyId,
    this.status,
    this.organizationId,
    this.isActive,
    this.isHidden,
    this.logisticNumber,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  String? projectId;
  String? terminalId;
  String? itemName;
  String? noOfPallets;
  DateTime? arrivalDate;
  String? subProjectId;
  String? inStock;
  String? description;
  dynamic createdBy;
  String? companyId;
  String? status;
  dynamic organizationId;
  bool? isActive;
  bool? isHidden;
  int? logisticNumber;
  DateTime? updatedAt;
  DateTime? createdAt;
  String? id;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    projectId: json["project_id"] == null ? null : json["project_id"],
    terminalId: json["terminal_id"] == null ? null : json["terminal_id"],
    itemName: json["item_name"] == null ? null : json["item_name"],
    noOfPallets: json["no_of_pallets"] == null ? null : json["no_of_pallets"],
    arrivalDate: json["arrival_date"] == null ? null : DateTime.parse(json["arrival_date"]),
    subProjectId: json["sub_project_id"] == null ? null : json["sub_project_id"],
    inStock: json["in_stock"] == null ? null : json["in_stock"],
    description: json["description"] == null ? null : json["description"],
    createdBy: json["created_by"],
    companyId: json["company_id"] == null ? null : json["company_id"],
    status: json["status"] == null ? null : json["status"],
    organizationId: json["organization_id"],
    isActive: json["is_active"] == null ? null : json["is_active"],
    isHidden: json["is_hidden"] == null ? null : json["is_hidden"],
    logisticNumber: json["logistic_number"] == null ? null : json["logistic_number"],
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    id: json["_id"] == null ? null : json["_id"],
  );

  Map<String, dynamic> toJson() => {
    "project_id": projectId == null ? null : projectId,
    "terminal_id": terminalId == null ? null : terminalId,
    "item_name": itemName == null ? null : itemName,
    "no_of_pallets": noOfPallets == null ? null : noOfPallets,
    "arrival_date": arrivalDate == null ? null : arrivalDate,
    "sub_project_id": subProjectId == null ? null : subProjectId,
    "in_stock": inStock == null ? null : inStock,
    "description": description == null ? null : description,
    "created_by": createdBy,
    "company_id": companyId == null ? null : companyId,
    "status": status == null ? null : status,
    "organization_id": organizationId,
    "is_active": isActive == null ? null : isActive,
    "is_hidden": isHidden == null ? null : isHidden,
    "logistic_number": logisticNumber == null ? null : logisticNumber,
    "updated_at": updatedAt == null ? null : updatedAt,
    "created_at": createdAt == null ? null : createdAt,
    "_id": id == null ? null : id,
  };
}
