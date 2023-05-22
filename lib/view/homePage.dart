import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ftx/navigationX.dart';
import 'package:intl/intl.dart';
import 'package:proj_site/common/colors/colors.dart';
import 'package:proj_site/common/image_constant/image_constant.dart';
import 'package:proj_site/common/widget_constant/widget_constant.dart';
import 'package:proj_site/cubits/auth_cubit.dart';
import 'package:proj_site/cubits/calendar_cubit.dart';
import 'package:proj_site/cubits/dashboard_cubit.dart';
import 'package:proj_site/cubits/shipment_cubit.dart';
import 'package:proj_site/helper/helper.dart';
import 'package:proj_site/services/sharedpreference_service.dart';
import 'package:proj_site/view/dashBoard.dart';
import 'package:proj_site/view/dashboard_card.dart';
import 'package:proj_site/view/projectName.dart';

class HomePage extends StatefulWidget {
  static const id = 'HomePage_screen';
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  late ShipmentCubit shipmentCub;
  late AuthCubit authCub;
  late DashBoardCubit dashBoardCub;

  SharedPreferenceService prefs = SharedPreferenceService();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    authCub=BlocProvider.of<AuthCubit>(context);
    shipmentCub=BlocProvider.of<ShipmentCubit>(context);
    dashBoardCub=BlocProvider.of<DashBoardCubit>(context);
    shipmentCub.MonthlyShipments(orgId, shipmentCub.status);
    dashBoardCub.PendingShipmentList(orgId, authCub.userInfoLogin!.projects!, authCub.userInfoLogin!.mobileOrganizationId!);
  }

  Widget userShipmentsStatus(int index){
    return Container(
      color: Colors.transparent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          getDivider(height: 15),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  commonText(dashBoardCub.pendingShipmentList[index].projectName.toString(), color: Colors.black, fontFamily: LexendRegular, fontWeight: FontWeight.w400, fontSize: 16),
                  verticalSpaces(context, height: 150),
                  getCenterIconWithText(startTime: dashBoardCub.pendingShipmentList[index].from.toString(), endTime: dashBoardCub.pendingShipmentList[index].to.toString()),
                ],
              ),
              Expanded(child: getRoundedCornerContainer(ctx: context, status: dashBoardCub.pendingShipmentList[index].shipmentType.toString(), boxColor: HexColor.yellow.withOpacity(0.3), textColor: HexColor.yellow, fontSize: 12))
            ],
          ),
          getSimpleRowText(sub1: "Responsible person", sub2: "${dashBoardCub.pendingShipmentList[index].responsiblePersonFirstName.toString()} ${dashBoardCub.pendingShipmentList[index].responsiblePersonLastName.toString()}"),
          getSimpleRowText(sub1: "Unloading Zone", sub2: dashBoardCub.pendingShipmentList[index].unloadingZone.toString()),
          getSimpleRowText(sub1: "Request Type", sub2: dashBoardCub.pendingShipmentList[index].shipmentType.toString()),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              getIconWithUnderlineText(
                ctx: context,
                icon: icons.ic_eyes,
                iconColor: HexColor.aliceblue,
                textColor: HexColor.aliceblue,
                underlineColor: HexColor.aliceblue, text: 'View', width: screenWidth(context,dividedBy: 5), height: screenHeight(context,dividedBy: 28),
                onTap: () async {
                  String? returnVal= await showDialog<String>(
                    barrierDismissible: false,
                    builder: (_) => DashBoardCard(index: index,), context: context
                  );
                  if(returnVal=="Success"){
                    shipmentCub.MonthlyShipments(orgId, shipmentCub.status);
                    dashBoardCub.PendingShipmentList(orgId, authCub.userInfoLogin!.projects!, authCub.userInfoLogin!.mobileOrganizationId!);
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  DateTime dateTime=DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBarWithText(title:"$orgVal", ctx: context) as PreferredSizeWidget?,
      backgroundColor: Colors.white,
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // IconButton(onPressed: () {
            //   Map map={};
            //   BlocProvider.of<ShipmentCubit>(context).UpdateShipment(map);
            // }, icon: Icon(Icons.add)),
            Container(padding: EdgeInsets.symmetric(horizontal: 15),child: commonText("Total this month", color: Colors.black, fontFamily: LexendSemiBold, fontWeight: FontWeight.w600, fontSize: 14)),
            BlocConsumer<ShipmentCubit,ShipmentState>(
              listener: (context, state) {
                if(state is MonthlyShipmentsSuccess){
                  if(shipmentCub.status=="approved"){
                    shipmentCub.status="rejected";
                    shipmentCub.MonthlyShipments(orgId, shipmentCub.status);
                  }else if(shipmentCub.status=="pending"){
                    shipmentCub.status="approved";
                    shipmentCub.MonthlyShipments(orgId, shipmentCub.status);
                  }else if(shipmentCub.status=="rejected"){
                    shipmentCub.status="pending";
                  }
                   log("mystatus${shipmentCub.status}");
                }
              }, builder: (context, state) {
              return getCommonContainer(
                height: screenHeight(context,dividedBy: 9),
                width: screenWidth(context),
                color: Colors.white,
                child: Row(
                    children: [
                      getUserStatus(
                          ctx: context,
                          count: state is MonthlyShipmentsLoading
                              ? ""
                              : shipmentCub.totalApprovedShipment,
                          status: "Approved shipments",
                          color: HexColor.greenCyan.withOpacity(0.4),
                          margin: EdgeInsets.only(left: 15, right: 7.5),
                          textColor: HexColor.greenCyan),
                      getUserStatus(
                          ctx: context,
                          count: state is MonthlyShipmentsLoading
                              ? ""
                              : shipmentCub.totalPendingShipment,
                          status: "Pending shipments",
                          color: HexColor.buttonColor.withOpacity(0.5),
                          margin: EdgeInsets.only(left: 7.5, right: 7.5),
                          textColor: Colors.orange.withOpacity(0.8)),
                      getUserStatus(
                          ctx: context,
                          count: state is MonthlyShipmentsLoading
                              ? ""
                              : shipmentCub.totalRejectedShipment,
                          status: "Rejected shipments",
                          color: HexColor.carnation.withOpacity(0.4),
                          margin: EdgeInsets.only(left: 7.5, right: 15),
                          textColor: HexColor.carnation),
                      // getUserStatus( ctx: context, count: "50", status: "Approved shipments", color: HexColor.greenCyan.withOpacity(0.3), margin: EdgeInsets.only(left: 15,right: 7.5), textColor: HexColor.greenCyan),
                      // getUserStatus( ctx: context, count: "25", status: "Pending shipments", color: HexColor.lavender.withOpacity(0.3), margin: EdgeInsets.only(left: 7.5,right: 7.5), textColor: HexColor.lavender),
                      // getUserStatus( ctx: context, count:  "3", status: "Rejected shipments", color: HexColor.carnation.withOpacity(0.3),  margin: EdgeInsets.only(left: 7.5,right: 15), textColor: HexColor.carnation),
                    ],
                  ),
              );
            }, ),

            verticalSpaces(context, height: 80),
            getCommonContainer(
              height: screenHeight(context,dividedBy: 15),
              padding: EdgeInsets.only(left: 15),
              width: screenWidth(context),
              color: Colors.white,
              child: getContainerWithTralingIcon(ctx: context, text: 'Pending shipments',onTap_xlsx: (){
              }),
            ),
         Expanded(child: BlocBuilder<DashBoardCubit, DashBoardState>(
           builder: (context, state) {
             if(state is PendingShipmentListLoading){
               return loader();
             }else if (state is PendingShipmentListError){
               return errorLoadDataText();
             }
             else{
               return ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    itemCount: dashBoardCub.pendingShipmentList.length,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return getCommonContainer(
                        color: Colors.white,
                        height: screenHeight(context, dividedBy: 5),
                        width: screenWidth(context),
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: GestureDetector(
                            onTap: () {
                              // Navigation.instance.navigate(ProjectName.id);
                            },
                            child: userShipmentsStatus(index)),
                      );
                    },
                  );
             }

           },
         )),
         // Expanded(
         //   child: ListView.builder(padding: EdgeInsets.zero,shrinkWrap: true,itemCount: 10  ,physics: BouncingScrollPhysics(),itemBuilder: (context, index) {
         //     return getCommonContainer(
         //       color: Colors.white,
         //       height: screenHeight(context,dividedBy: 6),
         //       width: screenWidth(context),
         //       padding: EdgeInsets.symmetric(horizontal: 15),
         //       child: GestureDetector(onTap: () {
         //        // Navigation.instance.navigate(ProjectName.id);
         //       },child: userShipmentsStatus()),
         //     );
         //   },),
         // )
          ],
        ),
      ),
    );
  }
}
