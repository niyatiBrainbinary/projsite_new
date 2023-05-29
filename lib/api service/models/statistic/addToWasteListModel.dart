// To parse this JSON data, do
//
//     final addToWasteListModel = addToWasteListModelFromJson(jsonString);

import 'dart:convert';

AddToWasteListModel addToWasteListModelFromJson(String str) => AddToWasteListModel.fromJson(json.decode(str));

String addToWasteListModelToJson(AddToWasteListModel data) => json.encode(data.toJson());

class AddToWasteListModel {
  bool? success;
  WasteData? wasteData;

  AddToWasteListModel({
    this.success,
    this.wasteData,
  });

  factory AddToWasteListModel.fromJson(Map<String, dynamic> json) => AddToWasteListModel(
    success: json["success"],
    wasteData: json["waste_data"] == null ? null : WasteData.fromJson(json["waste_data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "waste_data": wasteData?.toJson(),
  };
}

class WasteData {
  String? wasteContainer;
  String? wasteContainerId;
  int? numberOfContainers;
  String? wasteFraction;
  String? wasteFractionId;
  int? amountOfFraction;
  int? amountOfTransports;
  dynamic transportDistance;
  FractionAddress? fractionAddress;
  ProjectAddress? projectAddress;
  String? containerVehicle;
  String? containerVehicleFuel;
  String? containerVehicleEuroclass;
  dynamic loadWeightPerTransport;
  NtmSimpleData? ntmSimpleData;
  bool? ntm;

  WasteData({
    this.wasteContainer,
    this.wasteContainerId,
    this.numberOfContainers,
    this.wasteFraction,
    this.wasteFractionId,
    this.amountOfFraction,
    this.amountOfTransports,
    this.transportDistance,
    this.fractionAddress,
    this.projectAddress,
    this.containerVehicle,
    this.containerVehicleFuel,
    this.containerVehicleEuroclass,
    this.loadWeightPerTransport,
    this.ntmSimpleData,
    this.ntm,
  });

  factory WasteData.fromJson(Map<String, dynamic> json) => WasteData(
    wasteContainer: json["waste_container"],
    wasteContainerId: json["waste_container_id"],
    numberOfContainers: json["number_of_containers"],
    wasteFraction: json["waste_fraction"],
    wasteFractionId: json["waste_fraction_id"],
    amountOfFraction: json["amount_of_fraction"],
    amountOfTransports: json["amount_of_transports"],
    transportDistance: json["transport_distance"],
    fractionAddress: json["fraction_address"] == null ? null : FractionAddress.fromJson(json["fraction_address"]),
    projectAddress: json["project_address"] == null ? null : ProjectAddress.fromJson(json["project_address"]),
    containerVehicle: json["container_vehicle"],
    containerVehicleFuel: json["container_vehicle_fuel"],
    containerVehicleEuroclass: json["container_vehicle_euroclass"],
    loadWeightPerTransport: json["load_weight_per_transport"],
    ntmSimpleData: json["ntm_simple_data"] == null ? null : NtmSimpleData.fromJson(json["ntm_simple_data"]),
    ntm: json["ntm"],
  );

  Map<String, dynamic> toJson() => {
    "waste_container": wasteContainer,
    "waste_container_id": wasteContainerId,
    "number_of_containers": numberOfContainers,
    "waste_fraction": wasteFraction,
    "waste_fraction_id": wasteFractionId,
    "amount_of_fraction": amountOfFraction,
    "amount_of_transports": amountOfTransports,
    "transport_distance": transportDistance,
    "fraction_address": fractionAddress?.toJson(),
    "project_address": projectAddress?.toJson(),
    "container_vehicle": containerVehicle,
    "container_vehicle_fuel": containerVehicleFuel,
    "container_vehicle_euroclass": containerVehicleEuroclass,
    "load_weight_per_transport": loadWeightPerTransport,
    "ntm_simple_data": ntmSimpleData?.toJson(),
    "ntm": ntm,
  };
}

class FractionAddress {
  String? fractionSelectedAddress;
  double? fractionSelectedAddressLat;
  double? fractionSelectedAddressLng;

  FractionAddress({
    this.fractionSelectedAddress,
    this.fractionSelectedAddressLat,
    this.fractionSelectedAddressLng,
  });

  factory FractionAddress.fromJson(Map<String, dynamic> json) => FractionAddress(
    fractionSelectedAddress: json["fraction_selected_address"],
    fractionSelectedAddressLat: json["fraction_selected_address_lat"],
    fractionSelectedAddressLng: json["fraction_selected_address_lng"],
  );

  Map<String, dynamic> toJson() => {
    "fraction_selected_address": fractionSelectedAddress,
    "fraction_selected_address_lat": fractionSelectedAddressLat,
    "fraction_selected_address_lng": fractionSelectedAddressLng,
  };
}

class NtmSimpleData {
  Map<String, Total>? vehicle;
  Map<String, Total>? totals;

  NtmSimpleData({
    this.vehicle,
    this.totals,
  });

  factory NtmSimpleData.fromJson(Map<String, dynamic> json) => NtmSimpleData(
    vehicle: Map.from(json["vehicle"]!).map((k, v) => MapEntry<String, Total>(k, Total.fromJson(v))),
    totals: Map.from(json["totals"]!).map((k, v) => MapEntry<String, Total>(k, Total.fromJson(v))),
  );

  Map<String, dynamic> toJson() => {
    "vehicle": Map.from(vehicle!).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
    "totals": Map.from(totals!).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
  };
}

class Total {
  String? header;
  String? id;
  Unit? unit;
  dynamic value;
  dynamic precision;
  bool? greaterThan;
  bool? isFuelData;

  Total({
    this.header,
    this.id,
    this.unit,
    this.value,
    this.precision,
    this.greaterThan,
    this.isFuelData,
  });

  factory Total.fromJson(Map<String, dynamic> json) => Total(
    header: json["header"],
    id: json["id"],
    unit: unitValues.map[json["unit"]]!,
    value: json["value"],
    precision: json["precision"],
    greaterThan: json["greaterThan"],
    isFuelData: json["is_fuel_data"],
  );

  Map<String, dynamic> toJson() => {
    "header": header,
    "id": id,
    "unit": unitValues.reverse[unit],
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

class ProjectAddress {
  String? lat;
  String? lng;
  String? location;

  ProjectAddress({
    this.lat,
    this.lng,
    this.location,
  });

  factory ProjectAddress.fromJson(Map<String, dynamic> json) => ProjectAddress(
    lat: json["lat"],
    lng: json["lng"],
    location: json["location"],
  );

  Map<String, dynamic> toJson() => {
    "lat": lat,
    "lng": lng,
    "location": location,
  };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
