
import 'dart:convert';

DeleteLogisticModel deleteLogisticModelFromJson(String str) => DeleteLogisticModel.fromJson(json.decode(str));

String deleteLogisticModelToJson(DeleteLogisticModel data) => json.encode(data.toJson());

class DeleteLogisticModel {
  DeleteLogisticModel({
    required this.success,
  });

  bool success;

  factory DeleteLogisticModel.fromJson(Map<String, dynamic> json) => DeleteLogisticModel(
    success: json["success"] == null ? null : json["success"],
  );

  Map<String, dynamic> toJson() => {
    "success": success == null ? null : success,
  };
}
