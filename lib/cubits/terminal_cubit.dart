
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proj_site/api%20service/models/common_model.dart';
import 'package:proj_site/api%20service/models/shipment_models/add_shipment_model.dart';
import 'package:proj_site/api%20service/models/shipment_models/update_shipment_model.dart';
import 'package:proj_site/api%20service/models/terminal_models/terminal_list_model.dart';
import 'package:proj_site/api%20service/models/terminal_models/update_terminal_model.dart';
import 'package:proj_site/api%20service/repository.dart';
import 'package:proj_site/common/widget_constant/widget_constant.dart';

import '../api service/models/terminal_models/add_terminal_model.dart';


abstract class TerminalState {}

class Terminal extends TerminalState {}

class AddTerminalLoading extends TerminalState {}
class AddTerminalSuccess extends TerminalState {}
class AddTerminalError extends TerminalState {}

class UpdateTerminalLoading extends TerminalState {}
class UpdateTerminalSuccess extends TerminalState {}
class UpdateTerminalError extends TerminalState {}

class CloseTerminalLoading extends TerminalState {}
class CloseTerminalSuccess extends TerminalState {}
class CloseTerminalError extends TerminalState {}

class TerminalListLoading extends TerminalState {}
class TerminalListSuccess extends TerminalState {}
class TerminalListError extends TerminalState {}

class UpdateTerminalStatusLoading extends TerminalState {}
class UpdateTerminalStatusSuccess extends TerminalState {}
class UpdateTerminalStatusError extends TerminalState {}

class TerminalCubit extends Cubit<TerminalState> {
  TerminalCubit() : super(Terminal());

  List<TerminalListModel>? terminalList;

  void AddTerminal(Map body,BuildContext context) async {
    emit(AddTerminalLoading());
    AddTerminalModel? response = await Repository.postAddTerminal(body);
    if (response != null) {
      if (response.success == true) {
        snackBar("Terminal created successfully.", true);
        Navigator.pop(context);
        Navigator.pop(context,"Success");
        emit(AddTerminalSuccess());
      } else {
        snackBar("Something Went Wrong", false);
        emit(AddTerminalError());
      }
    } else {
      snackBar("Error to Load Data", false);
      emit(AddTerminalError());
    }
  }


  void UpdateTerminal(Map finalMap,BuildContext context, bool statusUpdated) async {
    emit(UpdateTerminalLoading());

    UpdateTerminalModel? response = await Repository.postUpdateTerminal(finalMap);


    if (response != null) {
      if (response.success == true) {
        if(statusUpdated == false)
        {

          snackBar("Terminal Update Successfully", true);
        }
        else
        {
          snackBar("No change has been made", true);

        }

        Navigator.of(context)..pop()..pop();
        Navigator.pop(context,"Success");
        emit(UpdateTerminalSuccess());
      } else {
        snackBar("Something Went Wrong", false);
        emit(UpdateTerminalSuccess());
      }
    } else {
      snackBar("Error to Load Data", false);
      emit(UpdateTerminalSuccess());
    }
  }

  void CloseTerminal(BuildContext context,String requestId) async {
    emit(CloseTerminalLoading());

    CommonModel? response = await Repository.postCloseTerminal(requestId);

    if (response != null) {
      if (response.success == true) {
        snackBar("Request closed successfully", true);
        Navigator.pop(context);
        Navigator.pop(context,"Success");
        emit(CloseTerminalSuccess());
      } else {
        snackBar("Something Went Wrong", false);
        emit(CloseTerminalError());
      }
    } else {
      snackBar("Error to Load Data", false);
      emit(CloseTerminalError());
    }
  }

  void TerminalList(String projectId) async {
    emit(TerminalListLoading());
    terminalList = await Repository.postTerminalList(projectId);
    if (terminalList != null) {
      emit(TerminalListSuccess());
    } else {
      snackBar("Error to Load Data", false);
      emit(TerminalListError());
    }
  }

  void UpdateTerminalStatus(String requestId, String transportStatus,BuildContext context) async {
    emit(UpdateTerminalStatusLoading());

    CommonModel? response = await Repository.postUpdateTerminalStatus(requestId,transportStatus);

    if (response != null) {
      if (response.success == true) {
        Navigator.pop(context);
        Navigator.pop(context,"Success");
        snackBar("Success", true);
        emit(UpdateTerminalStatusSuccess());
      } else {
        snackBar("Something Went Wrong", false);
        emit(UpdateTerminalStatusError());
      }
    } else {
      snackBar("Error to Load Data", false);
      emit(UpdateTerminalStatusError());
    }
  }

}