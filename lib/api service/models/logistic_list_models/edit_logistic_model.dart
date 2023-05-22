

import 'dart:convert';

EditLogisticModel editLogisticModelFromJson(String str) => EditLogisticModel.fromJson(json.decode(str));

String editLogisticModelToJson(EditLogisticModel data) => json.encode(data.toJson());

class EditLogisticModel {
  EditLogisticModel({
    required this.success,
    required this.result,
  });

  bool success;
  int result;

  factory EditLogisticModel.fromJson(Map<String, dynamic> json) => EditLogisticModel(
    success: json["success"] == null ? null : json["success"],
    result: json["result"] == null ? null : json["result"],
  );

  Map<String, dynamic> toJson() => {
    "success": success == null ? null : success,
    "result": result == null ? null : result,
  };
}
