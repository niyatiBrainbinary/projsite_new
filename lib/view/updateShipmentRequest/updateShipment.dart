import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:ftx/navigationX.dart';
import 'package:image_picker/image_picker.dart';
import 'package:proj_site/common/colors/colors.dart';
import 'package:proj_site/common/image_constant/image_constant.dart';
import 'package:proj_site/common/widget_constant/widget_constant.dart';
import 'package:proj_site/cubits/calendar_cubit.dart';
import 'package:proj_site/helper/helper.dart';
import 'package:proj_site/view/newShipmentRequest/enviroment.dart';
import 'dart:developer';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getwidget/getwidget.dart';
import 'package:proj_site/cubits/auth_cubit.dart';
import 'package:proj_site/cubits/drop_down_cubit.dart';
import 'package:proj_site/cubits/shipment_cubit.dart';
import 'package:proj_site/view/updateShipmentRequest/updateEnviroment.dart';

class UpdateShipment extends StatefulWidget {
  String requestId;
  String projectId;
  UpdateShipment(this.requestId, this.projectId);

  @override
  State<UpdateShipment> createState() => _UpdateShipmentState();
}

class _UpdateShipmentState extends State<UpdateShipment> {
  TextEditingController _description = TextEditingController();
  TextEditingController _instruction = TextEditingController();
  final List<String> _dropdownValues = ["One", "Two", "Three", "Four", "Five"];
  final ImagePicker _picker = ImagePicker();
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
  bool isRecurring = false;
  List weekDaysName=["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];
  List weekDaysVal=[false,false,false,false,false,false,false];
  List weekDaysIds=[];
  List firstPageUpdatedData=[];

  List _resource = [];
  List<String> _resourceId = [];
  List<int> _resourceIndex = [];
  String? _unloadingZone;
  String? _unloadingZoneId;
  String? _contractor;
  String? _contractorId;
  String? _person;
  String? _personId;
  String? _subProject;
  String? _subProjectId;

  bool isBox = false;

  late ShipmentCubit shipmentCub;
  late DropDownCubit dropDownCub;
  late CalendarCubit calendarCub;
  late AuthCubit authCub;
  TimeOfDay selectedFromTime = TimeOfDay(hour: 00, minute: 00);
  TimeOfDay selectedToTime = TimeOfDay(hour: 00, minute: 00);
  int fromTimeMinute=0;
  int toTimeMinute=0;

  init(){
    fromTime = DateFormat('HH:mm:ss').format(calendarCub.requestData!.result!.requestFromDateTime!);
    toTime = DateFormat('HH:mm:ss').format(calendarCub.requestData!.result!.requestToDateTime!);
    firstPageUpdatedData =[
      fromDate,
      fromTime,
      toDate,
      toTime,
      isRecurring,
      recurringToDate,
      _resourceId.toString(),
      _unloadingZoneId,
      _contractorId,
      _person,
      _subProjectId,
      _description.text,
      _instruction.text,
    ];
  }
  Widget resourcesDropDown() {
    return GFMultiSelect(
      initialSelectedItemsIndex: _resourceIndex,
      items: dropDownCub.resourcesName,
      onSelect: (value) {
        _resource=[];
        _resourceId=[];
        _resourceIndex=[];
        _resource = value;
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
    // if(fromDate=="Select Date"){
    //   snackBar("Please Select From Date", false);
    // } else if(toDate=="Select Date"){
    //   snackBar("Please Select To Date", false);
    // } else if(fromTime=="Select Time"){
    //   snackBar("Please Select From Time", false);
    // } else if(toTime=="Select Time"){
    //   snackBar("Please Select To Time", false);
    // }else if(isRecurring==true && recurringToDate=="Select Date"){
    //   snackBar("Please Select Recurring to date", false);
    // }else if(_resource.isEmpty){
    //   snackBar("Please Select Resource", false);
    // } else if(_unloadingZone==null){
    //   snackBar("Please Select UnloadingZone", false);
    // } else if(_contractor==null){
    //   snackBar("Please Select Contractor", false);
    // } else if(_person==null){
    //   snackBar("Please Select Responsible Person", false);
    // }
    // // else if(_subProject==null){
    //  //   snackBar("Please Select  Sub Project", false);
    // // }
    // else if(photo == null){
    //   snackBar("Please Select Picture", false);
    // } else {

    // Map map = {
    //   "project_id": projectIdMain,
    //   "request_from_date_time": "${fromDate} ${fromTime}",
    //   "request_to_date_time": "${toDate} ${toTime}",
    //   "resource_array": _resourceId,
    //   "unloading_zone_id": _unloadingZoneId,
    //   "contractor_id": _contractorId,
    //   "responsible_person_id": "",
    //   "sub_project_id": _subProjectId,
    //   "description": _description.text,
    //   "instruction": _instruction.text,
    //   "image_name": "",
    //   "image": null,
    //   "is_recurring": isRecurring,
    //   "recurring_id": null,
    //   "recurring_days": weekDaysIds,
    //   "recurring_to_date": recurringToDate,
    //   "created_by": "5bd35238e549570b1f1a3274",
    //   "status": "pending",
    //   "request_type": "general",
    //   "organization_id": authCub.userInfo!.user!.organizationId!,
    // };
    // print(map);

    Map shipmentMap = {
      "_id": calendarCub.requestData!.result!.id,
      "project_id":  widget.projectId,
      "request_from_date_time": "${fromDate} ${fromTime}",
      "request_to_date_time": "${toDate} ${toTime}",
      "resource_array": _resourceId,
      "unloading_zone_id": _unloadingZoneId,
      "contractor_id": _contractorId,
      "responsible_person_id": _personId,
      "sub_project_id": _subProjectId,
      "description": _description.text,
      "instruction": _instruction.text,
      "image_name": "",
      "image": "",
      "is_recurring": isRecurring,
      "recurring_id": "",
      "recurring_days": weekDaysIds,
      "recurring_to_date": recurringToDate == "Select Date"?"":recurringToDate,
      "created_by": "5bd35238e549570b1f1a3274",
      "status": calendarCub.requestData!.result!.status,
      "request_type": "general",
      "organization_id": authCub.userInfo!.user!.organizationId!,
    };

    List updatedData =[
      fromDate,
      fromTime,
      toDate,
      toTime,
      isRecurring,
      recurringToDate,
      _resourceId.toString(),
      _unloadingZoneId,
      _contractorId,
      _person,
      _subProjectId,
      _description.text,
      _instruction.text,
    ];


    bool isUpdated = false;
    for(int i=0;i< firstPageUpdatedData.length;i++)
      {
        if(firstPageUpdatedData[i] != updatedData[i])
          {
            isUpdated = false;
            break;
          }
        else
          {
            isUpdated = true;
          }
      }


    Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return UpdateEnviroment(shipmentMap, widget.projectId,isUpdated, widget.requestId, _personId == null ? "":_personId!);
      },
    ));
    //}
    log("resource=${_resource}");
    log("resourceId=${_resourceId}");
    log("resourceIndex=${_resourceIndex}");
  }
  initFirstData()async{
     shipmentCub = BlocProvider.of<ShipmentCubit>(context);
    dropDownCub = BlocProvider.of<DropDownCubit>(context);
    authCub = BlocProvider.of<AuthCubit>(context);
    calendarCub = BlocProvider.of<CalendarCubit>(context);
    calendarCub.RequestData(widget.requestId);
    dropDownCub.Organizations(organization_id: orgId);
    dropDownCub.UserSubProjectList(user_id: authCub.userInfo!.user!.id!, project_id: projectIdMain, organization_id: orgId);
    dropDownCub.resourcesList(projectIdMain,orgId);


   await Future.delayed(Duration(seconds: 2));
  }

  @override
  void initState() {

    loadData();
    super.initState();
  }
  loadData()async{
    await initFirstData();
    init();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: getAppBarWithIcon(
        ctx: context,
      ) as PreferredSizeWidget?,
      body: InkWell(
        onTap: (){
          isBox = false;
          setState(() {});
        },
        child: Stack(
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
                      child: commonText("Shipment request info",
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
                              Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        color: Colors.transparent),
                                  ))
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
                            Expanded(
                                child: Container(
                                  color: Colors.transparent,
                                  child: commonText("Package Information",
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
                    child: BlocConsumer<CalendarCubit,CalendarState>(
                      listener: (context, state) {
                        if(state is RequestDataSuccess){
                          fromDate = DateFormat('yyyy-MM-dd').format(calendarCub.requestData!.result!.requestFromDateTime!);
                          toDate = DateFormat('yyyy-MM-dd').format(calendarCub.requestData!.result!.requestToDateTime!);
                          fromTime = DateFormat('HH:mm:ss').format(calendarCub.requestData!.result!.requestFromDateTime!);
                          toTime = DateFormat('HH:mm:ss').format(calendarCub.requestData!.result!.requestToDateTime!);
                          isRecurring=bool.hasEnvironment(calendarCub.requestData!.result!.isRecurring.toString());
                          _description.text=calendarCub.requestData!.result!.description;
                          _instruction.text=calendarCub.requestData!.result!.instruction;
                          log("id1=${calendarCub.requestData!.result!.requestType}");

                          for (int i = 0; i < dropDownCub.resourcesId.length; i++) {
                              for (int j = 0; j < calendarCub.requestData!.result!.resourceArray!.length; j++) {
                                if(dropDownCub.resourcesId[i]==calendarCub.requestData?.result?.resourceArray?[j]){
                                  _resource.add(dropDownCub.resourcesName[i]);
                                  _resourceId.add(dropDownCub.resourcesId[i]);
                                  _resourceIndex.add(i);
                                }
                            }
                          }

                          for (int i = 0; i < dropDownCub.zoneName.length; i++) {
                            if (calendarCub.requestData?.result?.unloadingZoneId == dropDownCub.zoneId[i]) {
                              _unloadingZone = dropDownCub.zoneName[i];
                              _unloadingZoneId=dropDownCub.zoneId[i];
                              setState(() {});
                            }
                          }
                          for (int i = 0;
                          i < dropDownCub.organization.length;
                          i++) {
                            if (calendarCub.requestData?.result?.contractorId == dropDownCub.companyList?[i].id) {
                              _contractor = dropDownCub.companyList?[i].companyName;
                              _contractorId = dropDownCub.companyList?[i].id;
                              setState(() {});
                            }
                          }

                          for (int i = 0; i < dropDownCub.subProjects!.length; i++) {
                            if (calendarCub.requestData?.result?.subProjectId == dropDownCub.subProjects?[i].id) {
                              _subProjectId = dropDownCub.subProjects?[i].id;
                              setState(() {});
                            }
                          }

                          for (int i =0; i< dropDownCub.userName.length; i++){
                            if(calendarCub.requestData?.result?.responsiblePersonId == dropDownCub.userId[i]){
                              _person = dropDownCub.userName[i];
                              _personId = dropDownCub.userId[i];
                            }
                          }

                        }
                      },
                      builder: (context, state) {
                      if(state is RequestDataLoading){
                        return loader();
                      } else if (state is RequestDataError){
                        return errorLoadDataText();
                      } else {
                       return SingleChildScrollView(
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
                             Row(
                               children: [
                                 simpleCheckBox(context, value: isRecurring,
                                     onChanged: (val) {
                                       setState(() {
                                         isRecurring = !isRecurring;
                                         if(isRecurring==false){
                                           recurringToDate="Select Date";
                                         }
                                       });
                                     }),
                                 horizontal(context, width: 80),
                                 commonText('Is recurring?',
                                     color: HexColor.Gray53,
                                     fontFamily: LexendRegular,
                                     fontWeight: FontWeight.w400,
                                     fontSize: 14)
                               ],
                             ),
                             verticalSpaces(context, height: 60),
                             isRecurring
                                 ? Column(
                               crossAxisAlignment: CrossAxisAlignment.start,
                               children: [
                                 commonText("Recurring to date",
                                     color: Colors.black,
                                     fontFamily: LexendRegular,
                                     fontWeight: FontWeight.w400,
                                     fontSize: 12),
                                 verticalSpaces(context, height: 80),
                                 getRoundedContainerWithTralingIcon(
                                     height: 48,
                                     width: screenWidth(context, dividedBy: 2),
                                     text: recurringToDate,
                                     onTap: (){
                                       _selectDate("recurringToDate");
                                     },
                                     image: icons.ic_calendar),
                                 verticalSpaces(context, height: 40),
                                 SizedBox(
                                   height: 25,
                                   width: screenWidth(context),
                                   child: ListView.builder(shrinkWrap: true,scrollDirection: Axis.horizontal,itemCount: weekDaysName.length,itemBuilder: (context, index) {
                                     return SizedBox(
                                       height: 50,
                                       width: 70,
                                       child: Row(
                                         children: [
                                           simpleCheckBox(context, value: weekDaysVal[index],
                                               onChanged: (val) {
                                                 setState(() {
                                                   weekDaysVal[index] = !weekDaysVal[index];
                                                   if(weekDaysVal[index]==true){
                                                     weekDaysIds.add(index+1);
                                                   } else{
                                                     weekDaysIds.remove(index+1);
                                                   }
                                                   log("weekDays=${weekDaysIds}");

                                                 });
                                               }),
                                           horizontal(context, width: 80),
                                           commonText(weekDaysName[index].toString(),
                                               color: HexColor.Gray53,
                                               fontFamily: LexendRegular,
                                               fontWeight: FontWeight.w400,
                                               fontSize: 14)
                                         ],
                                       ),
                                     );
                                   },),
                                 ),
                               ],
                             )
                                 : Container(),
                             verticalSpaces(context, height: 60),
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
                                     commonText("Contractor",
                                         color: Colors.black,
                                         fontFamily: LexendRegular,
                                         fontWeight: FontWeight.w400,
                                         fontSize: 12),
                                     verticalSpaces(context, height: 80),
                                     getDropDownButton(
                                         ctx: context,
                                         items: dropDownCub.organization,
                                         hitText: "Select contractor",
                                         value: _contractor,
                                         onChnaged: (val) async{
                                           _contractor = val;

                                           dropDownCub.organizationCompanyId = "";

                                           for (int i = 0; i < dropDownCub.organization.length; i++) {
                                             if (val == dropDownCub.companyList![i].companyName) {
                                               _contractorId = dropDownCub.companyList![i].id;
                                               dropDownCub.organizationCompanyId = dropDownCub.companyList![i].companyName;
                                             }
                                           }

                                           await dropDownCub.userList(widget.projectId , authCub.userInfo?.user?.organizationId ?? "", _contractorId ?? "");

                                           setState(() {});
                                         }),
                                     verticalSpaces(context, height: 40),
                                     commonText("Responsible Person",
                                         color: Colors.black,
                                         fontFamily: LexendRegular,
                                         fontWeight: FontWeight.w400,
                                         fontSize: 12),
                                     verticalSpaces(context, height: 80),
                                     /*getDropDownButton(
                                         ctx: context,
                                         items: _dropdownValues,
                                         hitText: "Select responsible person",
                                         value: _person,
                                         onChnaged: (val) {
                                           _person = val;
                                           setState(() {});
                                         }),*/
                                     Stack(
                                       children: [
                                         Column(
                                           crossAxisAlignment: CrossAxisAlignment.start,
                                           children: [
                                             InkWell(
                                               onTap: (){
                                                 if(isBox == false){
                                                   isBox = true;
                                                 }
                                                 else{
                                                   isBox = false;
                                                 }
                                                 setState(() {});
                                               },
                                               child: Container(
                                                 height: screenHeight(context, dividedBy: 15),
                                                 width: screenWidth(context),
                                                 padding: EdgeInsets.symmetric(horizontal: 10),
                                                 decoration: BoxDecoration(
                                                     borderRadius: BorderRadius.circular(10.0),
                                                     border:
                                                     Border.all(color: HexColor.Gray53.withOpacity(0.6), width: 1.5)),
                                                 child: Row(
                                                   children: [
                                                     (_person == null) ? Text("Select responsible person",  style: TextStyle(
                                                       fontSize: 14,
                                                       fontWeight: FontWeight.w400,
                                                       fontFamily: LexendRegular,
                                                       color: HexColor.Gray53,
                                                     ),) : Text("$_person", style: TextStyle(fontSize: 14,
                                                       fontWeight: FontWeight.w400,
                                                       fontFamily: LexendRegular,),),
                                                     Icon(Icons.keyboard_arrow_down_rounded, color: HexColor.Gray53,),
                                                   ],
                                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                 ),
                                               ),
                                             ),
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
                                         ),
                                         (isBox == true)? Container(
                                           //height: screenHeight(context,  dividedBy: 5),
                                           width: screenWidth(context, dividedBy: 0.5),
                                           alignment: Alignment.centerLeft,
                                           decoration: BoxDecoration(
                                             color: Colors.white,
                                             boxShadow: [
                                               BoxShadow(
                                                 color: Colors.grey.shade300,
                                                 blurRadius: 10.0,
                                                 spreadRadius: 2.0,
                                               ),
                                             ],
                                           ),
                                           child: SingleChildScrollView(
                                             child: Column(
                                               crossAxisAlignment: CrossAxisAlignment.start,
                                               children: List.generate(dropDownCub.userName.length, (index) => InkWell(
                                                 onTap: (){
                                                   _person =  dropDownCub.userName[index];
                                                   isBox = false;
                                                   setState(() {});
                                                   for (int i = 0; i < dropDownCub.userName.length; i++) {
                                                     if (dropDownCub.userName[index] == dropDownCub.userName[i]) {
                                                       _personId = dropDownCub.userId[i];
                                                     }
                                                   }

                                                 },
                                                 child: Row(
                                                   children: [
                                                     Padding(
                                                         child: Text("${dropDownCub.userName[index]}", style: TextStyle(fontSize: 14,
                                                           fontWeight: FontWeight.w400,
                                                           fontFamily: LexendRegular,),
                                                         ),
                                                         padding : EdgeInsets.only(left: 20, top: 10, bottom: 10)
                                                     ),
                                                   ],
                                                 ),
                                               )
                                               ),

                                             ),
                                           ),

                                         ) : SizedBox(),
                                       ],
                                     ),
                                   ],
                                 );
                               },
                             ),
                             verticalSpaces(context, height: 40),
                             commonText("Description",
                                 color: Colors.black,
                                 fontFamily: LexendRegular,
                                 fontWeight: FontWeight.w400,
                                 fontSize: 12),
                             verticalSpaces(context, height: 80),
                             getRoundedTexfield(
                                 height: screenHeight(context, dividedBy: 7),
                                 hintText: "Description",
                                 controller: _description,
                                 maxline: 10,
                                 ctx: context),
                             verticalSpaces(context, height: 40),
                             commonText("Instruction",
                                 color: Colors.black,
                                 fontFamily: LexendRegular,
                                 fontWeight: FontWeight.w400,
                                 fontSize: 12),
                             verticalSpaces(context, height: 80),
                             getRoundedTexfield(
                                 height: screenHeight(context, dividedBy: 7),
                                 hintText: "Instruction",
                                 controller: _instruction,
                                 maxline: 10,
                                 ctx: context),
                             verticalSpaces(context, height: 40),
                             commonText("Picture",
                                 color: Colors.black,
                                 fontFamily: LexendRegular,
                                 fontWeight: FontWeight.w400,
                                 fontSize: 12),
                             verticalSpaces(context, height: 80),
                             DottedBorder(
                                 radius: Radius.circular(10),
                                 borderType: BorderType.RRect,
                                 color: HexColor.Gray53.withOpacity(0.6),
                                 dashPattern: [5, 5],
                                 child: Container(
                                   height: screenHeight(context, dividedBy: 16),
                                   width: screenWidth(context),
                                   decoration: BoxDecoration(
                                       borderRadius: BorderRadius.circular(10)),
                                   child: Row(
                                     children: [
                                       horizontal(context, width: 30),
                                       GestureDetector(
                                         onTap: () {
                                           getSelectPictureDialog(
                                             ctx: context,
                                             onTapCamera: () async {
                                               photo = await _picker.pickImage(
                                                   source: ImageSource.camera);
                                               Navigation.instance.goBack();
                                             },
                                             onTapGallery: () async {
                                               photo = await _picker.pickImage(
                                                   source: ImageSource.gallery);
                                               Navigation.instance.goBack();
                                             },
                                           );
                                         },
                                         child: Container(
                                           height:
                                           screenHeight(context, dividedBy: 23),
                                           width: screenWidth(context, dividedBy: 4),
                                           decoration: BoxDecoration(
                                               color:
                                               HexColor.Gray53.withOpacity(0.4),
                                               borderRadius:
                                               BorderRadius.circular(10),
                                               border: Border.all(
                                                   color: HexColor.Gray53)),
                                           child: Center(
                                               child: commonText("Choose file",
                                                   color: HexColor.Gray53,
                                                   fontFamily: LexendRegular,
                                                   fontWeight: FontWeight.w400,
                                                   fontSize: 14)),
                                         ),
                                       ),
                                       horizontal(context, width: 30),
                                       commonText(
                                           photo == null
                                               ? "No file chosen"
                                               : photo!.path.split("/").last,
                                           color: HexColor.Gray53.withOpacity(0.6),
                                           fontFamily: LexendRegular,
                                           fontWeight: FontWeight.w400,
                                           fontSize: 14)
                                     ],
                                   ),
                                 )),
                             verticalSpaces(context, height: 10)
                           ],
                         ),
                       );
                      }
                    },),
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
      ),
    );
  }
}
