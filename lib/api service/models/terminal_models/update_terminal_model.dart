/*
// To parse this JSON data, do
//
//     final addTerminalModel = addTerminalModelFromJson(jsonString);

import 'dart:convert';

import 'package:proj_site/api%20service/models/logistic_list_models/logistic_list_model.dart';

import '../enviromental_models/vehicle_model.dart';

UpdateTerminalModel updateTerminalModelFromJson(String str) => UpdateTerminalModel.fromJson(json.decode(str));

String updateTerminalModelToJson(UpdateTerminalModel data) => json.encode(data.toJson());

class UpdateTerminalModel {
  UpdateTerminalModel({
     this.success,
     this.result,
     this.requestIds,
  });

  bool? success;
  dynamic result;
  //Result? result;
  List<dynamic>? requestIds;

  factory UpdateTerminalModel.fromJson(Map<String, dynamic> json) => UpdateTerminalModel(
    success: json["success"] == null ? null : json["success"],
    result: json["result"] == null ? null : Result.fromJson(json["result"]),
    requestIds: List<dynamic>.from(json["request_ids"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "success": success == null ? null : success,
    "result": result == null ? null : result?.toJson(),
    "request_ids":(requestIds ==null)?null: List<dynamic>.from(requestIds!.map((x) => x)),
  };
}

class Result {
  Result({
    required this.projectId,
    required this.requestFromDateTime,
    required this.requestToDateTime,
    required this.contractorId,
    required this.responsiblePersonId,
    required this.description,
    required this.imageName,
    required this.createdBy,
    required this.organizationId,
    required this.itemName,
    required this.noOfPallets,
    required this.subProjectId,
    required this.status,
    required this.requestType,
    required this.isHidden,
    required this.unbooked,
    required this.resourceArray,
    required this.deliverySupplier,
    required this.loadWeight,
    required this.drivingDistance,
    required this.isReturn,
    required this.addresses,
    required this.ntmDataFullRoute,
    required this.isHiddenEnvironment,
    required this.transportStatus,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
  });

  String projectId;
  DateTime? requestFromDateTime;
  DateTime? requestToDateTime;
  String contractorId;
  String responsiblePersonId;
  dynamic description;
  dynamic imageName;
  String createdBy;
  String organizationId;
  String itemName;
  int noOfPallets;
  dynamic subProjectId;
  String status;
  String requestType;
  bool isHidden;
  bool unbooked;
  List<String>? resourceArray;
  String deliverySupplier;
  double loadWeight;
  double drivingDistance;
  bool isReturn;
  List<Address>? addresses;
  NtmDataFullRoute? ntmDataFullRoute;
  bool isHiddenEnvironment;
  String transportStatus;
  DateTime? updatedAt;
  DateTime? createdAt;
  String id;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    projectId: json["project_id"] == null ? null : json["project_id"],
    requestFromDateTime: json["request_from_date_time"] == null ? null : DateTime.parse(json["request_from_date_time"]),
    requestToDateTime: json["request_to_date_time"] == null ? null : DateTime.parse(json["request_to_date_time"]),
    contractorId: json["contractor_id"] == null ? null : json["contractor_id"],
    responsiblePersonId: json["responsible_person_id"] == null ? null : json["responsible_person_id"],
    description: json["description"],
    imageName: json["image_name"],
    createdBy: json["created_by"] == null ? null : json["created_by"],
    organizationId: json["organization_id"] == null ? null : json["organization_id"],
    itemName: json["item_name"] == null ? null : json["item_name"],
    noOfPallets: json["no_of_pallets"] == null ? null : json["no_of_pallets"],
    subProjectId: json["sub_project_id"],
    status: json["status"] == null ? null : json["status"],
    requestType: json["request_type"] == null ? null : json["request_type"],
    isHidden: json["is_hidden"] == null ? null : json["is_hidden"],
    unbooked: json["unbooked"] == null ? null : json["unbooked"],
    resourceArray: json["resource_array"] == null ? null : List<String>.from(json["resource_array"].map((x) => x)),
    deliverySupplier: json["delivery_supplier"] == null ? null : json["delivery_supplier"],
    loadWeight: json["load_weight"] == null ? null : json["load_weight"].toDouble(),
    drivingDistance: json["driving_distance"] == null ? null : json["driving_distance"].toDouble(),
    isReturn: json["is_return"] == null ? null : json["is_return"],
    addresses: json["addresses"] == null ? null : List<Address>.from(json["addresses"].map((x) => Address.fromJson(x))),
    ntmDataFullRoute: json["ntm_data_full_route"] == null ? null : NtmDataFullRoute.fromJson(json["ntm_data_full_route"]),
    isHiddenEnvironment: json["is_hidden_environment"] == null ? null : json["is_hidden_environment"],
    transportStatus: json["transport_status"] == null ? null : json["transport_status"],
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    id: json["_id"] == null ? null : json["_id"],
  );

  Map<String, dynamic> toJson() => {
    "project_id": projectId == null ? null : projectId,
    "request_from_date_time": requestFromDateTime == null ? null : requestFromDateTime?.toIso8601String(),
    "request_to_date_time": requestToDateTime == null ? null : requestToDateTime?.toIso8601String(),
    "contractor_id": contractorId == null ? null : contractorId,
    "responsible_person_id": responsiblePersonId == null ? null : responsiblePersonId,
    "description": description,
    "image_name": imageName,
    "created_by": createdBy == null ? null : createdBy,
    "organization_id": organizationId == null ? null : organizationId,
    "item_name": itemName == null ? null : itemName,
    "no_of_pallets": noOfPallets == null ? null : noOfPallets,
    "sub_project_id": subProjectId,
    "status": status == null ? null : status,
    "request_type": requestType == null ? null : requestType,
    "is_hidden": isHidden == null ? null : isHidden,
    "unbooked": unbooked == null ? null : unbooked,
    "resource_array": resourceArray == null ? null : List<dynamic>.from(resourceArray!.map((x) => x)),
    "delivery_supplier": deliverySupplier == null ? null : deliverySupplier,
    "load_weight": loadWeight == null ? null : loadWeight,
    "driving_distance": drivingDistance == null ? null : drivingDistance,
    "is_return": isReturn == null ? null : isReturn,
    "addresses": addresses == null ? null : List<dynamic>.from(addresses!.map((x) => x.toJson())),
    "ntm_data_full_route": ntmDataFullRoute == null ? null : ntmDataFullRoute?.toJson(),
    "is_hidden_environment": isHiddenEnvironment == null ? null : isHiddenEnvironment,
    "transport_status": transportStatus == null ? null : transportStatus,
    "updated_at": updatedAt == null ? null : updatedAt?.toIso8601String(),
    "created_at": createdAt == null ? null : createdAt?.toIso8601String(),
    "_id": id == null ? null : id,
  };
}

class Address {
  Address({
    required this.id,
    required this.place,
    required this.lat,
    required this.lng,
    required this.airport,
    required this.typeOfVehicle,
    required this.euroClass,
    required this.typeOfFuel,
    required this.vehicleCapacity,
    required this.partDistance,
    required this.ntmRequest,
    required this.ntmEnvironmentSimpleData,
    required this.ntm,
    required this.ntmEnvironmentData,
  });

  String id;
  String place;
  String lat;
  String lng;
  bool airport;
  String typeOfVehicle;
  String euroClass;
  String typeOfFuel;
  int vehicleCapacity;
  double partDistance;
  NtmRequest? ntmRequest;
  NtmEnvironmentSimpleData? ntmEnvironmentSimpleData;
  bool ntm;
  String ntmEnvironmentData;

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    id: json["id"] == null ? null : json["id"],
    place: json["place"] == null ? null : json["place"],
    lat: json["lat"] == null ? null : json["lat"],
    lng: json["lng"] == null ? null : json["lng"],
    airport: json["airport"] == null ? null : json["airport"],
    typeOfVehicle: json["type_of_vehicle"] == null ? null : json["type_of_vehicle"],
    euroClass: json["euro_class"] == null ? null : json["euro_class"],
    typeOfFuel: json["type_of_fuel"] == null ? null : json["type_of_fuel"],
    vehicleCapacity: json["vehicle_capacity"] == null ? null : json["vehicle_capacity"],
    partDistance: json["part_distance"] == null ? null : json["part_distance"].toDouble(),
    ntmRequest: json["ntm_request"] == null ? null : NtmRequest.fromJson(json["ntm_request"]),
    ntmEnvironmentSimpleData: json["ntm_environment_simple_data"] == null ? null : NtmEnvironmentSimpleData.fromJson(json["ntm_environment_simple_data"]),
    ntm: json["ntm"] == null ? null : json["ntm"],
    ntmEnvironmentData: json["ntm_environment_data"] == null ? null : json["ntm_environment_data"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "place": place == null ? null : place,
    "lat": lat == null ? null : lat,
    "lng": lng == null ? null : lng,
    "airport": airport == null ? null : airport,
    "type_of_vehicle": typeOfVehicle == null ? null : typeOfVehicle,
    "euro_class": euroClass == null ? null : euroClass,
    "type_of_fuel": typeOfFuel == null ? null : typeOfFuel,
    "vehicle_capacity": vehicleCapacity == null ? null : vehicleCapacity,
    "part_distance": partDistance == null ? null : partDistance,
    "ntm_request": ntmRequest == null ? null : ntmRequest?.toJson(),
    "ntm_environment_simple_data": ntmEnvironmentSimpleData == null ? null : ntmEnvironmentSimpleData?.toJson(),
    "ntm": ntm == null ? null : ntm,
    "ntm_environment_data": ntmEnvironmentData == null ? null : ntmEnvironmentData,
  };
}

class NtmEnvironmentSimpleData {
  NtmEnvironmentSimpleData({
    required this.vehicle,
    required this.fuel,
    required this.totals,
  });

  Map<String, NtmEnvironmentSimpleDataFuel>? vehicle;
  Map<String, NtmEnvironmentSimpleDataFuel>? fuel;
  Map<String, NtmEnvironmentSimpleDataFuel>? totals;

  factory NtmEnvironmentSimpleData.fromJson(Map<String, dynamic> json) => NtmEnvironmentSimpleData(
    vehicle: json["vehicle"] == null ? null : Map.from(json["vehicle"]).map((k, v) => MapEntry<String, NtmEnvironmentSimpleDataFuel>(k, NtmEnvironmentSimpleDataFuel.fromJson(v))),
    fuel: json["fuel"] == null ? null : Map.from(json["fuel"]).map((k, v) => MapEntry<String, NtmEnvironmentSimpleDataFuel>(k, NtmEnvironmentSimpleDataFuel.fromJson(v))),
    totals: json["totals"] == null ? null : Map.from(json["totals"]).map((k, v) => MapEntry<String, NtmEnvironmentSimpleDataFuel>(k, NtmEnvironmentSimpleDataFuel.fromJson(v))),
  );

  Map<String, dynamic> toJson() => {
    "vehicle": vehicle == null ? null : Map.from(vehicle!).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
    "fuel": fuel == null ? null : Map.from(fuel!).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
    "totals": totals == null ? null : Map.from(totals!).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
  };
}

class NtmEnvironmentSimpleDataFuel {
  NtmEnvironmentSimpleDataFuel({
    required this.header,
    required this.id,
    required this.unit,
    required this.value,
    required this.precision,
    required this.greaterThan,
    required this.isFuelData,
  });

  String header;
  String id;
  Unit? unit;
  double value;
  int precision;
  bool greaterThan;
  bool isFuelData;

  factory NtmEnvironmentSimpleDataFuel.fromJson(Map<String, dynamic> json) => NtmEnvironmentSimpleDataFuel(
    header: json["header"] == null ? null : json["header"],
    id: json["id"] == null ? null : json["id"],
    unit: json["unit"] == null ? null : unitValues.map[json["unit"]],
    value: json["value"] == null ? null : json["value"].toDouble(),
    precision: json["precision"] == null ? null : json["precision"],
    greaterThan: json["greaterThan"] == null ? null : json["greaterThan"],
    isFuelData: json["is_fuel_data"] == null ? null : json["is_fuel_data"],
  );

  Map<String, dynamic> toJson() => {
    "header": header == null ? null : header,
    "id": id == null ? null : id,
    "unit": unit == null ? null : unitValues.reverse[unit],
    "value": value == null ? null : value,
    "precision": precision == null ? null : precision,
    "greaterThan": greaterThan == null ? null : greaterThan,
    "is_fuel_data": isFuelData == null ? null : isFuelData,
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
    required this.calculationObject,
    required this.parameters,
  });

  CalculationObject? calculationObject;
  List<Parameter>? parameters;

  factory NtmRequest.fromJson(Map<String, dynamic> json) => NtmRequest(
    calculationObject: json["calculationObject"] == null ? null : CalculationObject.fromJson(json["calculationObject"]),
    parameters: json["parameters"] == null ? null : List<Parameter>.from(json["parameters"].map((x) => Parameter.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "calculationObject": calculationObject == null ? null : calculationObject?.toJson(),
    "parameters": parameters == null ? null : List<dynamic>.from(parameters!.map((x) => x.toJson())),
  };
}

class CalculationObject {
  CalculationObject({
    required this.id,
    required this.version,
  });

  String id;
  String version;

  factory CalculationObject.fromJson(Map<String, dynamic> json) => CalculationObject(
    id: json["id"] == null ? null : json["id"],
    version: json["version"] == null ? null : json["version"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "version": version == null ? null : version,
  };
}

class Parameter {
  Parameter({
    required this.id,
    required this.value,
    required this.unit,
  });

  String id;
  dynamic value;
  String unit;

  factory Parameter.fromJson(Map<String, dynamic> json) => Parameter(
    id: json["id"] == null ? null : json["id"],
    value: json["value"],
    unit: json["unit"] == null ? null : json["unit"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "value": value,
    "unit": unit == null ? null : unit,
  };
}

class NtmDataFullRoute {
  NtmDataFullRoute({
    required this.vehicle,
    required this.fuel,
    required this.totals,
  });

  Map<String, NtmDataFullRouteFuel>? vehicle;
  Map<String, NtmDataFullRouteFuel>? fuel;
  Map<String, NtmDataFullRouteFuel>? totals;

  factory NtmDataFullRoute.fromJson(Map<String, dynamic> json) => NtmDataFullRoute(
    vehicle: json["vehicle"] == null ? null : Map.from(json["vehicle"]).map((k, v) => MapEntry<String, NtmDataFullRouteFuel>(k, NtmDataFullRouteFuel.fromJson(v))),
    fuel: json["fuel"] == null ? null : Map.from(json["fuel"]).map((k, v) => MapEntry<String, NtmDataFullRouteFuel>(k, NtmDataFullRouteFuel.fromJson(v))),
    totals: json["totals"] == null ? null : Map.from(json["totals"]).map((k, v) => MapEntry<String, NtmDataFullRouteFuel>(k, NtmDataFullRouteFuel.fromJson(v))),
  );

  Map<String, dynamic> toJson() => {
    "vehicle": vehicle == null ? null : Map.from(vehicle!).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
    "fuel": fuel == null ? null : Map.from(fuel!).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
    "totals": totals == null ? null : Map.from(totals!).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
  };
}

class NtmDataFullRouteFuel {
  NtmDataFullRouteFuel({
    required this.value,
    required this.unit,
    required this.header,
    required this.id,
    required this.isFuelData,
  });

  double value;
  Unit? unit;
  String header;
  String id;
  bool isFuelData;

  factory NtmDataFullRouteFuel.fromJson(Map<String, dynamic> json) => NtmDataFullRouteFuel(
    value: json["value"] == null ? null : json["value"].toDouble(),
    unit: json["unit"] == null ? null : unitValues.map[json["unit"]],
    header: json["header"] == null ? null : json["header"],
    id: json["id"] == null ? null : json["id"],
    isFuelData: json["is_fuel_data"] == null ? null : json["is_fuel_data"],
  );

  Map<String, dynamic> toJson() => {
    "value": value == null ? null : value,
    "unit": unit == null ? null : unitValues.reverse?[unit],
    "header": header == null ? null : header,
    "id": id == null ? null : id,
    "is_fuel_data": isFuelData == null ? null : isFuelData,
  };
}

// class EnumValues<T> {
//   Map<String, T> map;
//   Map<T, String>? reverseMap;
//
//   EnumValues(this.map);
//
//   Map<T, String> get reverse {
//     if (reverseMap == null) {
//       reverseMap = map.map((k, v) => new MapEntry(v, k));
//     }
//     return reverseMap;
//   }
// }
*/

// To parse this JSON data, do
//
//     final updateTerminalModel = updateTerminalModelFromJson(jsonString);

// import 'dart:convert';
//
// UpdateTerminalModel updateTerminalModelFromJson(String str) => UpdateTerminalModel.fromJson(json.decode(str));
//
// String updateTerminalModelToJson(UpdateTerminalModel data) => json.encode(data.toJson());

class UpdateTerminalModel {
  UpdateTerminalModel({
    required this.success,
    required this.result,
    required this.requestIds,
  });

  bool success;
  int result;
  List<dynamic> requestIds;

  factory UpdateTerminalModel.fromJson(Map<String, dynamic> json) => UpdateTerminalModel(
    success: json["success"],
    result: json["result"],
    requestIds: List<dynamic>.from(json["request_ids"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "result": result,
    "request_ids": List<dynamic>.from(requestIds.map((x) => x)),
  };
}

