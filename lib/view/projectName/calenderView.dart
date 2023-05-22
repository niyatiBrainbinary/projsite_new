import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ftx/navigationX.dart';
import 'package:getwidget/getwidget.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:proj_site/api%20service/api_routes.dart';
import 'package:proj_site/common/colors/colors.dart';
import 'package:proj_site/common/image_constant/image_constant.dart';
import 'package:proj_site/common/widget_constant/widget_constant.dart';
import 'package:proj_site/cubits/calendar_cubit.dart';
import 'package:proj_site/cubits/logistic_list_cubit.dart';
import 'package:proj_site/cubits/drop_down_cubit.dart';
import 'package:proj_site/helper/helper.dart';
import 'package:proj_site/model/event.dart';
import 'package:proj_site/pages/day_view_page.dart';
import 'package:proj_site/pages/month_view_page.dart';
import 'package:proj_site/pages/week_view_page.dart';
import 'package:proj_site/src/calendar_controller_provider.dart';
import 'package:proj_site/src/calendar_event_data.dart';
import 'package:proj_site/src/event_controller.dart';
import 'package:proj_site/view/newShipmentRequest/shipment.dart';
import 'package:proj_site/view/projectName/eventList.dart';
import 'package:proj_site/view/terminalTransportBooking/terminalTransportshipment.dart';
import 'package:proj_site/view/unbookedShipmentRequest/unbookedShipment.dart';
import 'package:proj_site/view/wasteDisposal.dart';
import 'package:proj_site/weeklyDatePicker/weekly_date_picker.dart';

import '../../cubits/auth_cubit.dart';

DateTime get _now => DateTime.now();

class CalenderView extends StatefulWidget {
  static const id = 'CalenderView_screen';
  String? projectName;

  CalenderView({Key? key, this.projectName}) : super(key: key);

  @override
  State<CalenderView> createState() => _CalenderViewState();
}

class _CalenderViewState extends State<CalenderView>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;


  final List<String> _dropdownValues = ["One", "Two", "Three", "Four", "Five"];
  List<String> _weekDays = ["M", "T", "W", "T", "F", "S", "S"];
  List<String> _list = [
    "Not specified",
    "To Terminal Transport",
    "From Terminal Transport",
    "Unbooked Shipment Transport"
  ];
  List<String> _imageList = [
    images.pattern,
    images.pattern1,
    images.pattern2,
    images.pattern3
  ];
  DateTime _currentDate = DateTime.now();

  late AuthCubit authCub;
  late DropDownCubit dropDownCub;
  late LogisticListCubit logisticCub;
  late CalendarCubit calenderCub;

  List _resource = [];
  List _resourceId = [];
  List _zone = [];
  List _zoneId = [];
  List _entrepreneurs = [];
  List _entrepreneursId = [];
  List _filterStatus = [];
  List _filterStatusId = [];
  List _transportType = [];
  List _transportTypeId = [];
  List _subProject = [];
  List _subProjectId = [];
  int _selectedIndex = 0;

  Widget buildDropDownWithTitle(
      {required String title,
      required List<String> itemList,
      required List valueList,
      required void Function(List) onSelect,
      required String hintText}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        commonText(title,
            color: Colors.black,
            fontFamily: LexendSemiBold,
            fontWeight: FontWeight.w500,
            fontSize: 15),
        verticalSpaces(context, height: 80),
        GFMultiSelect(
          items: itemList,
          onSelect: onSelect,
          dropdownTitleTileText: hintText,
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
          dropdownTitleTileTextStyle: valueList.isEmpty
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
        ),
        verticalSpaces(context, height: 40),
      ],
    );
  }

  shipmentsBottomSheet(BuildContext context) {
    showModalBottomSheet<dynamic>(
      context: context,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
      isScrollControlled: true,
      builder: (context) {
        return Container(
          height: screenHeight(context, dividedBy: 1.5),
          width: screenWidth(context),
          child: ListView(
            physics: BouncingScrollPhysics(),
            children: [
              Container(
                margin: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: 25,
                  bottom: 35,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: commonText("Shipments",
                          color: Colors.black,
                          fontFamily: LexendBold,
                          fontWeight: FontWeight.w700,
                          fontSize: 20),
                    ),
                    verticalSpaces(context, height: 40),
                    commonText("Shipment Resources",
                        color: Colors.black,
                        fontFamily: LexendSemiBold,
                        fontWeight: FontWeight.w500,
                        fontSize: 15),
                    verticalSpaces(context, height: 80),
                    Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          border: Border.all(
                            color: HexColor.lightGray,
                          ),
                        ),
                        child: GridView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            itemCount:
                                dropDownCub.resourceListData!.resources!.length,
                            shrinkWrap: true,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 4,
                                    crossAxisSpacing: 8,
                                    childAspectRatio: 0.8),
                            itemBuilder: (BuildContext context, index) {
                              return Column(
                                children: [
                                  Container(
                                      height: 35,
                                      width: 35,
                                      padding: EdgeInsets.all(2),
                                      color: Colors.transparent,
                                      child: Image.network(
                                        '${ApiRoutes.ShipmentImage_URL}' +
                                            '${dropDownCub.resourceListData!.resources![index].resourcePattern}',
                                        fit: BoxFit.cover,
                                      )),
                                  commonText(dropDownCub.resourcesName[index],
                                      color: HexColor.HColor,
                                      fontFamily: LexendRegular,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 13,
                                      maxLines: 2,
                                      textAlign: TextAlign.center)
                                ],
                              );
                            })),
                    verticalSpaces(context, height: 40),
                    commonText("Shipment Zones",
                        color: Colors.black,
                        fontFamily: LexendSemiBold,
                        fontWeight: FontWeight.w500,
                        fontSize: 15),
                    verticalSpaces(context, height: 80),
                    Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          border: Border.all(
                            color: HexColor.lightGray,
                          ),
                        ),
                        child: GridView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: dropDownCub.zoneColor.length,
                            shrinkWrap: true,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    crossAxisSpacing: 8,
                                    childAspectRatio: 1.3),
                            itemBuilder: (BuildContext context, index) {
                              return Row(
                                children: [
                                  Container(
                                    height: 23,
                                    width: 23,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(3),
                                        border: Border.all(color: Colors.grey),
                                        color: Color.fromRGBO(
                                            int.parse(dropDownCub
                                                .zoneColor[index][0]),
                                            int.parse(dropDownCub
                                                .zoneColor[index][1]),
                                            int.parse(dropDownCub
                                                .zoneColor[index][2]),
                                            1)),
                                    // color: Colors.orange),
                                  ),
                                  horizontal(context, width: 80),
                                  Expanded(
                                    child: commonText(
                                        dropDownCub
                                            .zoneListData!
                                            .unloadingZones![index]
                                            .unloadingZoneName
                                            .toString(),
                                        color: HexColor.HColor,
                                        fontFamily: LexendRegular,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 13),
                                  )
                                ],
                              );
                            })),
                    verticalSpaces(context, height: 20),
                    Container(
                      padding: EdgeInsets.only(
                          left: 10,
                          right: 10,
                          top: screenHeight(context, dividedBy: 80)),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7),
                        border: Border.all(
                          color: HexColor.lightGray,
                        ),
                      ),
                      child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: 4,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Column(children: [
                            Row(
                              children: [
                                Container(
                                  height: 23,
                                  width: 23,
                                  child: SvgPicture.asset(_imageList[index],
                                      fit: BoxFit.cover),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(3),
                                    color: HexColor.Gray53,
                                  ),
                                ),
                                horizontal(context, width: 60),
                                commonText(_list[index],
                                    color: HexColor.HColor,
                                    fontFamily: LexendRegular,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14)
                              ],
                            ),
                            verticalSpaces(context, height: 80),
                          ]);
                        },
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }

  filterBottomSheet(BuildContext context) {
    showModalBottomSheet<dynamic>(
        context: context,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
        isScrollControlled: true,
        builder: (context) {
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return BlocBuilder<DropDownCubit, DropDownState>(
                  builder: (context, state) {
                return Container(
                  height: screenHeight(context, dividedBy: 1.5),
                  width: screenWidth(context),
                  child: ListView(
                    physics: BouncingScrollPhysics(),
                    children: [
                      Container(
                        margin: const EdgeInsets.only(
                          left: 20,
                          right: 20,
                          top: 25,
                          bottom: 35,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            commonText("Filter",
                                color: Colors.black,
                                fontFamily: LexendBold,
                                fontWeight: FontWeight.w700,
                                fontSize: 20),
                            verticalSpaces(context, height: 40),
                            buildDropDownWithTitle(
                                title: "Resource",
                                itemList: dropDownCub.resourcesName,
                                valueList: _resource,
                                onSelect: (value) {
                                  _resource = value;
                                  _resourceId = [];
                                  for (int i = 0; i < value.length; i++) {
                                    _resourceId
                                        .add(dropDownCub.resourcesId[value[i]]);
                                  }
                                  setState(() {});
                                  print('_resource $value ');
                                  print('_resourceId $_resourceId ');
                                },
                                hintText: state is ResourceListLoading
                                    ? ""
                                    : "Select Resource"),
                            buildDropDownWithTitle(
                                title: "Zone",
                                itemList: dropDownCub.zoneName,
                                valueList: _zone,
                                onSelect: (value) {
                                  _zone = value;
                                  _zoneId = [];
                                  for (int i = 0; i < value.length; i++) {
                                    _zoneId.add(dropDownCub.zoneId[value[i]]);
                                  }
                                  setState(() {});
                                  print('zone $value ');
                                  print('zoneId $_zoneId ');
                                },
                                hintText: state is ZoneListLoading
                                    ? ""
                                    : "Select Zone"),
                            buildDropDownWithTitle(
                                title: "Entrepreneur",
                                itemList: dropDownCub.organization,
                                valueList: _entrepreneurs,
                                onSelect: (value) {
                                  _entrepreneurs = value;
                                  _entrepreneursId = [];
                                  for (int i = 0; i < value.length; i++) {
                                    _entrepreneursId.add(
                                        dropDownCub.companyList![value[i]].id);
                                  }
                                  setState(() {});
                                },
                                hintText: "Select Entrepreneur"),
                            buildDropDownWithTitle(
                                title: "Status",
                                itemList: dropDownCub.statusList,
                                valueList: _filterStatus,
                                onSelect: (value) {
                                  _filterStatus = value;
                                  for (int i = 0; i < value.length; i++) {
                                    _filterStatusId
                                        .add(dropDownCub.statusList[value[i]]);
                                  }
                                  setState(() {});
                                },
                                hintText: "Select Status"),
                            buildDropDownWithTitle(
                                title: "Transport Type",
                                itemList: dropDownCub.transportTypeList,
                                valueList: _transportType,
                                onSelect: (value) {
                                  _transportType = value;
                                  for (int i = 0; i < value.length; i++) {
                                    _transportTypeId.add(dropDownCub
                                        .transportTypeList[value[i]]);
                                  }
                                  setState(() {});
                                },
                                hintText: "Select Transport Type"),
                            buildDropDownWithTitle(
                                title: "Sub Project",
                                itemList: dropDownCub.enterpreneurs,
                                valueList: _subProject,
                                onSelect: (value) {
                                  _subProject = value;
                                  _subProjectId = [];
                                  for (int i = 0; i < value.length; i++) {
                                    _subProjectId.add(
                                        dropDownCub.subProjects![value[i]].id);
                                  }
                                  setState(() {});
                                },
                                hintText: "Select Sub Project"),
                            verticalSpaces(context, height: 40),
                            BlocConsumer<CalendarCubit, CalendarState>(
                              listener: (context, state) {
                                if (state is EventListSuccess) {
                                  Navigator.pop(context);
                                }
                              },
                              builder: (context, state) {
                                if (state is EventListLoading) {
                                  return Container(
                                    height:
                                        screenHeight(context, dividedBy: 18),
                                    width: screenWidth(context, dividedBy: 3.2),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(32),
                                      color: HexColor.buttonColor,
                                    ),
                                    child:
                                        LoadingAnimationWidget.prograssiveDots(
                                      color: Colors.black,
                                      size: 35,
                                    ),
                                  );
                                } else {



                                  return commonButton(
                                    context: context,
                                    buttonName: "Apply Filter",
                                    onTap: () {

                                      String start = "${DateTime.now().subtract(Duration(days: 150)).toUtc().millisecondsSinceEpoch}";

                                      String end = "${DateTime.now().add(Duration(days: 150)).toUtc().millisecondsSinceEpoch}";

                                      calenderCub.EventList(
                                        projectIdMain,
                                        orgId,
                                        mobileOrgId,
                                        start,
                                        end,
                                        isFilter: true,
                                        filterResourceArray: _resourceId,
                                        filterZoneArray: _zoneId,
                                        filterEntrepreneurArray:
                                            _entrepreneursId,
                                        filterStatusArray: _filterStatusId,
                                        filterTransportStatusArray:
                                            _transportTypeId,
                                        filterSubprojectArray: _subProjectId,
                                      );
                                    },
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                );
                ;
              });
            },
          );
        });
  }

  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this);
    calenderCub = BlocProvider.of<CalendarCubit>(context);
    authCub = BlocProvider.of<AuthCubit>(context);
    dropDownCub = BlocProvider.of<DropDownCubit>(context);
    calenderCub.isCalender = true;
    // calenderCub.EventList(projectIdMain, authCub.userInfo!.user!.organizationId!,"${DateTime.now().subtract(Duration(days: 150)).toUtc().millisecondsSinceEpoch}","${DateTime.now().add(Duration(days: 150)).toUtc().millisecondsSinceEpoch}");
    dropDownCub.Organizations(organization_id: orgId);
    dropDownCub.UserSubProjectList(
        user_id: authCub.userInfo?.user?.id ?? "",
        project_id: projectIdMain,
        organization_id: orgId);
    dropDownCub.resourcesList(projectIdMain, orgId);
    dropDownCub.filterStatus(projectIdMain);
    dropDownCub.filterTransportType(projectIdMain);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: screenHeight(context),
            width: screenWidth(context),
            color: Colors.white,
            child: Column(
              children: [
                Container(
                  height: screenHeight(context, dividedBy: 8),
                  width: screenWidth(context),
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(height: 20),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () => Navigation.instance.goBack(),
                            child: const Icon(Icons.arrow_back_ios,
                                color: Colors.black),
                          ),
                         SizedBox(
                           //width: screenWidth(context, dividedBy: 2.5),
                           child:  commonText("Project Name",
                               color: Colors.black,
                               fontFamily: LexendBold,
                               fontWeight: FontWeight.w700,
                               fontSize: 20),
                         ),
                          Spacer(),
                          getContainerWithImage(
                              ctx: context,
                              icons: icons.ic_shipment,
                              onTap: () {
                                shipmentsBottomSheet(context);
                              }),
                          getContainerWithImage(
                              ctx: context,
                              icons: icons.ic_filter,
                              onTap: () {
                                _resource = [];
                                _resourceId = [];
                                _zone = [];
                                _zoneId = [];
                                _entrepreneurs = [];
                                _entrepreneursId = [];
                                _filterStatus = [];
                                _filterStatusId = [];
                                _transportType = [];
                                _transportTypeId = [];
                                _subProject = [];
                                _subProjectId = [];
                                filterBottomSheet(context);
                              }),
                          IconButton(
                              onPressed: () {
                                calenderCub =
                                    BlocProvider.of<CalendarCubit>(context);
                                authCub = BlocProvider.of<AuthCubit>(context);
                                calenderCub.EventList(
                                    projectIdMain,
                                    orgId,
                                    mobileOrgId,
                                    "${DateTime.now().subtract(Duration(days: 150)).toUtc().millisecondsSinceEpoch}",
                                    "${DateTime.now().add(Duration(days: 150)).toUtc().millisecondsSinceEpoch}");
                                /* _tabController = TabController(length: 4, vsync: this);
                           calenderCub = BlocProvider.of<CalendarCubit>(context);
                           authCub = BlocProvider.of<AuthCubit>(context);
                           dropDownCub = BlocProvider.of<DropDownCubit>(context);
                           calenderCub.isCalender=true;
                           // calenderCub.EventList(projectIdMain, authCub.userInfo!.user!.organizationId!,"${DateTime.now().subtract(Duration(days: 150)).toUtc().millisecondsSinceEpoch}","${DateTime.now().add(Duration(days: 150)).toUtc().millisecondsSinceEpoch}");
                           dropDownCub.Organizations(organization_id: orgId);
                           dropDownCub.UserSubProjectList(user_id: authCub.userInfo!.user!.id!, project_id: projectIdMain, organization_id: orgId);
                           dropDownCub.resourcesList(projectIdMain,orgId);
                           dropDownCub.filterStatus(projectIdMain);
                           dropDownCub.filterTransportType(projectIdMain);*/
                              },
                              icon: Icon(Icons.refresh)),
                        ],
                      ),
                      getDivider(height: 10)
                    ],
                  ),
                ),
                BlocBuilder<CalendarCubit, CalendarState>(
                  builder: (context, state) {
                    return  Container(
                      height: _selectedIndex == 3
                          ? screenHeight(context, dividedBy: 10)
                          : screenHeight(context, dividedBy: 5.8),
                      width: screenWidth(context),
                      margin: EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: HexColor.Gray53.withOpacity(0.2),
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset: Offset(0, 5), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Container(
                            color: Colors.transparent,
                            height: 50,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                _selectedIndex == 0
                                    ? Container(
                                    width: screenWidth(context,
                                        dividedBy: 2.5),
                                    height: screenHeight(context,
                                        dividedBy: 16),
                                    alignment: Alignment.center,
                                    child: commonText(
                                        DateFormat('MMM dd, yyyy').format(
                                            DateTime.parse(
                                                "${BlocProvider.of<CalendarCubit>(context).projectDate}")),
                                        color: HexColor.orange,
                                        fontFamily: LexendBold,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 14))
                                    : _selectedIndex == 1
                                    ? Container(
                                  width: screenWidth(context,
                                      dividedBy: 2.5),
                                  color: Colors.transparent,
                                  alignment: Alignment.center,
                                  child: Row(
                                    children: [
                                      Container(
                                          height: screenHeight(
                                              context,
                                              dividedBy: 16),
                                          alignment: Alignment.center,
                                          child: commonText(
                                              DateFormat('MMM d-')
                                                  .format(DateTime.parse(
                                                  "${BlocProvider.of<CalendarCubit>(context).weekStartDate}")),
                                              color: HexColor.orange,
                                              fontFamily: LexendBold,
                                              fontWeight:
                                              FontWeight.w700,
                                              fontSize: 14)),
                                      Container(
                                          height: screenHeight(
                                              context,
                                              dividedBy: 16),
                                          alignment: Alignment.center,
                                          child: commonText(
                                              DateFormat(
                                                  'MMM dd, yyyy')
                                                  .format(DateTime.parse(
                                                  "${BlocProvider.of<CalendarCubit>(context).weekEndDate}")),
                                              color: HexColor.orange,
                                              fontFamily: LexendBold,
                                              fontWeight:
                                              FontWeight.w700,
                                              fontSize: 14)),
                                    ],
                                  ),
                                )
                                    : _selectedIndex == 2
                                    ? Container(
                                    width: screenWidth(context,
                                        dividedBy: 2.5),
                                    height: screenHeight(context,
                                        dividedBy: 16),
                                    alignment: Alignment.center,
                                    child: commonText(DateFormat('yyyy-MMM').format(DateTime.parse("${BlocProvider.of<CalendarCubit>(context).projectDate}")),
                                        color: HexColor.orange,
                                        fontFamily: LexendBold,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 14))
                                    : _selectedIndex == 3
                                    ? Container(
                                    width: screenWidth(context,
                                        dividedBy: 2.5),
                                    height: screenHeight(context,
                                        dividedBy: 16),
                                    alignment: Alignment.center,
                                    child: commonText(
                                        DateFormat('yyyy-MMM').format(DateTime.parse("${BlocProvider.of<CalendarCubit>(context).projectDate}")),
                                        color: HexColor.orange,
                                        fontFamily: LexendBold,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 14))
                                    : Container(),
                                Expanded(
                                  child: getCommonFourTabBar(
                                    ctx: context,
                                    tab1: 'Day',
                                    tab2: 'Week',
                                    tab3: 'Month',
                                    tab4: 'List',
                                    controller: _tabController,
                                    onTap: (index) {
                                      _selectedIndex = index;
                                    },
                                  ),
                                ),
                                SizedBox(width: 20),
                                /* PopupMenuButton(
                                        constraints: BoxConstraints(maxWidth: 150),
                                        icon: Icon(
                                          Icons.more_vert_outlined,
                                          size: 25,
                                          color: Color(0xFF5F6368),
                                        ),
                                        offset: Offset(-20, 50),
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10.0))),
                                        onSelected: (value) async {
                                          if (value == 1) {
                                            // Navigator.push(context, MaterialPageRoute(builder: (context) {
                                            //   return UnbookedShipment();
                                            // },));
                                            String? returnVal =
                                                await Navigator.push(context,
                                                    MaterialPageRoute(
                                              builder: (context) {
                                                return Shipment(true);
                                              },
                                            ));
                                            if (returnVal == "Success") {
                                              calenderCub.EventList(
                                                  projectIdMain,
                                                  orgId,
                                                  mobileOrgId,
                                                  "${DateTime.now().subtract(Duration(days: 150)).toUtc().millisecondsSinceEpoch}",
                                                  "${DateTime.now().add(Duration(days: 150)).toUtc().millisecondsSinceEpoch}");
                                            }
                                            ;
                                            setState(() {});
                                          } else if (value == 2) {
                                            String? returnVal =
                                                await Navigator.push(context,
                                                    MaterialPageRoute(
                                              builder: (context) {
                                                return TerminalTransportShipment();
                                              },
                                            ));
                                            if (returnVal == "Success") {
                                              calenderCub.EventList(
                                                  projectIdMain,
                                                  orgId,
                                                  mobileOrgId,
                                                  "${DateTime.now().subtract(Duration(days: 150)).toUtc().millisecondsSinceEpoch}",
                                                  "${DateTime.now().add(Duration(days: 150)).toUtc().millisecondsSinceEpoch}");
                                            }
                                            ;
                                            setState(() {});
                                          } else if (value == 3) {
                                            Navigator.push(context,
                                                MaterialPageRoute(
                                              builder: (context) {
                                                return WasteDisposal();
                                              },
                                            ));
                                          }
                                        },
                                        // onSelected: (value) {
                                        //   setState(() {
                                        //     mainIndex = value;
                                        //     print("main index=${mainIndex}");
                                        //   });
                                        // },
                                        itemBuilder: (BuildContext context) =>
                                            <PopupMenuEntry<int>>[
                                              PopupMenuItem(
                                                height: 35,
                                                value: 0,
                                                child: Text(
                                                  'Show Weekends',
                                                  style: TextStyle(
                                                      color: HexColor.Gray53,
                                                      fontSize: 14),
                                                ),
                                              ),
                                              PopupMenuDivider(height: 0),
                                              PopupMenuItem(
                                                height: 40,
                                                value: 1,
                                                child: Text(
                                                  'Unbooked',
                                                  style: TextStyle(
                                                      color: HexColor.Gray53,
                                                      fontSize: 14),
                                                ),
                                              ),
                                              PopupMenuDivider(
                                                height: 0,
                                              ),
                                              PopupMenuItem(
                                                // onTap: () {
                                                //   Navigator.push(context, MaterialPageRoute(builder: (context) {
                                                //     return TerminalTransportShipment();
                                                //   },));
                                                //   log("terminalBooking");
                                                // },
                                                height: 35,
                                                value: 2,
                                                child: Text(
                                                  'Terminal Booking',
                                                  style: TextStyle(
                                                      color: HexColor.Gray53,
                                                      fontSize: 14),
                                                ),
                                              ),
                                              PopupMenuDivider(
                                                height: 0,
                                              ),
                                              PopupMenuItem(
                                                // onTap: () {
                                                //   Navigator.push(context, MaterialPageRoute(builder: (context) {
                                                //     return TerminalTransportShipment();
                                                //   },));
                                                //   log("terminalBooking");
                                                // },
                                                height: 35,
                                                value: 3,
                                                child: Text(
                                                  'Waste Disposal',
                                                  style: TextStyle(
                                                      color: HexColor.Gray53,
                                                      fontSize: 14),
                                                ),
                                              ),
                                            ])*/
                              ],
                            ),
                          ),
                          _selectedIndex == 0
                              ? WeeklyDatePicker(
                            selectedDay:
                            BlocProvider.of<CalendarCubit>(context)
                                .projectDate,
                            changeDay: (value) => setState(() {
                              BlocProvider.of<CalendarCubit>(context)
                                  .projectDate = value;
                              log("value=${value}");
                            }),

                            enableWeeknumberText: false,
                            weeknumberColor: Color(0xFF57AF87),
                            weeknumberTextColor: Colors.white,
                            backgroundColor: Colors.transparent,
                            weekdayTextColor: Colors.black,
                            digitsColor: Colors.black,
                            selectedBackgroundColor: HexColor.orange,
                            weekdays:  _weekDays,
                            daysInWeek:  7 ,
                          )
                              : _selectedIndex == 1
                              ? Expanded(
                            child: Container(
                              width: screenWidth(context),
                              color: Colors.transparent,
                              child: Row(
                                crossAxisAlignment:
                                CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: screenWidth(context,
                                        dividedBy: 7),
                                    color: Colors.transparent,
                                  ),
                                  ...List.generate(
                                    BlocProvider.of<CalendarCubit>(
                                        context)
                                        .listDate
                                        .length,
                                        (index) => Expanded(
                                        child: Container(
                                          color: Colors.transparent,
                                          child: Center(
                                            child: Column(
                                              mainAxisSize:
                                              MainAxisSize.min,
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .center,
                                              children: [
                                                commonText(
                                                    "${_weekDays[index]}",
                                                    color: Colors.black,
                                                    fontFamily:
                                                    LexendRegular,
                                                    fontWeight:
                                                    FontWeight.w400,
                                                    fontSize: 14),
                                                Container(
                                                    height: 30,
                                                    width: 30,
                                                    alignment:
                                                    Alignment.center,
                                                    decoration: BoxDecoration(
                                                        shape: BoxShape
                                                            .circle,
                                                        color: Colors
                                                            .transparent),
                                                    child: commonText(
                                                        "${BlocProvider.of<CalendarCubit>(context).listDate[index]}",
                                                        color:
                                                        Colors.black,
                                                        fontFamily:
                                                        LexendRegular,
                                                        fontWeight:
                                                        FontWeight
                                                            .w400,
                                                        fontSize: 14)),
                                              ],
                                            ),
                                          ),
                                        )),
                                  )
                                ],
                              ),
                            ),
                          )
                              : _selectedIndex == 2
                              ? Expanded(
                            child: Container(
                              width: screenWidth(context),
                              color: Colors.transparent,
                              child: Row(
                                crossAxisAlignment:
                                CrossAxisAlignment.center,
                                children: [

                                  ...List.generate(
                                    BlocProvider.of<
                                        CalendarCubit>(
                                        context)
                                        .listDate
                                        .length,
                                        (index) => Expanded(
                                      child: Container(
                                        color: Colors.transparent,
                                        child: Center(
                                          child: Column(
                                            mainAxisSize:
                                            MainAxisSize.min,
                                            mainAxisAlignment:
                                            MainAxisAlignment
                                                .center,
                                            children: [
                                              commonText(
                                                  "${_weekDays[index]}",
                                                  color: Colors
                                                      .black,
                                                  fontFamily:
                                                  LexendRegular,
                                                  fontWeight:
                                                  FontWeight
                                                      .w400,
                                                  fontSize: 14),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                              : Container(),
                        ],
                      ),
                    );
                  },
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      DayViewPage(),
                      WeekView(),
                      MonthViewPage(),
                      EventList(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

// @override
// Widget build(BuildContext context) {
//   return BlocBuilder<CalendarCubit,CalendarState>(
//     builder: (context, state) {
//       if(state is EventListLoading && calenderCub.isCalender==true){
//         return CalendarControllerProvider(
//           controller: EventController<Event>()..addAll([]),
//           child: Scaffold(
//             body: Container(
//               child: loader(),
//             ),
//           ),
//         );
//       } else {
//         return  CalendarControllerProvider(
//           controller: EventController<Event>()..addAll(calenderCub.events),
//           child:
//           Scaffold(
//             body:  Stack(
//               children: [
//                 Container(
//                   height: screenHeight(context),
//                   width: screenWidth(context),
//                   color: Colors.white,
//                   child: Column(
//                     children: [
//                       Container(
//                         height: screenHeight(context, dividedBy: 9),
//                         width: screenWidth(context),
//                         padding: EdgeInsets.symmetric(horizontal: 15),
//                         color: Colors.white,
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.end,
//                           children: [
//                             Row(
//                               children: [
//                                 GestureDetector(
//                                   onTap: () => Navigation.instance.goBack(),
//                                   child: const Icon(Icons.arrow_back_ios, color: Colors.black),
//                                 ),
//                                 commonText("Project Name",
//                                     color: Colors.black,
//                                     fontFamily: LexendBold,
//                                     fontWeight: FontWeight.w700,
//                                     fontSize: 20),
//                                 Spacer(),
//                                 getContainerWithImage(
//                                     ctx: context,
//                                     icons: icons.ic_shipment,
//                                     onTap: () {
//                                       shipmentsBottomSheet(context);
//                                     }),
//                                 getContainerWithImage(
//                                     ctx: context,
//                                     icons: icons.ic_filter,
//                                     onTap: () {
//                                       filterBottomSheet(context);
//                                     }),
//                               ],
//                             ),
//                             getDivider(height: 10)
//                           ],
//                         ),
//                       ),
//                       BlocBuilder<CalendarCubit, CalendarState>(
//                         builder: (context, state) {
//                           return  Container(
//                             height: _selectedIndex == 3?screenHeight(context,dividedBy: 10):screenHeight(context, dividedBy: 5.8),
//                             width: screenWidth(context),
//                             margin: EdgeInsets.only(bottom: 10),
//                             decoration: BoxDecoration(
//                               color: Colors.white,
//                               boxShadow: [
//                                 BoxShadow(
//                                   color: HexColor.Gray53.withOpacity(0.2),
//                                   spreadRadius: 1,
//                                   blurRadius: 5,
//                                   offset: Offset(0, 5), // changes position of shadow
//                                 ),
//                               ],
//                             ),
//                             child: Column(
//                               children: [
//                                 Container(
//                                   color: Colors.transparent,
//                                   height: 50,
//                                   child: Row(
//                                     crossAxisAlignment: CrossAxisAlignment.center,
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       _selectedIndex == 0 ?Container(
//                                           width: screenWidth(context,dividedBy: 2.5),
//                                           height:
//                                           screenHeight(context, dividedBy: 16),
//                                           alignment: Alignment.center,
//
//                                           child: commonText(
//                                               DateFormat('MMM dd, yyyy').format(
//                                                   DateTime.parse(
//                                                       "${BlocProvider.of<CalendarCubit>(context).projectDate}")),
//                                               color: HexColor.orange,
//                                               fontFamily: LexendBold,
//                                               fontWeight: FontWeight.w700,
//                                               fontSize: 14)):_selectedIndex == 1? Container(
//                                         width: screenWidth(context,dividedBy: 2.5),
//                                         color: Colors.transparent,
//                                         alignment: Alignment.center,
//                                         child: Row(
//                                           children: [
//                                             Container(
//                                                 height:
//                                                 screenHeight(context, dividedBy: 16),
//                                                 alignment: Alignment.center,
//                                                 child: commonText(
//                                                     DateFormat('MMM d-').format(
//                                                         DateTime.parse(
//                                                             "${BlocProvider.of<CalendarCubit>(context).weekStartDate}")),
//                                                     color: HexColor.orange,
//                                                     fontFamily: LexendBold,
//                                                     fontWeight: FontWeight.w700,
//                                                     fontSize: 14)),
//                                             Container(
//                                                 height:
//                                                 screenHeight(context, dividedBy: 16),
//                                                 alignment: Alignment.center,
//                                                 child: commonText(
//                                                     DateFormat('MMM dd, yyyy').format(
//                                                         DateTime.parse(
//                                                             "${BlocProvider.of<CalendarCubit>(context).weekEndDate}")),
//                                                     color: HexColor.orange,
//                                                     fontFamily: LexendBold,
//                                                     fontWeight: FontWeight.w700,
//                                                     fontSize: 14)),
//                                           ],
//                                         ),
//                                       ):_selectedIndex == 2?Container(
//                                           width: screenWidth(context,dividedBy: 2.5),
//                                           height:
//                                           screenHeight(context, dividedBy: 16),
//                                           alignment: Alignment.center,
//                                           child: commonText(
//                                               DateFormat('yyyy-MMM').format(
//                                                   DateTime.parse(
//                                                       "${BlocProvider.of<CalendarCubit>(context).projectDate}")),
//                                               color: HexColor.orange,
//                                               fontFamily: LexendBold,
//                                               fontWeight: FontWeight.w700,
//                                               fontSize: 14)):_selectedIndex == 3?Container(
//                                           width: screenWidth(context,dividedBy: 2.5),
//                                           height:
//                                           screenHeight(context, dividedBy: 16),
//                                           alignment: Alignment.center,
//                                           child: commonText(
//                                               DateFormat('yyyy-MMM').format(
//                                                   DateTime.parse(
//                                                       "${BlocProvider.of<CalendarCubit>(context).projectDate}")),
//                                               color: HexColor.orange,
//                                               fontFamily: LexendBold,
//                                               fontWeight: FontWeight.w700,
//                                               fontSize: 14)):Container(),
//                                       Expanded(
//                                         child: getCommonFourTabBar(
//                                           ctx: context,
//                                           tab1: 'Day',
//                                           tab2: 'Week',
//                                           tab3: 'Month',
//                                           tab4: 'List',
//                                           controller: _tabController, onTap: (index) {
//                                           _selectedIndex = index;
//                                         },
//                                         ),
//                                       ),
//                                       PopupMenuButton(
//                                           constraints: BoxConstraints(maxWidth: 150),
//                                           icon: Icon(
//                                             Icons.more_vert_outlined,
//                                             size: 25,
//                                             color: Color(0xFF5F6368),
//                                           ),
//                                           offset: Offset(-20, 50),
//                                           shape: RoundedRectangleBorder(
//                                               borderRadius: BorderRadius.all(Radius.circular(10.0))
//                                           ),
//                                           onSelected: (value) {
//                                             if(value == 1){
//                                               // Navigator.push(context, MaterialPageRoute(builder: (context) {
//                                               //   return UnbookedShipment();
//                                               // },));
//                                               Navigator.push(context, MaterialPageRoute(builder: (context) {
//                                                 return Shipment(true);
//                                               },));
//                                             }
//                                             else if(value == 2){
//                                               Navigator.push(context, MaterialPageRoute(builder: (context) {
//                                                 return TerminalTransportShipment();
//                                               },));
//                                             }
//                                             else if(value == 3){
//                                               Navigator.push(context, MaterialPageRoute(builder: (context) {
//                                                 return WasteDisposal();
//                                               },));
//                                             }
//
//                                           },
//                                           // onSelected: (value) {
//                                           //   setState(() {
//                                           //     mainIndex = value;
//                                           //     print("main index=${mainIndex}");
//                                           //   });
//                                           // },
//                                           itemBuilder: (BuildContext context) => <PopupMenuEntry<int>>[
//                                             PopupMenuItem(
//                                               height: 35,
//                                               value: 0,
//                                               child: Text(
//                                                 'Show Weekends',
//                                                 style: TextStyle(
//                                                     color: HexColor.Gray53,fontSize: 14),
//                                               ),
//                                             ),
//                                             PopupMenuDivider(height: 0),
//                                             PopupMenuItem(
//                                               height: 40,
//                                               value: 1,
//                                               child: Text(
//                                                 'Unbooked',
//                                                 style: TextStyle(
//                                                     color: HexColor.Gray53,fontSize: 14),
//                                               ),
//                                             ),
//                                             PopupMenuDivider(height: 0,),
//                                             PopupMenuItem(
//                                               // onTap: () {
//                                               //   Navigator.push(context, MaterialPageRoute(builder: (context) {
//                                               //     return TerminalTransportShipment();
//                                               //   },));
//                                               //   log("terminalBooking");
//                                               // },
//                                               height: 35,
//                                               value: 2,
//                                               child: Text(
//                                                 'Terminal Booking',
//                                                 style: TextStyle(
//                                                     color: HexColor.Gray53,fontSize: 14),
//                                               ),
//                                             ),
//                                             PopupMenuDivider(height: 0,),
//                                             PopupMenuItem(
//                                               // onTap: () {
//                                               //   Navigator.push(context, MaterialPageRoute(builder: (context) {
//                                               //     return TerminalTransportShipment();
//                                               //   },));
//                                               //   log("terminalBooking");
//                                               // },
//                                               height: 35,
//                                               value: 3,
//                                               child: Text(
//                                                 'Waste Disposal',
//                                                 style: TextStyle(
//                                                     color: HexColor.Gray53,fontSize: 14),
//                                               ),
//                                             ),
//                                           ])
//                                     ],
//                                   ),
//                                 ),
//                                 _selectedIndex == 0?WeeklyDatePicker(
//                                   selectedDay: BlocProvider.of<CalendarCubit>(context).projectDate,
//                                   changeDay: (value) => setState(() {
//                                     BlocProvider.of<CalendarCubit>(context).projectDate= value;
//                                     log("value=${value}");
//                                   }),
//                                   enableWeeknumberText: false,
//                                   weeknumberColor:  Color(0xFF57AF87),
//                                   weeknumberTextColor: Colors.white,
//                                   backgroundColor: Colors.transparent,
//                                   weekdayTextColor: Colors.black,
//                                   digitsColor: Colors.black,
//                                   selectedBackgroundColor: HexColor.orange,
//                                   weekdays:_weekDays,
//                                   daysInWeek: 7,
//                                 ):_selectedIndex == 1?
//                                 Expanded(
//                                   child: Container(
//                                     width: screenWidth(context),
//                                     color: Colors.transparent,
//                                     child: Row(
//                                       crossAxisAlignment: CrossAxisAlignment.center,
//                                       children: [
//                                         Container(
//                                           width: screenWidth(context, dividedBy: 7),
//                                           color: Colors.transparent,
//                                         ),
//                                         ...List.generate(
//                                           BlocProvider.of<CalendarCubit>(context)
//                                               .listDate
//                                               .length,
//                                               (index) => SizedBox(
//                                             height: 50,
//                                             width:
//                                             screenWidth(context, dividedBy: 8.2),
//                                             child: Center(
//                                               child: Column(
//                                                 mainAxisSize: MainAxisSize.min,
//                                                 mainAxisAlignment:
//                                                 MainAxisAlignment.center,
//                                                 children: [
//                                                   commonText("${_weekDays[index]}", color: Colors.black, fontFamily: LexendRegular, fontWeight: FontWeight.w400, fontSize: 14),
//                                                   Container(
//                                                       height: 30,
//                                                       width: 30,
//                                                       alignment: Alignment.center,
//                                                       decoration: BoxDecoration(
//                                                           shape: BoxShape.circle,
//                                                           color: Colors.transparent
//                                                       ),
//                                                       child: commonText("${BlocProvider.of<CalendarCubit>(context).listDate[index]}", color: Colors.black, fontFamily: LexendRegular, fontWeight: FontWeight.w400, fontSize: 14)
//                                                   ),
//                                                 ],
//                                               ),
//                                             ),
//                                           ),
//                                         )
//                                       ],
//                                     ),
//                                   ),
//                                 ):_selectedIndex == 2?Expanded(
//                                   child: Container(
//                                     width: screenWidth(context),
//                                     color: Colors.transparent,
//                                     child: Row(
//                                       crossAxisAlignment: CrossAxisAlignment.center,
//                                       children: [
//                                         ...List.generate(
//                                           BlocProvider.of<CalendarCubit>(context)
//                                               .listDate
//                                               .length,
//                                               (index) => Expanded(
//                                             child: Container(
//                                               color: Colors.transparent,
//                                               child: Center(
//                                                 child: Column(
//                                                   mainAxisSize: MainAxisSize.min,
//                                                   mainAxisAlignment:
//                                                   MainAxisAlignment.center,
//                                                   children: [
//                                                     commonText("${_weekDays[index]}", color: Colors.black, fontFamily: LexendRegular, fontWeight: FontWeight.w400, fontSize: 14),
//                                                   ],
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                         )
//                                       ],
//                                     ),
//                                   ),
//                                 ):Container(),
//
//                               ],
//                             ),
//                           );
//                         },
//                       ),
//                       Expanded(
//                         child: TabBarView(
//                           controller: _tabController,
//                           children:  [
//                             DayViewPage(),
//                             WeekView(),
//                             MonthViewPage(),
//                             EventList(),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       }
//     },);
// }
}
