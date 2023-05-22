class RentalListModel {
  RentalListModel({
    this.success,
    this.rentalList,
  });

  bool? success;
  List<RentalData>? rentalList;

  factory RentalListModel.fromJson(Map<String, dynamic> json) => RentalListModel(
    success: json["success"] == null ? null : json["success"],
    rentalList: json["rental_list"] == null ? null : List<RentalData>.from(json["rental_list"].map((x) => RentalData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success == null ? null : success,
    "rental_list": rentalList == null ? null : List<dynamic>.from(rentalList!.map((x) => x.toJson())),
  };
}

class RentalData {
  RentalData({
    this.id,
    this.projectId,
    this.arrivalDate,
    this.dueDate,
    this.vendorName,
    this.itemName,
    this.quantity,
    this.description,
    this.createdBy,
    this.organizationId,
    this.updatedAt,
    this.createdAt,
    this.itemImage,
  });

  String? id;
  String? projectId;
  DateTime? arrivalDate;
  DateTime? dueDate;
  String? vendorName;
  String? itemName;
  String? quantity;
  String? description;
  String? createdBy;
  String? organizationId;
  DateTime? updatedAt;
  DateTime? createdAt;
  String? itemImage;

  factory RentalData.fromJson(Map<String, dynamic> json) => RentalData(
    id: json["_id"] == null ? null : json["_id"],
    projectId: json["project_id"] == null ? null : json["project_id"],
    arrivalDate: json["arrival_date"] == null ? null : DateTime.parse(json["arrival_date"]),
    dueDate: json["due_date"] == null ? null : DateTime.parse(json["due_date"]),
    vendorName: json["vendor_name"] == null ? null : json["vendor_name"],
    itemName: json["item_name"] == null ? null : json["item_name"],
    quantity: json["quantity"] == null ? null : json["quantity"],
    description: json["description"] == null ? null : json["description"],
    createdBy: json["created_by"] == null ? null : json["created_by"],
    organizationId: json["organization_id"] == null ? null : json["organization_id"],
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    itemImage: json["item_image"] == null ? null : json["item_image"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id == null ? null : id,
    "project_id": projectId == null ? null : projectId,
    "arrival_date": arrivalDate == null ? null : arrivalDate,
    "due_date": dueDate == null ? null : dueDate,
    "vendor_name": vendorName == null ? null : vendorName,
    "item_name": itemName == null ? null : itemName,
    "quantity": quantity == null ? null : quantity,
    "description": description == null ? null : description,
    "created_by": createdBy == null ? null : createdBy,
    "organization_id": organizationId == null ? null : organizationId,
    "updated_at": updatedAt == null ? null : updatedAt,
    "created_at": createdAt == null ? null : createdAt,
    "item_image": itemImage == null ? null : itemImage,
  };
}
