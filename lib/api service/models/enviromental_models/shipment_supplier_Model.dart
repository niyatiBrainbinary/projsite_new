// To parse this JSON data, do
//
//     final shipmentSupplierModel = shipmentSupplierModelFromJson(jsonString);

import 'dart:convert';

ShipmentSupplierModel shipmentSupplierModelFromJson(String str) => ShipmentSupplierModel.fromJson(json.decode(str));

String shipmentSupplierModelToJson(ShipmentSupplierModel data) => json.encode(data.toJson());

class ShipmentSupplierModel {
  ShipmentSupplierModel({
    required this.success,
    required this.shipmentSupplierList,
  });

  bool success;
  List<ShipmentSupplierList>? shipmentSupplierList;

  factory ShipmentSupplierModel.fromJson(Map<String, dynamic> json) => ShipmentSupplierModel(
    success: json["success"] == null ? null : json["success"],
    shipmentSupplierList: json["shipment_supplier_list"] == null ? null : List<ShipmentSupplierList>.from(json["shipment_supplier_list"].map((x) => ShipmentSupplierList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success == null ? null : success,
    "shipment_supplier_list": shipmentSupplierList == null ? null : List<dynamic>.from(shipmentSupplierList!.map((x) => x.toJson())),
  };
}

class ShipmentSupplierList {
  ShipmentSupplierList({
    required this.id,
    required this.shipmentSupplierName,
    required this.projectId,
    required this.updatedAt,
    required this.createdAt,
  });

  String id;
  String shipmentSupplierName;
  ProjectId? projectId;
  DateTime? updatedAt;
  DateTime? createdAt;

  factory ShipmentSupplierList.fromJson(Map<String, dynamic> json) => ShipmentSupplierList(
    id: json["_id"] == null ? null : json["_id"],
    shipmentSupplierName: json["shipment_supplier_name"] == null ? null : json["shipment_supplier_name"],
    projectId: json["project_id"] == null ? null : projectIdValues.map[json["project_id"]],
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id == null ? null : id,
    "shipment_supplier_name": shipmentSupplierName == null ? null : shipmentSupplierName,
    "project_id": projectId == null ? null : projectIdValues.reverse[projectId],
    "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
    "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
  };
}

enum ProjectId { THE_6040_DA014_FDAB967583_A7_EB2 }

final projectIdValues = EnumValues({
  "6040da014fdab967583a7eb2": ProjectId.THE_6040_DA014_FDAB967583_A7_EB2
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap!;
  }
}
