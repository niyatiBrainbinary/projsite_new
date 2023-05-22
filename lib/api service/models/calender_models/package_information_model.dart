import 'dart:convert';

PackageIInformationModel packageIInformationModelFromJson(String str) => PackageIInformationModel.fromJson(json.decode(str));

String packageIInformationModelToJson(PackageIInformationModel data) => json.encode(data.toJson());

class PackageIInformationModel {
  PackageIInformationModel({
    required this.success,
    required this.data,
  });

  bool success;
  List<Information>? data;

  factory PackageIInformationModel.fromJson(Map<String, dynamic> json) => PackageIInformationModel(
    success: json["success"] == null ? null : json["success"],
    data: json["data"] == null ? null : List<Information>.from(json["data"].map((x) => Information.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success == null ? null : success,
    "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Information {
  Information({
    required this.id,
    required this.name,
    required this.value,
  });

  String id;
  String name;
  bool value;

  factory Information.fromJson(Map<String, dynamic> json) => Information(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
    value: json["value"] == null ? null : json["value"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
    "value": value == null ? null : value,
  };
}
