class ZoneDetailsModel {
  ZoneDetailsModel({
    this.success,
    this.unloadingZoneDetails,
  });

  bool? success;
  UnloadingZoneDetails? unloadingZoneDetails;

  factory ZoneDetailsModel.fromJson(Map<String, dynamic> json) => ZoneDetailsModel(
    success: json["success"],
    unloadingZoneDetails: UnloadingZoneDetails.fromJson(json["unloading_zone_details"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "unloading_zone_details": unloadingZoneDetails,
  };
}

class UnloadingZoneDetails {
  UnloadingZoneDetails({
    this.id,
    this.unloadingZoneName,
    this.zoneColor,
    this.projectId,
    this.organizationId,
    this.updatedAt,
    this.createdAt,
    this.isDeleted,
  });

  String? id;
  String? unloadingZoneName;
  String? zoneColor;
  String? projectId;
  String? organizationId;
  DateTime? updatedAt;
  DateTime? createdAt;
  bool? isDeleted;

  factory UnloadingZoneDetails.fromJson(Map<String, dynamic> json) => UnloadingZoneDetails(
    id: json["_id"],
    unloadingZoneName: json["unloading_zone_name"],
    zoneColor: json["zone_color"],
    projectId: json["project_id"],
    organizationId: json["organization_id"],
    updatedAt: DateTime.parse(json["updated_at"]),
    createdAt: DateTime.parse(json["created_at"]),
    isDeleted: json["is_deleted"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "unloading_zone_name": unloadingZoneName,
    "zone_color": zoneColor,
    "project_id": projectId,
    "organization_id": organizationId,
    "updated_at": updatedAt,
    "created_at": createdAt,
    "is_deleted": isDeleted,
  };
}
