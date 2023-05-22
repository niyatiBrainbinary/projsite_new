

import 'dart:convert';

NotTransportedCheckoutsModel notTransportedCheckoutsModelFromJson(String str) => NotTransportedCheckoutsModel.fromJson(json.decode(str));

String notTransportedCheckoutsModelToJson(NotTransportedCheckoutsModel data) => json.encode(data.toJson());

class NotTransportedCheckoutsModel {
  NotTransportedCheckoutsModel({
    required this.success,
    required this.checkOuts,
  });

  bool success;
  List<CheckOutTransportHistory>? checkOuts;

  factory NotTransportedCheckoutsModel.fromJson(Map<String, dynamic> json) => NotTransportedCheckoutsModel(
    success: json["success"] == null ? null : json["success"],
    checkOuts: json["check_outs"] == null ? null : List<CheckOutTransportHistory>.from(json["check_outs"].map((x) => CheckOutTransportHistory.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success == null ? null : success,
    "check_outs": checkOuts == null ? null : List<dynamic>.from(checkOuts!.map((x) => x.toJson())),
  };
}

class CheckOutTransportHistory {
  CheckOutTransportHistory({
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
    required this.itemName,
    required this.createdByPersonName,
  });

  String id;
  String logisticId;
  DateTime? releaseDate;
  String releaseQuantity;
  String currentStock;
  String status;
  String createdBy;
  bool isHidden;
  DateTime? updatedAt;
  DateTime?createdAt;
  String itemName;
  String createdByPersonName;

  factory CheckOutTransportHistory.fromJson(Map<String, dynamic> json) => CheckOutTransportHistory(
    id: json["_id"] == null ? null : json["_id"],
    logisticId: json["logistic_id"] == null ? null : json["logistic_id"],
    releaseDate: json["release_date"] == null ? null : DateTime.parse(json["release_date"]),
    releaseQuantity: json["release_quantity"] == null ? null : json["release_quantity"],
    currentStock: json["current_stock"] == null ? null : json["current_stock"],
    status: json["status"] == null ? null : json["status"],
    createdBy: json["created_by"] == null ? null : json["created_by"],
    isHidden: json["is_hidden"] == null ? null : json["is_hidden"],
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    itemName: json["item_name"] == null ? null : json["item_name"],
    createdByPersonName: json["created_by_person_name"] == null ? null : json["created_by_person_name"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id == null ? null : id,
    "logistic_id": logisticId == null ? null : logisticId,
    "release_date": releaseDate == null ? null : "${releaseDate?.year.toString().padLeft(4, '0')}-${releaseDate?.month.toString().padLeft(2, '0')}-${releaseDate?.day.toString().padLeft(2, '0')}",
    "release_quantity": releaseQuantity == null ? null : releaseQuantity,
    "current_stock": currentStock == null ? null : currentStock,
    "status": status == null ? null : status,
    "created_by": createdBy == null ? null : createdBy,
    "is_hidden": isHidden == null ? null : isHidden,
    "updated_at": updatedAt == null ? null : updatedAt?.toIso8601String(),
    "created_at": createdAt == null ? null : createdAt?.toIso8601String(),
    "item_name": itemName == null ? null : itemName,
    "created_by_person_name": createdByPersonName == null ? null : createdByPersonName,
  };
}
