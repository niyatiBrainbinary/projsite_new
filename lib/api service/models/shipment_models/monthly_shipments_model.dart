

class MonthlyShipmentsModel {
  MonthlyShipmentsModel({
    this.month,
    this.totalShipments,
    this.shipmentList,
  });

  dynamic? month;
  int? totalShipments;
  List<ShipmentList?>? shipmentList;

  factory MonthlyShipmentsModel.fromJson(Map<dynamic, dynamic> json) => MonthlyShipmentsModel(
    month: json["month"],
    totalShipments: json["total_shipments"],
    shipmentList: json["shipment_list"] == null ? [] : json["shipment_list"] == null ? [] : List<ShipmentList?>.from(json["shipment_list"]!.map((x) => ShipmentList.fromJson(x))),
  );

  Map<dynamic, dynamic> toJson() => {
    "month": month,
    "total_shipments": totalShipments,
    "shipment_list": shipmentList == null ? [] : shipmentList == null ? [] : List<dynamic>.from(shipmentList!.map((x) => x!.toJson())),
  };
}

class ShipmentList {
  ShipmentList({
    this.id,
    this.projectId,
    this.requestFromDateTime,
    this.requestToDateTime,
    //this.resourceArray,
    this.unloadingZoneId,
    this.contractorId,
    this.responsiblePersonId,
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
    this.updatedAt,
    this.createdAt,
    this.transportStatus,
    this.arrivedAt,
    this.inProgressAt,
    this.unloadedAt,
    this.subProjectId,
    this.requestType,
    this.isHiddenEnvironment,
  });

  dynamic? id;
  dynamic? projectId;
  dynamic? requestFromDateTime;
  dynamic? requestToDateTime;
//  dynamic? resourceArray;
  dynamic? unloadingZoneId;
  dynamic? contractorId;
  dynamic? responsiblePersonId;
  dynamic? description;
  dynamic? instruction;
  dynamic imageName;
  dynamic image;
  dynamic isRecurring;
  dynamic? recurringId;
  List<dynamic?>? recurringDays;
  dynamic? recurringToDate;
  dynamic? createdBy;
  dynamic? status;
  dynamic? organizationId;
  dynamic? isHidden;
  dynamic? deliverySupplier;
  dynamic? loadWeight;
  dynamic? drivingDistance;
  dynamic? isReturn;
  List<Address?>? addresses;
  NtmDataFullRoute? ntmDataFullRoute;
  List<Kolli?>? kollis;
  dynamic? unbooked;
  dynamic? updatedAt;
  dynamic? createdAt;
  dynamic? transportStatus;
  dynamic? arrivedAt;
  dynamic? inProgressAt;
  dynamic? unloadedAt;
  dynamic? subProjectId;
  dynamic? requestType;
  dynamic? isHiddenEnvironment;

  factory ShipmentList.fromJson(Map<dynamic, dynamic> json) => ShipmentList(
    id: json["_id"],
    projectId: json["project_id"],
    requestFromDateTime: json["request_from_date_time"],
    requestToDateTime: json["request_to_date_time"],
    //resourceArray: json["resource_array"] == null ? [] : json["resource_array"] == null ? [] : List<dynamic?>.from(json["resource_array"]!.map((x) => x)),
    unloadingZoneId: json["unloading_zone_id"],
    contractorId: json["contractor_id"],
    responsiblePersonId: json["responsible_person_id"],
    description: json["description"],
    instruction: json["instruction"],
    imageName: json["image_name"],
    image: json["image"],
    isRecurring: json["is_recurring"],
    recurringId: json["recurring_id"],
    recurringDays: json["recurring_days"] == null ? [] : json["recurring_days"] == null ? [] : List<dynamic?>.from(json["recurring_days"]!.map((x) => x)),
    recurringToDate: json["recurring_to_date"],
    createdBy: json["created_by"],
    status: json["status"],
    organizationId: json["organization_id"],
    isHidden: json["is_hidden"],
    deliverySupplier: json["delivery_supplier"],
    loadWeight: json["load_weight"],
    drivingDistance: json["driving_distance"],
    isReturn: json["is_return"],
    addresses: json["addresses"] == null ? [] : json["addresses"] == null ? [] : List<Address?>.from(json["addresses"]!.map((x) => Address.fromJson(x))),
    ntmDataFullRoute: json["ntm_data_full_route"]== null ? null : NtmDataFullRoute.fromJson(json["ntm_data_full_route"]),
    kollis: json["kollis"] == null ? [] : json["kollis"] == null ? [] : List<Kolli?>.from(json["kollis"]!.map((x) => Kolli.fromJson(x))),
    unbooked: json["unbooked"],
    updatedAt: json["updated_at"],
    createdAt: json["created_at"],
    transportStatus: json["transport_status"],
    arrivedAt: json["arrived_at"],
    inProgressAt: json["in_progress_at"],
    unloadedAt: json["unloaded_at"],
    subProjectId: json["sub_project_id"],
    requestType: json["request_type"],
    isHiddenEnvironment: json["is_hidden_environment"],
  );

  Map<dynamic, dynamic> toJson() => {
    "_id": id,
    "project_id": projectId,
    "request_from_date_time": requestFromDateTime,
    "request_to_date_time": requestToDateTime,
   // "resource_array": resourceArray == null ? [] : resourceArray == null ? [] : List<dynamic>.from(resourceArray!.map((x) => x)),
    "unloading_zone_id": unloadingZoneId,
    "contractor_id": contractorId,
    "responsible_person_id": responsiblePersonId,
    "description": description,
    "instruction": instruction,
    "image_name": imageName,
    "image": image,
    "is_recurring": isRecurring,
    "recurring_id": recurringId,
    "recurring_days": recurringDays == null ? [] : recurringDays == null ? [] : List<dynamic>.from(recurringDays!.map((x) => x)),
    "recurring_to_date": recurringToDate,
    "created_by": createdBy,
    "status": status,
    "organization_id": organizationId,
    "is_hidden": isHidden,
    "delivery_supplier": deliverySupplier,
    "load_weight": loadWeight,
    "driving_distance": drivingDistance,
    "is_return": isReturn,
    "addresses": addresses == null ? [] : addresses == null ? [] : List<dynamic>.from(addresses!.map((x) => x!.toJson())),
    "ntm_data_full_route": ntmDataFullRoute!.toJson(),
    "kollis": kollis == null ? [] : kollis == null ? [] : List<dynamic>.from(kollis!.map((x) => x!.toJson())),
    "unbooked": unbooked,
    "updated_at": updatedAt,
    "created_at": createdAt,
    "transport_status": transportStatus,
    "arrived_at": arrivedAt,
    "in_progress_at": inProgressAt,
    "unloaded_at": unloadedAt,
    "sub_project_id": subProjectId,
    "request_type": requestType,
    "is_hidden_environment": isHiddenEnvironment,
  };
}

class Address {
  Address({
    this.id,
    this.place,
    this.lat,
    this.lng,
    this.typeOfVehicle,
    this.euroClass,
    this.typeOfFuel,
    this.vehicleCapacity,
    this.partDistance,
    this.ntmRequest,
    this.ntmEnvironmentSimpleData,
    this.ntm,
    this.ntmEnvironmentData,
    this.airport,
  });

  dynamic? id;
  dynamic? place;
  dynamic? lat;
  dynamic? lng;
  dynamic? typeOfVehicle;
  dynamic? euroClass;
  dynamic? typeOfFuel;
  dynamic? vehicleCapacity;
  dynamic? partDistance;
  NtmRequest? ntmRequest;
  NtmEnvironmentSimpleData? ntmEnvironmentSimpleData;
  dynamic? ntm;
  dynamic? ntmEnvironmentData;
  dynamic? airport;

  factory Address.fromJson(Map<dynamic, dynamic> json) => Address(
    id: json["id"],
    place: json["place"],
    lat: json["lat"],
    lng: json["lng"],
    typeOfVehicle: json["type_of_vehicle"],
    euroClass: json["euro_class"],
    typeOfFuel: json["type_of_fuel"],
    vehicleCapacity: json["vehicle_capacity"],
    partDistance: json["part_distance"],
    ntmRequest: json["ntm_request"]== null ? null : NtmRequest.fromJson(json["ntm_request"]),
    ntmEnvironmentSimpleData: json["ntm_environment_simple_data"]== null ? null : NtmEnvironmentSimpleData.fromJson(json["ntm_environment_simple_data"]),
    ntm: json["ntm"],
    ntmEnvironmentData: json["ntm_environment_data"],
    airport: json["airport"],
  );

  Map<dynamic, dynamic> toJson() => {
    "id": id,
    "place": place,
    "lat": lat,
    "lng": lng,
    "type_of_vehicle": typeOfVehicle,
    "euro_class": euroClass,
    "type_of_fuel": typeOfFuel,
    "vehicle_capacity": vehicleCapacity,
    "part_distance": partDistance,
    "ntm_request": ntmRequest!.toJson(),
    "ntm_environment_simple_data": ntmEnvironmentSimpleData!.toJson(),
    "ntm": ntm,
    "ntm_environment_data": ntmEnvironmentData,
    "airport": airport,
  };
}


class NtmEnvironmentSimpleData {
  NtmEnvironmentSimpleData({
    this.vehicle,
    this.fuel,
    this.totals,
  });

  NtmEnvironmentSimpleDataFuel? vehicle;
  NtmEnvironmentSimpleDataFuel? fuel;
  NtmEnvironmentSimpleDataFuel? totals;

  factory NtmEnvironmentSimpleData.fromJson(Map<dynamic, dynamic> json) => NtmEnvironmentSimpleData(
    vehicle: json["vehicle"]== null ? null : NtmEnvironmentSimpleDataFuel.fromJson(json["vehicle"]),
    fuel: json["fuel"]== null ? null : NtmEnvironmentSimpleDataFuel.fromJson(json["fuel"]),
    totals: json["totals"]== null ? null : NtmEnvironmentSimpleDataFuel.fromJson(json["totals"]),
  );

  Map<dynamic, dynamic> toJson() => {
    "vehicle": vehicle!.toJson(),
    "fuel": fuel!.toJson(),
    "totals": totals!.toJson(),
  };
}

class NtmEnvironmentSimpleDataFuel {
  NtmEnvironmentSimpleDataFuel({
    this.header,
    this.id,
    this.unit,
    this.value,
    this.precision,
    this.greaterThan,
    this.isFuelData,
  });

  dynamic? header;
  dynamic? id;
  dynamic? unit;
  double? value;
  int? precision;
  dynamic? greaterThan;
  dynamic? isFuelData;

  factory NtmEnvironmentSimpleDataFuel.fromJson(Map<dynamic, dynamic> json) => NtmEnvironmentSimpleDataFuel(
    header: json["header"],
    id: json["id"],
    unit: json["unit"],
    value: json["value"],
    precision: json["precision"],
    greaterThan: json["greaterThan"],
    isFuelData: json["is_fuel_data"],
  );

  Map<dynamic, dynamic> toJson() => {
    "header": header,
    "id": id,
    "unit": unit,
    "value": value,
    "precision": precision,
    "greaterThan": greaterThan,
    "is_fuel_data": isFuelData,
  };
}

class NtmRequest {
  NtmRequest({
    this.calculationObject,
    this.parameters,
  });

  CalculationObject? calculationObject;
  List<Parameter?>? parameters;

  factory NtmRequest.fromJson(Map<dynamic, dynamic> json) => NtmRequest(
    calculationObject: json["calculationObject"] == null ? null : CalculationObject.fromJson(json["calculationObject"]),
    parameters: json["parameters"] == null ? [] : json["parameters"] == null ? [] : List<Parameter?>.from(json["parameters"]!.map((x) => Parameter.fromJson(x))),
  );

  Map<dynamic, dynamic> toJson() => {
    "calculationObject": calculationObject!.toJson(),
    "parameters": parameters == null ? [] : parameters == null ? [] : List<dynamic>.from(parameters!.map((x) => x!.toJson())),
  };
}

class CalculationObject {
  CalculationObject({
    this.id,
    this.version,
  });

  dynamic? id;
  dynamic? version;

  factory CalculationObject.fromJson(Map<dynamic, dynamic> json) => CalculationObject(
    id: json["id"],
    version: json["version"],
  );

  Map<dynamic, dynamic> toJson() => {
    "id": id,
    "version": version,
  };
}

class Parameter {
  Parameter({
    this.id,
    this.value,
    this.unit,
  });

  dynamic? id;
  dynamic? value;
  dynamic? unit;

  factory Parameter.fromJson(Map<dynamic, dynamic> json) => Parameter(
    id: json["id"],
    value: json["value"],
    unit: json["unit"],
  );

  Map<dynamic, dynamic> toJson() => {
    "id": id,
    "value": value,
    "unit": unit,
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
  dynamic? amount;

  factory Kolli.fromJson(Map<dynamic, dynamic> json) => Kolli(
    id: json["id"],
    value: json["value"],
    amount: json["amount"],
  );

  Map<dynamic, dynamic> toJson() => {
    "id": id,
    "value": value,
    "amount": amount,
  };
}

class NtmDataFullRoute {
  NtmDataFullRoute({
    this.vehicle,
    this.fuel,
    this.totals,
  });

  NtmDataFullRouteFuel? vehicle;
  NtmDataFullRouteFuel? fuel;
  NtmDataFullRouteFuel? totals;

  factory NtmDataFullRoute.fromJson(Map<dynamic, dynamic> json) => NtmDataFullRoute(
    vehicle: json["vehicle"]==null ? null : NtmDataFullRouteFuel.fromJson(json["vehicle"]),
    fuel: json["fuel"]==null ? null : NtmDataFullRouteFuel.fromJson(json["fuel"]),
    totals: json["totals"]==null ? null : NtmDataFullRouteFuel.fromJson(json["totals"]),
  );

  Map<dynamic, dynamic> toJson() => {
    "vehicle": vehicle,
    "fuel": fuel,
    "totals": totals,
  };
}

class NtmDataFullRouteFuel {
  NtmDataFullRouteFuel({
    this.value,
    this.unit,
    this.header,
    this.id,
    this.isFuelData,
  });

  double? value;
  dynamic? unit;
  dynamic? header;
  dynamic? id;
  dynamic? isFuelData;

  factory NtmDataFullRouteFuel.fromJson(Map<dynamic, dynamic> json) => NtmDataFullRouteFuel(
    value: json["value"],
    unit: json["unit"],
    header: json["header"],
    id: json["id"],
    isFuelData: json["is_fuel_data"],
  );

  Map<dynamic, dynamic> toJson() => {
    "value": value,
    "unit": unit,
    "header": header,
    "id": id,
    "is_fuel_data": isFuelData,
  };
}


// // To parse this JSON data, do
// //
// //     final monthlyShipmentsModel = monthlyShipmentsModelFromJson(jsondynamic);
//
// import 'dart:convert';
//
// MonthlyShipmentsModel? monthlyShipmentsModelFromJson(dynamic str) => MonthlyShipmentsModel.fromJson(json.decode(str));
//
// dynamic monthlyShipmentsModelToJson(MonthlyShipmentsModel? data) => json.encode(data!.toJson());
// class MonthlyShipmentsModel {
//   MonthlyShipmentsModel({
//     this.month,
//     this.totalShipments,
//     this.shipmentList,
//   });
//
//   dynamic? month;
//   int? totalShipments;
//   List<ShipmentList>? shipmentList;
//
//   factory MonthlyShipmentsModel.fromJson(Map<dynamic, dynamic> json) => MonthlyShipmentsModel(
//     month: json["month"] == null ? null : json["month"],
//     totalShipments: json["total_shipments"] == null ? null : json["total_shipments"],
//     shipmentList: json["shipment_list"] == null ? null : List<ShipmentList>.from(json["shipment_list"].map((x) => ShipmentList.fromJson(x))),
//   );
//
//   Map<dynamic, dynamic> toJson() => {
//     "month": month == null ? null : month,
//     "total_shipments": totalShipments == null ? null : totalShipments,
//     "shipment_list": shipmentList == null ? null : List<dynamic>.from(shipmentList!.map((x) => x.toJson())),
//   };
// }
//
// class ShipmentList {
//   ShipmentList({
//     this.id,
//     this.projectId,
//     this.requestFromDateTime,
//     this.requestToDateTime,
//     this.resourceArray,
//     this.unloadingZoneId,
//     this.contractorId,
//     this.responsiblePersonId,
//     this.description,
//     this.instruction,
//     this.imageName,
//     this.image,
//     this.isRecurring,
//     this.recurringId,
//     this.recurringDays,
//     this.recurringToDate,
//     this.createdBy,
//     this.status,
//     this.organizationId,
//     this.isHidden,
//     this.deliverySupplier,
//     this.loadWeight,
//     this.drivingDistance,
//     this.isReturn,
//     this.addresses,
//     this.ntmDataFullRoute,
//     this.kollis,
//     this.unbooked,
//     this.updatedAt,
//     this.createdAt,
//     this.transportStatus,
//     this.arrivedAt,
//     this.inProgressAt,
//     this.unloadedAt,
//     this.subProjectId,
//     this.requestType,
//     this.isHiddenEnvironment,
//   });
//
//   dynamic? id;
//   ProjectId? projectId;
//   DateTime? requestFromDateTime;
//   DateTime? requestToDateTime;
//   List<dynamic>? resourceArray;
//   UnloadingZoneId? unloadingZoneId;
//   ContractorId? contractorId;
//   ResponsiblePersonId? responsiblePersonId;
//   Description? description;
//   dynamic? instruction;
//   dynamic imageName;
//   dynamic image;
//   dynamic isRecurring;
//   RecurringId? recurringId;
//   List<dynamic>? recurringDays;
//   DateTime? recurringToDate;
//   CreatedBy? createdBy;
//   Status? status;
//   OrganizationId? organizationId;
//   dynamic? isHidden;
//   dynamic? deliverySupplier;
//   dynamic? loadWeight;
//   dynamic? drivingDistance;
//   dynamic? isReturn;
//   List<Address>? addresses;
//   NtmDataFullRoute? ntmDataFullRoute;
//   List<Kolli>? kollis;
//   dynamic? unbooked;
//   DateTime? updatedAt;
//   DateTime? createdAt;
//   TransportStatus? transportStatus;
//   At? arrivedAt;
//   At? inProgressAt;
//   At? unloadedAt;
//   dynamic? subProjectId;
//   dynamic? requestType;
//   dynamic? isHiddenEnvironment;
//
//   factory ShipmentList.fromJson(Map<dynamic, dynamic> json) => ShipmentList(
//     id: json["_id"] == null ? null : json["_id"],
//     projectId: json["project_id"] == null ? null : projectIdValues.map[json["project_id"]],
//     requestFromDateTime: json["request_from_date_time"] == null ? null : DateTime.parse(json["request_from_date_time"]),
//     requestToDateTime: json["request_to_date_time"] == null ? null : DateTime.parse(json["request_to_date_time"]),
//     resourceArray: json["resource_array"] == null ? null : List<dynamic>.from(json["resource_array"].map((x) => x)),
//     unloadingZoneId: json["unloading_zone_id"] == null ? null : unloadingZoneIdValues.map[json["unloading_zone_id"]],
//     contractorId: json["contractor_id"] == null ? null : contractorIdValues.map[json["contractor_id"]],
//     responsiblePersonId: json["responsible_person_id"] == null ? null : responsiblePersonIdValues.map[json["responsible_person_id"]],
//     description: json["description"] == null ? null : descriptionValues.map[json["description"]],
//     instruction: json["instruction"] == null ? null : json["instruction"],
//     imageName: json["image_name"],
//     image: json["image"],
//     isRecurring: json["is_recurring"],
//     recurringId: json["recurring_id"] == null ? null : recurringIdValues.map[json["recurring_id"]],
//     recurringDays: json["recurring_days"] == null ? null : List<dynamic>.from(json["recurring_days"].map((x) => x)),
//     recurringToDate: json["recurring_to_date"] == null ? null : DateTime.parse(json["recurring_to_date"]),
//     createdBy: json["created_by"] == null ? null : createdByValues.map[json["created_by"]],
//     status: json["status"] == null ? null : statusValues.map[json["status"]],
//     organizationId: json["organization_id"] == null ? null : organizationIdValues.map[json["organization_id"]],
//     isHidden: json["is_hidden"] == null ? null : json["is_hidden"],
//     deliverySupplier: json["delivery_supplier"] == null ? null : json["delivery_supplier"],
//     loadWeight: json["load_weight"] == null ? null : json["load_weight"],
//     drivingDistance: json["driving_distance"] == null ? null : json["driving_distance"],
//     isReturn: json["is_return"] == null ? null : json["is_return"],
//     addresses: json["addresses"] == null ? null : List<Address>.from(json["addresses"].map((x) => Address.fromJson(x))),
//     ntmDataFullRoute: json["ntm_data_full_route"] == null ? null : NtmDataFullRoute.fromJson(json["ntm_data_full_route"]),
//     kollis: json["kollis"] == null ? null : List<Kolli>.from(json["kollis"].map((x) => Kolli.fromJson(x))),
//     unbooked: json["unbooked"] == null ? null : json["unbooked"],
//     updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
//     createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
//     transportStatus: json["transport_status"] == null ? null : transportStatusValues.map[json["transport_status"]],
//     arrivedAt: json["arrived_at"] == null ? null : atValues.map[json["arrived_at"]],
//     inProgressAt: json["in_progress_at"] == null ? null : atValues.map[json["in_progress_at"]],
//     unloadedAt: json["unloaded_at"] == null ? null : atValues.map[json["unloaded_at"]],
//     subProjectId: json["sub_project_id"] == null ? null : json["sub_project_id"],
//     requestType: json["request_type"] == null ? null : json["request_type"],
//     isHiddenEnvironment: json["is_hidden_environment"] == null ? null : json["is_hidden_environment"],
//   );
//
//   Map<dynamic, dynamic> toJson() => {
//     "_id": id == null ? null : id,
//     "project_id": projectId == null ? null : projectIdValues.reverse[projectId],
//     "request_from_date_time": requestFromDateTime == null ? null : requestFromDateTime,
//     "request_to_date_time": requestToDateTime == null ? null : requestToDateTime,
//     "resource_array": resourceArray == null ? null : List<dynamic>.from(resourceArray!.map((x) => x)),
//     "unloading_zone_id": unloadingZoneId == null ? null : unloadingZoneIdValues.reverse[unloadingZoneId],
//     "contractor_id": contractorId == null ? null : contractorIdValues.reverse[contractorId],
//     "responsible_person_id": responsiblePersonId == null ? null : responsiblePersonIdValues.reverse[responsiblePersonId],
//     "description": description == null ? null : descriptionValues.reverse[description],
//     "instruction": instruction == null ? null : instruction,
//     "image_name": imageName,
//     "image": image,
//     "is_recurring": isRecurring,
//     "recurring_id": recurringId == null ? null : recurringIdValues.reverse[recurringId],
//     "recurring_days": recurringDays == null ? null : List<dynamic>.from(recurringDays!.map((x) => x)),
//     "recurring_to_date": recurringToDate == null ? null : recurringToDate,
//     "created_by": createdBy == null ? null : createdByValues.reverse[createdBy],
//     "status": status == null ? null : statusValues.reverse[status],
//     "organization_id": organizationId == null ? null : organizationIdValues.reverse[organizationId],
//     "is_hidden": isHidden == null ? null : isHidden,
//     "delivery_supplier": deliverySupplier == null ? null : deliverySupplier,
//     "load_weight": loadWeight == null ? null : loadWeight,
//     "driving_distance": drivingDistance == null ? null : drivingDistance,
//     "is_return": isReturn == null ? null : isReturn,
//     "addresses": addresses == null ? null : List<dynamic>.from(addresses!.map((x) => x.toJson())),
//     "ntm_data_full_route": ntmDataFullRoute == null ? null : ntmDataFullRoute!.toJson(),
//     "kollis": kollis == null ? null : List<dynamic>.from(kollis!.map((x) => x.toJson())),
//     "unbooked": unbooked == null ? null : unbooked,
//     "updated_at": updatedAt == null ? null : updatedAt,
//     "created_at": createdAt == null ? null : createdAt,
//     "transport_status": transportStatus == null ? null : transportStatusValues.reverse[transportStatus],
//     "arrived_at": arrivedAt == null ? null : atValues.reverse[arrivedAt],
//     "in_progress_at": inProgressAt == null ? null : atValues.reverse[inProgressAt],
//     "unloaded_at": unloadedAt == null ? null : atValues.reverse[unloadedAt],
//     "sub_project_id": subProjectId == null ? null : subProjectId,
//     "request_type": requestType == null ? null : requestType,
//     "is_hidden_environment": isHiddenEnvironment == null ? null : isHiddenEnvironment,
//   };
// }
//
// class Address {
//   Address({
//     this.id,
//     this.place,
//     this.lat,
//     this.lng,
//     this.typeOfVehicle,
//     this.euroClass,
//     this.typeOfFuel,
//     this.vehicleCapacity,
//     this.partDistance,
//     this.ntmRequest,
//     this.ntmEnvironmentSimpleData,
//     this.ntm,
//     this.ntmEnvironmentData,
//     this.airport,
//   });
//
//   AddressId? id;
//   dynamic? place;
//   dynamic? lat;
//   dynamic? lng;
//   TypeOfVehicle? typeOfVehicle;
//   dynamic? euroClass;
//   dynamic? typeOfFuel;
//   dynamic? vehicleCapacity;
//   dynamic? partDistance;
//   NtmRequest? ntmRequest;
//   NtmEnvironmentSimpleData? ntmEnvironmentSimpleData;
//   dynamic? ntm;
//   NtmEnvironmentData? ntmEnvironmentData;
//   dynamic? airport;
//
//   factory Address.fromJson(Map<dynamic, dynamic> json) => Address(
//     id: json["id"] == null ? null : addressIdValues.map[json["id"]],
//     place: json["place"] == null ? null : json["place"],
//     lat: json["lat"] == null ? null : json["lat"],
//     lng: json["lng"] == null ? null : json["lng"],
//     typeOfVehicle: json["type_of_vehicle"] == null ? null : typeOfVehicleValues.map[json["type_of_vehicle"]],
//     euroClass: json["euro_class"] == null ? null : json["euro_class"],
//     typeOfFuel: json["type_of_fuel"] == null ? null : json["type_of_fuel"],
//     vehicleCapacity: json["vehicle_capacity"] == null ? null : json["vehicle_capacity"],
//     partDistance: json["part_distance"] == null ? null : json["part_distance"],
//     ntmRequest: json["ntm_request"] == null ? null : NtmRequest.fromJson(json["ntm_request"]),
//     ntmEnvironmentSimpleData: json["ntm_environment_simple_data"] == null ? null : NtmEnvironmentSimpleData.fromJson(json["ntm_environment_simple_data"]),
//     ntm: json["ntm"] == null ? null : json["ntm"],
//     ntmEnvironmentData: json["ntm_environment_data"] == null ? null : ntmEnvironmentDataValues.map[json["ntm_environment_data"]],
//     airport: json["airport"] == null ? null : json["airport"],
//   );
//
//   Map<dynamic, dynamic> toJson() => {
//     "id": id == null ? null : addressIdValues.reverse[id],
//     "place": place == null ? null : place,
//     "lat": lat == null ? null : lat,
//     "lng": lng == null ? null : lng,
//     "type_of_vehicle": typeOfVehicle == null ? null : typeOfVehicleValues.reverse[typeOfVehicle],
//     "euro_class": euroClass == null ? null : euroClass,
//     "type_of_fuel": typeOfFuel == null ? null : typeOfFuel,
//     "vehicle_capacity": vehicleCapacity == null ? null : vehicleCapacity,
//     "part_distance": partDistance == null ? null : partDistance,
//     "ntm_request": ntmRequest == null ? null : ntmRequest!.toJson(),
//     "ntm_environment_simple_data": ntmEnvironmentSimpleData == null ? null : ntmEnvironmentSimpleData!.toJson(),
//     "ntm": ntm == null ? null : ntm,
//     "ntm_environment_data": ntmEnvironmentData == null ? null : ntmEnvironmentDataValues.reverse[ntmEnvironmentData],
//     "airport": airport == null ? null : airport,
//   };
// }
//
// enum AddressId { AC1, AC2, ADD_GENERAL_REQUEST_ENVIRONMENT_SECTION_AC2, ADD_GENERAL_REQUEST_ENVIRONMENT_SECTION_AC1, EDIT_GENERAL_REQUEST_ENVIRONMENT_SECTION_AC1, EDIT_GENERAL_REQUEST_ENVIRONMENT_SECTION_AC2 }
//
// final addressIdValues = EnumValues({
//   "ac1": AddressId.AC1,
//   "ac2": AddressId.AC2,
//   "add_general_request_environment_section_ac1": AddressId.ADD_GENERAL_REQUEST_ENVIRONMENT_SECTION_AC1,
//   "add_general_request_environment_section_ac2": AddressId.ADD_GENERAL_REQUEST_ENVIRONMENT_SECTION_AC2,
//   "edit_general_request_environment_section_ac1": AddressId.EDIT_GENERAL_REQUEST_ENVIRONMENT_SECTION_AC1,
//   "edit_general_request_environment_section_ac2": AddressId.EDIT_GENERAL_REQUEST_ENVIRONMENT_SECTION_AC2
// });
//
// enum NtmEnvironmentData { NTM_SUCCESS }
//
// final ntmEnvironmentDataValues = EnumValues({
//   "ntm success": NtmEnvironmentData.NTM_SUCCESS
// });
//
// class NtmEnvironmentSimpleData {
//   NtmEnvironmentSimpleData({
//     this.vehicle,
//     this.fuel,
//     this.totals,
//   });
//
//   Map<dynamic, NtmEnvironmentSimpleDataFuel>? vehicle;
//   Map<dynamic, NtmEnvironmentSimpleDataFuel>? fuel;
//   Map<dynamic, NtmEnvironmentSimpleDataFuel>? totals;
//
//   factory NtmEnvironmentSimpleData.fromJson(Map<dynamic, dynamic> json) => NtmEnvironmentSimpleData(
//     vehicle: json["vehicle"] == null ? null : Map.from(json["vehicle"]).map((k, v) => MapEntry<dynamic, NtmEnvironmentSimpleDataFuel>(k, NtmEnvironmentSimpleDataFuel.fromJson(v))),
//     fuel: json["fuel"] == null ? null : Map.from(json["fuel"]).map((k, v) => MapEntry<dynamic, NtmEnvironmentSimpleDataFuel>(k, NtmEnvironmentSimpleDataFuel.fromJson(v))),
//     totals: json["totals"] == null ? null : Map.from(json["totals"]).map((k, v) => MapEntry<dynamic, NtmEnvironmentSimpleDataFuel>(k, NtmEnvironmentSimpleDataFuel.fromJson(v))),
//   );
//
//   Map<dynamic, dynamic> toJson() => {
//     "vehicle": vehicle == null ? null : Map.from(vehicle!).map((k, v) => MapEntry<dynamic, dynamic>(k, v.toJson())),
//     "fuel": fuel == null ? null : Map.from(fuel!).map((k, v) => MapEntry<dynamic, dynamic>(k, v.toJson())),
//     "totals": totals == null ? null : Map.from(totals!).map((k, v) => MapEntry<dynamic, dynamic>(k, v.toJson())),
//   };
// }
//
// class NtmEnvironmentSimpleDataFuel {
//   NtmEnvironmentSimpleDataFuel({
//     this.header,
//     this.id,
//     this.unit,
//     this.value,
//     this.precision,
//     this.greaterThan,
//     this.isFuelData,
//   });
//
//   Header? header;
//   FuelId? id;
//   FuelUnit? unit;
//   double? value;
//   int? precision;
//   dynamic? greaterThan;
//   dynamic? isFuelData;
//
//   factory NtmEnvironmentSimpleDataFuel.fromJson(Map<dynamic, dynamic> json) => NtmEnvironmentSimpleDataFuel(
//     header: json["header"] == null ? null : headerValues.map[json["header"]],
//     id: json["id"] == null ? null : fuelIdValues.map[json["id"]],
//     unit: json["unit"] == null ? null : fuelUnitValues.map[json["unit"]],
//     value: json["value"] == null ? null : json["value"].toDouble(),
//     precision: json["precision"] == null ? null : json["precision"],
//     greaterThan: json["greaterThan"] == null ? null : json["greaterThan"],
//     isFuelData: json["is_fuel_data"] == null ? null : json["is_fuel_data"],
//   );
//
//   Map<dynamic, dynamic> toJson() => {
//     "header": header == null ? null : headerValues.reverse[header],
//     "id": id == null ? null : fuelIdValues.reverse[id],
//     "unit": unit == null ? null : fuelUnitValues.reverse[unit],
//     "value": value == null ? null : value,
//     "precision": precision == null ? null : precision,
//     "greaterThan": greaterThan == null ? null : greaterThan,
//     "is_fuel_data": isFuelData == null ? null : isFuelData,
//   };
// }
//
// enum Header { CH4, CO, CO2_BIOGEN, CO2_FOSSIL, CO2_TOTAL, CO2_E, DIESEL_B0_EU, DIESEL_B5_EU, DIESEL_B7_EU, DIESEL_B7_SWE, ENERGY, HC, N2_O, N_OX, PM, SO2 }
//
// final headerValues = EnumValues({
//   "CH4": Header.CH4,
//   "CO": Header.CO,
//   "CO2 biogen": Header.CO2_BIOGEN,
//   "CO2e": Header.CO2_E,
//   "CO2 fossil": Header.CO2_FOSSIL,
//   "CO2 total": Header.CO2_TOTAL,
//   "Diesel B0 - EU": Header.DIESEL_B0_EU,
//   "Diesel B5 - EU": Header.DIESEL_B5_EU,
//   "Diesel B7 - EU": Header.DIESEL_B7_EU,
//   "Diesel B7 - Swe": Header.DIESEL_B7_SWE,
//   "Energy": Header.ENERGY,
//   "HC": Header.HC,
//   "N2O": Header.N2_O,
//   "NOx": Header.N_OX,
//   "PM": Header.PM,
//   "SO2": Header.SO2
// });
//
// enum FuelId { CH4, CO, CO2_BIOGEN, CO2_FOSSIL, CO2_TOTAL, CO2_E, DIESEL_B0_EU, DIESEL_B5_EU, DIESEL_B7_EU, DIESEL_B7_SWE, ENERGY, HC, N2_O, NOX, PM, SO2 }
//
// final fuelIdValues = EnumValues({
//   "ch4": FuelId.CH4,
//   "co": FuelId.CO,
//   "co2_biogen": FuelId.CO2_BIOGEN,
//   "co2e": FuelId.CO2_E,
//   "co2_fossil": FuelId.CO2_FOSSIL,
//   "co2_total": FuelId.CO2_TOTAL,
//   "diesel_b0_eu": FuelId.DIESEL_B0_EU,
//   "diesel_b5_eu": FuelId.DIESEL_B5_EU,
//   "diesel_b7_eu": FuelId.DIESEL_B7_EU,
//   "diesel_b7_swe": FuelId.DIESEL_B7_SWE,
//   "energy": FuelId.ENERGY,
//   "hc": FuelId.HC,
//   "n2o": FuelId.N2_O,
//   "nox": FuelId.NOX,
//   "pm": FuelId.PM,
//   "so2": FuelId.SO2
// });
//
// enum FuelUnit { G, KG, L, MJ }
//
// final fuelUnitValues = EnumValues({
//   "g": FuelUnit.G,
//   "kg": FuelUnit.KG,
//   "l": FuelUnit.L,
//   "MJ": FuelUnit.MJ
// });
//
// class NtmRequest {
//   NtmRequest({
//     this.calculationObject,
//     this.parameters,
//   });
//
//   CalculationObject? calculationObject;
//   List<Parameter>? parameters;
//
//   factory NtmRequest.fromJson(Map<dynamic, dynamic> json) => NtmRequest(
//     calculationObject: json["calculationObject"] == null ? null : CalculationObject.fromJson(json["calculationObject"]),
//     parameters: json["parameters"] == null ? null : List<Parameter>.from(json["parameters"].map((x) => Parameter.fromJson(x))),
//   );
//
//   Map<dynamic, dynamic> toJson() => {
//     "calculationObject": calculationObject == null ? null : calculationObject!.toJson(),
//     "parameters": parameters == null ? null : List<dynamic>.from(parameters!.map((x) => x.toJson())),
//   };
// }
//
// class CalculationObject {
//   CalculationObject({
//     this.id,
//     this.version,
//   });
//
//   CalculationObjectId? id;
//   dynamic? version;
//
//   factory CalculationObject.fromJson(Map<dynamic, dynamic> json) => CalculationObject(
//     id: json["id"] == null ? null : calculationObjectIdValues.map[json["id"]],
//     version: json["version"] == null ? null : json["version"],
//   );
//
//   Map<dynamic, dynamic> toJson() => {
//     "id": id == null ? null : calculationObjectIdValues.reverse[id],
//     "version": version == null ? null : version,
//   };
// }
//
// enum CalculationObjectId { TRUCK_WITH_TRAILER_2028_T, RIGID_TRUCK_7512_T }
//
// final calculationObjectIdValues = EnumValues({
//   "rigid_truck_7_5_12_t": CalculationObjectId.RIGID_TRUCK_7512_T,
//   "truck_with_trailer_20_28_t": CalculationObjectId.TRUCK_WITH_TRAILER_2028_T
// });
//
// class Parameter {
//   Parameter({
//     this.id,
//     this.value,
//     this.unit,
//   });
//
//   ParameterId? id;
//   dynamic? value;
//   ParameterUnit? unit;
//
//   factory Parameter.fromJson(Map<dynamic, dynamic> json) => Parameter(
//     id: json["id"] == null ? null : parameterIdValues.map[json["id"]],
//     value: json["value"] == null ? null : json["value"],
//     unit: json["unit"] == null ? null : parameterUnitValues.map[json["unit"]],
//   );
//
//   Map<dynamic, dynamic> toJson() => {
//     "id": id == null ? null : parameterIdValues.reverse[id],
//     "value": value == null ? null : value,
//     "unit": unit == null ? null : parameterUnitValues.reverse[unit],
//   };
// }
//
// enum ParameterId { CALCULATION_MODEL, SHIPMENT_WEIGHT, DISTANCE, CARGO_LOAD_FACTOR_WEIGHT, EURO_CLASS, FUEL }
//
// final parameterIdValues = EnumValues({
//   "calculation_model": ParameterId.CALCULATION_MODEL,
//   "cargo_load_factor_weight": ParameterId.CARGO_LOAD_FACTOR_WEIGHT,
//   "distance": ParameterId.DISTANCE,
//   "euro_class": ParameterId.EURO_CLASS,
//   "fuel": ParameterId.FUEL,
//   "shipment_weight": ParameterId.SHIPMENT_WEIGHT
// });
//
// enum ParameterUnit { KG, KM, WEIGHT }
//
// final parameterUnitValues = EnumValues({
//   "kg": ParameterUnit.KG,
//   "km": ParameterUnit.KM,
//   "%weight": ParameterUnit.WEIGHT
// });
//
// enum TypeOfVehicle { THE_606_C1_FF74_FDAB9514_B5719_E2, THE_606_C200_C4_FDAB9514_B5719_E4 }
//
// final typeOfVehicleValues = EnumValues({
//   "606c1ff74fdab9514b5719e2": TypeOfVehicle.THE_606_C1_FF74_FDAB9514_B5719_E2,
//   "606c200c4fdab9514b5719e4": TypeOfVehicle.THE_606_C200_C4_FDAB9514_B5719_E4
// });
//
// enum At { THE_0000 }
//
// final atValues = EnumValues({
//   "00:00": At.THE_0000
// });
//
// enum ContractorId { THE_6048_B7944_FDAB927852_C8_B42, THE_6380_AE05_B8_A3_BE4_E59205422, THE_63440005_FEC6312_F915_F92_B5 }
//
// final contractorIdValues = EnumValues({
//   "6048b7944fdab927852c8b42": ContractorId.THE_6048_B7944_FDAB927852_C8_B42,
//   "63440005fec6312f915f92b5": ContractorId.THE_63440005_FEC6312_F915_F92_B5,
//   "6380ae05b8a3be4e59205422": ContractorId.THE_6380_AE05_B8_A3_BE4_E59205422
// });
//
// enum CreatedBy { THE_61_BA0_B944_FDAB93_E227_FA7_F2, THE_6380_AE1_FB8_ECFC3_F304_F47_F4, THE_63440011_E0_E6_D131707_F09_F3 }
//
// final createdByValues = EnumValues({
//   "61ba0b944fdab93e227fa7f2": CreatedBy.THE_61_BA0_B944_FDAB93_E227_FA7_F2,
//   "63440011e0e6d131707f09f3": CreatedBy.THE_63440011_E0_E6_D131707_F09_F3,
//   "6380ae1fb8ecfc3f304f47f4": CreatedBy.THE_6380_AE1_FB8_ECFC3_F304_F47_F4
// });
//
// enum Description { TMNING_AV_240_KUBIKARE, LEVERANS_AV_3_PALLAR_TILL_PLAN_2_OCH_3, AGGREGAT_TILL_PLAN_3_DEL_30_FLKTRUM_3_Q131, SPJLL_TILL_PLAN_3, LJUDDMPARE_SPJLL_TILL_PLAN_3 }
//
// final descriptionValues = EnumValues({
//   "Aggregat till Plan 3 del 30 - fläktrum 3Q131": Description.AGGREGAT_TILL_PLAN_3_DEL_30_FLKTRUM_3_Q131,
//   "leverans av 3 pallar till plan 2 och 3": Description.LEVERANS_AV_3_PALLAR_TILL_PLAN_2_OCH_3,
//   "Ljuddämpare/spjäll till plan 3": Description.LJUDDMPARE_SPJLL_TILL_PLAN_3,
//   "Spjäll till plan 3": Description.SPJLL_TILL_PLAN_3,
//   "Tömning av 2 40 kubikare": Description.TMNING_AV_240_KUBIKARE
// });
//
// class Kolli {
//   Kolli({
//     this.id,
//     this.value,
//     this.amount,
//   });
//
//   KolliId? id;
//   dynamic? value;
//   dynamic? amount;
//
//   factory Kolli.fromJson(Map<dynamic, dynamic> json) => Kolli(
//     id: json["id"] == null ? null : kolliIdValues.map[json["id"]],
//     value: json["value"] == null ? null : json["value"],
//     amount: json["amount"] == null ? null : json["amount"],
//   );
//
//   Map<dynamic, dynamic> toJson() => {
//     "id": id == null ? null : kolliIdValues.reverse[id],
//     "value": value == null ? null : value,
//     "amount": amount == null ? null : amount,
//   };
// }
//
// enum KolliId { EU_PALL, SJO_PALL, LANGGODS, BUNTS, PAKET, STYCKE_GODS }
//
// final kolliIdValues = EnumValues({
//   "bunts": KolliId.BUNTS,
//   "eu_pall": KolliId.EU_PALL,
//   "langgods": KolliId.LANGGODS,
//   "paket": KolliId.PAKET,
//   "sjo_pall": KolliId.SJO_PALL,
//   "stycke_gods": KolliId.STYCKE_GODS
// });
//
// class NtmDataFullRoute {
//   NtmDataFullRoute({
//     this.vehicle,
//     this.fuel,
//     this.totals,
//   });
//
//   Map<dynamic, NtmDataFullRouteFuel>? vehicle;
//   Map<dynamic, NtmDataFullRouteFuel>? fuel;
//   Map<dynamic, NtmDataFullRouteFuel>? totals;
//
//   factory NtmDataFullRoute.fromJson(Map<dynamic, dynamic> json) => NtmDataFullRoute(
//     vehicle: json["vehicle"] == null ? null : Map.from(json["vehicle"]).map((k, v) => MapEntry<dynamic, NtmDataFullRouteFuel>(k, NtmDataFullRouteFuel.fromJson(v))),
//     fuel: json["fuel"] == null ? null : Map.from(json["fuel"]).map((k, v) => MapEntry<dynamic, NtmDataFullRouteFuel>(k, NtmDataFullRouteFuel.fromJson(v))),
//     totals: json["totals"] == null ? null : Map.from(json["totals"]).map((k, v) => MapEntry<dynamic, NtmDataFullRouteFuel>(k, NtmDataFullRouteFuel.fromJson(v))),
//   );
//
//   Map<dynamic, dynamic> toJson() => {
//     "vehicle": vehicle == null ? null : Map.from(vehicle!).map((k, v) => MapEntry<dynamic, dynamic>(k, v.toJson())),
//     "fuel": fuel == null ? null : Map.from(fuel!).map((k, v) => MapEntry<dynamic, dynamic>(k, v.toJson())),
//     "totals": totals == null ? null : Map.from(totals!).map((k, v) => MapEntry<dynamic, dynamic>(k, v.toJson())),
//   };
// }
//
// class NtmDataFullRouteFuel {
//   NtmDataFullRouteFuel({
//     this.value,
//     this.unit,
//     this.header,
//     this.id,
//     this.isFuelData,
//   });
//
//   double? value;
//   FuelUnit? unit;
//   Header? header;
//   FuelId? id;
//   dynamic? isFuelData;
//
//   factory NtmDataFullRouteFuel.fromJson(Map<dynamic, dynamic> json) => NtmDataFullRouteFuel(
//     value: json["value"] == null ? null : json["value"].toDouble(),
//     unit: json["unit"] == null ? null : fuelUnitValues.map[json["unit"]],
//     header: json["header"] == null ? null : headerValues.map[json["header"]],
//     id: json["id"] == null ? null : fuelIdValues.map[json["id"]],
//     isFuelData: json["is_fuel_data"] == null ? null : json["is_fuel_data"],
//   );
//
//   Map<dynamic, dynamic> toJson() => {
//     "value": value == null ? null : value,
//     "unit": unit == null ? null : fuelUnitValues.reverse[unit],
//     "header": header == null ? null : headerValues.reverse[header],
//     "id": id == null ? null : fuelIdValues.reverse[id],
//     "is_fuel_data": isFuelData == null ? null : isFuelData,
//   };
// }
//
// enum OrganizationId { THE_5_FFEB87_C4_FDAB911_F579_A042 }
//
// final organizationIdValues = EnumValues({
//   "5ffeb87c4fdab911f579a042": OrganizationId.THE_5_FFEB87_C4_FDAB911_F579_A042
// });
//
// enum ProjectId { THE_6040_DA014_FDAB967583_A7_EB2 }
//
// final projectIdValues = EnumValues({
//   "6040da014fdab967583a7eb2": ProjectId.THE_6040_DA014_FDAB967583_A7_EB2
// });
//
// enum RecurringId { THE_61_EE76_AC2_A6_AA }
//
// final recurringIdValues = EnumValues({
//   "61ee76ac2a6aa": RecurringId.THE_61_EE76_AC2_A6_AA
// });
//
// enum ResponsiblePersonId { THE_6048_B7_A64_FDAB923957397_C2, THE_6380_AE1_FB8_ECFC3_F304_F47_F4, THE_63440011_E0_E6_D131707_F09_F3 }
//
// final responsiblePersonIdValues = EnumValues({
//   "6048b7a64fdab923957397c2": ResponsiblePersonId.THE_6048_B7_A64_FDAB923957397_C2,
//   "63440011e0e6d131707f09f3": ResponsiblePersonId.THE_63440011_E0_E6_D131707_F09_F3,
//   "6380ae1fb8ecfc3f304f47f4": ResponsiblePersonId.THE_6380_AE1_FB8_ECFC3_F304_F47_F4
// });
//
// enum Status { PENDING }
//
// final statusValues = EnumValues({
//   "pending": Status.PENDING
// });
//
// enum TransportStatus { NOT_ARRIVED }
//
// final transportStatusValues = EnumValues({
//   "not_arrived": TransportStatus.NOT_ARRIVED
// });
//
// enum UnloadingZoneId { THE_6041_CBAE4_FDAB964371_E8_CF5, THE_61_C16_CCC4_FDAB925_BF794722 }
//
// final unloadingZoneIdValues = EnumValues({
//   "6041cbae4fdab964371e8cf5": UnloadingZoneId.THE_6041_CBAE4_FDAB964371_E8_CF5,
//   "61c16ccc4fdab925bf794722": UnloadingZoneId.THE_61_C16_CCC4_FDAB925_BF794722
// });
//
// class EnumValues<T> {
//   Map<dynamic, T> map;
//   Map<T, dynamic>? reverseMap;
//
//   EnumValues(this.map);
//
//   Map<T, dynamic> get reverse {
//     if (reverseMap == null) {
//       reverseMap = map.map((k, v) => new MapEntry(v, k));
//     }
//     return reverseMap!;
//   }
// }
