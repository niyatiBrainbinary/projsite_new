

import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:proj_site/api%20service/models/project_list_models/project_details_model.dart';
import 'package:proj_site/api%20service/models/project_list_models/project_list_model.dart';
import 'package:proj_site/api%20service/repository.dart';
import 'package:proj_site/common/widget_constant/widget_constant.dart';
import 'package:proj_site/cubits/auth_cubit.dart';
import 'package:proj_site/helper/helper.dart';
import 'package:proj_site/services/sharedpreference_service.dart';


abstract class ProjectListState {}

class ProjectListInitial extends ProjectListState {}

class ProjectListLoading extends ProjectListState {}
class ProjectListSuccess extends ProjectListState {}
class ProjectListError extends ProjectListState {}

class ProjectDetailsLoading extends ProjectListState {}
class ProjectDetailsSuccess extends ProjectListState {}
class ProjectDetailsError extends ProjectListState {}

class ProjectListCubit extends Cubit<ProjectListState> {
  ProjectListCubit() : super(ProjectListInitial());

  setState(){
    emit(ProjectListInitial());
  }
List <Organization> organization = [];
List <ProjectsList> projectsList = [];
ProjectDetailsModel? projectDetails;
SharedPreferenceService prefs = SharedPreferenceService();
late AuthCubit authCub;

  void ProjectList(String projectId, Map userInfo, BuildContext context) async {
    emit(ProjectListLoading());
   // orgId = (await prefs.getStringData("organizationId")).toString();
   //  orgVal = (await prefs.getStringData("organizationVal")).toString();


  if(userInfoUpdate != null){
    userInfo = userInfoUpdate!;
  }

    ProjectListModel? response = await Repository.postProjectList(projectId,userInfo);

    if (response != null) {
      if (response.success == true) {
        organization = [];
        projectsList = [];
        organization = response.organizations!;
        projectsList = response.projectsList!;
        emit(ProjectListSuccess());
      } else {
        snackBar("Something Went Wrong", false);
        emit(ProjectListError());
      }
    } else {
      snackBar("Error to Load Data", false);
      emit(ProjectListError());
    }

  }

  void ProjectDetails(String projectId) async {
    emit(ProjectDetailsLoading());
     projectDetails = await Repository.postProjectDetails(projectId);

    if (projectDetails != null) {
      if (projectDetails!.success == true) {
        emit(ProjectDetailsSuccess());
      } else {
        snackBar("Something Went Wrong", false);
        emit(ProjectDetailsError());
      }
    } else {
      snackBar("Error to Load Data", false);
      emit(ProjectDetailsError());
    }
  }

}