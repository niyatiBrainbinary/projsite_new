
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:proj_site/api%20service/models/apd_plan_models/apdPlan_model.dart';
import 'package:proj_site/api%20service/models/apd_plan_models/delete_apdPlan_model.dart';
import 'package:proj_site/api%20service/models/profile_setting_models/edit_notification_model.dart';
import 'package:proj_site/api%20service/models/profile_setting_models/notification_model.dart';
import 'package:proj_site/api%20service/models/rental_list_models/add_rental_model.dart';
import 'package:proj_site/api%20service/models/rental_list_models/delete_rental_model.dart';
import 'package:proj_site/api%20service/models/rental_list_models/rental_list_model.dart';
import 'package:proj_site/api%20service/models/rental_list_models/update_rental_model.dart';
import 'package:proj_site/api%20service/repository.dart';
import 'package:proj_site/common/widget_constant/widget_constant.dart';


abstract class ProfileSettingState {}

class ProfileSettingInitial extends ProfileSettingState {}

class NotificationLoading extends ProfileSettingState {}
class NotificationSuccess extends ProfileSettingState {}
class NotificationError extends ProfileSettingState {}

class EditNotificationLoading extends ProfileSettingState {}
class EditNotificationSuccess extends ProfileSettingState {}
class EditNotificationError extends ProfileSettingState {}



class ProfileSettingCubit extends Cubit<ProfileSettingState> {
  ProfileSettingCubit() : super(ProfileSettingInitial());


  setState(){
    emit(ProfileSettingInitial());
  }

   bool? email;
  bool? sms;

  void GetNotification() async {
    emit(NotificationLoading());
    NotificationModel? response = await Repository.postNotification();

    if (response != null) {
      if (response.success == true) {

       email = response.account!.emailNotify;
       sms = response.account!.smsNotify;
        emit(NotificationSuccess());
      } else {
        snackBar("Something Went Wrong", false);
        emit(NotificationError());
      }
    } else {
      snackBar("Error to Load Data", false);
      emit(NotificationError());
    }
  }

  void EditNotification({required String email_notify,required String sms_notify}) async {
    emit(EditNotificationLoading());
    EditNotificationModel? response = await Repository.postEditNotification(email_notify:email_notify,sms_notify: sms_notify);
    if (response != null) {
      if (response.success == true) {
        emit(EditNotificationSuccess());
      } else {
        snackBar("Something Went Wrong", false);
        emit(EditNotificationError());
      }
    } else {
      snackBar("Error to Load Data", false);
      emit(EditNotificationError());
    }
  }


}