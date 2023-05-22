
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ftx/navigationX.dart';
import 'package:proj_site/api%20service/models/logistic_list_models/add_logistic_model.dart';
import 'package:proj_site/api%20service/models/logistic_list_models/checkout_logistic_model.dart';
import 'package:proj_site/api%20service/models/logistic_list_models/delete_logistic_model.dart';
import 'package:proj_site/api%20service/models/logistic_list_models/edit_logistic_model.dart';
import 'package:proj_site/api%20service/models/logistic_list_models/logistic_details_model.dart';
import 'package:proj_site/api%20service/models/logistic_list_models/logistic_list_model.dart';
import 'package:proj_site/api%20service/models/logistic_list_models/logistic_request_data_model.dart';
import 'package:proj_site/api%20service/models/logistic_list_models/notTransported_checkouts_model.dart';
import 'package:proj_site/api%20service/models/shipment_models/add_shipment_model.dart';
import 'package:proj_site/api%20service/repository.dart';
import 'package:proj_site/common/widget_constant/widget_constant.dart';


abstract class LogisticListState {}

class LogisticListInitial extends LogisticListState {}

class AddLogisticLoading extends LogisticListState {}

class AddLogisticSuccess extends LogisticListState {}

class AddLogisticError extends LogisticListState {}

class LogisticListLoading extends LogisticListState {}

class LogisticListSuccess extends LogisticListState {}

class LogisticListError extends LogisticListState {}

class LogisticDetailLoading extends LogisticListState {}

class LogisticDetailSuccess extends LogisticListState {}

class LogisticDetailError extends LogisticListState {}

class NotTransportedCheckoutLoading extends LogisticListState {}

class NotTransportedCheckoutSuccess extends LogisticListState {}

class NotTransportedCheckoutError extends LogisticListState {}

class EditLogisticLoading extends LogisticListState {}

class EditLogisticSuccess extends LogisticListState {}

class EditLogisticError extends LogisticListState {}

class DeleteLogisticLoading extends LogisticListState {}

class DeleteLogisticSuccess extends LogisticListState {}

class DeleteLogisticError extends LogisticListState {}

class CheckoutLogisticLoading extends LogisticListState {}

class CheckoutLogisticSuccess extends LogisticListState {}

class CheckoutLogisticError extends LogisticListState {}

class LogisticRequestDataLoading extends LogisticListState {}

class LogisticRequestDataSuccess extends LogisticListState {}

class LogisticRequestDataError extends LogisticListState {}

class LogisticListCubit extends Cubit<LogisticListState> {
  LogisticListCubit() : super(LogisticListInitial());

  List<LogisticList> LogisticsList = [];

  List<CheckOutTransportHistory>? checkOuts = [];

  List<String> userList = [];

  LogisticDetailsModel? logisticDetails;

  String selectedSubProject="";
  String selectedEnterpreneurs="";

  String arrival_date = "";
  var created_at;
  var updated_at;

dateFormate({required String date ,required String finalDate}){
 var selectedDate =DateTime.parse(date);
  finalDate = "${selectedDate.year}-${selectedDate.month}-${selectedDate.day}";
}

void setState(){
  emit(LogisticListInitial());
}

  void AddLogistic(Map<String, dynamic> body) async {
    emit(AddLogisticLoading());
    AddLogisticsModel? response = await Repository.postAddLogistic(body);
    if (response != null) {
      if (response.success == true) {
        snackBar("Logistic Added", true);
        emit(AddLogisticSuccess());
      } else {
        snackBar("Something Went Wrong", false);
        emit(AddLogisticError());
      }
    } else {
      snackBar("Error to Load Data", false);
      emit(AddLogisticError());
    }
  }

  void LogisticListData(String projectId, String terminalId) async {
    emit(LogisticListLoading());
    LogisticListModel? response = await Repository.postLogistic(projectId,terminalId);
    if (response != null) {
      if (response.success == true) {
        LogisticsList = [];
        LogisticsList = response.logisticList!;
        emit(LogisticListSuccess());
      } else {
        snackBar("Something Went Wrong", false);
        emit(LogisticListError());
      }
    } else {
      snackBar("Error to Load Data", false);
      emit(LogisticListError());
    }
  }

  void LogisticDetails(String logisticId) async {
    emit(LogisticDetailLoading());
    logisticDetails = await Repository.postLogisticDetails(logisticId);

    if (logisticDetails != null) {
      if (logisticDetails!.success == true) {

        var selectedDate =DateTime.parse(logisticDetails!.result!.arrivalDate.toString());
        arrival_date = "${selectedDate.year}-${selectedDate.month}-${selectedDate.day}";
        emit(LogisticDetailSuccess());
      } else {
        snackBar("Something Went Wrong", false);
        emit(LogisticDetailError());
      }
    } else {
      snackBar("Error to Load Data", false);
      emit(LogisticDetailError());
    }
  }

  void NotTransportedCheckout(String projectId, String terminalId,String startDate, String fromDate, String itemName) async {
    emit(NotTransportedCheckoutLoading());
    NotTransportedCheckoutsModel? response =
        await Repository.postNotTransportCheckouts(projectId, terminalId,startDate,fromDate,itemName);
    if (response != null) {
      if (response.success == true) {
        checkOuts = [];
        userList = [];
        checkOuts = response.checkOuts;
        for (int i = 0; i < checkOuts!.length; i++) {
          userList.add(checkOuts![i].createdByPersonName);
        }
        emit(NotTransportedCheckoutSuccess());
      } else {
        snackBar("Something Went Wrong", false);
        emit(NotTransportedCheckoutError());
      }
    } else {
      snackBar("Error to Load Data", false);
      emit(NotTransportedCheckoutError());
    }
  }

  // void Organizations({required String organization_id}) async {
  //   emit(OrganizationsLoading());
  //   OrganizationsModel? response = await Repository.postOrganizations(organization_id: organization_id);
  //   if (response != null) {
  //     if (response.success == true) {
  //       organization = [];
  //       companyList = response.companyList;
  //       for (int i = 0; i < companyList!.length; i++) {
  //         organization.add(companyList![i].companyName);
  //       }
  //       selectedSubProject = organization[0];
  //      //  UserSubProjectList();
  //
  //       emit(OrganizationsSuccess());
  //     } else {
  //       snackBar("Something Went Wrong", false);
  //       emit(OrganizationsError());
  //     }
  //   } else {
  //     snackBar("Error to Load Data", false);
  //     emit(OrganizationsError());
  //   }
  // }
  //
  // void UserSubProjectList({required String user_id,required String project_id,required String organization_id}) async {
  //   emit(UserSubProjectListLoading());
  //   UserSubProjectListModel? response =
  //       await Repository.postUserSubProjectList(user_id: user_id, project_id: project_id, organization_id: organization_id);
  //   if (response != null) {
  //     if (response.success == true) {
  //       subProjects = [];
  //       userSubProjects = [];
  //       enterpreneurs = [];
  //       subProjects = response.subProjects;
  //       userSubProjects = response.userSubProjects;
  //
  //       for (int i = 0; i < subProjects!.length; i++) {
  //         enterpreneurs.add(subProjects![i].subProjectName);
  //       }
  //       selectedEnterpreneurs = enterpreneurs[0];
  //       emit(UserSubProjectListSuccess());
  //     } else {
  //       snackBar("Something Went Wrong", false);
  //       emit(UserSubProjectListError());
  //     }
  //   } else {
  //     snackBar("Error to Load Data", false);
  //     emit(UserSubProjectListError());
  //   }
  // }

  void EditLogistic(Map<String, dynamic> body,String projectId,String terminalId) async {
    emit(EditLogisticLoading());
    EditLogisticModel? response = await Repository.postEditLogistic(body);
    if (response != null) {
      if (response.success == true) {
        LogisticListData(projectId,terminalId);
        Navigation.instance.goBack();
        snackBar("Logistic Updated", true);
        emit(EditLogisticSuccess());
      } else {
        snackBar("Something Went Wrong", false);
        emit(EditLogisticError());
      }
    } else {
      snackBar("Error to Load Data", false);
      emit(EditLogisticError());
    }
  }

  void DeleteLogistic(String logisticId,String projectId, String terminalId) async {
    emit(DeleteLogisticLoading());
    DeleteLogisticModel? response = await Repository.postDeleteLogistic(logisticId);
    if (response != null) {
      if (response.success == true) {
        LogisticListData(projectId,terminalId);
        Navigation.instance.goBack();
        emit(DeleteLogisticSuccess());
        snackBar("Logistic Deleted", true);
      } else {
        snackBar("Something Went Wrong", false);
        emit(DeleteLogisticError());
      }
    } else {
      snackBar("Error to Load Data", false);
      emit(DeleteLogisticError());
    }
  }

  void CheckoutLogistic(Map<String, dynamic> body) async {
    emit(CheckoutLogisticLoading());
    CheckoutLogisticModel? response = await Repository.postCheckoutLogistic(body);
    if (response != null) {
      if (response.success == true) {
        emit(CheckoutLogisticSuccess());
        snackBar("successfully", true);
      } else {
        snackBar("Something Went Wrong", false);
        emit(CheckoutLogisticError());
      }
    } else {
      snackBar("Error to Load Data", false);
      emit(CheckoutLogisticError());
    }
  }

  void LogisticRequestData(String requestId) async {
    emit(LogisticRequestDataLoading());
    LogisticRequestDataModel? response = await Repository.postLogisticRequestData(requestId);
    if (response != null) {
      if (response.success == true) {
        emit(LogisticRequestDataSuccess());
      } else {
        snackBar("Something Went Wrong", false);
        emit(LogisticRequestDataError());
      }
    } else {
      snackBar("Error to Load Data", false);
      emit(LogisticRequestDataError());
    }
  }

}
