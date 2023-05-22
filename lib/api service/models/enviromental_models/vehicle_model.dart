// To parse this JSON data, do
//
//     final vehicleModel = vehicleModelFromJson(jsonString);

import 'dart:convert';

List<VehicleModel> vehicleModelFromJson(String str) => List<VehicleModel>.from(json.decode(str).map((x) => VehicleModel.fromJson(x)));

String vehicleModelToJson(List<VehicleModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class VehicleModel {
  VehicleModel({
    required this.id,
    required this.vehicleName,
    required this.ntmId,
    required this.ntmFuels,
    required this.ntmEuroclass,
    required this.updatedAt,
    required this.createdAt,
  });

  String id;
  String vehicleName;
  String ntmId;
  List<String>?ntmFuels;
  List<NtmEuroclass>? ntmEuroclass;
  DateTime? updatedAt;
  DateTime? createdAt;

  factory VehicleModel.fromJson(Map<String, dynamic> json) => VehicleModel(
    id: json["_id"] == null ? null : json["_id"],
    vehicleName: json["vehicle_name"] == null ? null : json["vehicle_name"],
    ntmId: json["ntm_id"] == null ? null : json["ntm_id"],
    ntmFuels: json["ntm_fuels"] == null ? null : List<String>.from(json["ntm_fuels"].map((x) => x)),
    ntmEuroclass: json["ntm_euroclass"] == null ? null : List<NtmEuroclass>.from(json["ntm_euroclass"].map((x) => ntmEuroclassValues.map[x])),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id == null ? null : id,
    "vehicle_name": vehicleName == null ? null : vehicleName,
    "ntm_id": ntmId == null ? null : ntmId,
    "ntm_fuels": ntmFuels == null ? null : List<dynamic>.from(ntmFuels!.map((x) => x)),
    "ntm_euroclass": ntmEuroclass == null ? null : List<dynamic>.from(ntmEuroclass!.map((x) => ntmEuroclassValues.reverse[x])),
    "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
    "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
  };
}

enum NtmEuroclass { EURO_1, EURO_2, EURO_3, EURO_4, EURO_4_SCR, EURO_4_EGR, EURO_5, EURO_5_SCR, EURO_5_EGR, EURO_6 }

final ntmEuroclassValues = EnumValues({
  "euro_1": NtmEuroclass.EURO_1,
  "euro_2": NtmEuroclass.EURO_2,
  "euro_3": NtmEuroclass.EURO_3,
  "euro_4": NtmEuroclass.EURO_4,
  "euro_4_egr": NtmEuroclass.EURO_4_EGR,
  "euro_4_scr": NtmEuroclass.EURO_4_SCR,
  "euro_5": NtmEuroclass.EURO_5,
  "euro_5_egr": NtmEuroclass.EURO_5_EGR,
  "euro_5_scr": NtmEuroclass.EURO_5_SCR,
  "euro_6": NtmEuroclass.EURO_6
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
