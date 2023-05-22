

import 'dart:convert';

ApdPlanModel apdPlanModelFromJson(String str) => ApdPlanModel.fromJson(json.decode(str));

String apdPlanModelToJson(ApdPlanModel data) => json.encode(data.toJson());

class ApdPlanModel {
  ApdPlanModel({
    required this.success,
    required this.result,
  });

  bool success;
  List<Result> result;

  factory ApdPlanModel.fromJson(Map<String, dynamic> json) => ApdPlanModel(
    success: json["success"],
    result: List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "result": List<dynamic>.from(result.map((x) => x.toJson())),
  };
}

class Result {
  Result({
    required this.id,
    required this.projectId,
    required this.fileName,
    required this.filePath,
    required this.originalName,
    required this.updatedAt,
    required this.createdAt,
  });

  String id;
  String projectId;
  String fileName;
  String filePath;
  String originalName;
  DateTime updatedAt;
  DateTime createdAt;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["_id"],
    projectId: json["project_id"],
    fileName: json["file_name"],
    filePath: json["file_path"],
    originalName: json["original_name"],
    updatedAt: DateTime.parse(json["updated_at"]),
    createdAt: DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "project_id": projectId,
    "file_name": fileName,
    "file_path": filePath,
    "original_name": originalName,
    "updated_at": updatedAt.toIso8601String(),
    "created_at": createdAt.toIso8601String(),
  };
}
