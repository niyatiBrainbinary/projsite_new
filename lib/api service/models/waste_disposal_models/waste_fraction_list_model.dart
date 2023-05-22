// To parse this JSON data, do
//
//     final wasteFractionListModel = wasteFractionListModelFromJson(jsonString);

import 'dart:convert';

WasteFractionListModel wasteFractionListModelFromJson(String str) => WasteFractionListModel.fromJson(json.decode(str));

String wasteFractionListModelToJson(WasteFractionListModel data) => json.encode(data.toJson());

class WasteFractionListModel {
  WasteFractionListModel({
    this.success,
    this.fractionList,
  });

  bool? success;
  List<FractionList>? fractionList;

  factory WasteFractionListModel.fromJson(Map<String, dynamic> json) => WasteFractionListModel(
    success: json["success"],
    fractionList: List<FractionList>.from(json["fraction_list"].map((x) => FractionList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "fraction_list": List<dynamic>.from(fractionList!.map((x) => x.toJson())),
  };
}

class FractionList {
  FractionList({
    this.id,
    this.projectId,
    this.wasteFractionName,
    this.status,
    this.fractionAddress,
    this.updatedAt,
    this.createdAt,
  });

  String? id;
  ProjectId? projectId;
  String? wasteFractionName;
  bool? status;
  FractionAddress? fractionAddress;
  DateTime? updatedAt;
  DateTime? createdAt;

  factory FractionList.fromJson(Map<String, dynamic> json) => FractionList(
    id: json["_id"],
    projectId: projectIdValues.map[json["project_id"]],
    wasteFractionName: json["waste_fraction_name"],
    status: json["status"],
    fractionAddress: FractionAddress.fromJson(json["fraction_address"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    createdAt: DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "project_id": projectIdValues.reverse[projectId],
    "waste_fraction_name": wasteFractionName,
    "status": status,
    "fraction_address": fractionAddress,
    "updated_at": updatedAt,
    "created_at": createdAt,
  };
}

class FractionAddress {
  FractionAddress({
    this.fractionSelectedAddress,
    this.fractionSelectedAddressLat,
    this.fractionSelectedAddressLng,
  });

  FractionSelectedAddress? fractionSelectedAddress;
  double? fractionSelectedAddressLat;
  double? fractionSelectedAddressLng;

  factory FractionAddress.fromJson(Map<String, dynamic> json) => FractionAddress(
    fractionSelectedAddress: fractionSelectedAddressValues.map[json["fraction_selected_address"]],
    fractionSelectedAddressLat: json["fraction_selected_address_lat"].toDouble(),
    fractionSelectedAddressLng: json["fraction_selected_address_lng"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "fraction_selected_address": fractionSelectedAddressValues.reverse[fractionSelectedAddress],
    "fraction_selected_address_lat": fractionSelectedAddressLat,
    "fraction_selected_address_lng": fractionSelectedAddressLng,
  };
}

enum FractionSelectedAddress { FRSUNDALEDEN_216970_SOLNA_SVERIGE }

final fractionSelectedAddressValues = EnumValues({
  "Frösundaleden 2, 169 70 Solna, Sverige": FractionSelectedAddress.FRSUNDALEDEN_216970_SOLNA_SVERIGE
});

enum ProjectId { THE_6040_DA014_FDAB967583_A7_EB2 }

final projectIdValues = EnumValues({
  "6040da014fdab967583a7eb2": ProjectId.THE_6040_DA014_FDAB967583_A7_EB2
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
