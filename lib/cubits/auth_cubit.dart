import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ftx/navigationX.dart';
import 'package:proj_site/api%20service/models/auth_models/profile_details.dart';
import 'package:proj_site/api%20service/models/common_model.dart';
import 'package:proj_site/api%20service/models/auth_models/sign_in_model.dart';
import 'package:proj_site/api%20service/models/update_organization/update_organization.dart' as updateOrganization;
import 'package:proj_site/api%20service/repository.dart';
import 'package:proj_site/common/widget_constant/widget_constant.dart';
import 'package:proj_site/helper/helper.dart';
import 'package:proj_site/services/sharedpreference_service.dart';
import 'package:proj_site/view/createNewPassword.dart';
import 'package:proj_site/view/dashBoard.dart';
import 'package:proj_site/view/signIn.dart';
import 'package:proj_site/view/userVerify.dart';

abstract class AuthState {

}

class AuthInitial extends AuthState {}

class SignInLoading extends AuthState {}
class SignInSuccess extends AuthState {}
class SignInError extends AuthState {}

class ProfileDetailsLoading extends AuthState {}
class ProfileDetailsSuccess extends AuthState {}
class ProfileDetailsError extends AuthState {}

class EditProfileLoading extends AuthState {}
class EditProfileSuccess extends AuthState {}
class EditProfileError extends AuthState {}
class ShowErrorLoading extends AuthState {}

class ForgotPasswordLoading extends AuthState {}
class ForgotPasswordSuccess extends AuthState {}
class ForgotPasswordError extends AuthState {}

class UpdateOrgLoading extends AuthState {}
class UpdateOrgSuccess extends AuthState {}
class UpdateOrgError extends AuthState {}

class UpdatePasswordLoading extends AuthState {}
class UpdatePasswordSuccess extends AuthState {}
class UpdatePasswordError extends AuthState {}

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  UserInfo? userInfoLogin ;

  Role? role;
  ProfileDetailsModel? userInfo;
  List<String> userOrganizationEncoded=[];
  List<UserOrganization> userOrganization=[];
  SharedPreferenceService prefs = SharedPreferenceService();

  void signIn(String email, String password) async {
    emit(SignInLoading());
    SignInModel? response = await Repository.postSignIn(email, password);
    if (response != null) {
      if (response.success == true) {
        role=response.role;
        userOrganization=response.userOrganization!;
        userInfoLogin=response.userInfo;

        String user = jsonEncode(UserInfo.fromJson(response.userInfo!.toJson()));
        String rolle =jsonEncode(Role.fromJson(response.role!.toJson()));

        for(int i=0; i<response.userOrganization!.length;i++){
          String singleUserOrganization = jsonEncode(
              UserOrganization.fromJson(response.userOrganization![i].toJson()));
          userOrganizationEncoded.add(singleUserOrganization);
        }
        prefs.setStringData('userInfo', user);
        prefs.setStringData('userId', response.userInfo!.id!);
        prefs.setStringData('mobile_organization_id', response.userInfo!.mobileOrganizationId!);
        prefs.setStringData('accessToken', response.token!);
        prefs.setListData('userOrganization', userOrganizationEncoded);
        prefs.setStringData('organizationId', response.userOrganization![0].organizationId.toString());
        prefs.setStringData('organizationVal', response.userOrganization![0].organizationName.toString());

        prefs.setStringData('role', rolle);
        accessToken = (await prefs.getStringData("accessToken")).toString();
        orgId = (await prefs.getStringData("organizationId")).toString();
        mobileOrgId = (await prefs.getStringData("mobile_organization_id")).toString();
        orgVal = (await prefs.getStringData("organizationVal")).toString();
        snackBar("Login Successful", true);
        profileDetails(response.userInfo!.id.toString(), response.userInfo!.organizationId.toString());
        Navigation.instance.navigateAndRemoveUntil(DashBoard.id);
        emit(SignInSuccess());
      } else {
        snackBar("Invalid Email or Password", false);
        emit(SignInError());
      }
    } else {
      snackBar("Error to Load Data", false);
      emit(SignInError());
    }
  }

  // void signIn(String email, String password) async {
  //   emit(SignInLoading());
  //   SignInModel? response = await Repository.postSignIn(email, password);
  //   if (response != null) {
  //     if (response.success == true) {
  //       userInfo=response.userInfo;
  //       role=response.role;
  //       userOrganization=response.userOrganization!;
  //       String user = jsonEncode(
  //           UserInfo.fromJson(response.userInfo!.toJson()));
  //
  //       String rolle = jsonEncode(
  //           Role.fromJson(response.role!.toJson()));
  //
  //       for(int i=0; i<response.userOrganization!.length;i++){
  //         String singleUserOrganization = jsonEncode(
  //             UserOrganization.fromJson(response.userOrganization![i].toJson()));
  //         userOrganizationEncoded.add(singleUserOrganization);
  //       }
  //       prefs.setStringData('userInfo', user);
  //       prefs.setStringData('role', rolle);
  //       prefs.setListData('userOrganization', userOrganizationEncoded);
  //       prefs.setStringData('accessToken', response.token!);
  //       snackBar("Login Successful", true);
  //       Navigation.instance.navigateAndRemoveUntil(DashBoard.id);
  //       emit(SignInSuccess());
  //     } else {
  //       snackBar("Invalid Email or Password", false);
  //       emit(SignInError());
  //     }
  //   } else {
  //     snackBar("Error to Load Data", false);
  //     emit(SignInError());
  //   }
  // }

  void profileDetails(String id, String organizationId) async {
    emit(ProfileDetailsLoading());
    userInfo = await Repository.postProfileDetails(id, organizationId);
    if (userInfo != null) {
      if (userInfo!.success == true) {
        emit(ProfileDetailsSuccess());
        log("profileDetails${userInfo}");
      } else {
       // snackBar("Invalid UserName", false);
        emit(ProfileDetailsError());
      }
    } else {
      snackBar("Error to Load Data", false);
      emit(ProfileDetailsError());
    }
  }

  void editProfile(String id, String firstName, String lastName, String phone, String email,bool status) async {
    emit(EditProfileLoading());
    CommonModel? response = await Repository.postEditProfile(id, firstName, lastName, phone, email);
    if (response != null) {
      if (response.success == true) {
        profileDetails(userInfo!.user!.id!, userInfo!.user!.organizationId!);
        log("status${status}");
        if(status==true){
          snackBar("Profile Edit Successfully", true);
        } else{
          snackBar("No change has been made", true);
        }

        emit(EditProfileSuccess());
      } else {
       // snackBar("Invalid UserName", false);
        emit(EditProfileError());
      }
    } else {
      snackBar("Error to Load Data", false);
      emit(EditProfileError());
    }
  }

  void updateOrg(String orgId, String userId) async{
    emit(UpdateOrgLoading());

    updateOrganization.UpdateOrganizationModel? response = await Repository.updateOrganization(orgId, userId);

    if (response != null) {

      if (response.success == true) {

        Map userInfoUp = {
          "_id": response.userInfo!.id,
          "first_name": response.userInfo!.firstName,
          "last_name": response.userInfo!.lastName,
          "email": response.userInfo!.email,
          "organization_id": response.userInfo!.organizationId,
          "updated_at": response.userInfo!.updatedAt.toString(),
          "created_at": response.userInfo!.createdAt.toString(),
          "locale": response.userInfo!.locale,
          "language": response.userInfo!.language,
          "phone": response.userInfo!.phone,
          "role_id": response.userInfo!.roleId,
          "is_forgot_password_intitiated": response.userInfo!.isForgotPasswordIntitiated,
          "user_terminals": response.userInfo!.userTerminals,
          "company_id": response.userInfo!.companyId,
          "mobile_organization_id": response.userInfo!.mobileOrganizationId,
          "user_id": response.userInfo!.userId,
          "has_shipment_module": response.userInfo!.hasShipmentModule,
          "has_logistics_module": response.userInfo!.hasLogisticsModule,
          "projects": response.userInfo!.projects,
          "admin_projects": response.userInfo!.adminProjects,
          "is_admin": response.userInfo!.isAdmin,
          "is_project_admin": response.userInfo!.isProjectAdmin
        };

       userInfoUpdate = userInfoUp;

       print(userInfoUpdate);
        snackBar("Organization change successfully", true);

        emit(UpdateOrgSuccess());
      } else {
        emit(UpdateOrgError());
      }
    } else {
      snackBar("Error to Load Data", false);
      emit(UpdateOrgError());
    }
  }

  void forgotPassword(String email) async {
    emit(ForgotPasswordLoading());
    CommonModel? response = await Repository.postForgotPassword(email);
    if (response != null) {
      if (response.success == true) {
        snackBar("Change Password Link Sent to Your Email", true);
        Navigation.instance.navigateAndRemoveUntil(SignIn.id);
        emit(ForgotPasswordSuccess());
      } else {
        snackBar("Invalid UserName", false);
        emit(ForgotPasswordError());
      }
    } else {
      snackBar("Error to Load Data", false);
      emit(ForgotPasswordError());
    }
  }

  void updatePassword(String password,String userId) async {
    emit(UpdatePasswordLoading());
    CommonModel? response = await Repository.postUpdatePassword(password,userId);
    if (response != null) {
      if (response.success == true) {
        snackBar("Password Updated Successfully", true);
        prefs.remove("userInfo");
        prefs.remove("userId");
        prefs.remove("role");
        prefs.remove("userOrganization");
        prefs.remove("accessToken");
        prefs.remove("organizationId");
        prefs.remove("organizationVal");
        Navigation.instance.navigateAndRemoveUntil(SignIn.id);
        emit(UpdatePasswordSuccess());
      } else {
        snackBar("Try Again", false);
        emit(UpdatePasswordError());
      }
    } else {
      snackBar("Error to Load Data", false);
      emit(UpdatePasswordError());
    }
  }

  List<Map<String,dynamic>> showError(String firstnameText,String lastNameText,String phoneText,String emailText,BuildContext context,String controllersText){

    emit(ShowErrorLoading());

    List<Map<String,dynamic>> status =[
      {"All":false},
      {"firstName":false},
      {"phone":false},
      {"phoneLength":false},
    ];

    if(firstnameText != "" && phoneText == "" && phoneText.length >= 10){


      return status;
    }
    else{

      if(firstnameText == "")
      {
        return [
          {"All":false},
          {"firstName":true},
          {"phone":false},
          {"phoneLength":false},
        ];

      }
      else
      {

        if(phoneText == "")
        {
          return [
            {"All":false},
            {"firstName":false},
            {"phone":true},
            {"phoneLength":false},
          ];

        }
        else
        {

          if(phoneText.length < 10)
          {
            return  [
              {"All":false},
              {"firstName":false},
              {"phone":false},
              {"phoneLength":true},
            ];
          }
          else
          {
            return   [
              {"All":false},
              {"firstName":false},
              {"phone":false},
              {"phoneLength":false},
            ];;
          }

        }


      }


    }
  }

}