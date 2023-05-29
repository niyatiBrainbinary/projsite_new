// To parse this JSON data, do
//
//     final statisticSaveModel = statisticSaveModelFromJson(jsonString);

import 'dart:convert';

StatisticSaveModel statisticSaveModelFromJson(String str) => StatisticSaveModel.fromJson(json.decode(str));

String statisticSaveModelToJson(StatisticSaveModel data) => json.encode(data.toJson());

class StatisticSaveModel {
  bool? success;
  List<dynamic>? error;

  StatisticSaveModel({
    this.success,
    this.error,
  });

  factory StatisticSaveModel.fromJson(Map<String, dynamic> json) => StatisticSaveModel(
    success: json["success"],
    error: json["error"] == null ? [] : List<dynamic>.from(json["error"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "error": error == null ? [] : List<dynamic>.from(error!.map((x) => x)),
  };
}
