
class EventListModel {
  EventListModel({
    this.success,
    this.requestList,
  });

  dynamic? success;
  List<RequestList>? requestList;

  factory EventListModel.fromJson(Map<dynamic, dynamic> json) => EventListModel(
    success: json["success"] == null ? null : json["success"],
    requestList: json["request_list"] == null ? null : List<RequestList>.from(json["request_list"].map((x) => RequestList.fromJson(x))),
  );

  Map<dynamic, dynamic> toJson() => {
    "success": success == null ? null : success,
    "request_list": requestList == null ? null : List<dynamic>.from(requestList!.map((x) => x.toJson())),
  };
}

class RequestList {
  RequestList({
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
    this.updatedAt,
    this.createdAt,
    this.transportStatus,
    this.arrivedAt,
    this.inProgressAt,
    this.unloadedAt,
    this.projectName,
    this.projectStatus,
    this.projectCheckpoint,
    this.createrName,
    this.email,
    this.phone,
    this.responsiblePersonName,
    this.responsiblePersonEmail,
    this.responsiblePersonPhone,
    this.unloadingZoneName,
    this.zoneColor,
    this.subProjectName,
    this.companyName,
    this.resourceNameArray,
    this.resourcePatternArray,
    this.bookingTime,
    this.ntm,
    this.itemName,
    this.noOfPallets,
    this.terminalId,
    this.checkoutsArray,
    this.checkoutItemNameArray,
    this.checkoutEntreprenuerArray,
    this.checkoutReleaseQuantityArray,
    this.checkoutCreatedByNameArray,
  });

  dynamic? id;
  dynamic? projectId;
  DateTime? requestFromDateTime;
  DateTime? requestToDateTime;
  List<dynamic>? resourceArray;
  dynamic? unloadingZoneId;
  dynamic? contractorId;
  dynamic? responsiblePersonId;
  dynamic? subProjectId;
  dynamic description;
  dynamic instruction;
  dynamic imageName;
  dynamic image;
  dynamic? isRecurring;
  dynamic recurringId;
  dynamic recurringDays;
  dynamic recurringToDate;
  dynamic? createdBy;
  dynamic? status;
  dynamic? requestType;
  dynamic? organizationId;
  dynamic? isHidden;
  dynamic deliverySupplier;
  dynamic loadWeight;
  dynamic drivingDistance;
  dynamic? isReturn;
  List<Address>? addresses;
  dynamic ntmDataFullRoute;
  List<Kolli>? kollis;
  dynamic? unbooked;
  dynamic? isHiddenEnvironment;
  DateTime? updatedAt;
  DateTime? createdAt;
  dynamic? transportStatus;
  dynamic? arrivedAt;
  dynamic? inProgressAt;
  dynamic? unloadedAt;
  dynamic? projectName;
  dynamic? projectStatus;
  dynamic projectCheckpoint;
  dynamic? createrName;
  dynamic? email;
  dynamic? phone;
  dynamic? responsiblePersonName;
  dynamic? responsiblePersonEmail;
  dynamic? responsiblePersonPhone;
  dynamic? unloadingZoneName;
  dynamic? zoneColor;
  dynamic? subProjectName;
  dynamic? companyName;
  List<dynamic>? resourceNameArray;
  List<dynamic>? resourcePatternArray;
  double? bookingTime;
  dynamic? ntm;
  dynamic? itemName;
  dynamic? noOfPallets;
  dynamic? terminalId;
  List<dynamic>? checkoutsArray;
  List<dynamic>? checkoutItemNameArray;
  List<dynamic>? checkoutEntreprenuerArray;
  List<dynamic>? checkoutReleaseQuantityArray;
  List<dynamic>? checkoutCreatedByNameArray;

  factory RequestList.fromJson(Map<dynamic, dynamic> json) => RequestList(
    id: json["_id"] == null ? null : json["_id"],
    projectId: json["project_id"] == null ? null : json["project_id"],
    requestFromDateTime: json["request_from_date_time"] == null ? null : DateTime.parse(json["request_from_date_time"]),
    requestToDateTime: json["request_to_date_time"] == null ? null : DateTime.parse(json["request_to_date_time"]),
    resourceArray: json["resource_array"] == null ? null : List<dynamic>.from(json["resource_array"].map((x) => x)),
    unloadingZoneId: json["unloading_zone_id"] == null ? null : json["unloading_zone_id"],
    contractorId: json["contractor_id"] == null ? null : json["contractor_id"],
    responsiblePersonId: json["responsible_person_id"] == null ? null : json["responsible_person_id"],
    subProjectId: json["sub_project_id"] == null ? null : json["sub_project_id"],
    description: json["description"],
    instruction: json["instruction"],
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
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    transportStatus: json["transport_status"] == null ? null : json["transport_status"],
    arrivedAt: json["arrived_at"] == null ? null : json["arrived_at"],
    inProgressAt: json["in_progress_at"] == null ? null : json["in_progress_at"],
    unloadedAt: json["unloaded_at"] == null ? null : json["unloaded_at"],
    projectName: json["project_name"] == null ? null : json["project_name"],
    projectStatus: json["project_status"] == null ? null : json["project_status"],
    projectCheckpoint: json["project_checkpoint"],
    createrName: json["creater_name"] == null ? null : json["creater_name"],
    email: json["email"] == null ? null : json["email"],
    phone: json["phone"] == null ? null : json["phone"],
    responsiblePersonName: json["responsible_person_name"] == null ? null : json["responsible_person_name"],
    responsiblePersonEmail: json["responsible_person_email"] == null ? null : json["responsible_person_email"],
    responsiblePersonPhone: json["responsible_person_phone"] == null ? null : json["responsible_person_phone"],
    unloadingZoneName: json["unloading_zone_name"] == null ? null : json["unloading_zone_name"],
    zoneColor: json["zone_color"] == null ? null : json["zone_color"],
    subProjectName: json["sub_project_name"] == null ? null : json["sub_project_name"],
    companyName: json["company_name"] == null ? null : json["company_name"],
    resourceNameArray: json["resource_name_array"] == null ? null : List<dynamic>.from(json["resource_name_array"].map((x) => x)),
    resourcePatternArray: json["resource_pattern_array"] == null ? null : List<dynamic>.from(json["resource_pattern_array"].map((x) => x)),
    bookingTime: json["booking_time"] == null ? null : json["booking_time"].toDouble(),
    ntm: json["ntm"] == null ? null : json["ntm"],
    itemName: json["item_name"] == null ? null : json["item_name"],
    noOfPallets: json["no_of_pallets"] == null ? null : json["no_of_pallets"],
    terminalId: json["terminal_id"] == null ? null : json["terminal_id"],
    checkoutsArray: json["checkouts_array"] == null ? null : List<dynamic>.from(json["checkouts_array"].map((x) => x)),
    checkoutItemNameArray: json["checkout_item_name_array"] == null ? null : List<dynamic>.from(json["checkout_item_name_array"].map((x) => x)),
    checkoutEntreprenuerArray: json["checkout_entreprenuer_array"] == null ? null : List<dynamic>.from(json["checkout_entreprenuer_array"].map((x) => x)),
    checkoutReleaseQuantityArray: json["checkout_release_quantity_array"] == null ? null : List<dynamic>.from(json["checkout_release_quantity_array"].map((x) => x)),
    checkoutCreatedByNameArray: json["checkout_created_by_name_array"] == null ? null : List<dynamic>.from(json["checkout_created_by_name_array"].map((x) => x)),
  );

  Map<dynamic, dynamic> toJson() => {
    "_id": id == null ? null : id,
    "project_id": projectId == null ? null : projectId,
    "request_from_date_time": requestFromDateTime == null ? null : requestFromDateTime,
    "request_to_date_time": requestToDateTime == null ? null : requestToDateTime,
    "resource_array": resourceArray == null ? null : List<dynamic>.from(resourceArray!.map((x) => x)),
    "unloading_zone_id": unloadingZoneId == null ? null : unloadingZoneId,
    "contractor_id": contractorId == null ? null : contractorId,
    "responsible_person_id": responsiblePersonId == null ? null : responsiblePersonId,
    "sub_project_id": subProjectId == null ? null : subProjectId,
    "description": description,
    "instruction": instruction,
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
    "updated_at": updatedAt == null ? null : updatedAt,
    "created_at": createdAt == null ? null : createdAt,
    "transport_status": transportStatus == null ? null : transportStatus,
    "arrived_at": arrivedAt == null ? null : arrivedAt,
    "in_progress_at": inProgressAt == null ? null : inProgressAt,
    "unloaded_at": unloadedAt == null ? null : unloadedAt,
    "project_name": projectName == null ? null : projectName,
    "project_status": projectStatus == null ? null : projectStatus,
    "project_checkpoint": projectCheckpoint,
    "creater_name": createrName == null ? null : createrName,
    "email": email == null ? null : email,
    "phone": phone == null ? null : phone,
    "responsible_person_name": responsiblePersonName == null ? null : responsiblePersonName,
    "responsible_person_email": responsiblePersonEmail == null ? null : responsiblePersonEmail,
    "responsible_person_phone": responsiblePersonPhone == null ? null : responsiblePersonPhone,
    "unloading_zone_name": unloadingZoneName == null ? null : unloadingZoneName,
    "zone_color": zoneColor == null ? null : zoneColor,
    "sub_project_name": subProjectName == null ? null : subProjectName,
    "company_name": companyName == null ? null : companyName,
    "resource_name_array": resourceNameArray == null ? null : List<dynamic>.from(resourceNameArray!.map((x) => x)),
    "resource_pattern_array": resourcePatternArray == null ? null : List<dynamic>.from(resourcePatternArray!.map((x) => x)),
    "booking_time": bookingTime == null ? null : bookingTime,
    "ntm": ntm == null ? null : ntm,
    "item_name": itemName == null ? null : itemName,
    "no_of_pallets": noOfPallets == null ? null : noOfPallets,
    "terminal_id": terminalId == null ? null : terminalId,
    "checkouts_array": checkoutsArray == null ? null : List<dynamic>.from(checkoutsArray!.map((x) => x)),
    "checkout_item_name_array": checkoutItemNameArray == null ? null : List<dynamic>.from(checkoutItemNameArray!.map((x) => x)),
    "checkout_entreprenuer_array": checkoutEntreprenuerArray == null ? null : List<dynamic>.from(checkoutEntreprenuerArray!.map((x) => x)),
    "checkout_release_quantity_array": checkoutReleaseQuantityArray == null ? null : List<dynamic>.from(checkoutReleaseQuantityArray!.map((x) => x)),
    "checkout_created_by_name_array": checkoutCreatedByNameArray == null ? null : List<dynamic>.from(checkoutCreatedByNameArray!.map((x) => x)),
  };
}

class Address {
  Address({
    this.id,
    this.place,
    this.lat,
    this.lng,
    this.airport,
    this.typeOfVehicle,
    this.euroClass,
    this.typeOfFuel,
    this.vehicleCapacity,
    this.partDistance,
  });

  dynamic? id;
  dynamic? place;
  dynamic? lat;
  dynamic? lng;
  dynamic? airport;
  dynamic? typeOfVehicle;
  dynamic? euroClass;
  dynamic? typeOfFuel;
  dynamic? vehicleCapacity;
  dynamic partDistance;

  factory Address.fromJson(Map<dynamic, dynamic> json) => Address(
    id: json["id"] == null ? null : json["id"],
    place: json["place"] == null ? null : json["place"],
    lat: json["lat"] == null ? null : json["lat"],
    lng: json["lng"] == null ? null : json["lng"],
    airport: json["airport"] == null ? null : json["airport"],
    typeOfVehicle: json["type_of_vehicle"] == null ? null : json["type_of_vehicle"],
    euroClass: json["euro_class"] == null ? null : json["euro_class"],
    typeOfFuel: json["type_of_fuel"] == null ? null : json["type_of_fuel"],
    vehicleCapacity: json["vehicle_capacity"] == null ? null : json["vehicle_capacity"],
    partDistance: json["part_distance"],
  );

  Map<dynamic, dynamic> toJson() => {
    "id": id == null ? null : id,
    "place": place == null ? null : place,
    "lat": lat == null ? null : lat,
    "lng": lng == null ? null : lng,
    "airport": airport == null ? null : airport,
    "type_of_vehicle": typeOfVehicle == null ? null : typeOfVehicle,
    "euro_class": euroClass == null ? null : euroClass,
    "type_of_fuel": typeOfFuel == null ? null : typeOfFuel,
    "vehicle_capacity": vehicleCapacity == null ? null : vehicleCapacity,
    "part_distance": partDistance,
  };
}

class Kolli {
  Kolli({
    this.id,
    this.value,
    this.amount,
  });

  dynamic? id;
  dynamic? value;
  dynamic amount;

  factory Kolli.fromJson(Map<dynamic, dynamic> json) => Kolli(
    id: json["id"] == null ? null : json["id"],
    value: json["value"] == null ? null : json["value"],
    amount: json["amount"],
  );

  Map<dynamic, dynamic> toJson() => {
    "id": id == null ? null : id,
    "value": value == null ? null : value,
    "amount": amount,
  };
}
