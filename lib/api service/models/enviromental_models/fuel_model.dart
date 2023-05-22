// To parse this JSON data, do
//
//     final fuelModel = fuelModelFromJson(jsonString);

import 'dart:convert';

List<FuelModel> fuelModelFromJson(String str) => List<FuelModel>.from(json.decode(str).map((x) => FuelModel.fromJson(x)));

String fuelModelToJson(List<FuelModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FuelModel {
  FuelModel({
    required this.id,
    required this.fuelName,
    required this.ntmId,
    required this.updatedAt,
    required this.createdAt,
  });

  String id;
  String fuelName;
  String ntmId;
  DateTime? updatedAt;
  DateTime? createdAt;

  factory FuelModel.fromJson(Map<String, dynamic> json) => FuelModel(
    id: json["_id"] == null ? null : json["_id"],
    fuelName: json["fuel_name"] == null ? null : json["fuel_name"],
    ntmId: json["ntm_id"] == null ? null : json["ntm_id"],
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id == null ? null : id,
    "fuel_name": fuelName == null ? null : fuelName,
    "ntm_id": ntmId == null ? null : ntmId,
    "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
    "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
  };
}
