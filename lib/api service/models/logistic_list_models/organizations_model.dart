
import 'dart:convert';

OrganizationsModel organizationsModelFromJson(String str) => OrganizationsModel.fromJson(json.decode(str));

String organizationsModelToJson(OrganizationsModel data) => json.encode(data.toJson());

class OrganizationsModel {
  OrganizationsModel({
    required this.success,
    required this.companyList,
  });

  bool success;
  List<CompanyList>? companyList;

  factory OrganizationsModel.fromJson(Map<String, dynamic> json) => OrganizationsModel(
    success: json["success"] == null ? null : json["success"],
    companyList: json["company_list"] == null ? null : List<CompanyList>.from(json["company_list"].map((x) => CompanyList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success == null ? null : success,
    "company_list": companyList == null ? null : List<dynamic>.from(companyList!.map((x) => x.toJson())),
  };
}

class CompanyList {
  CompanyList({
    required this.id,
    required this.companyName,
    required this.organizationId,
    required this.updatedAt,
    required this.createdAt,
    required this.isDeleted,
  });

  String id;
  String companyName;
  String organizationId;
  DateTime? updatedAt;
  DateTime?createdAt;
  bool isDeleted;

  factory CompanyList.fromJson(Map<String, dynamic> json) => CompanyList(
    id: json["_id"] == null ? null : json["_id"],
    companyName: json["company_name"] == null ? null : json["company_name"],
    organizationId: json["organization_id"] == null ? null : json["organization_id"],
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    isDeleted: json["is_deleted"] == null ? null : json["is_deleted"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id == null ? null : id,
    "company_name": companyName == null ? null : companyName,
    "organization_id": organizationId == null ? null : organizationId,
    "updated_at": updatedAt == null ? null : updatedAt?.toIso8601String(),
    "created_at": createdAt == null ? null : createdAt?.toIso8601String(),
    "is_deleted": isDeleted == null ? null : isDeleted,
  };
}
