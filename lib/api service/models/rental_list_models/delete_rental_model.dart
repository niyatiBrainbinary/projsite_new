

import 'dart:convert';

DeleteRentalModel deleteRentaltModelFromJson(String str) => DeleteRentalModel.fromJson(json.decode(str));

String deleteRentaltModelToJson(DeleteRentalModel data) => json.encode(data.toJson());

class DeleteRentalModel {
  DeleteRentalModel({
    required this.success,
    required this.result,
  });

  bool success;
  int result;

  factory DeleteRentalModel.fromJson(Map<String, dynamic> json) => DeleteRentalModel(
    success: json["success"],
    result: json["result"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "result": result,
  };
}
