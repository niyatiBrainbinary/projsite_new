
import 'dart:convert';

CheckoutLogisticModel checkoutLogisticModelFromJson(String str) => CheckoutLogisticModel.fromJson(json.decode(str));

String checkoutLogisticModelToJson(CheckoutLogisticModel data) => json.encode(data.toJson());

class CheckoutLogisticModel {
  CheckoutLogisticModel({
    required this.success,
    required this.result,
  });

  bool success;
  int result;

  factory CheckoutLogisticModel.fromJson(Map<String, dynamic> json) => CheckoutLogisticModel(
    success: json["success"] == null ? null : json["success"],
    result: json["result"] == null ? null : json["result"],
  );

  Map<String, dynamic> toJson() => {
    "success": success == null ? null : success,
    "result": result == null ? null : result,
  };
}
