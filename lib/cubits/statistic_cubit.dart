

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:proj_site/api%20service/models/project_list_models/project_details_model.dart';
import 'package:proj_site/api%20service/models/project_list_models/project_list_model.dart';
import 'package:proj_site/api%20service/models/statistic/addToWasteListModel.dart';
import 'package:proj_site/api%20service/models/statistic/statisticSaveModel.dart';
import 'package:proj_site/api%20service/models/statistic/wastFractionDropDownModel.dart';
import 'package:proj_site/api%20service/models/sub_project_models/add_new_sub_project.dart';
import 'package:proj_site/api%20service/models/sub_project_models/sub_project_list_model.dart';
import 'package:proj_site/api%20service/models/statistic/wastContainerDropDownModel.dart';
import 'package:proj_site/api%20service/repository.dart';
import 'package:proj_site/common/widget_constant/widget_constant.dart';
import 'package:proj_site/cubits/auth_cubit.dart';
import 'package:proj_site/helper/helper.dart';
import 'package:proj_site/services/sharedpreference_service.dart';
import 'package:proj_site/view/statistics/statistic_table.dart';


abstract class StatisticsState {}

class StatisticsInitial extends StatisticsState {}

class ContainerDropDownLoading extends StatisticsState {}
class ContainerDropDownSuccess extends StatisticsState {}
class ContainerDropDownError extends StatisticsState {}

class FractionDropDownLoading extends StatisticsState {}
class FractionDropDownSuccess extends StatisticsState {}
class FractionDropDownError extends StatisticsState {}

class AddToListLoading extends StatisticsState {}
class AddToListSuccess extends StatisticsState {}
class AddToListError extends StatisticsState {}

class SubProjectListLoading extends StatisticsState {}
class SubProjectListSuccess extends StatisticsState {}
class SubProjectListError extends StatisticsState {}

class SaveStatisticLoading extends StatisticsState {}
class SaveStatisticSuccess extends StatisticsState {}
class SaveStatisticError extends StatisticsState {}

class StatisticsCubit extends Cubit<StatisticsState> {
  StatisticsCubit() : super(StatisticsInitial());

  setState(){
    emit(StatisticsInitial());
  }


  List wasteContainerDropDownList = [];
  List wasteFractionDropDownList = [];
  List subProjectList = [];
  List wasteData = [];

  var containerName;
  var containerId;

  var fractionName;
  var fractionId;

  var subProjectName;
  var subProjectId;

  String? toDate;

  TextEditingController numberOfWasteController = TextEditingController();
  TextEditingController amountOfFractionController = TextEditingController();
  TextEditingController numberOfTransportsController = TextEditingController();


  SharedPreferenceService prefs = SharedPreferenceService();
  late AuthCubit authCub;

  TextEditingController idController = TextEditingController();

  void containerDropDownList ({
    required String projectId
}) async{
    emit(ContainerDropDownLoading());

    WasteContainerDropDownModel? response = await Repository.wasteContainerDropDown(projectId: projectId);

    if (response != null) {
      if (response.success == true) {


        for(int i = 0; i < response.containerList!.length; i++ ){
          if(response.containerList?[i] != null){
            wasteContainerDropDownList.add(
              {
                "name": response.containerList?[i].wasteContainerName,
                "id": response.containerList?[i].id
              },
            );
          }
        }

        //snackBar("Successfully", true);
        emit(ContainerDropDownSuccess());

      } else {
        //snackBar("Something Went Wrong", false);
        emit(ContainerDropDownError());
      }
    } else {
      //snackBar("Error to Load Data", false);
      emit(ContainerDropDownError());
    }
  }


  void fractionDropDownList ({
    required String projectId
  }) async{

    emit(FractionDropDownLoading());

    WasteFractionDropDownModel? response = await Repository.wasteFractionDropDown(projectId: projectId);

    if (response != null) {
      if (response.success == true) {


        for(int i = 0; i < response.fractionList!.length; i++ ){
          if(response.fractionList?[i] != null){
            wasteFractionDropDownList.add(
              {
                "name": response.fractionList?[i].wasteFractionName,
                "id": response.fractionList?[i].id
              },
            );
          }
        }

        //snackBar("Successfully", true);
        emit(FractionDropDownSuccess());

      } else {
        //snackBar("Something Went Wrong", false);
        emit(FractionDropDownError());
      }
    } else {
      //snackBar("Error to Load Data", false);
      emit(FractionDropDownError());
    }
  }



   void addToWasteList ({
    required BuildContext context,
    required String projectId,
    required String wasteContainerId,
    required String wasteFractionId,
    required int numberOfContainers,
    required int amountOfFraction,
    required int amountOfTransports,
  }) async{

    emit(AddToListLoading());

    AddToWasteListModel? response = await Repository.addToWasteList(
        projectId: projectId,
      wasteContainerId: wasteContainerId,
      wasteFractionId: wasteFractionId,
      numberOfContainers: numberOfContainers,
      amountOfFraction: amountOfFraction,
      amountOfTransports: amountOfTransports
    );

    if (response != null) {
      if (response.success == true) {

        snackBar("Successfully", true);
        emit(AddToListSuccess());

        wasteData.add(
          {
            "waste_container": response.wasteData?.wasteContainer,
            "waste_container_id": response.wasteData?.wasteContainerId,
            "number_of_containers": response.wasteData?.numberOfContainers,
            "waste_fraction": response.wasteData?.wasteFraction,
            "waste_fraction_id": response.wasteData?.wasteFractionId,
            "amount_of_fraction": response.wasteData?.amountOfFraction,
            "amount_of_transports": response.wasteData?.amountOfTransports,
            "transport_distance": response.wasteData?.transportDistance,
            "fraction_address": {
              "fraction_selected_address": response.wasteData?.fractionAddress?.fractionSelectedAddress,
              "fraction_selected_address_lat": response.wasteData?.fractionAddress?.fractionSelectedAddressLat,
              "fraction_selected_address_lng": response.wasteData?.fractionAddress?.fractionSelectedAddressLat,
            },
            "project_address": {
              "lat": response.wasteData?.projectAddress?.lat,
              "lng": response.wasteData?.projectAddress?.lng,
              "location": response.wasteData?.projectAddress?.location
            },
            "container_vehicle": response.wasteData?.containerVehicle,
            "container_vehicle_fuel": response.wasteData?.containerVehicleFuel,
            "container_vehicle_euroclass": response.wasteData?.containerVehicleEuroclass,
            "load_weight_per_transport": response.wasteData?.loadWeightPerTransport,
            "ntm_simple_data": {
              "vehicle": response.wasteData?.ntmSimpleData?.vehicle,
              "totals": response.wasteData?.ntmSimpleData?.totals,
            },
            "ntm": response.wasteData?.ntm
          }
        );

        print(wasteData[0]["waste_container"]);

        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => StatisticTableScreen()));

        containerName = null;
        fractionName = null;
        numberOfWasteController.clear();
        amountOfFractionController.clear();
        numberOfTransportsController.clear();

      } else {
        snackBar("ntm error - The selected option for Fuel is invalid", false);
        emit(AddToListError());
      }
    } else {
      snackBar("Error to Load Data", false);
      emit(AddToListError());
    }
  }




  void subProjectDropDownList ({
    required String projectId,
    required String orgId
  }) async{

    emit(SubProjectListLoading());

    SubProjectListModel? response = await Repository.postSubProjectList( projectId, orgId );

    if (response != null) {

      if (response.success == true) {

        for(int i = 0; i < response.subProjects!.length; i++ ){
          if(response.subProjects?[i] != null){
            subProjectList.add(
              {
                "name": response.subProjects?[i].subProjectName,
                "id": response.subProjects?[i].id
              },
            );

            print(subProjectList);

          }
        }

        //snackBar("Successfully", true);
        emit(SubProjectListSuccess());

      } else {
        //snackBar("Something Went Wrong", false);
        emit(SubProjectListError());
      }
    } else {
      //snackBar("Error to Load Data", false);
      emit(SubProjectListError());
    }
  }



  void saveStatistic ({
    required String projectId,
    required String wasteListId,
    required String date,
    required String subprojectId,
  }) async{

    emit(SaveStatisticLoading());

    StatisticSaveModel? response = await Repository.saveStatistic(
        projectId: projectId,
       wasteListId: wasteListId,
      wastData: wasteData,
      date: date,
      subProjectId: subprojectId,
    );

    if (response != null) {
      if (response.success == true) {

        snackBar("Successfully", true);
        emit(SaveStatisticSuccess());

        toDate = null;
        idController.clear();
        subProjectName = null;
        subProjectId = null;

      } else {
        snackBar("Something Went Wrong", false);
        emit(SaveStatisticError());
      }
    } else {
      snackBar("Id is in use", false);
      emit(SaveStatisticError());
    }
  }


}