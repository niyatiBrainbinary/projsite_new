class CreateZoneModel {
  CreateZoneModel({
    this.success,
    this.error1,
    this.error,
  });

  bool? success;
  List<dynamic>? error1;
  Error? error;

  factory CreateZoneModel.fromJson(Map<String, dynamic> json) =>
      json['error'].isEmpty
          ? CreateZoneModel(
              success: json["success"],
              error1: List<dynamic>.from(json["error"].map((x) => x)),
            )
          : CreateZoneModel(
              success: json["success"],
              error: Error.fromJson(json["error"]),
            );

  Map<String, dynamic> toJson() => {
        "success": success,
        "error": List<dynamic>.from(error1!.map((x) => x)),
        "error": error!.toJson(),
      };
}

class Error {
  Error({
    this.error,
  });

  String? error;

  factory Error.fromJson(Map<String, dynamic> json) => Error(
        error: json["error"],
      );

  Map<String, dynamic> toJson() => {
        "error": error,
      };
}
