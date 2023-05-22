
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proj_site/api%20service/models/common_model.dart';
import 'package:proj_site/api%20service/models/waste_disposal_models/waste_container_list_model.dart';
import 'package:proj_site/api%20service/models/waste_disposal_models/waste_fraction_list_model.dart';
import 'package:proj_site/api%20service/repository.dart';
import 'package:proj_site/common/widget_constant/widget_constant.dart';

abstract class WasteDisposalState {}

class WasteDisposalInitial extends WasteDisposalState {}

class WasteContainerListLoading extends WasteDisposalState {}
class WasteContainerListSuccess extends WasteDisposalState {}
class WasteContainerListError extends WasteDisposalState {}

class WasteFractionListLoading extends WasteDisposalState {}
class WasteFractionListSuccess extends WasteDisposalState {}
class WasteFractionListError extends WasteDisposalState {}

class BookWasteDisposalLoading extends WasteDisposalState {}
class BookWasteDisposalSuccess extends WasteDisposalState {}
class BookWasteDisposalError extends WasteDisposalState {}

class WasteDisposalCubit extends Cubit<WasteDisposalState> {
  WasteDisposalCubit() : super(WasteDisposalInitial());

  List<ContainerList> containerList=[];
  List<FractionList> fractionList=[];
  List<String> containerNameList=[];
  List<String> fractionNameList=[];

  void wasteContainerList(String projectId) async {
    emit(WasteContainerListLoading());
    WasteContainerListModel? response = await Repository.postWasteContainerList(projectId);
    if (response != null) {
      if (response.success == true) {
        containerList=[];
        containerNameList=[];
        containerList=response.containerList!;
        for (int i = 0; i < response.containerList!.length; i++) {
          containerNameList.add(response.containerList![i].wasteContainerName!);
        }
        wasteFractionList(projectId);
        emit(WasteContainerListSuccess());
      } else {
        snackBar("Something Went Wrong", false);
        emit(WasteContainerListError());
      }
    } else {
      snackBar("Error to Load Data", false);
      emit(WasteContainerListError());
    }
  }

  void wasteFractionList(String projectId) async {
    emit(WasteFractionListLoading());
    WasteFractionListModel? response = await Repository.postWasteFractionList(projectId);
    if (response != null) {
      if (response.success == true) {
        fractionList=[];
        fractionNameList=[];
        fractionList=response.fractionList!;
        for (int i = 0; i < response.fractionList!.length; i++) {
          fractionNameList.add(response.fractionList![i].wasteFractionName!);
        }
        emit(WasteFractionListSuccess());
      } else {
        snackBar("Something Went Wrong", false);
        emit(WasteFractionListError());
      }
    } else {
      snackBar("Error to Load Data", false);
      emit(WasteFractionListError());
    }
  }

  void bookWasteDisposal(Map body,BuildContext context) async {
    emit(BookWasteDisposalLoading());
    CommonModel? response = await Repository.postBookWasteDisposal(body);
    if (response != null) {
      if (response.success == true) {
        snackBar("Booking Success", true);
        Navigator.pop(context);
        emit(BookWasteDisposalSuccess());
      } else {
        snackBar("Something Went Wrong", false);
        emit(BookWasteDisposalError());
      }
    } else {
      snackBar("Error to Load Data", false);
      emit(BookWasteDisposalError());
    }
  }
}