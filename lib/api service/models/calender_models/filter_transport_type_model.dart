
class FilterTransportTypeModel {
  FilterTransportTypeModel({
    this.success,
    this.data,
  });

  bool? success;
  Data? data;

  factory FilterTransportTypeModel.fromJson(Map<String, dynamic> json) => FilterTransportTypeModel(
    success: json["success"] == null ? null : json["success"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success == null ? null : success,
    "data": data == null ? null : data,
  };
}

class Data {
  Data({
    this.general,
    this.logistics,
    this.terminal,
    this.unbooked,
  });

  String? general;
  String? logistics;
  String? terminal;
  String? unbooked;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    general: json["general"] == null ? null : json["general"],
    logistics: json["logistics"] == null ? null : json["logistics"],
    terminal: json["terminal"] == null ? null : json["terminal"],
    unbooked: json["unbooked"] == null ? null : json["unbooked"],
  );

  Map<String, dynamic> toJson() => {
    "general": general == null ? null : general,
    "logistics": logistics == null ? null : logistics,
    "terminal": terminal == null ? null : terminal,
    "unbooked": unbooked == null ? null : unbooked,
  };
}
