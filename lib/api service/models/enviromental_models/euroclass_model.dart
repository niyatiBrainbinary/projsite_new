
import 'dart:convert';

List<EuroclassModel> euroclassModelFromJson(String str) => List<EuroclassModel>.from(json.decode(str).map((x) => EuroclassModel.fromJson(x)));

String euroclassModelToJson(List<EuroclassModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class EuroclassModel {
  EuroclassModel({
    required this.id,
    required this.euroclassName,
    required this.ntmId,
    required this.updatedAt,
    required this.createdAt,
  });

  String id;
  String euroclassName;
  String ntmId;
  DateTime? updatedAt;
  DateTime? createdAt;

  factory EuroclassModel.fromJson(Map<String, dynamic> json) => EuroclassModel(
    id: json["_id"] == null ? null : json["_id"],
    euroclassName: json["euroclass_name"] == null ? null : json["euroclass_name"],
    ntmId: json["ntm_id"] == null ? null : json["ntm_id"],
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id == null ? null : id,
    "euroclass_name": euroclassName == null ? null : euroclassName,
    "ntm_id": ntmId == null ? null : ntmId,
    "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
    "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
  };
}
