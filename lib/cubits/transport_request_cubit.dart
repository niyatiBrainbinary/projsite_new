import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proj_site/api%20service/models/common_model.dart';
import 'package:proj_site/api%20service/models/shipment_models/add_shipment_model.dart';
import 'package:proj_site/api%20service/models/transport_request_model/get_transport_request_model.dart';
import 'package:proj_site/api%20service/repository.dart';
import 'package:proj_site/common/widget_constant/widget_constant.dart';

abstract class TransportRequestState {}

class TransportRequestInitial extends TransportRequestState {}

class AddTransportRequestLoading extends TransportRequestState {}
class AddTransportRequestSuccess extends TransportRequestState {}
class AddTransportRequestError extends TransportRequestState {}

class GetTransportRequestLoading extends TransportRequestState {}
class GetTransportRequestSuccess extends TransportRequestState {}
class GetTransportRequestError extends TransportRequestState {}

class UpdateTransportRequestLoading extends TransportRequestState {}
class UpdateTransportRequestSuccess extends TransportRequestState {}
class UpdateTransportRequestError extends TransportRequestState {}

class UpdateTransportRequestStatusLoading extends TransportRequestState {}
class UpdateTransportRequestStatusSuccess extends TransportRequestState {}
class UpdateTransportRequestStatusError extends TransportRequestState {}

class CloseTransportRequestLoading extends TransportRequestState {}
class CloseTransportRequestSuccess extends TransportRequestState {}
class CloseTransportRequestError extends TransportRequestState {}

class TransportRequestCubit extends Cubit<TransportRequestState> {
  TransportRequestCubit() : super(TransportRequestInitial());

  GetTransportRequestModel? transportRequestData;

  void AddTransportRequest(Map finalMap,BuildContext context) async {
    emit(AddTransportRequestLoading());
    AddShipmentModel? response = await Repository.postAddTransportRequest(finalMap);
    if (response != null) {
      if (response.success == true) {
        Navigator.pop(context);
        Navigator.pop(context,"Success");
        snackBar("Request Saved Successfully", true);
        emit(AddTransportRequestSuccess());
      } else {
        snackBar("Something Went Wrong", false);
        emit(AddTransportRequestError());
      }
    } else {
      snackBar("Error to Load Data", false);
      emit(AddTransportRequestError());
    }
  }

  void GetTransportRequest(String requestId, String projectId,BuildContext context) async {
    emit(GetTransportRequestLoading());
    transportRequestData = await Repository.postGetTransportRequest(requestId,projectId);
    if (transportRequestData != null) {
      if (transportRequestData!.success == true) {
        emit(GetTransportRequestSuccess());
      } else {
        snackBar("Something Went Wrong", false);
        emit(GetTransportRequestError());
      }
    } else {
      snackBar("Error to Load Data", false);
      emit(GetTransportRequestError());
    }
  }

  void UpdateTransportRequest(Map finalMap,BuildContext context,bool statusUpdated) async {
    emit(UpdateTransportRequestLoading());
    CommonModel? response = await Repository.postUpdateTransportRequest(finalMap);


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

        Navigator.of(context)..pop()..pop();
        Navigator.pop(context,"Success");
        emit(UpdateTransportRequestSuccess());
      } else {
        snackBar("Something Went Wrong", false);
        emit(UpdateTransportRequestSuccess());
      }
    } else {
      snackBar("Error to Load Data", false);
      emit(UpdateTransportRequestSuccess());
    }
  }

  void UpdateTransportRequestStatus(String requestId, String transportStatus,BuildContext context) async {
    emit(UpdateTransportRequestStatusLoading());

    CommonModel? response = await Repository.postUpdateTransportRequestStatus(requestId,transportStatus);

    if (response != null) {
      if (response.success == true) {
        Navigator.pop(context);
        Navigator.pop(context,"Success");
        snackBar("Success", true);
        emit(UpdateTransportRequestStatusSuccess());
      } else {
        snackBar("Something Went Wrong", false);
        emit(UpdateTransportRequestStatusError());
      }
    } else {
      snackBar("Error to Load Data", false);
      emit(UpdateTransportRequestStatusError());
    }
  }

  void CloseTransportRequest(BuildContext context,String requestId) async {
    emit(CloseTransportRequestLoading());

    CommonModel? response = await Repository.postCloseTransportRequest(requestId);

    if (response != null) {
      if (response.success == true) {
        snackBar("Request closed successfully", true);
        Navigator.pop(context);
        Navigator.pop(context,"Success");
        emit(CloseTransportRequestSuccess());
      } else {
        snackBar("Something Went Wrong", false);
        emit(CloseTransportRequestError());
      }
    } else {
      snackBar("Error to Load Data", false);
      emit(CloseTransportRequestError());
    }
  }
}