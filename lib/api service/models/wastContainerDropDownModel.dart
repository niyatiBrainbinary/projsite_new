// To parse this JSON data, do
//
//     final wasteContainerDropDownModel = wasteContainerDropDownModelFromJson(jsonString);

import 'dart:convert';

WasteContainerDropDownModel wasteContainerDropDownModelFromJson(String str) => WasteContainerDropDownModel.fromJson(json.decode(str));

String wasteContainerDropDownModelToJson(WasteContainerDropDownModel data) => json.encode(data.toJson());

class WasteContainerDropDownModel {
  bool? success;
  List<ContainerList>? containerList;

  WasteContainerDropDownModel({
    this.success,
    this.containerList,
  });

  factory WasteContainerDropDownModel.fromJson(Map<String, dynamic> json) => WasteContainerDropDownModel(
    success: json["success"],
    containerList: json["container_list"] == null ? [] : List<ContainerList>.from(json["container_list"]!.map((x) => ContainerList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "container_list": containerList == null ? [] : List<dynamic>.from(containerList!.map((x) => x.toJson())),
  };
}

class ContainerList {
  String? id;
  String? projectId;
  String? wasteContainerName;
  bool? status;
  String? containerVehicle;
  String? containerVehicleFuel;
  String? containerVehicleEuroclass;
  DateTime? updatedAt;
  DateTime? createdAt;
  String? color;

  ContainerList({
    this.id,
    this.projectId,
    this.wasteContainerName,
    this.status,
    this.containerVehicle,
    this.containerVehicleFuel,
    this.containerVehicleEuroclass,
    this.updatedAt,
    this.createdAt,
    this.color,
  });

  factory ContainerList.fromJson(Map<String, dynamic> json) => ContainerList(
    id: json["_id"],
    projectId: json["project_id"],
    wasteContainerName: json["waste_container_name"],
    status: json["status"],
    containerVehicle: json["container_vehicle"],
    containerVehicleFuel: json["container_vehicle_fuel"],
    containerVehicleEuroclass: json["container_vehicle_euroclass"],
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    color: json["color"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "project_id": projectId,
    "waste_container_name": wasteContainerName,
    "status": status,
    "container_vehicle": containerVehicle,
    "container_vehicle_fuel": containerVehicleFuel,
    "container_vehicle_euroclass": containerVehicleEuroclass,
    "updated_at": updatedAt?.toIso8601String(),
    "created_at": createdAt?.toIso8601String(),
    "color": color,
  };
}
