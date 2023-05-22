class CreateSupplierModel {
  CreateSupplierModel({
    this.success,
    this.error,
    this.shipmentSupplierId,
  });

  bool? success;
  List<dynamic>? error;
  String? shipmentSupplierId;

  factory CreateSupplierModel.fromJson(Map<String, dynamic> json) => CreateSupplierModel(
    success: json["success"] == null ? null : json["success"],
    error: json["error"] == null ? null : List<dynamic>.from(json["error"].map((x) => x)),
    shipmentSupplierId: json["shipment_supplier_id"] == null ? null : json["shipment_supplier_id"],
  );

  Map<String, dynamic> toJson() => {
    "success": success == null ? null : success,
    "error": error == null ? null : List<dynamic>.from(error!.map((x) => x)),
    "shipment_supplier_id": shipmentSupplierId == null ? null : shipmentSupplierId,
  };
}