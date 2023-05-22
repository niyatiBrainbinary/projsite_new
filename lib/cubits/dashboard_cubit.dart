import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proj_site/api%20service/models/shipment_models/pending_shipment_list_model.dart';
import 'package:proj_site/api%20service/repository.dart';
import 'package:proj_site/common/widget_constant/widget_constant.dart';
import 'package:proj_site/helper/helper.dart';
import 'package:proj_site/services/sharedpreference_service.dart';

abstract class DashBoardState {}

class DashBoardInitial extends DashBoardState {}

class PendingShipmentListLoading extends DashBoardState {}
class PendingShipmentListSuccess extends DashBoardState {}
class PendingShipmentListError extends DashBoardState {}

class DashBoardCubit extends Cubit<DashBoardState> {
  DashBoardCubit() : super(DashBoardInitial());
  SharedPreferenceService prefs = SharedPreferenceService();
  List<PendingList> pendingShipmentList=[];

  void PendingShipmentList(String organizationId, List projectIdList, String oldOrgId) async {
    emit(PendingShipmentListLoading());
    // orgId = (await prefs.getStringData("organizationId")).toString();
    // orgVal = (await prefs.getStringData("organizationVal")).toString();
    log("myid$orgId");
    PendingShipmentListModel? response = await Repository.postPendingShipmentList(orgId,projectIdList, oldOrgId);
    if (response != null) {
      pendingShipmentList=[];
      pendingShipmentList=response.data!;
      emit(PendingShipmentListSuccess());
    } else {
      //snackBar("No matching records found", false);
      emit(PendingShipmentListError());
    }
  }
}