import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proj_site/api%20service/models/common_model.dart';
import 'package:proj_site/api%20service/models/unloading_zone_models/create_zone_model.dart';
import 'package:proj_site/api%20service/repository.dart';
import 'package:ftx/navigationX.dart';
import 'package:proj_site/api%20service/models/common_model.dart';
import 'package:proj_site/api%20service/models/unloading_zone_models/create_zone_model.dart';
import 'package:proj_site/api%20service/repository.dart';

import '../common/widget_constant/widget_constant.dart';


abstract class UnLoadingZoneState {}

class UnLoadingZoneInitial extends UnLoadingZoneState {}

class CreateUnLoadingZoneLoading extends UnLoadingZoneState {}
class CreateUnLoadingZoneSuccess extends UnLoadingZoneState {}
class CreateUnLoadingZoneError extends UnLoadingZoneState {}

class UpdateUnLoadingZoneLoading extends UnLoadingZoneState {}
class UpdateUnLoadingZoneSuccess extends UnLoadingZoneState {}
class UpdateUnLoadingZoneError extends UnLoadingZoneState {}

class UnLoadingZoneDetailsLoading extends UnLoadingZoneState {}
class UnLoadingZoneDetailsSuccess extends UnLoadingZoneState {}
class UnLoadingZoneDetailsError extends UnLoadingZoneState {}

class DeleteUnLoadingZoneLoading extends UnLoadingZoneState {}
class DeleteUnLoadingZoneSuccess extends UnLoadingZoneState {}
class DeleteUnLoadingZoneError extends UnLoadingZoneState {}

class UnLoadingZoneCubit extends Cubit<UnLoadingZoneState> {
  UnLoadingZoneCubit() : super(UnLoadingZoneInitial());

  void createUnLoadingZone(String projectId, String zoneName, String zoneColor,
      String organizationId) async {
    emit(CreateUnLoadingZoneLoading());
    CreateZoneModel? response = await Repository.postCreateUnloadingZone(
        projectId, zoneName, zoneColor, organizationId);
    if (response != null) {
      if (response.success == true) {
        snackBar("Zone Created Successfully", true);
        //Navigation.instance.navigateAndRemoveUntil(SignIn.id);
        emit(CreateUnLoadingZoneSuccess());
      } else {
        snackBar(response.error!.error!, false);
        emit(CreateUnLoadingZoneError());
      }
    } else {
      snackBar("Error to Load Data", false);
      emit(CreateUnLoadingZoneError());
    }
  }

  void updateUnLoadingZone(String projectId, String zoneId, String zoneName,
      String zoneColor, String organizationId) async {
    emit(UpdateUnLoadingZoneLoading());
    CreateZoneModel? response = await Repository.postUpdateUnloadingZone(
        projectId, zoneId, zoneName, zoneColor, organizationId);
    if (response != null) {
      if (response.success == true) {
        snackBar("Zone Updated Successfully", true);
        //Navigation.instance.navigateAndRemoveUntil(SignIn.id);
        emit(UpdateUnLoadingZoneSuccess());
      } else {
        snackBar(response.error!.error!, false);
        emit(UpdateUnLoadingZoneError());
      }
    } else {
      snackBar("Error to Load Data", false);
      emit(UpdateUnLoadingZoneError());
    }
  }

  void unLoadingZoneDetails(String zoneId, String organizationId) async {
    emit(UnLoadingZoneDetailsLoading());
    CommonModel? response = await Repository.postUnloadingZoneDetails(zoneId, organizationId);
    if (response != null) {
      if (response.success == true) {
        snackBar("Password Updated Successfully", true);
        //Navigation.instance.navigateAndRemoveUntil(SignIn.id);
        emit(UnLoadingZoneDetailsSuccess());
      } else {
        snackBar("Try Again", false);
        emit(UnLoadingZoneDetailsError());
      }
    } else {
      snackBar("Error to Load Data", false);
      emit(UnLoadingZoneDetailsError());
    }
  }

  void deleteUnloadingZone(String zoneId, String organizationId) async {
    emit(DeleteUnLoadingZoneLoading());
    CommonModel? response = await Repository.postDeleteUnloadingZone(zoneId);
    if (response != null) {
      if (response.success == true) {
        snackBar("Password Updated Successfully", true);
        //Navigation.instance.navigateAndRemoveUntil(SignIn.id);
        emit(DeleteUnLoadingZoneSuccess());
      } else {
        snackBar("Try Again", false);
        emit(DeleteUnLoadingZoneError());
      }
    } else {
      snackBar("Error to Load Data", false);
      emit(DeleteUnLoadingZoneError());
    }
  }

}