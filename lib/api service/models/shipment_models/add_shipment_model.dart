// To parse this JSON data, do
//
//     final addShipmentModel = addShipmentModelFromJson(jsondynamic);

import 'dart:convert';

AddShipmentModel? addShipmentModelFromJson(dynamic str) => AddShipmentModel.fromJson(json.decode(str));

dynamic addShipmentModelToJson(AddShipmentModel? data) => json.encode(data!.toJson());

class AddShipmentModel {
  AddShipmentModel({
    this.success,
    this.result,
    this.requestIds,
  });

  bool? success;
  dynamic result;
  List<dynamic?>? requestIds;

  factory AddShipmentModel.fromJson(Map<dynamic, dynamic> json) => AddShipmentModel(
    success: json["success"],
    result: json["result"],
    requestIds: json["request_ids"] == null ? [] : json["request_ids"] == null ? [] : List<dynamic?>.from(json["request_ids"]!.map((x) => x)),
  );

  Map<dynamic, dynamic> toJson() => {
    "success": success,
    "result": result,
    "request_ids": requestIds == null ? [] : requestIds == null ? [] : List<dynamic>.from(requestIds!.map((x) => x)),
  };
}

class Result {
  Result({
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
    this.id,
  });

  dynamic? projectId;
  DateTime? requestFromDateTime;
  DateTime? requestToDateTime;
  List<dynamic?>? resourceArray;
  dynamic? unloadingZoneId;
  dynamic? contractorId;
  dynamic responsiblePersonId;
  dynamic subProjectId;
  dynamic description;
  dynamic instruction;
  dynamic imageName;
  dynamic image;
  dynamic? isRecurring;
  dynamic recurringId;
  List<dynamic>? recurringDays;
  dynamic recurringToDate;
  dynamic? createdBy;
  dynamic? status;
  dynamic? requestType;
  dynamic? organizationId;
  bool? isHidden;
  dynamic? deliverySupplier;
  double? loadWeight;
  double? drivingDistance;
  bool? isReturn;
  List<Address?>? addresses;
  NtmDataFullRoute? ntmDataFullRoute;
  dynamic kollis;
  bool? unbooked;
  bool? isHiddenEnvironment;
  dynamic? transportStatus;
  DateTime? updatedAt;
  DateTime? createdAt;
  dynamic? id;

  factory Result.fromJson(Map<dynamic, dynamic> json) => Result(
    projectId: json["project_id"],
    requestFromDateTime: json["request_from_date_time"],
    requestToDateTime: json["request_to_date_time"],
    resourceArray: json["resource_array"] == null ? [] : json["resource_array"] == null ? [] : List<dynamic?>.from(json["resource_array"]!.map((x) => x)),
    unloadingZoneId: json["unloading_zone_id"],
    contractorId: json["contractor_id"],
    responsiblePersonId: json["responsible_person_id"],
    subProjectId: json["sub_project_id"],
    description: json["description"],
    instruction: json["instruction"],
    imageName: json["image_name"],
    image: json["image"],
    isRecurring: json["is_recurring"],
    recurringId: json["recurring_id"],
    recurringDays: json["recurring_days"] == null ? [] : json["recurring_days"] == null ? [] : List<dynamic>.from(json["recurring_days"]!.map((x) => x)),
    recurringToDate: json["recurring_to_date"],
    createdBy: json["created_by"],
    status: json["status"],
    requestType: json["request_type"],
    organizationId: json["organization_id"],
    isHidden: json["is_hidden"],
    deliverySupplier: json["delivery_supplier"],
    loadWeight: json["load_weight"],
    drivingDistance: json["driving_distance"],
    isReturn: json["is_return"],
    addresses: json["addresses"] == null ? [] : json["addresses"] == null ? [] : List<Address?>.from(json["addresses"]!.map((x) => Address.fromJson(x))),
    ntmDataFullRoute: json["ntm_data_full_route"],
    kollis: json["kollis"],
    unbooked: json["unbooked"],
    isHiddenEnvironment: json["is_hidden_environment"],
    transportStatus: json["transport_status"],
    updatedAt: json["updated_at"],
    createdAt: json["created_at"],
    id: json["_id"],
  );

  Map<dynamic, dynamic> toJson() => {
    "project_id": projectId,
    "request_from_date_time": requestFromDateTime,
    "request_to_date_time": requestToDateTime,
    "resource_array": resourceArray == null ? [] : resourceArray == null ? [] : List<dynamic>.from(resourceArray!.map((x) => x)),
    "unloading_zone_id": unloadingZoneId,
    "contractor_id": contractorId,
    "responsible_person_id": responsiblePersonId,
    "sub_project_id": subProjectId,
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
    "request_type": requestType,
    "organization_id": organizationId,
    "is_hidden": isHidden,
    "delivery_supplier": deliverySupplier,
    "load_weight": loadWeight,
    "driving_distance": drivingDistance,
    "is_return": isReturn,
    "addresses": addresses == null ? [] : addresses == null ? [] : List<dynamic>.from(addresses!.map((x) => x!.toJson())),
    "ntm_data_full_route": ntmDataFullRoute,
    "kollis": kollis,
    "unbooked": unbooked,
    "is_hidden_environment": isHiddenEnvironment,
    "transport_status": transportStatus,
    "updated_at": updatedAt,
    "created_at": createdAt,
    "_id": id,
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
    this.ntmRequest,
    this.ntmEnvironmentSimpleData,
    this.ntm,
    this.ntmEnvironmentData,
  });

  dynamic? id;
  dynamic? place;
  dynamic? lat;
  dynamic? lng;
  bool? airport;
  dynamic? typeOfVehicle;
  dynamic? euroClass;
  dynamic? typeOfFuel;
  int? vehicleCapacity;
  double? partDistance;
  NtmRequest? ntmRequest;
  NtmEnvironmentSimpleData? ntmEnvironmentSimpleData;
  bool? ntm;
  dynamic? ntmEnvironmentData;

  factory Address.fromJson(Map<dynamic, dynamic> json) => Address(
    id: json["id"],
    place: json["place"],
    lat: json["lat"],
    lng: json["lng"],
    airport: json["airport"],
    typeOfVehicle: json["type_of_vehicle"],
    euroClass: json["euro_class"],
    typeOfFuel: json["type_of_fuel"],
    vehicleCapacity: json["vehicle_capacity"],
    partDistance: json["part_distance"],
    ntmRequest: json["ntm_request"],
    ntmEnvironmentSimpleData: json["ntm_environment_simple_data"],
    ntm: json["ntm"],
    ntmEnvironmentData: json["ntm_environment_data"],
  );

  Map<dynamic, dynamic> toJson() => {
    "id": id,
    "place": place,
    "lat": lat,
    "lng": lng,
    "airport": airport,
    "type_of_vehicle": typeOfVehicle,
    "euro_class": euroClass,
    "type_of_fuel": typeOfFuel,
    "vehicle_capacity": vehicleCapacity,
    "part_distance": partDistance,
    "ntm_request": ntmRequest,
    "ntm_environment_simple_data": ntmEnvironmentSimpleData,
    "ntm": ntm,
    "ntm_environment_data": ntmEnvironmentData,
  };
}

class NtmEnvironmentSimpleData {
  NtmEnvironmentSimpleData({
    this.vehicle,
    this.fuel,
    this.totals,
  });

  Map<dynamic, NtmEnvironmentSimpleDataFuel?>? vehicle;
  Map<dynamic, NtmEnvironmentSimpleDataFuel?>? fuel;
  Map<dynamic, NtmEnvironmentSimpleDataFuel?>? totals;

  factory NtmEnvironmentSimpleData.fromJson(Map<dynamic, dynamic> json) => NtmEnvironmentSimpleData(
    vehicle: json["vehicle"],
    fuel: json["fuel"],
    totals: json["totals"],
  );

  Map<dynamic, dynamic> toJson() => {
    "vehicle": vehicle,
    "fuel": fuel,
    "totals": totals,
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
  Unit? unit;
  double? value;
  int? precision;
  bool? greaterThan;
  bool? isFuelData;

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

enum Unit { G, KG, L, MJ }

final unitValues = EnumValues({
  "g": Unit.G,
  "kg": Unit.KG,
  "l": Unit.L,
  "MJ": Unit.MJ
});

class NtmRequest {
  NtmRequest({
    this.calculationObject,
    this.parameters,
  });

  CalculationObject? calculationObject;
  List<Parameter?>? parameters;

  factory NtmRequest.fromJson(Map<dynamic, dynamic> json) => NtmRequest(
    calculationObject: json["calculationObject"],
    parameters: json["parameters"] == null ? [] : json["parameters"] == null ? [] : List<Parameter?>.from(json["parameters"]!.map((x) => Parameter.fromJson(x))),
  );

  Map<dynamic, dynamic> toJson() => {
    "calculationObject": calculationObject,
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
  dynamic value;
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

class NtmDataFullRoute {
  NtmDataFullRoute({
    this.vehicle,
    this.fuel,
    this.totals,
  });

  Map<dynamic, NtmDataFullRouteFuel?>? vehicle;
  Map<dynamic, NtmDataFullRouteFuel?>? fuel;
  Map<dynamic, NtmDataFullRouteFuel?>? totals;

  factory NtmDataFullRoute.fromJson(Map<dynamic, dynamic> json) => NtmDataFullRoute(
    vehicle: json["vehicle"],
    fuel: json["fuel"],
    totals: json["totals"],
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
  Unit? unit;
  dynamic? header;
  dynamic? id;
  bool? isFuelData;

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

class EnumValues<T> {
  Map<dynamic, T> map;
  Map<T, dynamic>? reverseMap;

  EnumValues(this.map);

  Map<T, dynamic>? get reverse {
    reverseMap ??= map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
