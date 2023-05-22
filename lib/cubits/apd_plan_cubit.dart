
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proj_site/api%20service/models/apd_plan_models/apdPlan_model.dart';
import 'package:proj_site/api%20service/models/apd_plan_models/delete_apdPlan_model.dart';
import 'package:proj_site/api%20service/models/common_model.dart';
import 'package:proj_site/api%20service/repository.dart';
import 'package:proj_site/common/widget_constant/widget_constant.dart';
import 'package:proj_site/helper/helper.dart';
import 'package:proj_site/view/apdPlan/apdPlanMainPage.dart';


abstract class ApdPlanState {}

class ApdPlanInitial extends ApdPlanState {}

class ApdPlanLoading extends ApdPlanState {}
class ApdPlanSuccess extends ApdPlanState {}
class ApdPlanError extends ApdPlanState {}

class DeleteApdPlanLoading extends ApdPlanState {}
class DeleteApdPlanSuccess extends ApdPlanState {}
class DeleteApdPlanError extends ApdPlanState {}

class UploadApdPlanLoading extends ApdPlanState {}
class UploadApdPlanSuccess extends ApdPlanState {}
class UploadApdPlanError extends ApdPlanState {}


class ApdPlanCubit extends Cubit<ApdPlanState> {
  ApdPlanCubit() : super(ApdPlanInitial());




List<Result> ApdPlanList = [];

  void ApdPlan({required String projectId}) async {
    emit(ApdPlanLoading());
    ApdPlanModel? response = await Repository.postApdPlan(projectId: projectId);
    if (response != null) {
      if (response.success == true) {
        ApdPlanList = [];
        ApdPlanList = response.result;
        emit(ApdPlanSuccess());
      } else {
        snackBar("Something Went Wrong", false);
        emit(ApdPlanError());
      }
    } else {
      snackBar("Error to Load Data", false);
      emit(ApdPlanError());
    }
  }

  void DeleteApdPlan({required BuildContext context,required String id}) async {
    emit(DeleteApdPlanLoading());
    DeleteApdPlanModel? response = await Repository.postDeleteApdPlan(id: id);
    if (response != null) {
      if (response.success == true) {
        ApdPlan(projectId: projectIdMain);
        Navigator.pop(context);
        snackBar("Successfully", true);
        emit(DeleteApdPlanSuccess());
      } else {
        snackBar("Something Went Wrong", false);
        emit(DeleteApdPlanError());
      }
    } else {
      snackBar("Error to Load Data", false);
      emit(DeleteApdPlanError());
    }
  }

  Future<CommonModel?> UploadApdPlan({required String apd_file_name,required File file,required String project_id, required BuildContext context}) async {


     emit(UploadApdPlanLoading());
    CommonModel? response = await Repository.postUploadApdPlan(apd_file_name: apd_file_name, file: file, project_id: project_id,);
    if (response != null) {
      if (response.success == true) {
        snackBar("Successfully", true);
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => ApdPlanMainPage()));
        emit(UploadApdPlanSuccess());
      } else {
        snackBar("Something Went Wrong", false);
        emit(UploadApdPlanError());
      }
    } else {
      snackBar("Error to Load Data", false);
      emit(UploadApdPlanError());
    }


  }


}