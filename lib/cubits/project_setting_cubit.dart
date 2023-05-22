
import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proj_site/api%20service/models/project_setting_models/get_booking_form_model.dart';
import 'package:proj_site/api%20service/models/project_setting_models/save_booking_form_model.dart';
import 'package:proj_site/api%20service/repository.dart';
import 'package:proj_site/common/widget_constant/widget_constant.dart';


abstract class ProjectSettingState {}

class ProjectSettingInitial extends ProjectSettingState {}

class BookingFormNotificationLoading extends ProjectSettingState {}
class BookingFormNotificationSuccess extends ProjectSettingState {}
class BookingFormNotificationError extends ProjectSettingState {}

class ProjectSettingCubit extends Cubit<ProjectSettingState> {
  ProjectSettingCubit() : super(ProjectSettingInitial());


  setState(){
    emit(ProjectSettingInitial());
  }
List? shipmentData;
List? environmentData;
bool zone = false;
bool auto = false;
bool waste = false;
bool isMail = false;
bool isSms = false;
String? id;

  void GetBookingFormNotification(String projectId) async {
    emit(BookingFormNotificationLoading());
    GetBookingFormModel? response = await Repository.postBookingFormNotification(projectId);

    if (response != null) {
      if (response.success == true) {

        id = response.projectInfo?.id ?? "";

       final data = response.projectInfo?.projectSettings;
       final data2 = response.projectInfo?.mailSmsSettings;

       if(data !=null){
       /*  shipmentData=
         [
           data['resource'] == "true" ? true : false,
           data['zone'] == "true" ? true : false,
           data['contractor'] == "true" ? true : false,
           data['responsible_person'] == "true" ? true : false,
           data['sub_project'] == "true" ? true : false,
         ];
         environmentData= [
           data['delivery_supplier'] == "true" ? true : false,
           data['euro_class'] == "true" ? true : false,
           data['type_of_fuel'] == "true" ? true : false,
           data['load_weight'] == "true" ? true : false,
           data['vehicle_capacity'] == "true" ? true : false,
           data['driving_distance'] == "true" ? true : false,
           data['addresses'] == "true" ? true : false,
           data['Type of Vehicle'] == "true" ? true : false
         ];

         zone = data['zone'] == "true" ? true : false;
         auto = data['auto_approval'] == "true" ? true : false;
         waste = data['waste_disposal'] == "true" ? true : false;
*/

         shipmentData=
         [
           data['resource'],
           data['zone'],
           data['contractor'] ,
           data['responsible_person'] ,
           data['sub_project'] ,
         ];
         environmentData= [
           data['delivery_supplier'],
           data['euro_class'],
           data['type_of_fuel'] ,
           data['load_weight'],
           data['vehicle_capacity'],
           data['driving_distance'],
           data['addresses'],
           data['type_of_vehicle']
         ];

         zone = data['zones_simultaneously'] ?? false;
         auto = data['auto_approval'] ?? false;
         waste = data['waste_disposal'] ?? false;

      /*   shipmentData=
         [
           data.resource,
           data.zone,
           data.contractor,
           data.responsiblePerson,
           data.subProject,
         ];
         environmentData= [
           data.deliverySupplier,
           data.euroClass,
           data.typeOfFuel,
           data.loadWeight,
           data.vehicleCapacity,
           data.drivingDistance,
           data.addresses == "true" ? true : false,
           data.typeOfVehicle
         ];

         zone = data.zone ?? false;
         auto = data.autoApproval ?? false;
         waste = data.wasteDisposal ?? false;*/

         isMail = data2?.mail ?? false;
         isSms = data2?.sms ?? false;

       }
        emit(BookingFormNotificationSuccess());
      } else {
        snackBar("Something Went Wrong", false);
        emit(BookingFormNotificationError());
      }
    } else {
      snackBar("Error to Load Data", false);
      emit(BookingFormNotificationError());
    }
  }


  void SaveBookingFormNotification({
    required String type,
    required String id,
    List<dynamic>? shipment,
     List<dynamic>? environment,
  }) async {
    emit(BookingFormNotificationLoading());
    SaveBookingFormModel? response = await Repository.postSaveBookingFormNotification(
      type: type,
      id: id,
        shipment: shipment ?? [],
        environment:environment ?? [],


    );
    if (response != null) {
      if (response.success == 1) {

        emit(BookingFormNotificationSuccess());
      } else {
        snackBar("Something Went Wrong", false);
        emit(BookingFormNotificationError());
      }
    } else {
      snackBar("Error to Load Data", false);
      emit(BookingFormNotificationError());
    }
  }


  void SaveCalender({
    required String type,
    required String id,
    bool? zone,
    bool? auto,
    bool? waste,
  }) async {
    emit(BookingFormNotificationLoading());
    SaveBookingFormModel? response = await Repository.postSaveCalender(
      type: type,
      id: id,
      zone: zone ?? false,
      auto: auto ?? false,
      waste: waste ?? false,

    );
    if (response != null) {
      if (response.success == 1) {

        emit(BookingFormNotificationSuccess());
      } else {
        snackBar("Something Went Wrong", false);
        emit(BookingFormNotificationError());
      }
    } else {
      snackBar("Error to Load Data", false);
      emit(BookingFormNotificationError());
    }
  }


  void SaveNotification({
    required String type,
    required String id,
    bool? mail,
    bool? sms,
  }) async {
    emit(BookingFormNotificationLoading());
    SaveBookingFormModel? response = await Repository.postSaveNotification(
      type: type,
      id: id,
      mail: mail ?? false,
      sms: sms ?? false
    );
    if (response != null) {
      if (response.success == 1) {

        emit(BookingFormNotificationSuccess());
      } else {
        snackBar("Something Went Wrong", false);
        emit(BookingFormNotificationError());
      }
    } else {
      snackBar("Error to Load Data", false);
      emit(BookingFormNotificationError());
    }
  }


}