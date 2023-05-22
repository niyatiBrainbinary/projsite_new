

class ZoneListModel {
  ZoneListModel({
    this.success,
    this.unloadingZones,
  });

  bool? success;
  List<UnloadingZone>? unloadingZones;

  factory ZoneListModel.fromJson(Map<String, dynamic> json) => ZoneListModel(
    success: json["success"] == null ? null : json["success"],
    unloadingZones: json["unloading_zones"] == null ? null : List<UnloadingZone>.from(json["unloading_zones"].map((x) => UnloadingZone.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success == null ? null : success,
    "unloading_zones": unloadingZones == null ? null : List<dynamic>.from(unloadingZones!.map((x) => x.toJson())),
  };
}

class UnloadingZone {
  UnloadingZone({
    this.id,
    this.unloadingZoneName,
    this.zoneColor,
    this.projectId,
    this.organizationId,
    this.updatedAt,
    this.createdAt,
    this.projectName,
  });

  String? id;
  String? unloadingZoneName;
  String? zoneColor;
  ProjectId? projectId;
  OrganizationId? organizationId;
  DateTime? updatedAt;
  DateTime? createdAt;
  ProjectName? projectName;

  factory UnloadingZone.fromJson(Map<String, dynamic> json) => UnloadingZone(
    id: json["_id"] == null ? null : json["_id"],
    unloadingZoneName: json["unloading_zone_name"] == null ? null : json["unloading_zone_name"],
    zoneColor: json["zone_color"] == null ? null : json["zone_color"],
    projectId: json["project_id"] == null ? null : projectIdValues.map![json["project_id"]],
    organizationId: json["organization_id"] == null ? null : organizationIdValues.map![json["organization_id"]],
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    projectName: json["project_name"] == null ? null : projectNameValues.map![json["project_name"]],
  );

  Map<String, dynamic> toJson() => {
    "_id": id == null ? null : id,
    "unloading_zone_name": unloadingZoneName == null ? null : unloadingZoneName,
    "zone_color": zoneColor == null ? null : zoneColor,
    "project_id": projectId == null ? null : projectIdValues.reverse[projectId],
    "organization_id": organizationId == null ? null : organizationIdValues.reverse[organizationId],
    "updated_at": updatedAt == null ? null : updatedAt,
    "created_at": createdAt == null ? null : createdAt,
    "project_name": projectName == null ? null : projectNameValues.reverse[projectName],
  };
}

enum OrganizationId { THE_5_FFEB87_C4_FDAB911_F579_A042 }

final organizationIdValues = EnumValues({
  "5ffeb87c4fdab911f579a042": OrganizationId.THE_5_FFEB87_C4_FDAB911_F579_A042
});

enum ProjectId { THE_6040_DA014_FDAB967583_A7_EB2 }

final projectIdValues = EnumValues({
  "6040da014fdab967583a7eb2": ProjectId.THE_6040_DA014_FDAB967583_A7_EB2
});

enum ProjectName { HAGA_NORRA }

final projectNameValues = EnumValues({
  "Haga Norra": ProjectName.HAGA_NORRA
});

class EnumValues<T> {
  Map<String, T>? map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map!.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap!;
  }
}
