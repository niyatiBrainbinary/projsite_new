import 'dart:convert';

AddTerminalModel addTerminalModelFromJson(String str) => AddTerminalModel.fromJson(json.decode(str));

String addTerminalModelToJson(AddTerminalModel data) => json.encode(data.toJson());

class AddTerminalModel {
  AddTerminalModel({
    required this.success,
  });

  bool success;


  factory AddTerminalModel.fromJson(Map<String, dynamic> json) => AddTerminalModel(
    success: json["success"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
  };
}

