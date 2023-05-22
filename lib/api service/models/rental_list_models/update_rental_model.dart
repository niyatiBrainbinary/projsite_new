
import 'dart:convert';

UpdateRentalModel updateRentalModelFromJson(String str) => UpdateRentalModel.fromJson(json.decode(str));

String updateRentalModelToJson(UpdateRentalModel data) => json.encode(data.toJson());

class UpdateRentalModel {
  UpdateRentalModel({
    required this.success,
    required this.result,
  });

  bool success;
  dynamic result;

  factory UpdateRentalModel.fromJson(Map<String, dynamic> json) => UpdateRentalModel(
    success: json["success"],
    result: json["result"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "result": result,
  };
}
