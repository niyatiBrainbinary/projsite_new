

import 'dart:convert';

AddNewSubProjectModel addNewSubProjectModelFromJson(String str) => AddNewSubProjectModel.fromJson(json.decode(str));

String addNewSubProjectModelToJson(AddNewSubProjectModel data) => json.encode(data.toJson());

class AddNewSubProjectModel {
  bool? success;
  List<dynamic>? error;

  AddNewSubProjectModel({
    this.success,
    this.error,
  });

  factory AddNewSubProjectModel.fromJson(Map<String, dynamic> json) => AddNewSubProjectModel(
    success: json["success"],
    error: json["error"] == null ? [] : List<dynamic>.from(json["error"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "error": error == null ? [] : List<dynamic>.from(error!.map((x) => x)),
  };
}
