

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:proj_site/api%20service/models/project_list_models/project_details_model.dart';
import 'package:proj_site/api%20service/models/project_list_models/project_list_model.dart';
import 'package:proj_site/api%20service/models/sub_project_models/add_new_sub_project.dart';
import 'package:proj_site/api%20service/models/sub_project_models/sub_project_list_model.dart';
import 'package:proj_site/api%20service/repository.dart';
import 'package:proj_site/common/widget_constant/widget_constant.dart';
import 'package:proj_site/cubits/auth_cubit.dart';
import 'package:proj_site/helper/helper.dart';
import 'package:proj_site/services/sharedpreference_service.dart';


abstract class SubProjectListState {}

class SubProjectListInitial extends SubProjectListState {}

class SubProjectListLoading extends SubProjectListState {}
class SubProjectListSuccess extends SubProjectListState {}
class SubProjectListError extends SubProjectListState {}

class AddSubProjectLoading extends SubProjectListState {}
class AddSubProjectSuccess extends SubProjectListState {}
class AddSubProjectError extends SubProjectListState {}

class SubProjectListCubit extends Cubit<SubProjectListState> {
  SubProjectListCubit() : super(SubProjectListInitial());

  setState(){
    emit(SubProjectListInitial());
  }
  List <Organization> organization = [];
  List <SubProject> subProjectList = [];
  //ProjectDetailsModel? projectDetails;
  SharedPreferenceService prefs = SharedPreferenceService();
  late AuthCubit authCub;

  void SubProjectList(String projectId, String orgId, BuildContext context) async {
    emit(SubProjectListLoading());
     orgId = (await prefs.getStringData("organizationId")).toString();
    //  orgVal = (await prefs.getStringData("organizationVal")).toString();


    SubProjectListModel? response = await Repository.postSubProjectList(projectId,orgId);

    if (response != null) {
      if (response.success == true) {
        //organization = [];
        subProjectList = [];
        //organization = response.organizations!;
        subProjectList = response.subProjects!;
        emit(SubProjectListSuccess());
      } else {
        snackBar("Something Went Wrong", false);
        emit(SubProjectListError());
      }
    } else {
      //snackBar("Error to Load Data", false);
      emit(SubProjectListError());
    }

  }

  void AddSubProject({
    required BuildContext context,
    required String orgId,
    required String projectId,
    required String subProjectName
  })
  async {

    emit(AddSubProjectLoading());

    AddNewSubProjectModel? response = await Repository.postAddSubProject(orgId: orgId, projectId: projectId, name: subProjectName);

    if (response != null) {
      if (response.success == true) {

       SubProjectList(projectId, orgId, context);

        Navigator.of(context).pop();

        snackBar("Successfully", true);
        emit(AddSubProjectSuccess());

      } else {
        snackBar("Something Went Wrong", false);
        emit(AddSubProjectError());
      }
    } else {
      snackBar("Error to Load Data", false);
      emit(AddSubProjectError());
    }
  }


}