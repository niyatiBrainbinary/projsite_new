// To parse this JSON data, do
//
//     final saveBookingFormModel = saveBookingFormModelFromJson(jsonString);

import 'dart:convert';

SaveBookingFormModel saveBookingFormModelFromJson(String str) => SaveBookingFormModel.fromJson(json.decode(str));

String saveBookingFormModelToJson(SaveBookingFormModel data) => json.encode(data.toJson());

class SaveBookingFormModel {
  SaveBookingFormModel({
    required this.success,
  });

  int success;

  factory SaveBookingFormModel.fromJson(Map<String, dynamic> json) => SaveBookingFormModel(
    success: json["success"] == null ? null : json["success"],
  );

  Map<String, dynamic> toJson() => {
    "success": success == null ? null : success,
  };
}
