// To parse this JSON data, do
//
//     final wasteFractionDropDownModel = wasteFractionDropDownModelFromJson(jsonString);

import 'dart:convert';

WasteFractionDropDownModel wasteFractionDropDownModelFromJson(String str) => WasteFractionDropDownModel.fromJson(json.decode(str));

String wasteFractionDropDownModelToJson(WasteFractionDropDownModel data) => json.encode(data.toJson());

class WasteFractionDropDownModel {
  bool? success;
  List<FractionList>? fractionList;

  WasteFractionDropDownModel({
    this.success,
    this.fractionList,
  });

  factory WasteFractionDropDownModel.fromJson(Map<String, dynamic> json) => WasteFractionDropDownModel(
    success: json["success"],
    fractionList: json["fraction_list"] == null ? [] : List<FractionList>.from(json["fraction_list"]!.map((x) => FractionList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "fraction_list": fractionList == null ? [] : List<dynamic>.from(fractionList!.map((x) => x.toJson())),
  };
}

class FractionList {
  String? id;
  String? projectId;
  String? wasteFractionName;
  bool? status;
  FractionAddress? fractionAddress;
  DateTime? updatedAt;
  DateTime? createdAt;
  String? color;

  FractionList({
    this.id,
    this.projectId,
    this.wasteFractionName,
    this.status,
    this.fractionAddress,
    this.updatedAt,
    this.createdAt,
    this.color,
  });

  factory FractionList.fromJson(Map<String, dynamic> json) => FractionList(
    id: json["_id"],
    projectId: json["project_id"],
    wasteFractionName: json["waste_fraction_name"],
    status: json["status"],
    fractionAddress: json["fraction_address"] == null ? null : FractionAddress.fromJson(json["fraction_address"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    color: json["color"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "project_id": projectId,
    "waste_fraction_name": wasteFractionName,
    "status": status,
    "fraction_address": fractionAddress?.toJson(),
    "updated_at": updatedAt?.toIso8601String(),
    "created_at": createdAt?.toIso8601String(),
    "color": color,
  };
}

class FractionAddress {
  String? fractionSelectedAddress;
  double? fractionSelectedAddressLat;
  double? fractionSelectedAddressLng;

  FractionAddress({
    this.fractionSelectedAddress,
    this.fractionSelectedAddressLat,
    this.fractionSelectedAddressLng,
  });

  factory FractionAddress.fromJson(Map<String, dynamic> json) => FractionAddress(
    fractionSelectedAddress: json["fraction_selected_address"],
    fractionSelectedAddressLat: json["fraction_selected_address_lat"]?.toDouble(),
    fractionSelectedAddressLng: json["fraction_selected_address_lng"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "fraction_selected_address": fractionSelectedAddress,
    "fraction_selected_address_lat": fractionSelectedAddressLat,
    "fraction_selected_address_lng": fractionSelectedAddressLng,
  };
}
