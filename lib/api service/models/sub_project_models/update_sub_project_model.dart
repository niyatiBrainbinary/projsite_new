

import 'dart:convert';

UpdateSubProjectModel updateSubProjectModelFromJson(String str) => UpdateSubProjectModel.fromJson(json.decode(str));

String updateSubProjectModelToJson(UpdateSubProjectModel data) => json.encode(data.toJson());

class UpdateSubProjectModel {
  bool? success;
  List<dynamic>? error;

  UpdateSubProjectModel({
    this.success,
    this.error,
  });

  factory UpdateSubProjectModel.fromJson(Map<String, dynamic> json) => UpdateSubProjectModel(
    success: json["success"],
    error: json["error"] == null ? [] : List<dynamic>.from(json["error"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "error": error == null ? [] : List<dynamic>.from(error!.map((x) => x)),
  };
}
