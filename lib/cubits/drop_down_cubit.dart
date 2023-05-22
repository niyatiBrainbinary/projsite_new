import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proj_site/api%20service/models/calender_models/filter_status_model.dart';
import 'package:proj_site/api%20service/models/calender_models/filter_transport_type_model.dart';
import 'package:proj_site/api%20service/models/calender_models/resource_list_model.dart';
import 'package:proj_site/api%20service/models/calender_models/user_list_model.dart';
import 'package:proj_site/api%20service/models/calender_models/zone_list_model.dart';
import 'package:proj_site/api%20service/models/logistic_list_models/organizations_model.dart';
import 'package:proj_site/api%20service/repository.dart';
import 'package:proj_site/common/widget_constant/widget_constant.dart';

import '../api service/models/logistic_list_models/user_sub_project_list_model.dart';


abstract class DropDownState {}

class DropDownInitial extends DropDownState {}

class ResourceListLoading extends DropDownState {}
class ResourceListSuccess extends DropDownState {}
class ResourceListError extends DropDownState {}

class ZoneListLoading extends DropDownState {}
class ZoneListSuccess extends DropDownState {}
class ZoneListError extends DropDownState {}

class UserListLoading extends DropDownState {}
class UserListSuccess extends DropDownState {}
class UserListError extends DropDownState {}

class OrganizationsLoading extends DropDownState {}
class OrganizationsSuccess extends DropDownState {}
class OrganizationsError extends DropDownState {}

class UserSubProjectListLoading extends DropDownState {}
class UserSubProjectListSuccess extends DropDownState {}
class UserSubProjectListError extends DropDownState {}

class FilterStatusLoading extends DropDownState {}
class FilterStatusSuccess extends DropDownState {}
class FilterStatusError extends DropDownState {}

class FilterTransportTypeLoading extends DropDownState {}
class FilterTransportTypeSuccess extends DropDownState {}
class FilterTransportTypeError extends DropDownState {}

class DropDownCubit extends Cubit<DropDownState> {
  DropDownCubit() : super(DropDownInitial());

  List<String> contractor = ["1", "2", "3"];

  List<String> person1 = ["rtgs", "ergs", "rtert"];

  List<String> person2 = ["gdg", "dgf", "rgt"];

  List<String> person3 = ["dsfd", "rttfg", "dfgg"];

  ResourceListModel? resourceListData;
  ZoneListModel? zoneListData;
  UserListModel? userListData;

  List<String> resourcesName = [];
  List resourcesId = [];

  List<String> zoneName = [];
  List zoneId = [];
  List zoneColor = [];
  List<String> userName = [];
  List userId = [];
  List<SubProject>? subProjects;
  List<UserSubProject>? userSubProjects;
  List<String> enterpreneurs = [];
  List<CompanyList>? companyList;
  List<String> organization = [];
  String organizationCompanyId = "";
  String selectedSubProject="";
  String selectedEnterpreneurs="";
  List<String> statusList = [];
  List<String> transportTypeList = [];


  void resourcesList(String projectId, String organizationId) async {
    emit(ResourceListLoading());
    resourceListData =
    await Repository.postResourcesList(projectId,organizationId);
    if (resourceListData != null) {
      if (resourceListData!.success == true) {
         resourcesName = [];
         resourcesId = [];
        for (int i = 0; i < resourceListData!.resources!.length; i++) {
          resourcesName.add(resourceListData!.resources![i].resourceName);
          resourcesId.add(resourceListData!.resources![i].id);
        }
         zoneList(projectId,organizationId);

        emit(ResourceListSuccess());
      } else {
        snackBar("Something Went Wrong", false);
        emit(ResourceListError());
      }
    } else {
      snackBar("Error to Load Data", false);
      emit(ResourceListError());
    }
  }

  void zoneList(String projectId, String organizationId) async {
    emit(ZoneListLoading());
     zoneListData = await Repository.postZoneList(projectId,organizationId);
    if (zoneListData != null) {
      if (zoneListData!.success == true) {
        zoneName = [];
        zoneId =[];
        zoneColor=[];
        for (int i = 0; i < zoneListData!.unloadingZones!.length; i++) {
          zoneName.add(zoneListData!.unloadingZones![i].unloadingZoneName!);
          zoneId.add(zoneListData!.unloadingZones![i].id);
          String abc= zoneListData!.unloadingZones![i].zoneColor!.split("(").last.split(")").first;
          List a= abc.split(", ");
          zoneColor.add([a[0],a[1],a[2]]);

        }
        emit(ZoneListSuccess());
      } else {
        snackBar("Something Went Wrong", false);
        emit(ZoneListError());
      }
    } else {
      snackBar("Error to Load Data", false);
      emit(ZoneListError());
    }
  }

   userList(String projectId, String organizationId, String comapnyId) async {
    emit(UserListLoading());
    userName = [];
    userId = [];
    userListData = await Repository.postUserList(projectId,organizationId, comapnyId);
    if (userListData != null) {
      if (userListData!.success == true) {
        for (int i = 0; i < userListData!.users!.length; i++) {
          if(organizationCompanyId == userListData!.users![i].companyName){
            userName.add("${userListData!.users?[i].firstName ?? ""} ${userListData?.users?[i].lastName ?? ""}");
            userId.add("${userListData!.users?[i].userId ?? ""}");
          }
        }
        emit(UserListSuccess());
      } else {
        snackBar("Something Went Wrong", false);
        emit(UserListError());
      }
    } else {
      snackBar("Error to Load Data", false);
      emit(UserListError());
    }
  }

  void Organizations({required String organization_id}) async {
    emit(OrganizationsLoading());
    OrganizationsModel? response = await Repository.postOrganizations(organization_id: organization_id);
    if (response != null) {
      if (response.success == true) {
        organization = [];

        companyList = response.companyList;
        for (int i = 0; i < companyList!.length; i++) {
          organization.add(companyList![i].companyName);
        }
        selectedSubProject = organization[0];
        //  UserSubProjectList();
        emit(OrganizationsSuccess());
      } else {
        snackBar("Something Went Wrong", false);
        emit(OrganizationsError());
      }
    } else {
      snackBar("Error to Load Data", false);
      emit(OrganizationsError());
    }
  }

  void UserSubProjectList({required String user_id,required String project_id,required String organization_id}) async {
    emit(UserSubProjectListLoading());
    UserSubProjectListModel? response =
    await Repository.postUserSubProjectList(user_id: user_id, project_id: project_id, organization_id: organization_id);
    if (response != null) {
      if (response.success == true) {
        subProjects = [];
        userSubProjects = [];
        enterpreneurs = [];
        subProjects = response.subProjects;
        userSubProjects = response.userSubProjects;

        for (int i = 0; i < subProjects!.length; i++) {
          enterpreneurs.add(subProjects![i].subProjectName);
        }
        selectedEnterpreneurs = enterpreneurs[0];
        emit(UserSubProjectListSuccess());
      } else {
        snackBar("Something Went Wrong", false);
        emit(UserSubProjectListError());
      }
    } else {
      snackBar("Error to Load Data", false);
      emit(UserSubProjectListError());
    }
  }

  void filterStatus(String id) async {
    emit(FilterStatusLoading());
    List response =
    (await Repository.postFilterStatus(id))!;
    if (response.isNotEmpty) {
      statusList=[];
      for (int i = 0; i < response.length; i++) {
        statusList.add(response[i].toString());
      }
      emit(FilterStatusSuccess());
    } else {
      snackBar("Something Went Wrong", false);
      emit(FilterStatusError());
    }
  }

  void filterTransportType(String id) async {
    emit(FilterTransportTypeLoading());
    List response =
    (await Repository.postFilterTransportType(id))!;
      if (response.isNotEmpty) {
        transportTypeList=[];
        for (int i = 0; i < response.length; i++) {
          transportTypeList.add(response[i].toString());
        }
        emit(FilterTransportTypeSuccess());
      } else {
        snackBar("Something Went Wrong", false);
        emit(FilterTransportTypeError());
      }
  }
}