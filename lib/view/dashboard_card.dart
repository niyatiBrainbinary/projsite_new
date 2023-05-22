import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:proj_site/common/colors/colors.dart';
import 'package:proj_site/common/widget_constant/widget_constant.dart';
import 'package:proj_site/cubits/auth_cubit.dart';
import 'package:proj_site/cubits/booking_cubit.dart';
import 'package:proj_site/cubits/calendar_cubit.dart';
import 'package:proj_site/cubits/dashboard_cubit.dart';
import 'package:proj_site/cubits/drop_down_cubit.dart';
import 'package:proj_site/cubits/shipment_cubit.dart';
import 'package:proj_site/cubits/terminal_cubit.dart';
import 'package:proj_site/cubits/transport_request_cubit.dart';
import 'package:proj_site/helper/helper.dart';
import 'package:proj_site/view/booking_history.dart';
import 'package:proj_site/view/logisticList/updateTransportRequestShipment.dart';
import 'package:proj_site/view/terminalTransportBooking/updateTerminalTransportShipment.dart';
import 'package:proj_site/view/updateShipmentRequest/updateShipment.dart';
import 'package:proj_site/common/image_constant/image_constant.dart';

class DashBoardCard extends StatefulWidget {
  DashBoardCard({
    required this.index,
  }) : super();

  final int index;


  @override
  State<DashBoardCard> createState() => _DashBoardCardState();
}

class _DashBoardCardState extends State<DashBoardCard> {

  bool isApprove= false;
  late TransportRequestCubit transportRequestCub;
  late AuthCubit authCub;
  late DashBoardCubit dashBoardCub;
  late ShipmentCubit shipmentCub;
  late CalendarCubit calendarCub;
  late DropDownCubit dropDownCub;

  closeRequestDialogue(BuildContext context){
    showDialog(
      barrierColor: Colors.black.withOpacity(0.4),barrierDismissible: false,
      builder: (context) {
        return Container(
          child: AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))
            ),
            contentPadding: EdgeInsets.only(left: 18,right: 18,top: 18,bottom: 18),
            content: Container(
              height: screenHeight(context,dividedBy: 5),
              width: screenWidth(context),
              color: Colors.transparent,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Center(child:Text("Are you sure you want to close this request?",style: TextStyle(color: Colors.black,fontFamily: LexendRegular,fontSize: 16,))),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      commonButton(
                          context: context,
                          buttonName:
                          "No",
                          width: 95,
                          buttonColor: HexColor
                              .Gray53
                              .withOpacity(
                              0.5),
                          onTap: () {
                            Navigator.pop(
                                context);
                          }),

                      dashBoardCub.pendingShipmentList[widget.index].shipmentType=="To Terminal Transport"?
                      BlocBuilder<TerminalCubit, TerminalState>(
                        builder: (context, state) {
                          if(state is CloseTerminalLoading){
                            return commonLoadingButton(context: context,width: 95);
                          }
                          else {
                            return commonButton(context: context, buttonName: "Yes",width: 95,onTap: (){
                              BlocProvider.of<TerminalCubit>(context).CloseTerminal(context,dashBoardCub.pendingShipmentList[widget.index].requestId!);

                              BlocProvider.of<BookingCubit>(context).AddBooking(calendarCub.requestData!.result!.id.toString(), calendarCub.requestData!.result!.responsiblePersonId.toString());
                            });
                          }
                        },
                      ):dashBoardCub.pendingShipmentList[widget.index].shipmentType=="Shipment Transport"?
                      BlocBuilder<ShipmentCubit, ShipmentState>(
                        builder: (context, state) {
                          if(state is CloseShipmentLoading){
                            return commonLoadingButton(context: context,width: 95);
                          }
                          else {
                            return commonButton(context: context, buttonName: "Yes",width: 95,onTap: (){
                              shipmentCub.CloseShipment(context,dashBoardCub.pendingShipmentList[widget.index].requestId!);
                              BlocProvider.of<BookingCubit>(context).AddBooking(calendarCub.requestData!.result!.id.toString(), calendarCub.requestData!.result!.responsiblePersonId.toString());
                            });
                          }
                        },
                      ):BlocBuilder<TransportRequestCubit, TransportRequestState>(
                        builder: (context, state) {
                          if(state is CloseTransportRequestLoading){
                            return commonLoadingButton(context: context,width: 95);
                          }
                          else {
                            return commonButton(context: context, buttonName: "Yes",width: 95,onTap: (){
                              transportRequestCub.CloseTransportRequest(context, dashBoardCub.pendingShipmentList[widget.index].requestId!);
                              BlocProvider.of<BookingCubit>(context).AddBooking(calendarCub.requestData!.result!.id.toString(), calendarCub.requestData!.result!.responsiblePersonId.toString());
                            });
                          }
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      }, context: context,
    );

  }

  statusUpdateDialogue(BuildContext context){
    showDialog(
      barrierColor: Colors.black.withOpacity(0.4),barrierDismissible: false,
      builder: (context) {
        return Container(
          child: AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))
            ),
            contentPadding: EdgeInsets.only(left: 18,right: 18,top: 7,bottom: 18),
            content: Container(
              height: screenHeight(context,dividedBy: 5),
              width: screenWidth(context),
              color: Colors.transparent,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(padding: EdgeInsets.zero,constraints: BoxConstraints(),onPressed: () {
                      Navigator.pop(context);
                    }, icon: Icon(Icons.cancel_rounded,size: 30,color: Colors.black,)),
                  ),
                  Text("Status : Pending", style: TextStyle(color: Colors.black,fontFamily: LexendRegular,fontSize: 16,)),
                  SizedBox(height: 20,),
                  dashBoardCub.pendingShipmentList[widget.index].shipmentType=="To Terminal Transport"?
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      BlocBuilder<TerminalCubit, TerminalState>(
                        builder: (context, state) {
                          if(state is UpdateTerminalStatusLoading && isApprove==true){
                            return commonLoadingButton(context: context,width: 95);
                          }
                          else {
                            return commonButton(
                                context: context,
                                buttonName:
                                "Approve",
                                width: 100,
                                onTap: () {
                                  isApprove=true;
                                  setState(() {});
                                  BlocProvider.of<TerminalCubit>(context)
                                      .UpdateTerminalStatus(dashBoardCub.pendingShipmentList[widget.index].requestId!,"approved",context);
                                });
                          }
                        },
                      ),

                      BlocBuilder<ShipmentCubit, ShipmentState>(
                        builder: (context, state) {
                          if(state is UpdateTerminalStatusLoading && isApprove==false){
                            return commonLoadingButton(context: context,width: 95);
                          }
                          else {
                            return commonButton(context: context,
                                buttonColor: HexColor.Gray53.withOpacity(0.5),
                                buttonName: "Reject",width: 100,
                                onTap: (){
                                  isApprove=false;
                                  setState(() {});
                                  BlocProvider.of<TerminalCubit>(context)
                                      .UpdateTerminalStatus(dashBoardCub.pendingShipmentList[widget.index].requestId!,"rejected",context);
                                });
                          }
                        },
                      ),


                    ],
                  ):Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      BlocBuilder<ShipmentCubit, ShipmentState>(
                        builder: (context, state) {
                          if(state is UpdateApprovalStatusLoading && isApprove==true){
                            return commonLoadingButton(context: context,width: 95);
                          }
                          else {
                            return commonButton(
                                context: context,
                                buttonName:
                                "Approve",
                                width: 100,
                                onTap: () {
                                  isApprove=true;
                                  setState(() {});
                                  BlocProvider.of<ShipmentCubit>(context)
                                      .UpdateApprovalStatus("approved",dashBoardCub.pendingShipmentList[widget.index].requestId!,context);
                                });
                          }
                        },
                      ),
                      BlocBuilder<ShipmentCubit, ShipmentState>(
                        builder: (context, state) {
                          if(state is UpdateApprovalStatusLoading && isApprove==false){
                            return commonLoadingButton(context: context,width: 95);
                          }
                          else {
                            return commonButton(context: context,
                                buttonColor: HexColor.Gray53.withOpacity(0.5),
                                buttonName: "Reject",width: 100,
                                onTap: (){
                                  isApprove=false;
                                  setState(() {});
                                  BlocProvider.of<ShipmentCubit>(context)
                                      .UpdateApprovalStatus("rejected",dashBoardCub.pendingShipmentList[widget.index].requestId!,context);
                                });
                          }
                        },
                      ),


                    ],
                  )
                ],
              ),
            ),
          ),
        );
      }, context: context,
    );

  }

  statusUpdateDialogue2(BuildContext context){
    showDialog(
      barrierColor: Colors.black.withOpacity(0.4),barrierDismissible: false,
      builder: (context) {
        return Container(
          child: AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))
            ),
            contentPadding: EdgeInsets.only(left: 18,right: 18,top: 7,bottom: 18),
            content: Container(
              height: screenHeight(context,dividedBy: 5),
              width: screenWidth(context),
              color: Colors.transparent,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(padding: EdgeInsets.zero,constraints: BoxConstraints(),onPressed: () {
                      Navigator.pop(context);
                    }, icon: Icon(Icons.cancel_rounded,size: 30,color: Colors.black,)),
                  ),
                  Text("Status : Transport Requested", style: TextStyle(color: Colors.black,fontFamily: LexendRegular,fontSize: 14,)),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      BlocBuilder<TransportRequestCubit, TransportRequestState>(
                        builder: (context, state) {
                          if(state is UpdateTransportRequestStatusLoading && isApprove==true){
                            return commonLoadingButton(context: context,width: 95);
                          }
                          else {
                            return commonButton(
                                context: context,
                                buttonName:
                                "Approve",
                                width: 100,
                                onTap: () {
                                  isApprove=true;
                                  setState(() {});
                                  transportRequestCub.UpdateTransportRequestStatus(dashBoardCub.pendingShipmentList[widget.index].requestId!, "approved", context);
                                });
                          }
                        },
                      ),
                      BlocBuilder<TransportRequestCubit, TransportRequestState>(
                        builder: (context, state) {
                          if(state is UpdateTransportRequestStatusLoading && isApprove==false){
                            return commonLoadingButton(context: context,width: 95);
                          }
                          else {
                            return commonButton(context: context,
                                buttonColor: HexColor.Gray53.withOpacity(0.5),
                                buttonName: "Reject",width: 100,
                                onTap: (){
                                  isApprove=false;
                                  setState(() {});
                                  transportRequestCub.UpdateTransportRequestStatus(dashBoardCub.pendingShipmentList[widget.index].requestId!, "rejected", context);
                                });
                          }
                        },
                      ),

                    ],
                  )
                ],
              ),
            ),
          ),
        );
      }, context: context,
    );

  }

  Widget _buildImage({required String Image}){
    return Center(
      child: Container(
          width: screenWidth(context,dividedBy: 1.3),
          height: screenHeight(context,dividedBy: 2.5),
          child:SvgPicture.asset(Image,fit: BoxFit.cover)
      ),
    );
  }
  Widget _buildPattern(){
    if(dashBoardCub.pendingShipmentList[widget.index].shipmentType == "To Terminal Transport"){
      return _buildImage(Image: images.pattern1);
    } else if(dashBoardCub.pendingShipmentList[widget.index].shipmentType  == "From Terminal Transport"){
      return _buildImage(Image: images.pattern2);
    }
    else {
     // if(calendarCub.eventList[widget.index].unbooked == false){
        return _buildImage(Image: images.pattern);
      // }
      // else{
      //   return _buildImage(Image: images.pattern3);
      // }
    }

  }

  @override
  void initState() {
    transportRequestCub = BlocProvider.of<TransportRequestCubit>(context);
    dashBoardCub=BlocProvider.of<DashBoardCubit>(context);
    authCub = BlocProvider.of<AuthCubit>(context);
    shipmentCub=BlocProvider.of<ShipmentCubit>(context);
    calendarCub = BlocProvider.of<CalendarCubit>(context);
    dropDownCub = BlocProvider.of<DropDownCubit>(context);

    if(dashBoardCub.pendingShipmentList[widget.index].shipmentType=="From Terminal Transport"){
      transportRequestCub.GetTransportRequest(dashBoardCub.pendingShipmentList[widget.index].requestId!, dashBoardCub.pendingShipmentList[widget.index].projectId??"",context);
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _buildPattern(),
        Center(
          child: Container(
              padding: EdgeInsets.all(15),
              //margin: EdgeInsets.all(5),
              width: screenWidth(context,dividedBy: 1.3),
              height: screenHeight(context,dividedBy: 2.5),
              // color: Colors.primaries[Random().nextInt(Colors.primaries.length)],
              color: Colors.orange.withOpacity(0.5),
             // color: Color.fromRGBO(int.parse(dropDownCub.zoneColor[widget.index][0]),int.parse(dropDownCub.zoneColor[widget.index][1]),int.parse(dropDownCub.zoneColor[widget.index][2]),1),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      commonText(
                          "${DateFormat('HH:mm').format(DateTime.parse(dashBoardCub.pendingShipmentList[widget.index].from!))} - ${DateFormat('HH:mm').format(DateTime.parse(dashBoardCub.pendingShipmentList[widget.index].to!))}",
                          color: Colors.black,
                          fontFamily: LexendRegular,
                          fontWeight: FontWeight.w400,
                          fontSize: 16),
                      Spacer(),
                      GestureDetector(onTap: () {
                        Navigator.pop(context);
                      },child: Icon(Icons.cancel_rounded,size: 30,color: Colors.black,))
                      // IconButton(padding: EdgeInsets.zero,constraints: BoxConstraints(),onPressed: () {
                      //   Navigator.pop(context);
                      // }, icon: Icon(Icons.cancel_rounded,size: 30,color: Colors.black,))
                    ],
                  ),
                  dashBoardCub.pendingShipmentList[widget.index].shipmentType=="From Terminal Transport"
                      ? Container(
                    padding: EdgeInsets.all(5),
                    margin: EdgeInsets.symmetric(vertical: 10),
                    height: screenHeight(context, dividedBy: 25),
                    width: screenWidth(context, dividedBy: 3.2),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.yellow),
                    child: Center(
                        child: commonText(
                            "Transport Requested", color: Colors.black, fontFamily: LexendRegular, fontWeight: FontWeight.w400, fontSize: 12,maxLines: 1
                        )),
                  )
                      : GestureDetector(
                          onTap: () {
                            statusUpdateDialogue(context);
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(vertical: 10),
                            height: screenHeight(context, dividedBy: 25),
                            width: screenWidth(context, dividedBy: 3.2),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.yellow),
                            child: const Center(
                                child: Text(
                              "Pending",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  decoration: TextDecoration.none),
                            )),
                          ),
                        ),
                  commonText(
                      dashBoardCub.pendingShipmentList[widget.index]
                          .shipmentType!,
                      color: Colors.black,
                      fontFamily: LexendMedium,
                      fontWeight: FontWeight.w400,
                      fontSize: 14),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: TextButton.styleFrom(
                          backgroundColor: HexColor.orange, // Background Color
                        ),
                        onPressed: () {
                          if(dashBoardCub.pendingShipmentList[widget.index].shipmentType=="Shipment Transport"){
                            Navigator.push(
                                context, MaterialPageRoute(builder: (context) {
                              return UpdateShipment(dashBoardCub.pendingShipmentList[widget.index].requestId!, dashBoardCub.pendingShipmentList[widget.index].projectId??"");
                            },));
                          } else if (dashBoardCub.pendingShipmentList[widget.index].shipmentType=="To Terminal Transport"){
                            Navigator.push(
                                context, MaterialPageRoute(builder: (context) {
                              return UpdateTerminalTransportShipment(dashBoardCub.pendingShipmentList[widget.index].requestId!,  dashBoardCub.pendingShipmentList[widget.index].projectId??"");
                            },));
                          } else {
                            Navigator.push(
                                context, MaterialPageRoute(builder: (context) {
                              return UpdateTransportRequestShipment(dashBoardCub.pendingShipmentList[widget.index].requestId!,dashBoardCub.pendingShipmentList[widget.index].projectId??"");
                            },));
                          }

                        },
                        child: commonText('Update', color: Colors.black,
                            fontFamily: LexendRegular,
                            fontWeight: FontWeight.w400,
                            fontSize: 14),
                      ),
                      SizedBox(width: 10,),
                      ElevatedButton(
                        style: TextButton.styleFrom(
                          backgroundColor: HexColor.orange, // Background Color
                        ),
                        onPressed: () {
                          closeRequestDialogue(context);
                        },
                        child: commonText('Close Request', color: Colors.black,
                            fontFamily: LexendRegular,
                            fontWeight: FontWeight.w400,
                            fontSize: 14),
                      ),
                    ],
                  ),
                  verticalSpaces(context, height: 80),
                  Align(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      style: TextButton.styleFrom(
                        backgroundColor: HexColor.orange, // Background Color
                      ),
                      onPressed: () {
                        Navigator.push(
                            context, MaterialPageRoute(builder: (context) {
                          return BookingHistory(dashBoardCub.pendingShipmentList[widget.index].requestId!);
                        },));
                      },
                      child: commonText('Booking History', color: Colors.black,
                          fontFamily: LexendRegular,
                          fontWeight: FontWeight.w400,
                          fontSize: 15),
                    ),
                  ),

                ],
              )
          ),
        ),
      ],
    );
  }
}