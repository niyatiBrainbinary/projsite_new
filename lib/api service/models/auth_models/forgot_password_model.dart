class ForgotPasswordModel {
  ForgotPasswordModel({this.success, this.error});

  bool? success;
  Error? error;

  factory ForgotPasswordModel.fromJson(Map<String, dynamic> json) =>
      json['error'] == null
          ? ForgotPasswordModel(
              success: json["success"],
            )
          : ForgotPasswordModel(
              error: Error.fromJson(json["error"]),
            );

  Map<String, dynamic> toJson() => {
        "success": success,
      };
}

class Error {
  Error({
    this.invalidUsername,
  });

  bool? invalidUsername;

  factory Error.fromJson(Map<String, dynamic> json) => Error(
        invalidUsername: json["invalid_username"],
      );

  Map<String, dynamic> toJson() => {
        "invalid_username": invalidUsername,
      };
}
