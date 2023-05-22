import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proj_site/api%20service/models/calender_models/package_information_model.dart';
import 'package:proj_site/api%20service/repository.dart';
import 'package:proj_site/common/widget_constant/widget_constant.dart';


abstract class PackageInformationState {}

class PackageInformationInitial extends PackageInformationState {}
class PackageInformationLoading extends PackageInformationState {}
class PackageInformationSuccess extends PackageInformationState {}
class PackageInformationError extends PackageInformationState {}

class PackageInformationCubit extends Cubit<PackageInformationState> {
  PackageInformationCubit() : super(PackageInformationInitial());


List <Information> packageInfo = [];

 Future<void> PackageInformation() async {
    emit(PackageInformationLoading());
    PackageIInformationModel? response = await Repository.postPackageInformation();
    if (response != null) {
      if (response.success == true) {
        packageInfo = [];
        packageInfo = response.data!;
        emit(PackageInformationSuccess());
      } else {
        snackBar("Something Went Wrong", false);
        emit(PackageInformationError());
      }
    } else {
      snackBar("Error to Load Data", false);
      emit(PackageInformationError());
    }
  }

  setState(){
    emit(PackageInformationInitial());
  }

}