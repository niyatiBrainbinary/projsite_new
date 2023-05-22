import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_swiper_null_safety_flutter3/flutter_swiper_null_safety_flutter3.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:proj_site/common/colors/colors.dart';
import 'package:proj_site/common/image_constant/image_constant.dart';
import 'package:proj_site/common/widget_constant/widget_constant.dart';
import 'package:proj_site/cubits/booking_cubit.dart';
import 'package:proj_site/cubits/calendar_cubit.dart';
import 'package:proj_site/cubits/drop_down_cubit.dart';
import 'package:proj_site/cubits/shipment_cubit.dart';
import 'package:proj_site/cubits/terminal_cubit.dart';
import 'package:proj_site/helper/constants.dart';
import 'package:proj_site/helper/helper.dart';
import 'package:proj_site/view/booking_history.dart';
import 'package:proj_site/view/terminalTransportBooking/updateTerminalTransportShipment.dart';
import 'package:proj_site/view/updateShipmentRequest/updateShipment.dart';
import 'package:stacked_card_carousel/stacked_card_carousel.dart';

class StackCard extends StatefulWidget {
  String date;
  List indexList;
  StackCard(this.date,this.indexList);

  @override
  State<StackCard> createState() => _StackCardState();
}

class _StackCardState extends State<StackCard> {
  List<Widget> shipmentList=[];
  PageController pageController = PageController();
  late CalendarCubit calendarCub;
  List<Color> colors=[];

@override
  void initState() {
  calendarCub = BlocProvider.of<CalendarCubit>(context);
    shipmentList = [];
    colors = [];
    for (int i = 0; i < 10; i++) {
      colors.add(Colors.primaries[Random().nextInt(Colors.primaries.length)]);
      shipmentList.add(FancyCard(
       // Date:"${DateFormat('HH:mm').format(DateTime.parse(calendarCub.eventList[i].requestFromDateTime.toString()))} - ${DateFormat('HH:mm').format(DateTime.parse(calendarCub.eventList[i].requestToDateTime.toString()))} ",
        Date: "Date",
        index: i,
        currentIndex: _currentIndex, color: colors[i],
      ),);

    }

  }

  int _currentIndex = 1;
  int _index = 0;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          // Stack(children: [
          //   Container(
          //     height: 70,
          //     color: Colors.white,
          //   ),
          //   Container(
          //     height: 70,
          //     color: Colors.black.withOpacity(0.55),
          //   ),
          // ],),
          Column(
            children: [
              SizedBox(height: screenHeight(context,dividedBy: 5)),
              Expanded(
                // child: ListView.builder(
                //   // controller: controller,
                //   itemCount: shipmentList.length,
                //   shrinkWrap: true,
                //   physics: BouncingScrollPhysics(),
                //   itemBuilder: (context, index) {
                //     // double scale = 1.0;
                //     // if(top>0.5){
                //     //   scale = index+0.5-top;
                //     //   print("scale$scale");
                //     //   if(scale <0){
                //     //     scale =0.0;
                //     //   }
                //     //   else if(scale >1){
                //     //     scale =1;
                //     //   }
                //     // }
                //     return shipmentList[index];
                //   },
                // ),


                //   child: Padding(
                //     padding: const EdgeInsets.all(8.0),
                //     child: PageView.builder(
                //       itemCount: 10,
                //       scrollDirection: Axis.vertical,
                //       controller: PageController(viewportFraction: 0.7),
                //       onPageChanged: (int index) => setState(() => _index = index),
                //       itemBuilder: (_, i) {
                //         return Transform.scale(
                //           transformHitTests: true,
                //           scale: i == _index ? 1 : 0.9,
                //           child: shipmentList[_index],
                //         );
                //       },
                //     ),
                //   ),
                child: Swiper(
                  itemBuilder: (BuildContext context, int index) {
                    //return shipmentList[index];
                    return FancyCard(Date: "Date", index: index, color: colors[index]);
                  },
                  itemCount: widget.indexList.length,
                  viewportFraction: 0.8,
                  scale: 0.9,loop: false,
                ),
              )
            ],
          ),

        ],
      ),
    );

      // Scaffold(
      //   backgroundColor: Colors.transparent,
      //   body: Column(
      //     children: [
      //       Stack(children: [
      //         Container(
      //           height: 50,
      //           color: Colors.white,
      //         ),
      //         Container(
      //           height: 50,
      //           color: Colors.black.withOpacity(0.55),
      //         ),
      //         Align(
      //           alignment: Alignment.centerLeft,
      //           child: IconButton(onPressed: () {
      //             Navigator.pop(context);
      //           }, icon: Icon(Icons.arrow_back_ios_new_rounded,size: 25,color: Colors.black,)),
      //         ),
      //       ],),
      //
      //
      //       Expanded(
      //         child: StackedCardCarousel(
      //           initialOffset: 0,
      //           items: shipmentList,
      //           onPageChanged: (pageIndex) {
      //             setState(() {
      //               _currentIndex = pageIndex;
      //             });
      //
      //           },
      //         ),
      //       ),
      //     ],
      //   ),
      // );
  }
}
class FancyCard extends StatefulWidget {
   FancyCard({

    //  required this.image,
    //   required this.title,
    required this.Date,
    required this.index,
    required this.color,
    this.currentIndex,
  }) : super();

 // final Image image;
  //final String title;
  final String Date;
  final int index;
  final Color color;
  int? currentIndex;

  @override
  State<FancyCard> createState() => _FancyCardState();
}

class _FancyCardState extends State<FancyCard> {

  late ShipmentCubit shipmentCub;
  late CalendarCubit calendarCub;
  late DropDownCubit dropDownCub;
  late BookingCubit bookingCub;
  int currentIndex=-1;
  bool isApprove= false;

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
                  Center(
                      child:Text("Are you sure you want to close this request?",style: TextStyle(color: Colors.black,fontFamily: LexendRegular,fontSize: 16,))),
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
                      calendarCub.eventList[widget.index].requestType == "terminal"?
                      BlocBuilder<TerminalCubit, TerminalState>(
                        builder: (context, state) {
                          if(state is CloseTerminalLoading){
                            return commonLoadingButton(context: context,width: 95);
                          }
                          else {
                            return commonButton(context: context, buttonName: "Yes",width: 95,onTap: (){
                              BlocProvider.of<TerminalCubit>(context).CloseTerminal(context,calendarCub.eventList[widget.index].id);
                              bookingCub.AddBooking(calendarCub.eventList[widget.index].id, calendarCub.eventList[widget.index].responsiblePersonId ?? "");
                            });
                          }
                        },
                      ):BlocBuilder<ShipmentCubit, ShipmentState>(
                        builder: (context, state) {
                          if(state is CloseShipmentLoading){
                            return commonLoadingButton(context: context,width: 95);
                          }
                          else {
                            return commonButton(context: context, buttonName: "Yes",width: 95,onTap: (){
                              shipmentCub.CloseShipment(context,calendarCub.eventList[widget.index].id);
                              bookingCub.AddBooking(calendarCub.eventList[widget.index].id, calendarCub.eventList[widget.index].responsiblePersonId ?? "");
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
                  calendarCub.eventList[widget.index].requestType == "terminal"?
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      BlocBuilder<TerminalCubit, TerminalState>(
                        builder: (context, state) {
                          if(widget.index==currentIndex && state is UpdateTerminalStatusLoading && isApprove==true){
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
                                      .UpdateTerminalStatus(calendarCub.eventList[widget.index].id,"approved",context);
                                });
                          }
                        },
                      ),

                      BlocBuilder<ShipmentCubit, ShipmentState>(
                        builder: (context, state) {
                          if(widget.index==currentIndex && state is UpdateTerminalStatusLoading && isApprove==false){
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
                                  .UpdateTerminalStatus(calendarCub.eventList[widget.index].id,"rejected",context);
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
                          if(widget.index==currentIndex && state is UpdateApprovalStatusLoading && isApprove==true){
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
                                      .UpdateApprovalStatus("approved",calendarCub.eventList[widget.index].id,context);
                                });
                          }
                        },
                      ),

                      BlocBuilder<ShipmentCubit, ShipmentState>(
                        builder: (context, state) {
                          if(widget.index==currentIndex && state is UpdateApprovalStatusLoading && isApprove==false){
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
                                      .UpdateApprovalStatus("rejected",calendarCub.eventList[widget.index].id,context);
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

  @override
  void initState() {
    // TODO: implement initState
    shipmentCub=BlocProvider.of<ShipmentCubit>(context);
    calendarCub = BlocProvider.of<CalendarCubit>(context);
    dropDownCub = BlocProvider.of<DropDownCubit>(context);
    super.initState();

  }
  //calendarCub.eventList[widget.index].requestType == "terminal"?

  Widget _buildImage({required String Image}){
    return Container(
      width: screenWidth(context,dividedBy: 1.3),
      height: screenHeight(context,dividedBy: 1.8),
      child:SvgPicture.asset(Image,fit: BoxFit.cover)
    );
  }
  Widget _buildPattern(){
    if(calendarCub.eventList[widget.index].requestType == "terminal"){
      return _buildImage(Image: images.pattern1);
    } else if(calendarCub.eventList[widget.index].requestType == "logistics"){
      return _buildImage(Image: images.pattern2);
    }
    else {
      if(calendarCub.eventList[widget.index].unbooked == false){
        return _buildImage(Image: images.pattern);
      }
      else{
        return _buildImage(Image: images.pattern3);
      }
    }

  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Stack(
          children: [
            _buildPattern(),
            Container(
                padding: EdgeInsets.only(left: 20,right: 20,top: 15,bottom: 20),

                width: screenWidth(context,dividedBy: 1.3),
                height: screenHeight(context,dividedBy: 1.8),
               // color: Colors.primaries[Random().nextInt(Colors.primaries.length)],
             //   color: widget.color,
               color: Color.fromRGBO(int.parse(dropDownCub.zoneColor[widget.index][0]),int.parse(dropDownCub.zoneColor[widget.index][1]),int.parse(dropDownCub.zoneColor[widget.index][2]),1).withOpacity(0.5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        commonText("${DateFormat('HH:mm').format(calendarCub.eventList[widget.index].requestFromDateTime!)} - ${DateFormat('HH:mm').format(calendarCub.eventList[widget.index].requestToDateTime!)}", color: Colors.black,
                            fontFamily: LexendRegular,
                            fontWeight: FontWeight.w400,
                            fontSize: 16),
                        Spacer(),
                        IconButton(padding: EdgeInsets.zero,constraints: BoxConstraints(),onPressed: () {
                          Navigator.pop(context);
                        }, icon: Icon(Icons.cancel_rounded,size: 30,color: Colors.black,))
                      ],
                    ),
                    // BlocBuilder<ShipmentCubit, ShipmentState>(
                    //   builder: (context, state) {
                    //     if (widget.index==currentIndex && state is UpdateTransportStatusLoading) {
                    //       return Container(
                    //         margin: EdgeInsets.symmetric(vertical: 10),
                    //         height: screenHeight(context,dividedBy: 25),
                    //         width: screenWidth(context,dividedBy: 3.2), 
                    //         alignment: Alignment.center,
                    //         decoration: BoxDecoration(
                    //             borderRadius: BorderRadius.circular(5),
                    //             color: Colors.red      
                    //         ),
                    //         child: LoadingAnimationWidget.prograssiveDots(
                    //           color: Colors.white,
                    //           size: 35,
                    //         ),
                    //       );
                    //     } else {
                    //       return GestureDetector(
                    //         onTap: () {
                    //           currentIndex=widget.index;
                    //           setState(() {});
                    //           BlocProvider.of<ShipmentCubit>(context)
                    //               .UpdateTransportStatus();
                    //         },
                    //         child: Container(
                    //           margin: EdgeInsets.symmetric(vertical: 10),
                    //           height: screenHeight(context,dividedBy: 25),
                    //           width: screenWidth(context,dividedBy: 3.2),
                    //           decoration: BoxDecoration(
                    //               borderRadius: BorderRadius.circular(5),
                    //               color: Colors.red
                    //           ),
                    //           child: Center(child: Text("Not Arrived",
                    //             style: TextStyle(color: Colors.white,
                    //                 fontSize: 16,
                    //                 decoration: TextDecoration.none),)),
                    //         ),
                    //       );
                    //     }
                    //   },
                    // ),
                    // BlocBuilder<ShipmentCubit, ShipmentState>(
                    //   builder: (context, state) {
                    //     if (widget.index==currentIndex && state is UpdateApprovalStatusLoading) {
                    //       return Container(
                    //         margin: EdgeInsets.symmetric(vertical: 10),
                    //         height: screenHeight(context,dividedBy: 25),
                    //         width: screenWidth(context,dividedBy: 3.2),
                    //         alignment: Alignment.center,
                    //         decoration: BoxDecoration(
                    //             borderRadius: BorderRadius.circular(5),
                    //             color: Colors.indigo
                    //         ),
                    //         child: LoadingAnimationWidget.prograssiveDots(
                    //           color: Colors.white,
                    //           size: 35,
                    //         ),
                    //       );
                    //     } else {
                    //       return GestureDetector(
                    //         onTap: () {
                    //           currentIndex=widget.index;
                    //           setState(() {});
                    //         },
                    //         child: Container(
                    //           margin: EdgeInsets.symmetric(vertical: 10),
                    //           height: screenHeight(context,dividedBy: 25),
                    //           width: screenWidth(context,dividedBy: 3.2),
                    //           decoration: BoxDecoration(
                    //               borderRadius: BorderRadius.circular(5),
                    //               color: Colors.indigo
                    //           ),
                    //           child: Center(child: Text("Approved",
                    //             style: TextStyle(color: Colors.white,
                    //                 fontSize: 18,
                    //                 decoration: TextDecoration.none),)),
                    //         ),
                    //       );
                    //     }
                    //   },
                    // ),
                    calendarCub.eventList[widget.index].status == "pending" &&
                            calendarCub.eventList[widget.index].transportStatus ==
                                "not_arrived"
                        ? GestureDetector(
                            onTap: () {
                              currentIndex = widget.index;
                              setState(() {});
                              statusUpdateDialogue(context);

                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(vertical: 10),
                              height: screenHeight(context, dividedBy: 25),
                              width: screenWidth(context, dividedBy: 3.2),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.yellow),
                              child: Center(
                                  child: Text(
                                "Pending",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    decoration: TextDecoration.none),
                              )),
                            ),
                          )
                        : calendarCub.eventList[widget.index].status == "approved" &&
                                calendarCub
                                        .eventList[widget.index].transportStatus ==
                                    "not_arrived"
                            ? Column(
                              children: [
                                BlocBuilder<ShipmentCubit, ShipmentState>(
                                  builder: (context, state) {
                                    if (widget.index==currentIndex && state is UpdateTransportStatusLoading) {
                                      return Container(
                                        margin: EdgeInsets.symmetric(vertical: 10),
                                        height: screenHeight(context,dividedBy: 25),
                                        width: screenWidth(context,dividedBy: 3.2),
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(5),
                                            color: Colors.red
                                        ),
                                        child: LoadingAnimationWidget.prograssiveDots(
                                          color: Colors.white,
                                          size: 35,
                                        ),
                                      );
                                    } else {
                                      return GestureDetector(
                                        onTap: () {
                                          currentIndex = widget.index;
                                          setState(() {});
                                          shipmentCub.UpdateTransportStatus(calendarCub.eventList[widget.index].id,"in_progress",context);
                                        },
                                        child: Container(
                                          margin: EdgeInsets.symmetric(vertical: 10),
                                          height: screenHeight(context, dividedBy: 25),
                                          width: screenWidth(context, dividedBy: 3.2),
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(5),
                                              color: Colors.red),
                                          child: Center(
                                              child: Text(
                                                "Not Arrived",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 18,
                                                    decoration: TextDecoration.none),
                                              )),
                                        ),
                                      );
                                    }
                                  },
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(vertical: 10),
                                  height: screenHeight(context, dividedBy: 25),
                                  width: screenWidth(context, dividedBy: 3.2),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors.deepPurpleAccent),
                                  child: Center(
                                      child: Text(
                                        "Approved",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                            decoration: TextDecoration.none),
                                      )),
                                ),
                              ],
                            )
                            : calendarCub.eventList[widget.index].status ==
                                        "approved" &&
                                    calendarCub.eventList[widget.index]
                                            .transportStatus ==
                                        "in_progress"
                                ? Column(
                      children: [
                        BlocBuilder<ShipmentCubit, ShipmentState>(
                          builder: (context, state) {
                            if (widget.index==currentIndex && state is UpdateTransportStatusLoading) {
                              return Container(
                                margin: EdgeInsets.symmetric(vertical: 10),
                                height: screenHeight(context,dividedBy: 25),
                                width: screenWidth(context,dividedBy: 3.2),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.red
                                ),
                                child: LoadingAnimationWidget.prograssiveDots(
                                  color: Colors.white,
                                  size: 35,
                                ),
                              );
                            } else {
                              return GestureDetector(
                                onTap: () {
                                  currentIndex = widget.index;
                                  setState(() {});
                                  shipmentCub.UpdateTransportStatus(calendarCub.eventList[widget.index].id,"unloaded",context);
                                },
                                child: Container(
                                  margin: EdgeInsets.symmetric(vertical: 10),
                                  height: screenHeight(context, dividedBy: 25),
                                  width: screenWidth(context, dividedBy: 3.2),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors.indigo),
                                  child: Center(
                                      child: Text(
                                        "In Progress",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            decoration: TextDecoration.none),
                                      )),
                                ),
                              );
                            }
                          },
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          height: screenHeight(context, dividedBy: 25),
                          width: screenWidth(context, dividedBy: 3.2),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.deepPurpleAccent),
                          child: Center(
                              child: Text(
                                "Approved",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    decoration: TextDecoration.none),
                              )),
                        ),
                      ],
                    )
                                : calendarCub.eventList[widget.index].status ==
                                            "approved" &&
                                        calendarCub.eventList[widget.index]
                                                .transportStatus ==
                                            "unloaded"
                                    ? Column(
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          height: screenHeight(context, dividedBy: 25),
                          width: screenWidth(context, dividedBy: 3.2),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.green),
                          child: Center(
                              child: Text(
                                "Unloaded",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    decoration: TextDecoration.none),
                              )),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          height: screenHeight(context, dividedBy: 25),
                          width: screenWidth(context, dividedBy: 3.2),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.deepPurpleAccent),
                          child: Center(
                              child: Text(
                                "Approved",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    decoration: TextDecoration.none),
                              )),
                        ),
                      ],
                    )
                                    : Container(),

                    calendarCub.eventList[widget.index].requestType == "terminal"
                        ? commonText('Transport To Terminal',
                            color: Colors.black,
                            fontFamily: LexendMedium,
                            fontWeight: FontWeight.w400,
                            fontSize: 16)
                        : calendarCub.eventList[widget.index].unbooked == true
                            ? commonText('Unbooked Shipment Transport',
                                color: Colors.black,
                                fontFamily: LexendMedium,
                                fontWeight: FontWeight.w400,
                                fontSize: 16)
                            : Container(),

                    commonText('${calendarCub.eventList[widget.index].companyName}', color: Colors.black,
                        fontFamily: LexendMedium,
                        fontWeight: FontWeight.w400,
                        fontSize: 16),
                    commonText(
                        'Responsible person: ${calendarCub.eventList[widget.index].responsiblePersonName}', color: Colors.black,
                       // 'Responsible person: ', color: Colors.black,
                        fontFamily: LexendMedium,
                        fontWeight: FontWeight.w400,
                        fontSize: 16),
                    commonText(
                       // 'Email:daniel@gmail.com', color: Colors.black,
                        'Email:${calendarCub.eventList[widget.index].email}', color: Colors.black,
                        fontFamily: LexendMedium,
                        fontWeight: FontWeight.w400,
                        fontSize: 16),
                    commonText(
                       // 'Phone:0718469935', color: Colors.black,
                        'Phone:${calendarCub.eventList[widget.index].phone}', color: Colors.black,
                        fontFamily: LexendMedium,
                        fontWeight: FontWeight.w400,
                        fontSize: 16),
                    verticalSpaces(context, height: 80),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          style: TextButton.styleFrom(
                            backgroundColor: HexColor.orange, // Background Color
                          ),
                          onPressed: () {
                            calendarCub.eventList[widget.index].requestType == "terminal"?
                            Navigator.push(
                                context, MaterialPageRoute(builder: (context) {
                              return UpdateTerminalTransportShipment(calendarCub.eventList[widget.index].id, calendarCub.eventList[widget.index].projectId);
                            },)):Navigator.push(
                                context, MaterialPageRoute(builder: (context) {
                              return UpdateShipment(calendarCub.eventList[widget.index].id, calendarCub.eventList[widget.index].projectId);
                            },));
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
                            return BookingHistory(calendarCub.eventList[widget.index].id.toString());
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
          ],
        ),
      //  SizedBox(height: 20,),
        // Container(
        //   width: 250,
        //   height: 250,
        //   // child: image,
        //   color: Colors.orange,
        // ),
        // Text(
        //   title,
        //   style: Theme.of(context).textTheme.headline5,
        // ),
        // ElevatedButton(
        //   child: const Text("Learn more"),
        //   onPressed: () => print("Button was tapped"),
        // ),
      ],
    );
  }
}





