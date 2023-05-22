
class UpdateShipmentModel {
  UpdateShipmentModel({
    required this.success,
    required this.result,
    required this.requestIds,
  });

  dynamic success;
  dynamic result;
  List<dynamic>? requestIds;

  factory UpdateShipmentModel.fromJson(Map<String, dynamic> json) => UpdateShipmentModel(
    success: json["success"] == null ? null : json["success"],
    result: json["result"] == null ? null : json["result"],
    requestIds: json["request_ids"] == null ? null : List<dynamic>.from(json["request_ids"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "success": success == null ? null : success,
    "result": result == null ? null : result,
    "request_ids": requestIds == null ? null : List<dynamic>.from(requestIds!.map((x) => x)),
  };
}
