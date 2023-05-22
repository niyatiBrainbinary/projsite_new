
import 'dart:convert';

DeleteApdPlanModel deleteApdPlanModelFromJson(String str) => DeleteApdPlanModel.fromJson(json.decode(str));

String deleteApdPlanModelToJson(DeleteApdPlanModel data) => json.encode(data.toJson());

class DeleteApdPlanModel {
  DeleteApdPlanModel({
    required this.success,
  });

  bool success;

  factory DeleteApdPlanModel.fromJson(Map<String, dynamic> json) => DeleteApdPlanModel(
    success: json["success"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
  };
}
