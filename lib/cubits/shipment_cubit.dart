


import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ftx/navigationX.dart';
import 'package:proj_site/api%20service/models/common_model.dart';
import 'package:proj_site/api%20service/models/logistic_list_models/create_supplier_model.dart';
import 'package:proj_site/api%20service/models/logistic_list_models/shipment_supplier_list_model.dart';
import 'package:proj_site/api%20service/models/shipment_models/add_shipment_model.dart';
import 'package:proj_site/api%20service/models/shipment_models/monthly_shipments_model.dart';
import 'package:proj_site/api%20service/models/shipment_models/update_shipment_model.dart';
import 'package:proj_site/api%20service/repository.dart';
import 'package:proj_site/common/widget_constant/widget_constant.dart';
import 'package:proj_site/cubits/booking_cubit.dart';
import 'package:proj_site/helper/helper.dart';
import 'package:proj_site/services/sharedpreference_service.dart';

abstract class ShipmentState {}

class ShipmentInitial extends ShipmentState {}

class AddShipmentLoading extends ShipmentState {}
class AddShipmentSuccess extends ShipmentState {}
class AddShipmentError extends ShipmentState {}

class UpdateShipmentLoading extends ShipmentState {}
class UpdateShipmentSuccess extends ShipmentState {}
class UpdateShipmentError extends ShipmentState {}

class CloseShipmentLoading extends ShipmentState {}
class CloseShipmentSuccess extends ShipmentState {}
class CloseShipmentError extends ShipmentState {}

class UpdateApprovalStatusLoading extends ShipmentState {}
class UpdateApprovalStatusSuccess extends ShipmentState {}
class UpdateApprovalStatusError extends ShipmentState {}

class UpdateTransportStatusLoading extends ShipmentState {}
class UpdateTransportStatusSuccess extends ShipmentState {}
class UpdateTransportStatusError extends ShipmentState {}

class CreateShipmentSupplierLoading extends ShipmentState {}
class CreateShipmentSupplierSuccess extends ShipmentState {}
class CreateShipmentSupplierError extends ShipmentState {}

class ShipmentSupplierListLoading extends ShipmentState {}
class ShipmentSupplierListSuccess extends ShipmentState {}
class ShipmentSupplierListError extends ShipmentState {}

class MonthlyShipmentsLoading extends ShipmentState {}
class MonthlyShipmentsSuccess extends ShipmentState {}
class MonthlyShipmentsError extends ShipmentState {}

class ShipmentCubit extends Cubit<ShipmentState> {
  ShipmentCubit() : super(ShipmentInitial());

  Map shipmentData={};
  SharedPreferenceService prefs = SharedPreferenceService();

  List<String> shipmentSuppName=[];
  List shipmentSuppId=[];
  List<MonthlyShipmentsModel>? monthlyShipments;
  String status="pending";
  String totalPendingShipment="";
  String totalApprovedShipment="";
  String totalRejectedShipment="";

  void AddShipment(Map finalMap,BuildContext context) async {
    emit(AddShipmentLoading());
    AddShipmentModel? response = await Repository.postAddShipment(finalMap);
    if (response != null) {
      if (response.success == true) {

        Navigator.of(context)..pop()..pop();
        Navigator.pop(context,"Success");
        snackBar("Shipment Request Saved Successfully", true);

        emit(AddShipmentSuccess());

        BlocProvider.of<BookingCubit>(context).AddBooking(response.requestIds?[0], response.result?.responsiblePersonId);

      } else {
        snackBar("Something Went Wrong", false);
        emit(AddShipmentError());
      }
    } else {
      snackBar("Error to Load Data", false);
      emit(AddShipmentError());
    }
  }

  void UpdateShipment(Map finalMap,BuildContext context,bool statusUpdated) async {
    emit(UpdateShipmentLoading());

    UpdateShipmentModel? response = await Repository.postUpdateShipment(finalMap);

    if (response != null) {
      if (response.success == true) {
        if(statusUpdated == false)
          {

        snackBar("Request updated successfully", true);
          }
        else
          {
            snackBar("No change has been made", true);

          }

        Navigator.of(context)..pop()..pop()..pop();
        Navigator.pop(context,"Success");


        emit(UpdateShipmentSuccess());
      } else {
        snackBar("Something Went Wrong", false);
        emit(UpdateShipmentError());
      }
    } else {
      snackBar("Error to Load Data", false);
      emit(UpdateShipmentError());
    }
  }

  void CloseShipment(BuildContext context,String requestId) async {
    emit(CloseShipmentLoading());

    CommonModel? response = await Repository.postCloseShipment(requestId);

    if (response != null) {
      if (response.success == true) {
        snackBar("Request closed successfully", true);
        Navigator.pop(context);
        Navigator.pop(context,"Success");

        emit(CloseShipmentSuccess());
      } else {
        snackBar("Something Went Wrong", false);
        emit(CloseShipmentError());
      }
    } else {
      snackBar("Error to Load Data", false);
      emit(CloseShipmentError());
    }
  }

  void UpdateApprovalStatus(String status, String requestId, BuildContext context) async {

    emit(UpdateApprovalStatusLoading());

    CommonModel? response = await Repository.postUpdateApprovalStatus(status,requestId);

    if (response != null) {
      if (response.success == true) {
        Navigator.pop(context);
        Navigator.pop(context,"Success");
        snackBar("success", true);
        emit(UpdateApprovalStatusSuccess());
      } else {
        snackBar("Something Went Wrong", false);
        emit(UpdateApprovalStatusError());
      }
    } else {
      snackBar("Error to Load Data", false);
      emit(UpdateApprovalStatusError());
    }
  }

  void UpdateTransportStatus(String requestId, String transportStatus,BuildContext context) async {
    emit(UpdateTransportStatusLoading());

    CommonModel? response = await Repository.postUpdateTransportStatus(requestId,transportStatus);

    if (response != null) {
      if (response.success == true) {
        Navigator.pop(context,"Success");
        snackBar("success", true);
        emit(UpdateTransportStatusSuccess());
      } else {
        snackBar("Something Went Wrong", false);
        emit(UpdateTransportStatusError());
      }
    } else {
      snackBar("Error to Load Data", false);
      emit(UpdateTransportStatusError());
    }
  }

  void CreateShipmentSupplier(String projectId, String supplierName) async {
    emit(CreateShipmentSupplierLoading());

    CreateSupplierModel? response = await Repository.postCreateSupplier(projectId, supplierName);

    if (response != null) {
      if (response.success == true) {
        ShipmentSupplierList(projectId);
        Navigation.instance.goBack();
        snackBar("Shipment Supplier Created", true);
        emit(CreateShipmentSupplierSuccess());
      } else {
        snackBar("Something Went Wrong", false);
        emit(CreateShipmentSupplierError());
      }
    } else {
      Navigation.instance.goBack();
      emit(CreateShipmentSupplierError());
    }
  }

  void ShipmentSupplierList(String projectId) async {
    emit(ShipmentSupplierListLoading());

    SupplierListModel? response = await Repository.postSupplierList(projectId);

    if (response != null) {
      if (response.success == true) {
        shipmentSuppName=[];
        shipmentSuppId=[];
        for(int i=0; i<response.shipmentSupplierList!.length; i++){
          shipmentSuppName.add(response.shipmentSupplierList![i].shipmentSupplierName!);
          shipmentSuppId.add(response.shipmentSupplierList![i].id);
        }
        emit(ShipmentSupplierListSuccess());
      } else {
         snackBar("Something Went Wrong", false);
        emit(ShipmentSupplierListError());
      }
    } else {
      snackBar("Error to Load Data", false);
      emit(ShipmentSupplierListError());
    }
  }

  void MonthlyShipments(String organizationId, String status) async {
    emit(MonthlyShipmentsLoading());
    // orgVal = (await prefs.getStringData("organizationVal")).toString();
    // orgId = (await prefs.getStringData("organizationId")).toString();
    print("ordid${organizationId}");

    monthlyShipments = await Repository.postMonthlyShipments(organizationId, status);

    if (monthlyShipments != null) {
      if(status=="pending"){
        totalPendingShipment= monthlyShipments![0].totalShipments.toString();
      } else if(status=="approved"){
        totalApprovedShipment= monthlyShipments![0].totalShipments.toString();
      } else if(status=="rejected"){
        totalRejectedShipment= monthlyShipments![0].totalShipments.toString();
      }
        // shipmentSuppName=[];
        // shipmentSuppId=[];
        // for(int i=0; i<response.shipmentSupplierList!.length; i++){
        //   shipmentSuppName.add(response.shipmentSupplierList![i].shipmentSupplierName!);
        //   shipmentSuppId.add(response.shipmentSupplierList![i].id);
        // }

        emit(MonthlyShipmentsSuccess());
      }
     else {
      snackBar("Error to Load Data", false);
      emit(MonthlyShipmentsError());
    }
  }

}