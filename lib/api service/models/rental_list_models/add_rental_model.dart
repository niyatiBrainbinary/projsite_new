
import 'dart:convert';

AddRentalModel addRentalModelFromJson(String str) => AddRentalModel.fromJson(json.decode(str));

String addRentalModelToJson(AddRentalModel data) => json.encode(data.toJson());

class AddRentalModel {
  AddRentalModel({
    required this.success,
    required this.result,
  });

  bool success;
  Result result;

  factory AddRentalModel.fromJson(Map<String, dynamic> json) => AddRentalModel(
    success: json["success"],
    result: Result.fromJson(json["result"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "result": result.toJson(),
  };
}

class Result {
  Result({
    required this.projectId,
    required this.arrivalDate,
    required this.dueDate,
    required this.vendorName,
    required this.itemName,
    required this.quantity,
    required this.description,
    required this.createdBy,
    required this.organizationId,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
  });

  String projectId;
  DateTime arrivalDate;
  DateTime dueDate;
  String vendorName;
  String itemName;
  String quantity;
  String description;
  String createdBy;
  String organizationId;
  DateTime updatedAt;
  DateTime createdAt;
  String id;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    projectId: json["project_id"],
    arrivalDate: DateTime.parse(json["arrival_date"]),
    dueDate: DateTime.parse(json["due_date"]),
    vendorName: json["vendor_name"],
    itemName: json["item_name"],
    quantity: json["quantity"],
    description: json["description"],
    createdBy: json["created_by"],
    organizationId: json["organization_id"],
    updatedAt: DateTime.parse(json["updated_at"]),
    createdAt: DateTime.parse(json["created_at"]),
    id: json["_id"],
  );

  Map<String, dynamic> toJson() => {
    "project_id": projectId,
    "arrival_date": arrivalDate.toIso8601String(),
    "due_date": dueDate.toIso8601String(),
    "vendor_name": vendorName,
    "item_name": itemName,
    "quantity": quantity,
    "description": description,
    "created_by": createdBy,
    "organization_id": organizationId,
    "updated_at": updatedAt.toIso8601String(),
    "created_at": createdAt.toIso8601String(),
    "_id": id,
  };
}
