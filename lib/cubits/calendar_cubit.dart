import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proj_site/api%20service/models/calender_models/event_list_model.dart';
import 'package:proj_site/api%20service/models/shipment_models/request_data_model.dart';
import 'package:proj_site/api%20service/repository.dart';
import 'package:proj_site/common/colors/colors.dart';
import 'package:proj_site/common/widget_constant/widget_constant.dart';
import 'package:proj_site/model/event.dart';
import 'package:proj_site/src/calendar_event_data.dart';

abstract class CalendarState {}

class CalendarInitial extends CalendarState {}

class CalendarLoading extends CalendarState {}

class CalendarSuccess extends CalendarState {}

class CalendarError extends CalendarState {}

class EventListLoading extends CalendarState {}

class EventListSuccess extends CalendarState {}

class EventListError extends CalendarState {}

class RequestDataLoading extends CalendarState {}

class RequestDataSuccess extends CalendarState {}

class RequestDataError extends CalendarState {}

class CalendarCubit extends Cubit<CalendarState> {
  CalendarCubit() : super(CalendarInitial());

  bool status = false;
  DateTime projectDate = DateTime.now();
  DateTime StarDate = DateTime.now();
  DateTime EndDate = DateTime.now();
  DateTime weekStartDate = DateTime.now();
  DateTime weekEndDate = DateTime.now();
  List<CalendarEventData<Event>> events = [];
  List listDate = [];
  List<RequestList> eventList = [];
  RequestDataModel? requestData;
  bool isCalender = false;
  bool isShowWeekends = true;

  fun() {
    listDate = [];
    var now = StarDate;
    weekStartDate = now.subtract(Duration(days: now.weekday - 1));
    weekEndDate = now.subtract(Duration(days: now.weekday - 7));

    listDate = List.generate(7 , (i) => '${weekStartDate.add(Duration(days: i)).day}');

  }

  setState() {
    emit(CalendarInitial());
  }

  void EventList(
      String projectId, String organizationId, String mobileOrgId ,String startDate, String endDate,
      {bool? isFilter,
      List? filterResourceArray,
      List? filterZoneArray,
      List? filterEntrepreneurArray,
      List? filterStatusArray,
      List? filterTransportStatusArray,
      List? filterSubprojectArray}) async {
    emit(EventListLoading());

    EventListModel? response = await Repository.postEventList(
        projectId,
        organizationId,
        mobileOrgId,
        startDate,
        endDate,
        isFilter,
        filterResourceArray,
        filterZoneArray,
        filterEntrepreneurArray,
        filterStatusArray,
        filterTransportStatusArray,
        filterSubprojectArray);

    if (response != null) {
      if (response.success == true) {
        events = [];
        eventList = [];
        eventList = response.requestList!;
        for (int i = 0; i < eventList.length; i++) {
          events.add(
            CalendarEventData(
              date: eventList[i].requestFromDateTime!,
              title: "${eventList[i].companyName}",
              description: eventList[i].description,
              startTime: eventList[i].requestFromDateTime,
              endTime: eventList[i].requestToDateTime,
            ),
          );
        }
        // shipmentSuppName=[];
        // shipmentSuppId=[];
        // for(int i=0; i<response.shipmentSupplierList!.length; i++){
        //   shipmentSuppName.add(response.shipmentSupplierList![i].shipmentSupplierName!);
        //   shipmentSuppId.add(response.shipmentSupplierList![i].id);
        // }
        emit(EventListSuccess());
      } else {
        snackBar("Something Went Wrong", false);
        emit(EventListError());
      }
    } else {
      snackBar("Error to Load Data", false);
      emit(EventListError());
    }
  }

  void RequestData(String requestId) async {
    emit(RequestDataLoading());
    requestData = await Repository.postRequestData(requestId);

    if (requestData != null) {
      if (requestData!.success == true) {
        emit(RequestDataSuccess());
      } else {
        snackBar("Something Went Wrong", false);
        emit(RequestDataError());
      }
    } else {
      snackBar("Error to Load Data", false);
      emit(RequestDataError());
    }
  }
}
