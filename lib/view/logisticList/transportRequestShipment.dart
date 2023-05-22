import 'dart:developer';

import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ftx/navigationX.dart';
import 'package:getwidget/getwidget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:proj_site/common/colors/colors.dart';
import 'package:proj_site/common/image_constant/image_constant.dart';
import 'package:proj_site/common/widget_constant/widget_constant.dart';
import 'package:proj_site/cubits/auth_cubit.dart';
import 'package:proj_site/cubits/drop_down_cubit.dart';
import 'package:proj_site/cubits/shipment_cubit.dart';
import 'package:proj_site/helper/helper.dart';
import 'package:proj_site/view/logisticList/transportRequestEnviroment.dart';
import 'package:proj_site/view/terminalTransportBooking/terminalTransportEnviromental.dart';

class TransportRequestShipment extends StatefulWidget {
  List selectedCheckoutIdList=[];
  String logisticId;
  TransportRequestShipment(this.selectedCheckoutIdList,this.logisticId);

  @override
  State<TransportRequestShipment> createState() => _TransportRequestShipmentState();
}

class _TransportRequestShipmentState extends State<TransportRequestShipment> {
  TextEditingController _description = TextEditingController();
  TextEditingController _itemName = TextEditingController();
  TextEditingController _palletCon = TextEditingController();
  final List<String> _dropdownValues = ["One", "Two", "Three", "Four", "Five"];
  XFile? photo;
  DateTime selectedDate=DateTime.now();
  String fromDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  String toDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  String fromTime = "Select Time";
  String toTime = "Select Time";
  // String fromTimeApi = "Select Time";
  // String toTimeApi = "Select Time";
  String recurringToDate = "Select Date";
  DateTime? arriveDate;
  DateTime? dueDate;

  List _resource = [];
  List _resourceId = [];
  String? _unloadingZone;
  String? _unloadingZoneId;
  String? _subProject;
  String? _subProjectId;

  late ShipmentCubit shipmentCub;
  late DropDownCubit dropDownCub;
  late AuthCubit authCub;
  TimeOfDay selectedFromTime = TimeOfDay(hour: 00, minute: 00);
  TimeOfDay selectedToTime = TimeOfDay(hour: 00, minute: 00);
  int fromTimeMinute=0;
  int toTimeMinute=0;
  Widget resourcesDropDown() {
    return GFMultiSelect(
      items: dropDownCub.resourcesName,
      onSelect: (value) {
        _resource = value;
        _resourceId=[];
        for (int i = 0; i < value.length; i++) {
          _resourceId.add(dropDownCub.resourcesId[value[i]]);
        }
        setState(() {});
        print('_resource $_resource ');
      },
      dropdownTitleTileText: 'Select resource'.tr(),
      dropdownTitleTileColor: Colors.white,
      dropdownTitleTileMargin: EdgeInsets.zero,
      dropdownTitleTilePadding:
      EdgeInsets.only(left: 10, right: 5, top: 12, bottom: 12),
      dropdownUnderlineBorder:
      const BorderSide(color: Colors.transparent, width: 2),
      dropdownTitleTileBorder:
      Border.all(color: HexColor.Gray53.withOpacity(0.6), width: 1.5),
      dropdownTitleTileBorderRadius: BorderRadius.circular(10),
      expandedIcon: Icon(
        Icons.keyboard_arrow_down,
        color: HexColor.Gray53.withOpacity(0.6),
      ),
      collapsedIcon: Icon(
        Icons.keyboard_arrow_up,
        color: HexColor.Gray53.withOpacity(0.6),
      ),
      submitButton:
      commonButton(context: context, buttonName: "Ok", width: 100),
      cancelButton: commonButton(
        context: context,
        buttonName: "Cancel",
        buttonTextSize: 15,
        width: 100,
        buttonColor: HexColor.Gray53.withOpacity(0.5),
      ),
      buttonColor: Colors.white,
      dropdownTitleTileTextStyle: _resource.isEmpty
          ? TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        fontFamily: LexendRegular,
        color: HexColor.Gray53,
      )
          : TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        fontFamily: LexendRegular,
        color: Colors.black,
      ),
      type: GFCheckboxType.basic,
      activeBgColor: HexColor.orange,
      inactiveBorderColor: Colors.grey,
      activeIcon: Icon(Icons.check, color: Colors.white, size: 20),
      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 1),
      padding: EdgeInsets.zero,
      size: 25,
    );
  }

  Future<void> _selectDate(String dateType) async {
    DateTime? _dateTime = await showDatePicker(
        context: context,
        initialDate: dateType=="recurringToDate"?selectedDate:DateTime.now(),
        firstDate: dateType=="recurringToDate"?selectedDate:DateTime.now(),
        lastDate: DateTime(2101));
    if (_dateTime != null) {
      print(_dateTime);

      String formattedDate = DateFormat('yyyy-MM-dd').format(_dateTime);
      print(formattedDate);
      setState(() {
        if(dateType=="fromDate"){
          fromDate=formattedDate;
          toDate=formattedDate;
          selectedDate=_dateTime;
          recurringToDate = "Select Date";
        }
        else if(dateType=="toDate"){
          fromDate=formattedDate;
          toDate=formattedDate;
          selectedDate=_dateTime;
          recurringToDate = "Select Date";
        }
        else if(dateType=="recurringToDate"){
          recurringToDate=formattedDate;
        }
      });
    } else {
      print("Date is not selected");
    }
  }

  /// 24 hr format

  Future<void> _selectTime(String timeType) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedFromTime,
    );
    if (picked != null) {
      setState(() {
        if (timeType == "fromTime") {
          selectedFromTime = picked;
          String _hour = selectedFromTime.hour.toString().padLeft(2, '0');
          String _minute = selectedFromTime.minute.toString().padLeft(2, '0');
          String finalTime = "${_hour}:${_minute}:00";
          fromTime = finalTime;
          fromTimeMinute = selectedFromTime.hour * 60 + selectedFromTime.minute;
          //log("fromTime=${fromDate} ${fromTime}");
        } else if (timeType == "toTime") {
          selectedToTime = picked;
          String _hour = selectedToTime.hour.toString().padLeft(2, '0');
          String _minute = selectedToTime.minute.toString().padLeft(2, '0');
          String finalTime = "${_hour}:${_minute}:00";
          toTime = finalTime;

          toTimeMinute = selectedToTime.hour * 60 + selectedToTime.minute;

          if (selectedFromTime.hour >= 12 && selectedToTime.hour < 12) {
            toTime = "23:59:00";
            snackBar("Max select time is today", false);
          } else {
            if ((toTimeMinute - fromTimeMinute) > 720) {
              toTime =
              "${selectedFromTime.hour + 12}:${selectedFromTime.minute.toString().padLeft(2, '0')}:00";
              snackBar(
                  "End Date Time can not be greater than 12 hrs from Start Date Time",
                  false);
            }
          }
        }
      });
    }
  }

  /// 12 hr AM/PM format

  /*Future<void> _selectTime(String timeType) async {
    final TimeOfDay? picked = await showTimePicker(

      context: context,
      initialTime: selectedFromTime,
      builder: (context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true), // false
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        if (timeType == "fromTime") {
          selectedFromTime = picked;
          String _hour = selectedFromTime.hour.toString().padLeft(2, '0');
          //String _hourP = selectedFromTime.hourOfPeriod.toString().padLeft(2, '0');
          String _minute = selectedFromTime.minute.toString().padLeft(2, '0');
          //String _period = selectedFromTime.period.name.toString().padLeft(2, '0');
          String finalTime = "${_hour}:${_minute}:00";
          // String finalTimeApi = "${_hour}:${_minute}:00";
          fromTime = finalTime;
          //fromTimeApi = finalTimeApi;
          fromTimeMinute = selectedFromTime.hour * 60 + selectedFromTime.minute;
          //log("fromTime=${fromDate} ${fromTime}");
        } else if (timeType == "toTime") {
          selectedToTime = picked;
          String _hour = selectedToTime.hour.toString().padLeft(2, '0');
          //String _hourP = selectedToTime.hourOfPeriod.toString().padLeft(2, '0');
          String _minute = selectedToTime.minute.toString().padLeft(2, '0');
          //String _period = selectedFromTime.period.name.toString().padLeft(2, '0');
          String finalTime = "${_hour}:${_minute}:00"; //"${_hourP}:${_minute}:00 $_period";
          //String finalTimeApi = "${_hour}:${_minute}:00";
          toTime = finalTime;
          //toTimeApi = finalTimeApi;

          toTimeMinute = selectedToTime.hour * 60 + selectedToTime.minute;



          if (selectedFromTime.hour >= 12 && selectedToTime.hour < 12) {
            toTime = "11:59:00";
            snackBar("Max select time is today", false);
          } else {
            if ((toTimeMinute - fromTimeMinute) > 720) {
              toTime = "${selectedFromTime.hour}:${selectedFromTime.minute.toString().padLeft(2, '0')}:00";
              snackBar(
                  "End Date Time can not be greater than 12 hrs from Start Date Time",
                  false);
            }
          }

        }
      });
    }
  }*/

  void nextOnTap(){
    if(fromDate=="Select Date"){
      snackBar("Please Select From Date", false);
    } else if(toDate=="Select Date"){
      snackBar("Please Select To Date", false);
    } else if(fromTime=="Select Time"){
      snackBar("Please Select From Time", false);
    } else if(toTime=="Select Time"){
      snackBar("Please Select To Time", false);
    } else if(_resource.isEmpty){
      snackBar("Please Select Resource", false);
    } else {
      Map shipmentMap = {
        /*"_id": widget.logisticId,
        "project_id": projectIdMain,
        "request_from_date_time": "${fromDate} ${fromTime}",
        "request_to_date_time": "${toDate} ${toTime}",
        "resource_array": _resourceId,
        "unloading_zone_id": _unloadingZoneId,
        "selected_checkouts": widget.selectedCheckoutIdList,
        "sub_project_id": _subProjectId,
        "description": _description.text,
        "arrived_at":"",
        "in_progress_at":"",
        "unloaded_at": "",*/

        "project_id":  projectIdMain,
        "terminal_id": widget.logisticId,
        "request_from_date_time": "${fromDate} ${fromTime}",
        "request_to_date_time": "${toDate} ${toTime}",
        "resource_array": _resourceId[0],
        "responsible_person_id": "5fb845054fdab967c315b6e3",
        "created_by": "5fb845054fdab967c315b6e3",
        "organization_id": orgId,
        "unloading_zone_id": _unloadingZoneId,
        "description": _description.text,
        "sub_project_id": _subProjectId,
        "is_hidden": false,
        "unbooked": false,
      };
      print(shipmentMap);

      Navigator.push(context, MaterialPageRoute(
        builder: (context) {
          return TransportRequestEnviromental(shipmentMap);
        },
      ));
    }
  }

  @override
  void initState() {
    shipmentCub = BlocProvider.of<ShipmentCubit>(context);
    dropDownCub = BlocProvider.of<DropDownCubit>(context);
    authCub = BlocProvider.of<AuthCubit>(context);
    dropDownCub.resourcesList(projectIdMain,orgId);
    dropDownCub.Organizations(
      organization_id: orgId
    );
    dropDownCub.UserSubProjectList(user_id: authCub.userInfo!.user!.id!, project_id: projectIdMain, organization_id: orgId);


    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: getAppBarWithIcon(
        ctx: context,
      ) as PreferredSizeWidget?,
      body: Stack(
        children: [
          getCommonContainer(
            color: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                getCommonContainer(
                    height: screenHeight(context, dividedBy: 15),
                    width: screenWidth(context),
                    color: Colors.transparent,
                    child: commonText("Process Transport request",
                        color: Colors.black,
                        fontFamily: LexendRegular,
                        fontWeight: FontWeight.w700,
                        fontSize: 20)),
                Container(
                  height: screenHeight(context, dividedBy: 12),
                  width: screenWidth(context),
                  color: Colors.transparent,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        height: screenHeight(context, dividedBy: 100),
                        width: screenWidth(context),
                        decoration: BoxDecoration(
                            color: HexColor.Gray53.withOpacity(0.4),
                            borderRadius: BorderRadius.circular(30)),
                        child: Row(
                          children: [
                            Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: HexColor.orange,
                                  ),
                                )),
                            Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: Colors.transparent),
                                )),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: Container(
                                color: Colors.transparent,
                                child: commonText("Shipment Data",
                                    color: HexColor.orange,
                                    textAlign: TextAlign.center,
                                    fontFamily: LexendRegular,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14),
                              )),
                          Expanded(
                              child: Container(
                                color: Colors.transparent,
                                child: commonText("Environmental Data",
                                    color: Colors.black,
                                    textAlign: TextAlign.center,
                                    fontFamily: LexendRegular,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14),
                              )),
                        ],
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                                child: commonText("From",
                                    color: Colors.black,
                                    fontFamily: LexendRegular,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12)),
                            horizontal(context, width: 60),
                            Expanded(
                                child: commonText("To",
                                    color: Colors.black,
                                    fontFamily: LexendRegular,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12)),
                          ],
                        ),
                        verticalSpaces(context, height: 80),
                        Container(
                          height: screenHeight(context, dividedBy: 16),
                          child: Row(
                            children: [
                              Expanded(
                                child: getRoundedContainerWithTralingIcon(
                                    text: fromDate,
                                    onTap: () {
                                      _selectDate("fromDate");
                                    },
                                    image: icons.ic_calendar),
                              ),
                              horizontal(context, width: 60),
                              Expanded(
                                child: getRoundedContainerWithTralingIcon(
                                    text: toDate,
                                    onTap: () {
                                      _selectDate("toDate");
                                    },
                                    image: icons.ic_calendar),
                              ),
                            ],
                          ),
                        ),
                        verticalSpaces(context, height: 40),
                        Row(
                          children: [
                            Expanded(
                                child: commonText("From",
                                    color: Colors.black,
                                    fontFamily: LexendRegular,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12)),
                            horizontal(context, width: 60),
                            Expanded(
                                child: commonText("To",
                                    color: Colors.black,
                                    fontFamily: LexendRegular,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12)),
                          ],
                        ),
                        verticalSpaces(context, height: 80),
                        Container(
                          height: screenHeight(context, dividedBy: 16),
                          child: Row(
                            children: [
                              Expanded(
                                child: getRoundedContainerWithTralingIcon(
                                    text: fromTime,
                                    onTap: (){
                                      _selectTime("fromTime");
                                    },
                                    image: icons.ic_calendar),
                              ),
                              horizontal(context, width: 60),
                              Expanded(
                                child: getRoundedContainerWithTralingIcon(
                                    text: toTime,
                                    onTap: (){
                                      _selectTime("toTime");
                                    },
                                    image: icons.ic_calendar),
                              ),
                            ],
                          ),
                        ),
                        verticalSpaces(context, height: 40),
                        BlocBuilder<DropDownCubit, DropDownState>(
                          builder: (context, state) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                commonText("Resources",
                                    color: Colors.black,
                                    fontFamily: LexendRegular,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12),
                                verticalSpaces(context, height: 80),
                                resourcesDropDown(),
                                verticalSpaces(context, height: 40),
                                commonText("Available Unloading Zones",
                                    color: Colors.black,
                                    fontFamily: LexendRegular,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12),
                                verticalSpaces(context, height: 80),
                                getDropDownButton(
                                    ctx: context,
                                    items: dropDownCub.zoneName,
                                    hitText: "Select unloading zone",
                                    value: _unloadingZone,
                                    onChnaged: (val) {
                                      _unloadingZone = val;
                                      for (int i = 0;
                                      i < dropDownCub.zoneName.length;
                                      i++) {
                                        if (val == dropDownCub.zoneName[i]) {
                                          _unloadingZoneId = dropDownCub.zoneId[i];
                                        }
                                      }
                                      setState(() {});
                                    }),
                                verticalSpaces(context, height: 40),

                                commonText("Sub Project",
                                    color: Colors.black,
                                    fontFamily: LexendRegular,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12),
                                verticalSpaces(context, height: 80),
                                getDropDownButton(
                                    ctx: context,
                                    items: dropDownCub.enterpreneurs,
                                    hitText: "Select Sub Project",
                                    value: _subProject,
                                    onChnaged: (val) {
                                      _subProject = val;
                                      for (int i = 0;
                                      i < dropDownCub.subProjects!.length;
                                      i++) {
                                        if (val ==
                                            dropDownCub.subProjects![i].subProjectName) {
                                          _subProjectId = dropDownCub.subProjects![i].id;
                                        }
                                      }
                                      setState(() {});
                                    }),
                              ],
                            );
                          },
                        ),
                        verticalSpaces(context, height: 40),
                        commonText("Other Information",
                            color: Colors.black,
                            fontFamily: LexendRegular,
                            fontWeight: FontWeight.w400,
                            fontSize: 12),
                        verticalSpaces(context, height: 80),
                        getRoundedTexfield(
                            height: screenHeight(context, dividedBy: 7),
                            hintText: "Enter Other Information",
                            controller: _description,
                            maxline: 10,
                            ctx: context),
                        verticalSpaces(context, height: 10)
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: HexColor.Gray53.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: Offset(0, -5), // changes position of shadow
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  commonButton(
                      context: context,
                      buttonName: "close",
                      buttonColor: HexColor.Gray53.withOpacity(0.5),
                      onTap: () {
                        Navigator.pop(context);
                      }),
                  horizontal(context, width: 20),
                  commonButton(
                      context: context,
                      buttonName: "Next",
                      onTap: () {
                        nextOnTap();
                      })
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
