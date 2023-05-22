
class WasteContainerListModel {
  WasteContainerListModel({
    this.success,
    this.containerList,
  });

  bool? success;
  List<ContainerList>? containerList;

  factory WasteContainerListModel.fromJson(Map<String, dynamic> json) => WasteContainerListModel(
    success: json["success"],
    containerList: List<ContainerList>.from(json["container_list"].map((x) => ContainerList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "container_list": List<dynamic>.from(containerList!.map((x) => x.toJson())),
  };
}

class ContainerList {
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
  });

  String? id;
  String? projectId;
  String? wasteContainerName;
  bool? status;
  String? containerVehicle;
  String? containerVehicleFuel;
  String? containerVehicleEuroclass;
  DateTime? updatedAt;
  DateTime? createdAt;

  factory ContainerList.fromJson(Map<String, dynamic> json) => ContainerList(
    id: json["_id"],
    projectId: json["project_id"],
    wasteContainerName: json["waste_container_name"],
    status: json["status"],
    containerVehicle: json["container_vehicle"],
    containerVehicleFuel: json["container_vehicle_fuel"],
    containerVehicleEuroclass: json["container_vehicle_euroclass"],
    updatedAt: DateTime.parse(json["updated_at"]),
    createdAt: DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "project_id": projectId,
    "waste_container_name": wasteContainerName,
    "status": status,
    "container_vehicle": containerVehicle,
    "container_vehicle_fuel": containerVehicleFuel,
    "container_vehicle_euroclass": containerVehicleEuroclass,
    "updated_at": updatedAt,
    "created_at": createdAt,
  };
}
