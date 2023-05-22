
class RequestDataModel {
  RequestDataModel({
    this.success,
    this.result,
  });

  bool? success;
  Result? result;

  factory RequestDataModel.fromJson(Map<String, dynamic> json) => RequestDataModel(
    success: json["success"] == null ? null : json["success"],
    result: json["result"] == null ? null : Result.fromJson(json["result"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success == null ? null : success,
    "result": result == null ? null : result!.toJson(),
  };
}

class Result {
  Result({
    this.id,
    this.projectId,
    this.requestFromDateTime,
    this.requestToDateTime,
    this.resourceArray,
    this.unloadingZoneId,
    this.contractorId,
    this.responsiblePersonId,
    this.subProjectId,
    this.description,
    this.instruction,
    this.imageName,
    this.image,
    this.isRecurring,
    this.recurringId,
    this.recurringDays,
    this.recurringToDate,
    this.createdBy,
    this.status,
    this.requestType,
    this.organizationId,
    this.isHidden,
    this.deliverySupplier,
    this.loadWeight,
    this.drivingDistance,
    this.isReturn,
    this.addresses,
    this.ntmDataFullRoute,
    this.kollis,
    this.unbooked,
    this.isHiddenEnvironment,
    this.transportStatus,
    this.updatedAt,
    this.createdAt,
    this.noOfPallet,
  });

  String? id;
  String? projectId;
  DateTime? requestFromDateTime;
  DateTime? requestToDateTime;
  List<String>? resourceArray;
  String? unloadingZoneId;
  String? contractorId;
  String? responsiblePersonId;
  dynamic subProjectId;
  dynamic description;
  dynamic instruction;
  dynamic imageName;
  dynamic image;
  dynamic isRecurring;
  dynamic recurringId;
  dynamic recurringDays;
  dynamic recurringToDate;
  String? createdBy;
  String? status;
  String? requestType;
  String? organizationId;
  dynamic isHidden;
  dynamic deliverySupplier;
  dynamic loadWeight;
  dynamic drivingDistance;
  dynamic isReturn;
  List<Address>? addresses;
  dynamic ntmDataFullRoute;
  List<Kolli>? kollis;
  dynamic unbooked;
  bool? isHiddenEnvironment;
  String? transportStatus;
  DateTime? updatedAt;
  DateTime? createdAt;
  dynamic noOfPallet;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["_id"] == null ? null : json["_id"],
    projectId: json["project_id"] == null ? null : json["project_id"],
    requestFromDateTime: json["request_from_date_time"] == null ? null : DateTime.parse(json["request_from_date_time"]),
    requestToDateTime: json["request_to_date_time"] == null ? null : DateTime.parse(json["request_to_date_time"]),
    resourceArray: json["resource_array"] == null ? null : List<String>.from(json["resource_array"].map((x) => x)),
    unloadingZoneId: json["unloading_zone_id"] == null ? null : json["unloading_zone_id"],
    contractorId: json["contractor_id"] == null ? null : json["contractor_id"],
    responsiblePersonId: json["responsible_person_id"] == null ? null : json["responsible_person_id"],
    subProjectId: json["sub_project_id"],
    description: json["description"] == null ? null : json["description"],
    instruction: json["instruction"] == null ? null : json["instruction"],
    imageName: json["image_name"],
    image: json["image"],
    isRecurring: json["is_recurring"] == null ? null : json["is_recurring"],
    recurringId: json["recurring_id"],
    recurringDays: json["recurring_days"],
    recurringToDate: json["recurring_to_date"],
    createdBy: json["created_by"] == null ? null : json["created_by"],
    status: json["status"] == null ? null : json["status"],
    requestType: json["request_type"] == null ? null : json["request_type"],
    organizationId: json["organization_id"] == null ? null : json["organization_id"],
    isHidden: json["is_hidden"] == null ? null : json["is_hidden"],
    deliverySupplier: json["delivery_supplier"],
    loadWeight: json["load_weight"],
    drivingDistance: json["driving_distance"],
    isReturn: json["is_return"] == null ? null : json["is_return"],
    addresses: json["addresses"] == null ? null : List<Address>.from(json["addresses"].map((x) => Address.fromJson(x))),
    ntmDataFullRoute: json["ntm_data_full_route"],
    kollis: json["kollis"] == null ? null : List<Kolli>.from(json["kollis"].map((x) => Kolli.fromJson(x))),
    unbooked: json["unbooked"] == null ? null : json["unbooked"],
    isHiddenEnvironment: json["is_hidden_environment"] == null ? null : json["is_hidden_environment"],
    transportStatus: json["transport_status"] == null ? null : json["transport_status"],
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    noOfPallet: json["no_of_pallets"] == null ? null : json["no_of_pallets"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id == null ? null : id,
    "project_id": projectId == null ? null : projectId,
    "request_from_date_time": requestFromDateTime == null ? null : requestFromDateTime,
    "request_to_date_time": requestToDateTime == null ? null : requestToDateTime,
    "resource_array": resourceArray == null ? null : List<dynamic>.from(resourceArray!.map((x) => x)),
    "unloading_zone_id": unloadingZoneId == null ? null : unloadingZoneId,
    "contractor_id": contractorId == null ? null : contractorId,
    "responsible_person_id": responsiblePersonId == null ? null : responsiblePersonId,
    "sub_project_id": subProjectId,
    "description": description == null ? "" : description,
    "instruction": instruction == null ? "" : instruction,
    "image_name": imageName,
    "image": image,
    "is_recurring": isRecurring == null ? null : isRecurring,
    "recurring_id": recurringId,
    "recurring_days": recurringDays,
    "recurring_to_date": recurringToDate,
    "created_by": createdBy == null ? null : createdBy,
    "status": status == null ? null : status,
    "request_type": requestType == null ? null : requestType,
    "organization_id": organizationId == null ? null : organizationId,
    "is_hidden": isHidden == null ? null : isHidden,
    "delivery_supplier": deliverySupplier,
    "load_weight": loadWeight,
    "driving_distance": drivingDistance,
    "is_return": isReturn == null ? null : isReturn,
    "addresses": addresses == null ? null : List<dynamic>.from(addresses!.map((x) => x.toJson())),
    "ntm_data_full_route": ntmDataFullRoute,
    "kollis": kollis == null ? null : List<dynamic>.from(kollis!.map((x) => x.toJson())),
    "unbooked": unbooked == null ? null : unbooked,
    "is_hidden_environment": isHiddenEnvironment == null ? null : isHiddenEnvironment,
    "transport_status": transportStatus == null ? null : transportStatus,
    "updated_at": updatedAt == null ? null : updatedAt,
    "created_at": createdAt == null ? null : createdAt,
    "no_of_pallets": noOfPallet == null ? null : noOfPallet,
  };
}

class Address {
  Address({
    this.id,
    this.place,
    this.lat,
    this.lng,
  });

  String? id;
  String? place;
  String? lat;
  String? lng;

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    id: json["id"] == null ? null : json["id"],
    place: json["place"] == null ? null : json["place"],
    lat: json["lat"] == null ? null : json["lat"],
    lng: json["lng"] == null ? null : json["lng"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "place": place == null ? null : place,
    "lat": lat == null ? null : lat,
    "lng": lng == null ? null : lng,
  };
}

class Kolli {
  Kolli({
    this.id,
    this.value,
    this.amount,
  });

  String? id;
  dynamic value;
  dynamic amount;

  factory Kolli.fromJson(Map<String, dynamic> json) => Kolli(
    id: json["id"] == null ? null : json["id"],
    value: json["value"] == null ? null : json["value"],
    amount: json["amount"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "value": value == null ? null : value,
    "amount": amount,
  };
}
