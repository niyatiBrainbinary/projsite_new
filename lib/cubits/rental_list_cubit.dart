import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ftx/navigationX.dart';
import 'package:image_picker/image_picker.dart';
import 'package:proj_site/api%20service/models/logistic_list_models/logistic_list_model.dart';
import 'package:proj_site/api%20service/models/rental_list_models/add_rental_model.dart';
import 'package:proj_site/api%20service/models/rental_list_models/delete_rental_model.dart';
import 'package:proj_site/api%20service/models/rental_list_models/rental_list_model.dart';
import 'package:proj_site/api%20service/models/rental_list_models/rental_list_model.dart';
import 'package:proj_site/api%20service/models/rental_list_models/update_rental_model.dart';
import 'package:proj_site/api%20service/repository.dart';
import 'package:proj_site/common/widget_constant/widget_constant.dart';
import 'package:proj_site/cubits/auth_cubit.dart';
import 'package:proj_site/helper/helper.dart';
import 'package:proj_site/view/rentalList/rentalList.dart';
import 'package:proj_site/view/rentalList/rentalMainPage.dart';

abstract class RentalListState {}

class RentalInitial extends RentalListState {}

class RentalLoading extends RentalListState {}

class RentalSuccess extends RentalListState {}

class RentalError extends RentalListState {}

class UpdateRentalLoading extends RentalListState {}

class UpdateRentalSuccess extends RentalListState {}

class UpdateRentalError extends RentalListState {}

class DeleteRentalLoading extends RentalListState {}

class DeleteRentalSuccess extends RentalListState {}

class DeleteRentalError extends RentalListState {}

class AddRentalLoading extends RentalListState {}

class AddRentalSuccess extends RentalListState {}

class AddRentalError extends RentalListState {}

class RentalListCubit extends Cubit<RentalListState> {
  RentalListCubit() : super(RentalInitial());

  XFile? photo1;
  XFile? photo2;
  List<RentalData> rentalList = [];

  setState() {
    emit(RentalInitial());
  }

  void RentalListData({required String projectId}) async {
    emit(RentalLoading());
    RentalListModel? response =
        await Repository.postRental(projectId: projectId);
    if (response != null) {
      if (response.success == true) {
        rentalList = [];
        rentalList = response.rentalList!;
        // log("rentalListData${response.rentalList![0].itemImage
        // }");
        emit(RentalSuccess());
      } else {
        snackBar("Something Went Wrong", false);
        emit(RentalError());
      }
    } else {
      snackBar("Error to Load Data", false);
      emit(RentalError());
    }
  }

  void UpdateRental({
    required String rental_id,
    required String vendor_name,
    required String item_name,
    required String arrival_date,
    required String due_date,
    required String quantity,
    required String description,
    required String api,
     File? file,
    required BuildContext context,
  }) async {
    emit(UpdateRentalLoading());
    UpdateRentalModel? response = await Repository.postUpdateRental(
        rental_id: rental_id,
        vendor_name: vendor_name,
        item_name: item_name,
        arrival_date: arrival_date,
        due_date: due_date,
        quantity: quantity,
        api: api,
        description: description,
        file: file);
    if (response != null) {
      if (response.success == true) {
        RentalListData(
            projectId: projectIdMain);
        Navigation.instance.goBack();
        snackBar("Rental Information Updated", true);
        emit(UpdateRentalSuccess());
      } else {
        snackBar("Something Went Wrong", false);
        emit(UpdateRentalError());
      }
    } else {
      snackBar("Error to Load Data", false);
      emit(UpdateRentalError());
    }
  }

  void DeleteRental(String rentalId, BuildContext context) async {
    emit(DeleteRentalLoading());
    DeleteRentalModel? response = await Repository.postDeleteRental(rentalId);
    if (response != null) {
      if (response.success == true) {
        RentalListData(
            projectId: projectIdMain);
        Navigation.instance.goBack();
        snackBar("Rental Deleted", true);
        emit(DeleteRentalSuccess());
      } else {
        snackBar("Something Went Wrong", false);
        emit(DeleteRentalError());
      }
    } else {
      snackBar("Error to Load Data", false);
      emit(DeleteRentalError());
    }
  }

  void AddRental({
    required BuildContext context,
    required String project_id,
    required String organization_id,
    required String vendor_name,
    required String item_name,
    required String arrival_date,
    required String due_date,
    required String quantity,
    required String description,
    required String created_by,
    required String Image,
    required String api,
  }) async {
    emit(AddRentalLoading());
    AddRentalModel? response = await Repository.postAddRental(
        project_id: project_id,
        organization_id: organization_id,
        vendor_name: vendor_name,
        item_name: item_name,
        arrival_date: arrival_date,
        due_date: due_date,
        quantity: quantity,
        description: description,
        created_by: created_by,
        Image: Image,
        api: api);
    if (response != null) {
      if (response.success == true) {
        snackBar("New Rental Added", true);
        //Navigation.instance.goBack();
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => RentalMainPage()));
        emit(AddRentalSuccess());
      } else {
        snackBar("Something Went Wrong", false);
        emit(AddRentalError());
      }
    } else {
      snackBar("Error to Load Data", false);
      emit(AddRentalError());
    }
  }
}
