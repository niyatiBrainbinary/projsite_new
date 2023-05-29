import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:intl/intl.dart';
import 'package:proj_site/api%20service/api_routes.dart';
import 'package:proj_site/api%20service/http_service.dart';
import 'package:proj_site/api%20service/models/apd_plan_models/apdPlan_model.dart';
import 'package:proj_site/api%20service/models/apd_plan_models/delete_apdPlan_model.dart';
import 'package:proj_site/api%20service/models/auth_models/profile_details.dart';
import 'package:proj_site/api%20service/models/booking_models/add_bookings_model.dart';
import 'package:proj_site/api%20service/models/booking_models/booking_history_model.dart';
import 'package:proj_site/api%20service/models/calender_models/package_information_model.dart';
import 'package:proj_site/api%20service/models/calender_models/event_list_model.dart';
import 'package:proj_site/api%20service/models/calender_models/resource_list_model.dart';
import 'package:proj_site/api%20service/models/calender_models/zone_list_model.dart';
import 'package:proj_site/api%20service/models/common_model.dart';
import 'package:proj_site/api%20service/models/enviromental_models/euroclass_model.dart';
import 'package:proj_site/api%20service/models/enviromental_models/fuel_model.dart';
import 'package:proj_site/api%20service/models/enviromental_models/vehicle_model.dart';
import 'package:proj_site/api%20service/models/logistic_list_models/add_logistic_model.dart';
import 'package:proj_site/api%20service/models/logistic_list_models/checkout_logistic_model.dart';
import 'package:proj_site/api%20service/models/logistic_list_models/create_supplier_model.dart';
import 'package:proj_site/api%20service/models/logistic_list_models/delete_logistic_model.dart';
import 'package:proj_site/api%20service/models/logistic_list_models/edit_logistic_model.dart';
import 'package:proj_site/api%20service/models/logistic_list_models/logistic_details_model.dart';
import 'package:proj_site/api%20service/models/logistic_list_models/logistic_list_model.dart';
import 'package:proj_site/api%20service/models/logistic_list_models/logistic_request_data_model.dart';
import 'package:proj_site/api%20service/models/logistic_list_models/notTransported_checkouts_model.dart';
import 'package:proj_site/api%20service/models/logistic_list_models/organizations_model.dart';
import 'package:proj_site/api%20service/models/logistic_list_models/shipment_supplier_list_model.dart';
import 'package:proj_site/api%20service/models/logistic_list_models/user_sub_project_list_model.dart';
import 'package:proj_site/api%20service/models/profile_setting_models/edit_notification_model.dart';
import 'package:proj_site/api%20service/models/profile_setting_models/notification_model.dart';
import 'package:proj_site/api%20service/models/project_list_models/project_details_model.dart';
import 'package:proj_site/api%20service/models/project_setting_models/get_booking_form_model.dart';
import 'package:proj_site/api%20service/models/project_setting_models/save_booking_form_model.dart';
import 'package:proj_site/api%20service/models/rental_list_models/add_rental_model.dart';
import 'package:proj_site/api%20service/models/rental_list_models/delete_rental_model.dart';
import 'package:proj_site/api%20service/models/rental_list_models/rental_list_model.dart';
import 'package:proj_site/api%20service/models/rental_list_models/update_rental_model.dart';
import 'package:proj_site/api%20service/models/auth_models/sign_in_model.dart';
import 'package:proj_site/api%20service/models/shipment_models/add_shipment_model.dart';
import 'package:proj_site/api%20service/models/shipment_models/monthly_shipments_model.dart';
import 'package:proj_site/api%20service/models/shipment_models/pending_shipment_list_model.dart';
import 'package:proj_site/api%20service/models/shipment_models/request_data_model.dart';
import 'package:proj_site/api%20service/models/shipment_models/update_shipment_model.dart';
import 'package:proj_site/api%20service/models/sub_project_models/add_new_sub_project.dart';
import 'package:proj_site/api%20service/models/sub_project_models/assign_user_model.dart';
import 'package:proj_site/api%20service/models/sub_project_models/sub_project_list_model.dart';
import 'package:proj_site/api%20service/models/sub_project_models/userListDropDownModel.dart';
import 'package:proj_site/api%20service/models/terminal_models/add_terminal_model.dart';
import 'package:proj_site/api%20service/models/terminal_models/update_terminal_model.dart';
import 'package:proj_site/api%20service/models/transport_request_model/get_transport_request_model.dart';
import 'package:proj_site/api%20service/models/waste_disposal_models/waste_container_list_model.dart';
import 'package:proj_site/api%20service/models/waste_disposal_models/waste_fraction_list_model.dart';
import 'package:proj_site/common/widget_constant/widget_constant.dart';
import 'package:proj_site/helper/helper.dart';
import 'package:proj_site/api%20service/models/unloading_zone_models/create_zone_model.dart';
import 'package:proj_site/services/sharedpreference_service.dart';
import 'models/calender_models/user_list_model.dart';
import 'models/project_list_models/project_list_model.dart';
import 'models/statistic/addToWasteListModel.dart';
import 'models/statistic/statisticSaveModel.dart';
import 'models/statistic/wastFractionDropDownModel.dart';
import 'models/sub_project_models/remove_user_model.dart';
import 'models/sub_project_models/sub_project_user_list_model.dart';
import 'models/sub_project_models/update_sub_project_model.dart';
import 'models/terminal_models/terminal_list_model.dart';
import 'models/update_organization/update_organization.dart';
import 'models/statistic/wastContainerDropDownModel.dart';

class Repository {
  Repository._();

  static Dio get _dio {
    return Dio(
      BaseOptions(
        baseUrl: ApiRoutes.BASE_URL,
        headers: {
          // 'Authorization': 'Bearer ${Model.accessToken}',
          // "X-Requested-With": "XMLHttpRequest",
        },
        contentType: Headers.formUrlEncodedContentType,
      ),
    )..interceptors.addAll(
        [
          //  PrettyDioLogger(requestBody: true),
        ],
      );
  }

  static Future<SignInModel?> postSignIn(String email, String password) async {
    Map<String, dynamic> body = {
      'username': email,
      'password': password,
      'type': "mobile"
    };
    try {
      final res = await _dio.post(
        ApiRoutes.postSignIn,
        data: body,
      );
      if (res.statusCode! >= 200 && res.statusCode! < 300) {
        return SignInModel.fromJson(res.data);
      }
    } catch (e) {
      print(e);
      return null;
    }
    return null;
  }

  static Future<ProfileDetailsModel?> postProfileDetails(
      String id, String organizationId) async {
    Map<String, dynamic> body = {
      "data": {"_id": id, "organization_id": organizationId}
      // '_id': "5bd35238e549570b1f1a3274",
      // 'organization_id': "5ffeb87c4fdab911f579a042",
    };
    try {
      final res = await _dio.post(ApiRoutes.postProfileDetails,
          data: body, options: Options(headers: {"token": accessToken}));
      if (res.statusCode! >= 200 && res.statusCode! < 300) {
        return ProfileDetailsModel.fromJson(res.data);
      }
    } catch (e) {
      print(e);
      return null;
    }
    return null;
  }

  static Future<CommonModel?> postEditProfile(String id, String firstName,
      String lastName, String phone, String email) async {
    Map<String, dynamic> body = {
      "data": {
        "first_name": firstName,
        "last_name": lastName,
        "phone": phone,
        "email": email
      },
      "id": id
    };
    try {
      final res = await _dio.post(ApiRoutes.postEditProfile,
          data: body, options: Options(headers: {"token": accessToken}));
      if (res.statusCode! >= 200 && res.statusCode! < 300) {
        return CommonModel.fromJson(res.data);
      }
    } catch (e) {
      print(e);
      return null;
    }
    return null;
  }

  static Future<UpdateOrganizationModel?> updateOrganization(
      String orgId, String userId) async {
    Map<String, dynamic> body = {
      "user_id": userId,
      "organization_id": orgId,
      "type": "mobile"
    };
    try {
      final res = await _dio.post(ApiRoutes.updateOrganisation,
          data: body, options: Options(headers: {"token": accessToken}));
      if (res.statusCode! >= 200 && res.statusCode! < 300) {
        return UpdateOrganizationModel.fromJson(res.data);
      }
    } catch (e) {
      print(e);
      return null;
    }
    return null;
  }

  static Future<CommonModel?> postForgotPassword(String email) async {
    Map<String, dynamic> body = {
      'email': email,
    };
    try {
      final res = await _dio.post(
        ApiRoutes.postForgotPassword,
        data: body,
      );
      if (res.statusCode! >= 200 && res.statusCode! < 300) {
        return CommonModel.fromJson(res.data);
      }
    } catch (e) {
      print(e);
      return null;
    }
    return null;
  }

  static Future<CommonModel?> postUpdatePassword(
      String password, String userId) async {
    Map<String, dynamic> body = {
      'password': password,
      'user_id': userId,
    };
    try {
      final res = await _dio.post(
        ApiRoutes.postUpdatePassword,
        data: body,
      );
      if (res.statusCode! >= 200 && res.statusCode! < 300) {
        return CommonModel.fromJson(res.data);
      }
    } catch (e) {
      print(e);
      return null;
    }
    return null;
  }

  static Future<ApdPlanModel?> postApdPlan({required String projectId}) async {
    Map<String, dynamic> body = {
      'project_id': projectId,
    };
    try {
      final res = await _dio.post(
        ApiRoutes.postApdPlan,
        options: Options(headers: {"token": accessToken}),
        data: body,
      );
      if (res.statusCode! >= 200 && res.statusCode! < 300) {
        return ApdPlanModel.fromJson(res.data);
      }
    } catch (e) {
      print(e);
      return null;
    }
    return null;
  }

  static Future<CommonModel?> postUploadApdPlan(
      {required String apd_file_name,
      required File file,
      required String project_id}) async {
    String uploadFile = file.path.split('/').last;
    var formData = FormData.fromMap({
      'data':
          '{"project_id": "$project_id" , "apd_file_name": "$apd_file_name"}',
      'file': await MultipartFile.fromFile(file.path,
          filename: uploadFile, contentType: MediaType("application", "pdf")),
    });

    log("message${file.path}");

    try {
      final res = await _dio.post(
        ApiRoutes.postUploadApdPlan,
        options: Options(
          headers: {
            "token": accessToken,
            //'Content-Type': "multipart/form-data",
            // 'Content-Length': '<calculated when request is sent>',
            // 'Host': '<calculated when request is sent>',
          },
        ),
        data: formData,
      );

      if (res.statusCode! >= 200 && res.statusCode! < 300) {
        return CommonModel.fromJson(res.data);
      }
    } catch (e) {
      print(e);
      log("error${e.toString()}");

      return null;
    }
    return null;
  }

  static Future<DeleteApdPlanModel?> postDeleteApdPlan(
      {required String id}) async {
    Map<String, dynamic> body = {
      'file_id': id,
    };
    try {
      final res = await _dio.post(
        ApiRoutes.deleteApdPlan,
        options: Options(headers: {
          "token": accessToken,
          "Content-Type": "application/json"
        }),
        data: body,
      );
      if (res.statusCode! >= 200 && res.statusCode! < 300) {
        log("message=${res.data}");
        return DeleteApdPlanModel.fromJson(res.data);
      }
    } catch (e) {
      print(e);
      return null;
    }
    return null;
  }

  static Future<RentalListModel?> postRental(
      {required String projectId}) async {
    Map<String, dynamic> body = {
      'project_id': projectId,
    };
    try {
      final res = await _dio.post(
        ApiRoutes.postRental,
        options: Options(headers: {"token": accessToken}),
        data: body,
      );
      if (res.statusCode! >= 200 && res.statusCode! < 300) {
        log("rentalList${res.data}");
        return RentalListModel.fromJson(res.data);
      }
    } catch (e) {
      print(e);
      return null;
    }
    return null;
  }

  static Future<DeleteRentalModel?> postDeleteRental(String rentalId) async {
    Map<String, dynamic> body = {"rental_id": rentalId};
    try {
      final res = await _dio.post(
        ApiRoutes.postDeleteRental,
        options: Options(headers: {"token": accessToken}),
        data: body,
      );
      if (res.statusCode! >= 200 && res.statusCode! < 300) {
        return DeleteRentalModel.fromJson(res.data);
      }
    } catch (e) {
      print(e);
      return null;
    }
    return null;
  }

  static Future<UpdateRentalModel?> postUpdateRental({
    required String rental_id,
    required String vendor_name,
    required String item_name,
    required String arrival_date,
    required String due_date,
    required String quantity,
    required String description,
    required String api,
    File? file,
  }) async {
    var body;
    if (file == null) {
      body = FormData.fromMap({
        "rental_id": rental_id,
        "vendor_name": vendor_name,
        "item_name": item_name,
        "arrival_date": arrival_date,
        "due_date": due_date,
        "quantity": quantity,
        "description": description,
        'api': api,
      });
    } else {
      String uploadImage = file.path.split('/').last;
      body = FormData.fromMap({
        "rental_id": rental_id,
        "vendor_name": vendor_name,
        "item_name": item_name,
        "arrival_date": arrival_date,
        "due_date": due_date,
        "quantity": quantity,
        "description": description,
        'api': api,
        'file':
            await MultipartFile.fromFile(file.path, filename: '${uploadImage}'),
      });
    }

    try {
      final res = await _dio.post(
        ApiRoutes.postUpdateRental,
        options: Options(headers: {"token": accessToken}),
        data: body,
      );
      log("Data${res.data}");
      log("Data${res.statusCode}");
      if (res.statusCode! >= 200 && res.statusCode! < 300) {
        return UpdateRentalModel.fromJson(res.data);
      }
    } catch (e) {
      print(e);
      return null;
    }
    return null;
  }

  static Future<AddRentalModel?> postAddRental({
    required String project_id,
    required String organization_id,
    required String vendor_name,
    required String item_name,
    required String arrival_date,
    required String due_date,
    required String quantity,
    required String description,
    required String created_by,
    required String Image,
    required String api,
  }) async {
    // Map<String, dynamic> body = {
    //   "project_id": project_id,
    //   "organization_id": organization_id,
    //   "vendor_name": vendor_name,
    //   "item_name": item_name,
    //   "arrival_date": arrival_date,
    //   "due_date": due_date,
    //   "quantity": quantity,
    //   "description": description,
    //   "created_by": created_by,
    // };
    File imageFile = File(Image.toString());
    String uploadImage = Image.split('/').last;
    var body = FormData.fromMap({
      "project_id": project_id,
      "organization_id": organization_id,
      "vendor_name": vendor_name,
      "item_name": item_name,
      "arrival_date": arrival_date,
      "due_date": due_date,
      "quantity": quantity,
      "description": description == null ? "" : description,
      "created_by": created_by,
      'file': Image == ""
          ? ""
          : await MultipartFile.fromFile(imageFile.path,
              filename: '${uploadImage}'),
      'api': api
    });
    try {
      final res = await _dio.post(
        ApiRoutes.postAddRental,
        options: Options(headers: {"token": accessToken}),
        data: body,
      );
      if (res.statusCode! >= 200 && res.statusCode! < 300) {
        return AddRentalModel.fromJson(res.data);
      }
    } catch (e) {
      print(e);
      return null;
    }
    return null;
  }

  static Future<CreateZoneModel?> postCreateUnloadingZone(String projectId,
      String zoneName, String zoneColor, String organizationId) async {
    Map<String, dynamic> body = {
      "project_id": projectId,
      "unloading_zone_name": zoneName,
      "zone_color": zoneColor,
      "organization_id": organizationId
    };
    try {
      final res = await _dio.post(ApiRoutes.createUnloadingZone,
          data: body,
          options: Options(
            headers: {'token': accessToken},
          ));
      if (res.statusCode! >= 200 && res.statusCode! < 300) {
        return CreateZoneModel.fromJson(res.data);
      }
    } catch (e) {
      print(e);
      return null;
    }
    return null;
  }

  static Future<CreateZoneModel?> postUpdateUnloadingZone(
      String projectId,
      String zoneId,
      String zoneName,
      String zoneColor,
      String organizationId) async {
    Map<String, dynamic> body = {
      "project_id": projectId,
      "unloading_zone_id": zoneId,
      "unloading_zone_name": zoneName,
      "zone_color": zoneColor,
      "organization_id": organizationId
    };
    try {
      final res = await _dio.post(ApiRoutes.updateUnloadingZone,
          data: body,
          options: Options(
            headers: {'token': accessToken},
          ));
      if (res.statusCode! >= 200 && res.statusCode! < 300) {
        return CreateZoneModel.fromJson(res.data);
      }
    } catch (e) {
      print(e);
      return null;
    }
    return null;
  }

  static Future<CommonModel?> postUnloadingZoneDetails(
      String zoneId, String organizationId) async {
    Map<String, dynamic> body = {
      "unloading_zone_id": "6369741cf2e71767ec14dce3",
      "organization_id": "5fb845054fdab967c315b6e2"
    };
    try {
      final res = await _dio.post(ApiRoutes.unloadingZoneDetails,
          data: body,
          options: Options(
            headers: {'token': accessToken},
          ));
      if (res.statusCode! >= 200 && res.statusCode! < 300) {
        return CommonModel.fromJson(res.data);
      }
    } catch (e) {
      print(e);
      return null;
    }
    return null;
  }

  static Future<CommonModel?> postDeleteUnloadingZone(String zoneId) async {
    Map<String, dynamic> body = {"zone_id": zoneId, "is_deleted": true};
    try {
      final res = await _dio.post(ApiRoutes.deleteUnloadingZone,
          data: body,
          options: Options(
            headers: {'token': accessToken},
          ));
      if (res.statusCode! >= 200 && res.statusCode! < 300) {
        return CommonModel.fromJson(res.data);
      }
    } catch (e) {
      print(e);
      return null;
    }
    return null;
  }

  static Future<List<TerminalListModel>?> postTerminalList(
      String projectId) async {
    Map<String, dynamic> body = {"project_id": projectId};
    print("projectId=${projectId}");
    try {
      final res = await _dio.post(ApiRoutes.postTerminalList,
          options: Options(headers: {"token": accessToken}), data: body);

      if (res.statusCode! >= 200 && res.statusCode! < 300) {
        log("message${res.data}");
        return (res.data as List)
            .map((x) => TerminalListModel.fromJson(x))
            .toList();
      }
    } catch (e) {
      print(e);
      return null;
    }
    return null;
  }

  static Future<AddLogisticsModel?> postAddLogistic(
      Map<String, dynamic> body) async {
    try {
      final res = await _dio.post(ApiRoutes.postAddLogistics,
          options: Options(headers: {
            "token": accessToken,
            "Content-Type": "application/json"
          }),
          data: body);

      if (res.statusCode! >= 200 && res.statusCode! < 300) {
        return AddLogisticsModel.fromJson(res.data);
      }
    } catch (e) {
      print(e);
      return null;
    }
    return null;
  }

  static Future<LogisticListModel?> postLogistic(
      String projectId, String terminalId) async {
    Map<String, dynamic> body = {
      "project_id": projectId,
      "terminal_id": terminalId,
      "is_active": true
    };
    log("logisticlistBody=${body}");
    try {
      final res = await _dio.post(ApiRoutes.postLogisticList,
          options: Options(headers: {
            "token": accessToken,
            "Content-Type": "application/json"
          }),
          data: body);

      if (res.statusCode! >= 200 && res.statusCode! < 300) {
        log("logisticListData=${res.data}");
        return LogisticListModel.fromJson(res.data);
      }
    } catch (e) {
      print(e);
      return null;
    }
    return null;
  }

  static Future<LogisticDetailsModel?> postLogisticDetails(
      String logisticId) async {
    Map<String, dynamic> body = {"logistic_id": logisticId};
    log("logisticId=${logisticId}");
    try {
      final res = await _dio.post(ApiRoutes.postLogisticDetails,
          options: Options(headers: {"token": accessToken}), data: body);

      if (res.statusCode! >= 200 && res.statusCode! < 300) {
        log("logisticDetails=${res.data}");
        return LogisticDetailsModel.fromJson(res.data);
      }
    } catch (e) {
      print(e);
      return null;
    }
    return null;
  }

  static Future<CreateSupplierModel?> postCreateSupplier(
      String projectId, String supplierName) async {
    Map<String, dynamic> body = {
      "project_id": projectId,
      "shipment_supplier_name": supplierName
    };

    try {
      final res = await _dio.post(ApiRoutes.postCreateShipmentSupplier,
          options: Options(headers: {"token": accessToken}), data: body);

      if (res.statusCode! >= 200 && res.statusCode! < 300) {
        if (res.data["error"] == "shipment_supplier_exsists") {
          snackBar("Shipment Supplier Already Exist", false);
        }
        return CreateSupplierModel.fromJson(res.data);
      }
    } catch (e) {
      print(e);
      return null;
    }
    return null;
  }

  static Future<SupplierListModel?> postSupplierList(String projectId) async {
    Map<String, dynamic> body = {
      "project_id": projectId,
    };

    try {
      final res = await _dio.post(ApiRoutes.postShipmentSupplierList,
          options: Options(headers: {"token": accessToken}), data: body);

      if (res.statusCode! >= 200 && res.statusCode! < 300) {
        return SupplierListModel.fromJson(res.data);
      }
    } catch (e) {
      print(e);
      return null;
    }
    return null;
  }

  static Future<List<MonthlyShipmentsModel>?> postMonthlyShipments(
      String organizationId, String status) async {
    Map<String, dynamic> body = {
      "organization_id": organizationId,
      "status": status
    };
    log("body${body}");
    //  try {
    final res = await _dio.post(ApiRoutes.postMonthlyShipment,
        options: Options(headers: {"token": accessToken}), data: body);

    if (res.statusCode! >= 200 && res.statusCode! < 300) {
      log("res.data${res.data}");
      return (res.data as List)
          .map((x) => MonthlyShipmentsModel.fromJson(x))
          .toList();
      //res.data.map<MonthlyShipmentsModel>((x) => MonthlyShipmentsModel.fromJson(x)).toList();
    }
    // } catch (e) {
    //   print(e);
    //   return null;
    // }
    return null;
  }

  static Future<PendingShipmentListModel?> postPendingShipmentList(
      String organizationId, List projectIdList, String oldOrgId) async {
    log("organizationId${organizationId}");
    log("projectIdList${projectIdList}");

    Map<String, dynamic> body = {
      "mandatory_filter": {
        "organization_id": organizationId,
        "status": "pending",
        "is_hidden": false,
        "project_id": [
          "5fb8455c4fdab96467773503",
          "6251b4a74fdab90e47522505",
          "5fc782834fdab9688e76c7c2",
          "62d8553f4fdab92b110efa32"
        ]
      },
      "datatable_requests": {
        "draw": "1",
        "columns": [
          {
            "data": "0",
            "name": "id",
            "searchable": "false",
            "orderable": "false",
            "search": {"value": null, "regex": "false"}
          },
          {
            "data": "1",
            "name": "project.project_name",
            "searchable": "true",
            "orderable": "true",
            "search": {"value": null, "regex": "false"}
          },
          {
            "data": "2",
            "name": "user.first_name",
            "searchable": "true",
            "orderable": "true",
            "search": {"value": null, "regex": "false"}
          },
          {
            "data": "3",
            "name": "user.last_name",
            "searchable": "true",
            "orderable": "false",
            "search": {"value": null, "regex": "false"}
          },
          {
            "data": "4",
            "name": "request_from_date_time",
            "searchable": "true",
            "orderable": "true",
            "search": {"value": null, "regex": "false"}
          },
          {
            "data": "5",
            "name": "request_to_date_time",
            "searchable": "true",
            "orderable": "false",
            "search": {"value": null, "regex": "false"}
          },
          {
            "data": "6",
            "name": "zone.unloading_zone_name",
            "searchable": "true",
            "orderable": "true",
            "search": {"value": null, "regex": "false"}
          },
          {
            "data": "7",
            "name": "request_type",
            "searchable": "true",
            "orderable": "true",
            "search": {"value": null, "regex": "false"}
          },
          {
            "data": "8",
            "name": "action",
            "searchable": "false",
            "orderable": "false",
            "search": {"value": null, "regex": "false"}
          }
        ],
        "order": [
          {"column": "5", "dir": "desc"}
        ],
        "start": "0",
        "length": "20",
        "search": {"value": null, "regex": "false"},
        "_": "1672940988527"
      }
    };

    Map<String, dynamic> body2 = {
      "mandatory_filter": {
        "organization_id": organizationId,
        "status": "pending",
        "is_hidden": false,
        //"project_id": projectIdList2,
        "project_id": [],
      },
      "datatable_requests": {
        "draw": "1",
        "columns": [
          {
            "data": "0",
            "name": "id",
            "searchable": "false",
            "orderable": "false",
            "search": {"value": null, "regex": "false"}
          },
          {
            "data": "1",
            "name": "project.project_name",
            "searchable": "true",
            "orderable": "true",
            "search": {"value": null, "regex": "false"}
          },
          {
            "data": "2",
            "name": "user.first_name",
            "searchable": "true",
            "orderable": "true",
            "search": {"value": null, "regex": "false"}
          },
          {
            "data": "3",
            "name": "user.last_name",
            "searchable": "true",
            "orderable": "false",
            "search": {"value": null, "regex": "false"}
          },
          {
            "data": "4",
            "name": "request_from_date_time",
            "searchable": "true",
            "orderable": "true",
            "search": {"value": null, "regex": "false"}
          },
          {
            "data": "5",
            "name": "request_to_date_time",
            "searchable": "true",
            "orderable": "false",
            "search": {"value": null, "regex": "false"}
          },
          {
            "data": "6",
            "name": "zone.unloading_zone_name",
            "searchable": "true",
            "orderable": "true",
            "search": {"value": null, "regex": "false"}
          },
          {
            "data": "7",
            "name": "request_type",
            "searchable": "true",
            "orderable": "true",
            "search": {"value": null, "regex": "false"}
          },
          {
            "data": "8",
            "name": "action",
            "searchable": "false",
            "orderable": "false",
            "search": {"value": null, "regex": "false"}
          }
        ],
        "order": [
          {"column": "5", "dir": "desc"}
        ],
        "start": "0",
        "length": "20",
        "search": {"value": null, "regex": "false"},
        "_": "1672940988527"
      }
    };

    try {
      final res = await _dio.post(ApiRoutes.postPendingShipmentList,
          options: Options(headers: {
            "token": accessToken,
            'Content-Type': 'application/json'
          }),
          data: body2);

      if (res.statusCode! >= 200 && res.statusCode! < 300) {
        log("PendingShipmentList${res.data}");
        return PendingShipmentListModel.fromJson(res.data);
      }
    } catch (e) {
      print(e);
      return null;
    }
    return null;

    /*var headers = {
      'token': accessToken,
    };
    var request = http.Request('POST', Uri.parse('https://dev.projsite.com/delivery_management_api/public/api/get_requests_for_mobile'));
    request.body = jsonEncode(body);
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      var data = await response.stream.bytesToString();
      var dataData = jsonDecode(data);
      return PendingShipmentListModel.fromJson(dataData);
    }
    else {
      print(response.reasonPhrase);
    }*/
  }

  static Future<LogisticRequestDataModel?> postLogisticRequestData(
      String requestId) async {
    Map<String, dynamic> body = {
      "request_id": requestId,
    };

    try {
      final res = await _dio.post(ApiRoutes.postLogisticRequestData,
          options: Options(headers: {"token": accessToken}), data: body);

      if (res.statusCode! >= 200 && res.statusCode! < 300) {
        return LogisticRequestDataModel.fromJson(res.data);
      }
    } catch (e) {
      print(e);
      return null;
    }
    return null;
  }

  static Future<NotTransportedCheckoutsModel?> postNotTransportCheckouts(
      String projectId,
      String terminalId,
      String startDate,
      String fromDate,
      String itemName) async {
    Map<String, dynamic> body = {
      "project_id": projectId,
      "terminal_id": terminalId,
      "start_date": startDate,
      "end_date": fromDate,
      "search": itemName
    };
    log("Not transported checkout body${body}");
    try {
      final res = await _dio.post(ApiRoutes.postNotTransportCheckouts,
          options: Options(headers: {"token": accessToken}), data: body);

      if (res.statusCode! >= 200 && res.statusCode! < 300) {
        log("Not transported checkout${res.data}");
        return NotTransportedCheckoutsModel.fromJson(res.data);
      }
    } catch (e) {
      print(e);
      return null;
    }
    return null;
  }

  static Future<AddShipmentModel?> postAddTransportRequest(Map finalMap) async {
    Map<dynamic, dynamic> body = finalMap;
    log("rrr${body}");
    try {
      final res = await _dio.post(
        ApiRoutes.postAddTransportRequest,
        options: Options(headers: {
          "token": accessToken,
          'Content-Type': 'application/json'
        }),
        data: body,
      );

      if (res.statusCode == 200) {
        final data =
            Map<String, dynamic>.from(res.data) as Map<String, dynamic>;
        return AddShipmentModel.fromJson(data);
      }
    } catch (e) {
      print(e);
      return null;
    }
    return null;
  }

  static Future<GetTransportRequestModel?> postGetTransportRequest(
      String requestId, String projectId) async {
    Map<dynamic, dynamic> body = {
      "request_id": requestId,
      "project_id": projectId
    };

    try {
      final res = await _dio.post(
        ApiRoutes.postGetTransportRequest,
        options: Options(headers: {
          "token": accessToken,
          'Content-Type': 'application/json'
        }),
        data: body,
      );
      log("GetTransportRequest=${res.data}");
      if (res.statusCode! >= 200 && res.statusCode! < 300) {
        // final data = Map<String, dynamic>.from(res.data) as Map<String, dynamic>;
        return GetTransportRequestModel.fromJson(res.data);
      }
    } catch (e) {
      print(e);
      return null;
    }
    return null;
  }

  static Future<CommonModel?> postUpdateTransportRequest(Map finalMap) async {
    Map<dynamic, dynamic> body = finalMap;
    log("rrr${body}");
    try {
      final res = await _dio.post(
        ApiRoutes.postUpdateTransportRequest,
        options: Options(headers: {
          "token": accessToken,
          'Content-Type': 'application/json'
        }),
        data: body,
      );
      if (res.statusCode == 200) {
        return CommonModel.fromJson(res.data);
      }
    } catch (e) {
      print(e);
      return null;
    }
    return null;
  }

  static Future<CommonModel?> postUpdateTransportRequestStatus(
      String requestId, String transportStatus) async {
    Map<String, dynamic> body = {
      "request_id": requestId,
      "status": transportStatus,
    };
    try {
      final res = await _dio.post(
        ApiRoutes.postUpdateTransportRequestStatus,
        options: Options(headers: {"token": accessToken}),
        data: body,
      );
      if (res.statusCode! >= 200 && res.statusCode! < 300) {
        return CommonModel.fromJson(res.data);
      }
    } catch (e) {
      print(e);
      return null;
    }
    return null;
  }

  static Future<CommonModel?> postCloseTransportRequest(
      String requestId) async {
    /* Map<String, dynamic> body = {
      "request_id":requestId,
      "is_hidden":true,
    };
    try {
      final res = await _dio.post(
        ApiRoutes.postCloseTransportRequest,
        options: Options(headers: {"token": accessToken}),
        data: body,
      );
      if (res.statusCode! >= 200 && res.statusCode! < 300) {
        return CommonModel.fromJson(res.data);
      }
    } catch (e) {
      print(e);
      return null;
    }
    return null;*/

    var headers = {
      'token': accessToken,
      'Authorization': 'Bearer $accessToken',
      'Content-Type': 'application/json'
    };
    var request = http.Request(
        'POST',
        Uri.parse(
            'https://dev.projsite.com/delivery_management_api/public/api/close_checkout_request'));
    request.body = json.encode({
      "request_id": requestId,
      "is_hidden": true,
      "close_all_recurring": true
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var data = await response.stream.bytesToString();
      var dataData = jsonDecode(data);
      return CommonModel.fromJson(dataData);
    } else {}
  }

  static Future<OrganizationsModel?> postOrganizations(
      {required String organization_id}) async {
    Map<String, dynamic> body = {"organization_id": orgId};

    try {
      final res = await _dio.post(ApiRoutes.postOrganizations,
          options: Options(headers: {"token": accessToken}), data: body);

      if (res.statusCode! >= 200 && res.statusCode! < 300) {
        return OrganizationsModel.fromJson(res.data);
      }
    } catch (e) {
      print(e);
      return null;
    }
    return null;
  }

  static Future<UserSubProjectListModel?> postUserSubProjectList(
      {required String user_id,
      required String project_id,
      required String organization_id}) async {
    Map<String, dynamic> body = {
      "user_id": user_id,
      "project_id": project_id,
      "organization_id": orgId
    };
    try {
      final res = await _dio.post(ApiRoutes.postUserSubProjectList,
          options: Options(headers: {"token": accessToken}), data: body);

      if (res.statusCode! >= 200 && res.statusCode! < 300) {
        return UserSubProjectListModel.fromJson(res.data);
      }
    } catch (e) {
      print(e);
      return null;
    }
    return null;
  }

  static Future<DeleteLogisticModel?> postDeleteLogistic(
      String logisticId) async {
    Map<String, dynamic> body = {"logistic_id": logisticId, "is_hidden": true};
    try {
      final res = await _dio.post(
        ApiRoutes.postDeleteLogistic,
        options: Options(headers: {
          "token": accessToken,
          'Content-Type': 'application/json'
        }),
        data: body,
      );
      if (res.statusCode! >= 200 && res.statusCode! < 300) {
        return DeleteLogisticModel.fromJson(res.data);
      }
    } catch (e) {
      print(e);
      return null;
    }
    return null;
  }

  static Future<EditLogisticModel?> postEditLogistic(
      Map<String, dynamic> body) async {
    try {
      final res = await _dio.post(
        ApiRoutes.postEditLogistic,
        options: Options(headers: {"token": accessToken}),
        data: body,
      );
      if (res.statusCode! >= 200 && res.statusCode! < 300) {
        return EditLogisticModel.fromJson(res.data);
      }
    } catch (e) {
      print(e);
      return null;
    }
    return null;
  }

  static Future<CheckoutLogisticModel?> postCheckoutLogistic(
      Map<String, dynamic> body) async {
    try {
      final res = await _dio.post(
        ApiRoutes.postCheckoutLogistic,
        options: Options(headers: {"token": accessToken}),
        data: body,
      );
      log("body${body}");

      if (res.statusCode! >= 200 && res.statusCode! < 300) {
        log("check_out${res.data}");
        return CheckoutLogisticModel.fromJson(res.data);
      }
    } catch (e) {
      print(e);
      return null;
    }
    return null;
  }

  static Future<NotificationModel?> postNotification() async {
    Map<String, dynamic> body = {
      "organization_id": "5ffeb87c4fdab911f579a042",
      "id": "5bd35238e549570b1f1a3274"
    };
    try {
      final res = await _dio.post(
        ApiRoutes.postNotification,
        options: Options(headers: {"token": accessToken}),
        data: body,
      );
      if (res.statusCode! >= 200 && res.statusCode! < 300) {
        return NotificationModel.fromJson(jsonDecode(res.data));
      }
    } catch (e) {
      print(e);
      return null;
    }
    return null;
  }

  static Future<EditNotificationModel?> postEditNotification(
      {required String email_notify, required String sms_notify}) async {
    Map<String, dynamic> body = {
      "organization_id": "5ffeb87c4fdab911f579a042",
      "id": "5bd35238e549570b1f1a3274",
      "email_notify": email_notify,
      "sms_notify": sms_notify
    };
    try {
      final res = await _dio.post(
        ApiRoutes.postEditNotification,
        options: Options(headers: {"token": accessToken}),
        data: body,
      );
      if (res.statusCode! >= 200 && res.statusCode! < 300) {
        return EditNotificationModel.fromJson(jsonDecode(res.data));
      }
    } catch (e) {
      print(e);
      return null;
    }
    return null;
  }

  static Future<AddShipmentModel?> postAddShipment(Map finalMap) async {
    Map<dynamic, dynamic> body = finalMap;
    log("rrr${body}");
    try {
      final res = await _dio.post(
        ApiRoutes.postAddShipmentRequest,
        options: Options(headers: {
          "token": accessToken,
          'Content-Type': 'application/json'
        }),
        data: body,
      );

      if (res.statusCode == 200) {
        final data =
            Map<String, dynamic>.from(res.data) as Map<String, dynamic>;
        return AddShipmentModel.fromJson(data);
      }
    } catch (e) {
      print(e);
      return null;
    }
    return null;
  }

  static Future<UpdateShipmentModel?> postUpdateShipment(Map finalMap) async {
    Map<dynamic, dynamic> body = finalMap;
    // Map<String, dynamic> body = {
    //   "_id": "63145434b86d8c614627caf2",
    //   "project_id": "6040da014fdab967583a7eb2",
    //   "request_from_date_time": "2022-11-30 08:00:00",
    //   "request_to_date_time": "2022-11-30 08:30:00",
    //   "resource_array": [
    //     "6227213b4fdab951bc129372"
    //   ],
    //   "unloading_zone_id": "6225f4a24fdab92fc5160c75",
    //   "contractor_id": "5ffed61b4fdab9123a5f0b82",
    //   "responsible_person_id": "5c137a684fdab94eb87bd924",
    //   "sub_project_id": "",
    //   "description": "siam",
    //   "instruction": "",
    //   "image_name": "",
    //   "image": null,
    //   "is_recurring": "false",
    //   "recurring_id": null,
    //   "recurring_days": "",
    //   "recurring_to_date": "",
    //   "created_by": "5bd35238e549570b1f1a3274",
    //   "status": "pending",
    //   "request_type": "general",
    //   "organization_id": "5ffeb87c4fdab911f579a042",
    //   "is_hidden": false,
    //   "delivery_supplier": "607419664fdab9030b499e42",
    //   "load_weight": 0.11,
    //   "driving_distance": 4.83,
    //   "is_return": false,
    //   "addresses": [
    //     {
    //       "id" : "add_general_request_environment_section_ac1",
    //       "place" : "Villagatan 13, 114 32 Stockholm, Sweden",
    //       "lat" : "59.3432098",
    //       "lng" : "18.0735131",
    //       "airport" : false,
    //       "type_of_vehicle" : "606c20054fdab95295322203",
    //       "euro_class" : "606c1f7f4fdab9514a7dad42",
    //       "type_of_fuel" : "610fb72e4fdab91d4171f793",
    //       "vehicle_capacity" : 40,
    //       "part_distance" : 4.828
    //     },
    //     {
    //       "id" : "add_general_request_environment_section_ac2",
    //       "place" : "Frösundaleden 4, 169 70 Solna, Sverige",
    //       "lat" : "59.3645547",
    //       "lng" : "18.0193712"
    //     }
    //   ],
    //   "kollis": [
    //     {
    //       "id": "eu_pall",
    //       "value": false,
    //       "amount": ""
    //     },
    //     {
    //       "id": "sjo_pall",
    //       "value": false,
    //       "amount": ""
    //     },
    //     {
    //       "id": "langgods",
    //       "value": false,
    //       "amount": ""
    //     },
    //     {
    //       "id": "bunts",
    //       "value": false,
    //       "amount": ""
    //     },
    //     {
    //       "id": "paket",
    //       "value": false,
    //       "amount": ""
    //     },
    //     {
    //       "id": "stycke_gods",
    //       "value": false,
    //       "amount": ""
    //     }
    //   ],
    //   "unbooked": "",
    //   "is_hidden_environment": false,
    //   "transport_status": "unloaded",
    //   "arrived_at":"2022-11-30T10:58",
    //   "in_progress_at":"2022-11-30T10:58",
    //   "unloaded_at": "2022-11-30T10:59",
    //   "api": true
    // };
    log(jsonEncode(body));
    try {
      final res = await _dio.post(
        ApiRoutes.postUpdateShipmentRequest,
        options: Options(headers: {
          "token": accessToken,
          'Content-Type': 'application/json'
        }),
        data: body,
      );
      if (res.statusCode! >= 200 && res.statusCode! < 300) {
        // log(res.data);

        return UpdateShipmentModel.fromJson(res.data);
      }
    } catch (e) {
      print(e);
      return null;
    }

    /*var headers = {
      'token': accessToken,
      'Authorization': 'Bearer $accessToken',
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse('https://dev.projsite.com/delivery_management_api/public/api/update_request'));
    request.body = json.encode(body);
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var data = await response.stream.bytesToString();
      var dataData = jsonDecode(data);
      return UpdateShipmentModel.fromJson(dataData);
    }
    else {
      print(response.reasonPhrase);
    }*/

    return null;
  }

  static Future<CommonModel?> postCloseShipment(String requestId) async {
    /* Map<String, dynamic> body = {
      "request_id":requestId,
      "is_hidden":true,
      "close_all_recurring":true,
    };
    try {
      final res = await _dio.post(
        ApiRoutes.postCloseShipmentRequest,
        options: Options(headers: {"token": accessToken}),
        data: body,
      );
      if (res.statusCode! >= 200 && res.statusCode! < 300) {
        return CommonModel.fromJson(res.data);
      }
    } catch (e) {
      print(e);
      return null;
    }
    return null;*/

    var headers = {
      'token': accessToken,
      'Authorization': 'Bearer $accessToken',
      'Content-Type': 'application/json'
    };
    var request = http.Request(
        'POST',
        Uri.parse(
            'https://dev.projsite.com/delivery_management_api/public/api/close_request'));
    request.body = json.encode({
      "request_id": requestId,
      "is_hidden": true,
      "close_all_recurring": true
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var data = await response.stream.bytesToString();
      var dataData = jsonDecode(data);
      return CommonModel.fromJson(dataData);
    } else {}
  }

  static Future<AddTerminalModel?> postAddTerminal(Map finalMap) async {
    Map<dynamic, dynamic> body = finalMap;
    try {
      final res = await _dio.post(
        ApiRoutes.postAddTerminal,
        options: Options(headers: {
          "token": accessToken,
          'Content-Type': 'application/json'
        }),
        data: finalMap,
      );

      if (res.statusCode! >= 200 && res.statusCode! < 300) {
        return AddTerminalModel.fromJson(res.data);
      }
    } catch (e) {
      print(e);
      log("error$e");
      return null;
    }
    return null;
  }

  static Future<UpdateTerminalModel?> postUpdateTerminal(Map finalMap) async {
    Map<dynamic, dynamic> body = finalMap;
    try {
      final res = await _dio.post(
        ApiRoutes.postUpdateTerminal,
        options: Options(headers: {
          "token": accessToken,
          'Content-Type': 'application/json'
        }),
        data: body,
      );
      if (res.statusCode! >= 200 && res.statusCode! < 300) {
        return UpdateTerminalModel.fromJson(res.data);
      }
    } catch (e) {
      print(e);
      return null;
    }
    return null;

    /*var headers = {
      'token': accessToken,
      'Authorization': 'Bearer $accessToken',
      'Content-Type': 'application/json',
      'Cookie': 'XSRF-TOKEN=$accessToken',
    };
    var request = http.Request('POST', Uri.parse('https://dev.projsite.com/delivery_management_api/public/api/update_terminal_request'));
    request.body = json.encode(finalMap);
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {

      var data = await response.stream.bytesToString();
      var dataData = jsonDecode(data);
      return UpdateTerminalModel.fromJson(dataData);
    }
    else {
      print(response.reasonPhrase);
    }
*/
  }

  static Future<CommonModel?> postCloseTerminal(String requestId) async {
    /*Map<String, dynamic> body = {
      "request_id":requestId,
      "is_hidden":true,
      "delete_logistics":true
    };
    try {
      final res = await _dio.post(
        ApiRoutes.postCloseTerminal,
        options: Options(headers: {"token": accessToken}),
        data: body,
      );
      if (res.statusCode! >= 200 && res.statusCode! < 300) {
        return CommonModel.fromJson(res.data);
      }
    } catch (e) {
      print(e);
      return null;
    }
    return null;*/

    var headers = {
      'token': accessToken,
      'Authorization': 'Bearer $accessToken',
      'Content-Type': 'application/json'
    };
    var request = http.Request(
        'POST',
        Uri.parse(
            'https://dev.projsite.com/delivery_management_api/public/api/close_terminal_request'));
    request.body = json.encode(
        {"request_id": requestId, "is_hidden": true, "delete_logistics": true});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var data = await response.stream.bytesToString();
      var dataData = jsonDecode(data);
      return CommonModel.fromJson(dataData);
    } else {}
  }

  static Future<CommonModel?> postUpdateApprovalStatus(
      String status, String requestId) async {
    Map<String, dynamic> body = {
      "status": status,
      "request_id": requestId,
      "update_all_recurring": true,
      "recurring_id": ""
    };
    try {
      final res = await _dio.post(
        ApiRoutes.postUpdateApprovalStatus,
        options: Options(headers: {
          "token": accessToken,
          'Content-Type': 'application/json'
        }),
        data: body,
      );
      if (res.statusCode! >= 200 && res.statusCode! < 300) {
        return CommonModel.fromJson(res.data);
      }
    } catch (e) {
      print(e);
      return null;
    }
    return null;
  }

  static Future<CommonModel?> postUpdateTransportStatus(
      String requestId, String transportStatus) async {
    Map<String, dynamic> body = {
      "id": requestId,
      "transport_status": transportStatus,
      // "checkpoint" : true,
      // "arrived_at" : false,
      // "in_progress_at" : "2022-12-01T00:00",
      // "unloaded_at" : false
    };
    try {
      final res = await _dio.post(
        ApiRoutes.postUpdateTransportStatus,
        options: Options(headers: {"token": accessToken}),
        data: body,
      );
      if (res.statusCode! >= 200 && res.statusCode! < 300) {
        return CommonModel.fromJson(res.data);
      }
    } catch (e) {
      print(e);
      return null;
    }
    return null;
  }

  static Future<CommonModel?> postUpdateTerminalStatus(
      String requestId, String transportStatus) async {
    Map<String, dynamic> body = {
      "request_id": requestId,
      "status": transportStatus,
      // "checkpoint" : true,
      // "arrived_at" : false,
      // "in_progress_at" : "2022-12-01T00:00",
      // "unloaded_at" : false
    };
    try {
      final res = await _dio.post(
        ApiRoutes.postUpdateTerminalStatus,
        options: Options(headers: {"token": accessToken}),
        data: body,
      );
      if (res.statusCode! >= 200 && res.statusCode! < 300) {
        return CommonModel.fromJson(res.data);
      }
    } catch (e) {
      print(e);
      return null;
    }
    return null;
  }

  static Future<GetBookingFormModel?> postBookingFormNotification(
      String projectId) async {
    Map<String, dynamic> body = {"project_id": projectId};
    try {
      final res = await _dio.post(
        ApiRoutes.postBookingFormNotification,
        options: Options(headers: {"token": accessToken}),
        data: body,
      );
      if (res.statusCode! >= 200 && res.statusCode! < 300) {
        return GetBookingFormModel.fromJson(res.data);
      }
    } catch (e) {
      print(e);
      return null;
    }
    return null;
  }

  static Future<SaveBookingFormModel?> postSaveBookingFormNotification(
      {required String type,
      required String id,
      List<dynamic>? shipment,
      List<dynamic>? environment}) async {
    /*  try {
      final res = await _dio.post(
        ApiRoutes.postSaveBookingFormNotification,
        options: Options(headers: {"token": accessToken}),
        data: bodyBooking,
      );
      if (res.statusCode! >= 200 && res.statusCode! < 300) {
        return SaveBookingFormModel.fromJson(res.data);
      }
    } catch (e) {
      print(e);
      return null;
    }
    return null;*/

    var headers = {
      'token': accessToken,
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken'
    };
    var request = http.Request(
        'POST',
        Uri.parse(
            'https://dev.projsite.com/delivery_management_api/public/api/update-project-settings'));
    request.body = json.encode({
      "_id": id,
      "project_settings": {
        "resource": shipment![0],
        "zone": shipment[1],
        "contractor": shipment[2],
        "responsible_person": shipment[3],
        "sub_project": shipment[4],
        "euro_class": environment![1],
        "type_of_fuel": environment[2],
        "load_weight": environment[3],
        "vehicle_capacity": environment[4],
        "driving_distance": environment[5],
        "delivery_supplier": environment[0],
        "type_of_vehicle": environment[7],
      }
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var data = await response.stream.bytesToString();
      var dataData = jsonDecode(data);
      return SaveBookingFormModel.fromJson(dataData);
    } else {
      print(response.reasonPhrase);
    }
  }

  static Future<SaveBookingFormModel?> postSaveCalender(
      {required String type,
      required String id,
      bool? zone,
      bool? auto,
      bool? waste}) async {
    /*   try {
      final res = await _dio.post(ApiRoutes.postSaveBookingFormNotification,
          options: Options(headers: {"token": accessToken}),
          data: bodyCalender);
      if (res.statusCode! >= 200 && res.statusCode! < 300) {
        return SaveBookingFormModel.fromJson(res.data);
      }
    } catch (e) {
      print(e);
      return null;
    }
    return null;*/
    var headers = {
      'token': accessToken,
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken'
    };
    var request = http.Request(
        'POST',
        Uri.parse(
            'https://dev.projsite.com/delivery_management_api/public/api/update-project-settings'));
    request.body = json.encode({
      "_id": id,
      "project_settings": {
        "auto_approval": auto,
        "waste_disposal": waste,
        "zone": zone
      }
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var data = await response.stream.bytesToString();
      var dataData = jsonDecode(data);
      return SaveBookingFormModel.fromJson(dataData);
    } else {
      print(response.reasonPhrase);
    }
  }

  static Future<SaveBookingFormModel?> postSaveNotification(
      {required String type, required String id, bool? mail, bool? sms}) async {
    /*   try {
      final res = await _dio.post(
        ApiRoutes.postSaveBookingFormNotification,
        options: Options(headers: {"token": accessToken}),
        data: jsonEncode(bodyNotification),
      );
      if (res.statusCode! >= 200 && res.statusCode! < 300) {
        return SaveBookingFormModel.fromJson(res.data);
      }
    } catch (e) {
      print(e);
      return null;
    }
    return null;*/

    var headers = {
      'token': accessToken,
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken'
    };
    var request = http.Request(
        'POST',
        Uri.parse(
            'https://dev.projsite.com/delivery_management_api/public/api/update-mail-sms-settings'));
    request.body = json.encode({
      "_id": id,
      "mail_sms_settings": {"mail": mail, "sms": sms}
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var data = await response.stream.bytesToString();
      var dataData = jsonDecode(data);
      return SaveBookingFormModel.fromJson(dataData);
    } else {
      print(response.reasonPhrase);
    }
  }

  static Future<ProjectListModel?> postProjectList(
      String projectId, Map userInfo) async {
    Map<String, dynamic> body = {
      "user_info": userInfo,
      "get_extra_info": true,
      "get_extra_projects": true,
      "type": "mobile",
    };

    /*try {
      final res = await _dio.post(
       ApiRoutes.postProjectList,
        options: Options(
            headers: {"token":accessToken,'Content-Type': 'application/json'},
        ),
        data: body,
      );

      if (res.statusCode! >= 200 && res.statusCode! < 300) {
        log("projectList${res.data}");
        return ProjectListModel.fromJson(res.data);
      }
    } catch (e) {
      print(e);
      return null;
    }
    return null;*/

    var headers = {
      'token': accessToken,
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${accessToken}'
    };
    var request = http.Request(
        'POST',
        Uri.parse(
            'https://dev.projsite.com/delivery_management_api/public/api/get_users_projects_list'));
    request.body = json.encode({
      "user_info": userInfo,
      "get_extra_info": true,
      "get_extra_projects": true,
      "type": "mobile"
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var data = await response.stream.bytesToString();
      var dataData = jsonDecode(data);
      return ProjectListModel.fromJson(dataData);
    } else {
      print(response.reasonPhrase);
    }
  }

  static Future<ProjectDetailsModel?> postProjectDetails(
      String projectId) async {
    Map<String, dynamic> body = {
      "id": projectId,
    };
//    try {
    final res = await _dio.post(
      ApiRoutes.postProjectDetails,
      options: Options(
        headers: {"token": accessToken, 'Content-Type': 'application/json'},
      ),
      data: body,
    );

    if (res.statusCode! >= 200 && res.statusCode! < 300) {
      log("ProjectDetailsModel=${res.data}");
      return ProjectDetailsModel.fromJson(res.data);
    }
    // } catch (e) {
    //   print(e);
    //   return null;
    // }
    return null;
  }

  ///------------------

  static Future<SubProjectListModel?> postSubProjectList(
      String projectId, String orgId) async {
    Map<String, dynamic> body = {
      "organization_id": orgId,
      "project_id": projectId,
    };

    try {
      final res = await _dio.post(
        ApiRoutes.subProjectList,
        options: Options(headers: {"token": accessToken}),
        data: body,
      );
      if (res.statusCode! >= 200 && res.statusCode! < 300) {
        return SubProjectListModel.fromJson(res.data);
      }
    } catch (e) {
      print(e);
      return null;
    }
    return null;
  }

  static Future<SubProjectUserListModel?> postSubProjectUserList(
      String subProjectId, String orgId) async {
    Map<String, dynamic> body = {
      "organization_id": orgId,
      "sub_project_id": subProjectId,
    };

    /*try {
      final res = await _dio.post(
       ApiRoutes.postProjectList,
        options: Options(
            headers: {"token":accessToken,'Content-Type': 'application/json'},
        ),
        data: body,
      );

      if (res.statusCode! >= 200 && res.statusCode! < 300) {
        log("projectList${res.data}");
        return ProjectListModel.fromJson(res.data);
      }
    } catch (e) {
      print(e);
      return null;
    }
    return null;*/

    try {
      final res = await _dio.post(
        ApiRoutes.subProjectUserList,
        options: Options(headers: {"token": accessToken}),
        data: body,
      );
      if (res.statusCode! >= 200 && res.statusCode! < 300) {
        return SubProjectUserListModel.fromJson(res.data);
      }
    } catch (e) {
      print(e);
      return null;
    }
    return null;
  }

  static Future<RemoveUserModel?> postRemoveUser(
      {required String orgId,
      required String subProjectId,
      required String userId}) async {
    Map<String, dynamic> body = {
      "organization_id": orgId,
      "sub_project_id": subProjectId,
      "user_id": userId
    };
    try {
      final res = await _dio.post(
        ApiRoutes.removeUser,
        options: Options(headers: {
          "token": accessToken,
          "Content-Type": "application/json"
        }),
        data: body,
      );
      if (res.statusCode! >= 200 && res.statusCode! < 300) {
        log("message=${res.data}");
        return RemoveUserModel.fromJson(res.data);
      }
    } catch (e) {
      print(e);
      return null;
    }
    return null;
  }

  static Future<UserListDropDownModel?> postUserListDropDown(
      String projectId) async {
    Map<String, dynamic> body = {
      "data": {"project_id": projectId}
    };

    /*try {
      final res = await _dio.post(
       ApiRoutes.postProjectList,
        options: Options(
            headers: {"token":accessToken,'Content-Type': 'application/json'},
        ),
        data: body,
      );

      if (res.statusCode! >= 200 && res.statusCode! < 300) {
        log("projectList${res.data}");
        return ProjectListModel.fromJson(res.data);
      }
    } catch (e) {
      print(e);
      return null;
    }
    return null;*/

    try {
      final res = await _dio.post(
        ApiRoutes.userListDropDown,
        options: Options(headers: {"token": accessToken}),
        data: body,
      );
      if (res.statusCode! >= 200 && res.statusCode! < 300) {
        return userListDropDownModelFromJson(res.data);
      }
    } catch (e) {
      print(e);
      return null;
    }
    return null;
  }

  static Future<AssignUserModel?> postAssignUser(
      {required String orgId,
      required String subProjectId,
      required String userId}) async {
    Map<String, dynamic> body = {
      "organization_id": orgId,
      "sub_project_id": subProjectId,
      "user_id": userId
    };
    try {
      final res = await _dio.post(
        ApiRoutes.assignUser,
        options: Options(headers: {
          "token": accessToken,
          "Content-Type": "application/json"
        }),
        data: body,
      );
      if (res.statusCode! >= 200 && res.statusCode! < 300) {
        log("message=${res.data}");
        return AssignUserModel.fromJson(res.data);
      }
    } catch (e) {
      print(e);
      return null;
    }
    return null;
  }

  static Future<AddNewSubProjectModel?> postAddSubProject(
      {required String orgId,
      required String projectId,
      required String name}) async {
    Map<String, dynamic> body = {
      "organization_id": orgId,
      "project_id": projectId,
      "sub_project_name": name
    };
    try {
      final res = await _dio.post(
        ApiRoutes.createSubProject,
        options: Options(headers: {
          "token": accessToken,
          "Content-Type": "application/json"
        }),
        data: body,
      );
      if (res.statusCode! >= 200 && res.statusCode! < 300) {
        log("message=${res.data}");
        return AddNewSubProjectModel.fromJson(res.data);
      }
    } catch (e) {
      print(e);
      return null;
    }
    return null;
  }

  static Future<UpdateSubProjectModel?> postUpdateSubProject(
      {required String orgId,
      required String subProjectId,
      required String projectId,
      required String name}) async {
    Map<String, dynamic> body = {
      "organization_id": orgId,
      "project_id": projectId,
      "sub_project_id": subProjectId,
      "sub_project_name": name,
    };
    try {
      final res = await _dio.post(
        ApiRoutes.updateSubProject,
        options: Options(headers: {
          "token": accessToken,
          "Content-Type": "application/json"
        }),
        data: body,
      );
      if (res.statusCode! >= 200 && res.statusCode! < 300) {
        log("message=${res.data}");
        return UpdateSubProjectModel.fromJson(res.data);
      }
    } catch (e) {
      print(e);
      return null;
    }
    return null;
  }

  ///-----------------

  /// ----- statistics -----------

  static Future<WasteContainerDropDownModel?> wasteContainerDropDown(
      {required String projectId}) async {
    Map<String, dynamic> body = {"project_id": projectId};

    try {
      final res = await _dio.post(
        ApiRoutes.wasteContainerDropDown,
        options: Options(headers: {
          "token": accessToken,
          "Content-Type": "application/json"
        }),
        data: body,
      );
      if (res.statusCode! >= 200 && res.statusCode! < 300) {
        log("message=${res.data}");
        return WasteContainerDropDownModel.fromJson(res.data);
      }
    } catch (e) {
      print(e);
      return null;
    }
    return null;
  }

  static Future<WasteFractionDropDownModel?> wasteFractionDropDown(
      {required String projectId}) async {
    Map<String, dynamic> body = {"project_id": projectId};

    try {
      final res = await _dio.post(
        ApiRoutes.wasteFractionsDropDown,
        options: Options(headers: {
          "token": accessToken,
          "Content-Type": "application/json"
        }),
        data: body,
      );
      if (res.statusCode! >= 200 && res.statusCode! < 300) {
        log("message=${res.data}");
        return WasteFractionDropDownModel.fromJson(res.data);
      }
    } catch (e) {
      print(e);
      return null;
    }
    return null;
  }

  static Future<AddToWasteListModel?> addToWasteList({
    required String projectId,
    required String wasteContainerId,
    required String wasteFractionId,
    required int numberOfContainers,
    required int amountOfFraction,
    required int amountOfTransports,
  }) async {
    Map<String, dynamic> body = {
      "project_id": projectId,
      "waste_container_id": wasteContainerId,
      "waste_fraction_id": wasteFractionId,
      "number_of_containers": numberOfContainers,
      "amount_of_fraction": amountOfFraction,
      "amount_of_transports": amountOfTransports
    };

    try {
      final res = await _dio.post(
        ApiRoutes.addToWasteList,
        options: Options(headers: {
          "token": accessToken,
          "Content-Type": "application/json"
        }),
        data: body,
      );
      if (res.statusCode! >= 200 && res.statusCode! < 300) {
        log("message=${res.data}");
        return AddToWasteListModel.fromJson(res.data);
      }
    } catch (e) {
      print(e);
      return null;
    }
    return null;
  }

  static Future<StatisticSaveModel?> saveStatistic({
    required String projectId,
    required String wasteListId,
    required List wastData,
    required String date,
    required String subProjectId,

  }) async {
    Map<String, dynamic> body = {
      "project_id": projectId,
      "waste_list_id": wasteListId,
      "waste_list": wastData,
      "date": date,
      "sub_project_id": subProjectId
    };

    try {
      final res = await _dio.post(
        ApiRoutes.saveToWasteList,
        options: Options(headers: {
          "token": accessToken,
          "Content-Type": "application/json"
        }),
        data: body,
      );
      if (res.statusCode! >= 200 && res.statusCode! < 300) {
        log("message=${res.data}");
        return StatisticSaveModel.fromJson(res.data);
      }
    } catch (e) {
      print(e);
      return null;
    }
    return null;
  }


  static Future<List<EuroclassModel>?> postEuroclass() async {
    try {
      final res = await _dio.post(
        ApiRoutes.postEuroclass,
        options: Options(headers: {
          "token": accessToken,
          'Content-Type': 'application/json'
        }),
        data: {},
      );
      if (res.statusCode! >= 200 && res.statusCode! < 300) {
        final List result = res.data;
        return result.map(((e) => EuroclassModel.fromJson(e))).toList();
      }
    } catch (e) {
      print(e);
      return null;
    }
    return null;
  }

  static Future<List<VehicleModel>?> postVehicle() async {
    try {
      final res = await _dio.post(
        ApiRoutes.postVehicle,
        options: Options(headers: {
          "token": accessToken,
          'Content-Type': 'application/json'
        }),
        data: {},
      );
      if (res.statusCode! >= 200 && res.statusCode! < 300) {
        final List result = res.data;
        return result.map(((e) => VehicleModel.fromJson(e))).toList();
      }
    } catch (e) {
      print(e);
      return null;
    }
    return null;
  }

  static Future<List<FuelModel>?> postFuel() async {
    try {
      final res = await _dio.post(
        ApiRoutes.postFuel,
        options: Options(headers: {"token": accessToken}),
        data: {},
      );
      if (res.statusCode! >= 200 && res.statusCode! < 300) {
        final List result = res.data;
        return result.map(((e) => FuelModel.fromJson(e))).toList();
      }
    } catch (e) {
      print(e);
      return null;
    }
    return null;
  }

  static Future<ResourceListModel?> postResourcesList(
      String projectId, String organizationId) async {
    Map<String, dynamic> body = {
      "organization_id": orgId,
      "project_id": projectId,
      "active_one": true
    };
    try {
      final res = await _dio.post(
        ApiRoutes.postResourcesList,
        options: Options(headers: {"token": accessToken}),
        data: body,
      );
      if (res.statusCode! >= 200 && res.statusCode! < 300) {
        return ResourceListModel.fromJson(res.data);
      }
    } catch (e) {
      print(e);
      return null;
    }
    return null;
  }

  static Future<ZoneListModel?> postZoneList(
      String projectId, String organizationId) async {
    Map<String, dynamic> body = {
      "organization_id": organizationId,
      "project_id": projectId
    };
    try {
      final res = await _dio.post(
        ApiRoutes.postZoneList,
        options: Options(headers: {"token": accessToken}),
        data: body,
      );
      if (res.statusCode! >= 200 && res.statusCode! < 300) {
        return ZoneListModel.fromJson(res.data);
      }
    } catch (e) {
      print(e);
      return null;
    }
    return null;
  }

  static Future<UserListModel?> postUserList(
      String projectId, String organizationId, String companyId) async {
    var headers = {'token': accessToken, 'Content-Type': 'application/json'};
    var request = http.Request(
        'POST',
        Uri.parse(
            'https://dev.projsite.com/delivery_management_api/public/api/get_users'));
    request.body = json.encode({
      "data": {
        "organization_id": organizationId,
        "company_id": companyId,
        "project_id": projectId
      }
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var data = await response.stream.bytesToString();
      var dataData = jsonDecode(data);
      return UserListModel.fromJson(dataData);
    } else {
      print(response.reasonPhrase);
    }

    /*  Map<String, dynamic> body = {
      "organization_id":"5ffeb87c4fdab911f579a042",
      "company_id":"",
      "project_id":"6040da014fdab967583a7eb2"
    };
    try {
      final res = await _dio.post(
        ApiRoutes.postUser,
        options: Options(headers: {"token": accessToken}),
        data: body,
      );

      if (res.statusCode! >= 200 && res.statusCode! < 300) {

        return UserListModel.fromJson(res.data);
      }
    } catch (e) {
      print(e);
      return null;
    }*/
    return null;
  }

  static Future<List?> postFilterStatus(String id) async {
    Map<String, dynamic> body = {"id": id};
    try {
      final res = await _dio.post(
        ApiRoutes.postFilterStatus,
        options: Options(headers: {"token": accessToken}),
        data: body,
      );
      if (res.statusCode! >= 200 && res.statusCode! < 300) {
        return res.data["data"].values.toList();
        // return FilterStatusModel.fromJson(res.data);
      }
    } catch (e) {
      print(e);
      return null;
    }
    return null;
  }

  static Future<List?> postFilterTransportType(String id) async {
    Map<String, dynamic> body = {"id": id};
    try {
      final res = await _dio.post(
        ApiRoutes.postFilterTransportType,
        options: Options(headers: {"token": accessToken}),
        data: body,
      );
      if (res.statusCode! >= 200 && res.statusCode! < 300) {
        return res.data["data"].values.toList();
      }
    } catch (e) {
      print(e);
      return null;
    }
    return null;
  }

  static Future<PackageIInformationModel?> postPackageInformation() async {
    try {
      final res = await _dio.post(
        ApiRoutes.postPackageInfo,
        options: Options(headers: {"token": accessToken}),
      );
      if (res.statusCode! >= 200 && res.statusCode! < 300) {
        return PackageIInformationModel.fromJson(res.data);
      }
    } catch (e) {
      print(e);
      return null;
    }
    return null;
  }

  static Future<EventListModel?> postEventList(
      String projectId,
      String organizationId,
      String mobileOrgId,
      String startDate,
      String endDate,
      bool? isFilter,
      List? filterResourceArray,
      List? filterZoneArray,
      List? filterEntrepreneurArray,
      List? filterStatusArray,
      List? filterTransportStatusArray,
      List? filterSubprojectArray) async {
    SharedPreferenceService prefs = SharedPreferenceService();

    /*Map<dynamic, dynamic> body = {
            "organization_id": organizationId,
            "project_id": projectId,
            "active_one": true,
            "start": "${DateFormat("yyyy-MM-dd HH:mm:ss").parse("2023-02-06 08:00:00").millisecondsSinceEpoch}",
            "end": "${DateFormat("yyyy-MM-dd HH:mm:ss").parse(DateTime.now().toString()).millisecondsSinceEpoch}",
             // "start": "1675641600000",
             // "end": "1676073600000",
            "unbooked_type": "regular",
            "filter_resource_array":filterResourceArray,
            "filter_zone_array":filterZoneArray,
            "filter_entrepreneur_array":filterEntrepreneurArray,
            "filter_status_array":filterStatusArray,
            "filter_transport_status_array":filterTransportStatusArray,
            "filter_type_array":null,
            "filter_subproject_array":filterSubprojectArray
          };*/

    Map<dynamic, dynamic> bodyForDataFilter = {
      "organization_id": organizationId, //mobileOrgId,
      "project_id": projectId,
      "active_one": true,
      "start": startDate,
      "end": endDate,
      "unbooked_type": "regular",
      "filter_resource_array":
          filterResourceArray?.length == 0 ? null : filterResourceArray,
      "filter_zone_array":
          filterZoneArray?.length == 0 ? null : filterZoneArray,
      "filter_entrepreneur_array":
          filterEntrepreneurArray?.length == 0 ? null : filterEntrepreneurArray,
      "filter_status_array":
          filterStatusArray?.length == 0 ? null : filterStatusArray,
      "filter_transport_status_array": filterTransportStatusArray?.length == 0
          ? null
          : filterTransportStatusArray,
      "filter_type_array": null,
      "filter_subproject_array":
          filterSubprojectArray?.length == 0 ? null : filterSubprojectArray,
    };

    Map<dynamic, dynamic> bodyForShowData = {
      "organization_id": organizationId, //mobileOrgId,
      "project_id": projectId,
      "active_one": true,
      "start": startDate,
      "end": endDate,
      "unbooked_type": "regular",
      "filter_resource_array": null,
      "filter_zone_array": null,
      "filter_entrepreneur_array": null,
      "filter_status_array": null,
      "filter_transport_status_array": [],
      "filter_type_array": null,
      "filter_subproject_array": null
    };

    try {
      final res = await _dio.post(
        ApiRoutes.postEventList,
        options: Options(headers: {
          "token": accessToken,
          "Content-Type": "application/json"
        }),
        data: (isFilter == true) ? bodyForDataFilter : bodyForShowData,
      );
      if (res.statusCode! >= 200 && res.statusCode! < 300) {
        log("${res.data}");
        return EventListModel.fromJson(res.data);
      }
    } catch (e) {
      print(e);
      return null;
    }
    return null;
  }

  static Future<RequestDataModel?> postRequestData(String requestId) async {
    Map<String, dynamic> body = {"request_id": requestId};
    try {
      final res = await _dio.post(
        ApiRoutes.postRequestData,
        options: Options(headers: {"token": accessToken}),
        data: body,
      );
      if (res.statusCode! >= 200 && res.statusCode! < 300) {
        log("RequestData=${res.data}");
        return RequestDataModel.fromJson(res.data);
      }
    } catch (e) {
      print(e);
      return null;
    }
    return null;
  }

  static Future<AddBookingModel?> postAddBooking(
      String requestId, String responsiblePerson) async {
    Map<String, dynamic> body = {
      "request_id": requestId,
      "event": "Pending",
      "responsible_person": "5fb845054fdab967c315b6e3"
    };
    try {
      final res = await _dio.post(
        ApiRoutes.postAddBooking,
        options: Options(headers: {"token": accessToken}),
        data: body,
      );
      if (res.statusCode! >= 200 && res.statusCode! < 300) {
        log("addbookings=${res.data}");
        return AddBookingModel.fromJson(res.data);
      }
    } catch (e) {
      print(e);
      return null;
    }
    return null;
  }

  static Future<List<BookingHistoryModel>?> postBookingHistory(
      String requestId) async {
    try {
      final res = await _dio.post(
        ApiRoutes.postBookingHistory,
        options: Options(headers: {"token": accessToken}),
        data: {"request_id": requestId},
      );
      if (res.statusCode! >= 200 && res.statusCode! < 300) {
        log("booking data=${res.data}");
        return (res.data as List)
            .map((x) => BookingHistoryModel.fromJson(x))
            .toList();
        // final List result = res.data;
        // return result.map(((e) => BookingHistoryModel.fromJson(e))).toList();
      }
    } catch (e) {
      print(e);
      return null;
    }
    return null;
  }

  static Future<WasteContainerListModel?> postWasteContainerList(
      String projectId) async {
    Map<String, dynamic> body = {
      "project_id": projectId,
    };
    try {
      final res = await _dio.post(
        ApiRoutes.postWasteContainerList,
        options: Options(headers: {"token": accessToken}),
        data: body,
      );
      log("listfinal${res.data}");
      if (res.statusCode! >= 200 && res.statusCode! < 300) {
        return WasteContainerListModel.fromJson(res.data);
      }
    } catch (e) {
      print(e);
      return null;
    }
    return null;
  }

  static Future<WasteFractionListModel?> postWasteFractionList(
      String projectId) async {
    Map<String, dynamic> body = {
      "project_id": projectId,
    };
    try {
      final res = await _dio.post(
        ApiRoutes.postWasteFractionList,
        options: Options(headers: {"token": accessToken}),
        data: body,
      );
      if (res.statusCode! >= 200 && res.statusCode! < 300) {
        return WasteFractionListModel.fromJson(res.data);
      }
    } catch (e) {
      print(e);
      return null;
    }
    return null;
  }

  static Future<CommonModel?> postBookWasteDisposal(Map body) async {
    try {
      final res = await _dio.post(
        ApiRoutes.postBookWasteDisposal,
        options: Options(headers: {"token": accessToken}),
        data: body,
      );
      if (res.statusCode! >= 200 && res.statusCode! < 300) {
        return CommonModel.fromJson(res.data);
      }
    } catch (e) {
      print(e);
      return null;
    }
    return null;
  }
}
