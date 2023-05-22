import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proj_site/api%20service/models/enviromental_models/euroclass_model.dart';
import 'package:proj_site/api%20service/models/enviromental_models/fuel_model.dart';
import 'package:proj_site/api%20service/models/enviromental_models/vehicle_model.dart';
import 'package:proj_site/api%20service/repository.dart';
import 'package:proj_site/common/widget_constant/widget_constant.dart';



abstract class EnviromentalState {}

class EnviromentalInitial extends EnviromentalState {}

class EuroclassLoading extends EnviromentalState {}
class EuroclassSuccess extends EnviromentalState {}
class EuroclassError extends EnviromentalState {}

class VehicleLoading extends EnviromentalState {}
class VehicleSuccess extends EnviromentalState {}
class VehicleError extends EnviromentalState {}

class FuelLoading extends EnviromentalState {}
class FuelSuccess extends EnviromentalState {}
class FuelError extends EnviromentalState {}


class EnviromentalCubit extends Cubit<EnviromentalState> {
  EnviromentalCubit() : super(EnviromentalInitial());

  List<String>euroclassList =[];
  List<String>euroclassListId =[];
  List<String>vehicleList =[];
  List<String>vehicleListId =[];
  List<String>fuelList =[];
  List<String>fuelListId =[];

  void Euroclass() async {
    emit(EuroclassLoading());
    List<EuroclassModel>? response = await Repository.postEuroclass();
    if (response != null) {
      emit(EuroclassSuccess());
      euroclassList = [];
      for (int i = 0; i < response.length; i++) {
        euroclassList.add(response[i].euroclassName);
        euroclassListId.add(response[i].id);
      }
    } else {
      snackBar("Error to Load Data", false);
      emit(EuroclassError());
    }
  }

  void Vehicle() async {
    emit(VehicleLoading());
    List<VehicleModel>?  response = await Repository.postVehicle();
    if (response != null) {
      emit(VehicleSuccess());
      vehicleList = [];
      for (int i = 0; i < response.length; i++) {
        vehicleList.add(response[i].vehicleName);
        vehicleListId.add(response[i].id);
      }
    } else {
      snackBar("Error to Load Data", false);
      emit(VehicleError());
    }
  }

  void Fuel() async {
    emit(FuelLoading());
    List<FuelModel>?  response = await Repository.postFuel();
    if (response != null) {
      fuelList = [];
      for (int i = 0; i < response.length; i++) {
        fuelList.add(response[i].fuelName);
        fuelListId.add(response[i].id);
      }
      emit(FuelSuccess());
    } else {
      snackBar("Error to Load Data", false);
      emit(FuelError());
    }
  }

}