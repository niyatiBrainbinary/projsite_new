import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:proj_site/common/colors/colors.dart';
import 'package:proj_site/common/widget_constant/widget_constant.dart';
import 'package:proj_site/cubits/auth_cubit.dart';
import 'package:proj_site/cubits/calendar_cubit.dart';
import 'package:proj_site/helper/helper.dart';

class EventList extends StatefulWidget {
  const EventList({Key? key}) : super(key: key);

  @override
  State<EventList> createState() => _EventListState();
}

class _EventListState extends State<EventList> {

  late CalendarCubit calenderCub;
  late AuthCubit authCub;
  _eventList(){
    calenderCub.setState();
  }
  DateTime dateTime=DateTime.now();

  @override
  void initState() {
    // TODO: implement initState
    calenderCub=BlocProvider.of<CalendarCubit>(context);
    authCub = BlocProvider.of<AuthCubit>(context);
    calenderCub.isCalender=false;
    calenderCub.EventList(projectIdMain,orgId!, mobileOrgId,"${DateTime.now().subtract(Duration(days: DateTime.now().weekday - 1)).toUtc().millisecondsSinceEpoch}","${DateTime.now().add(Duration(days: DateTime.now().weekday-5)).toUtc().millisecondsSinceEpoch}");
    super.initState();
  }

  Widget buildEventList(String day,List list,String date){
    return Column(children: [
      Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        height: screenHeight(context, dividedBy: 18),
        color: Color(0xffF0F0F0),
        child:
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          commonText(day,
              color: HexColor.Gray53,
              fontFamily: LexendRegular,
              fontWeight: FontWeight.w400,
              fontSize: 14),
          commonText(date,
              color: HexColor.Gray53,
              fontFamily: LexendRegular,
              fontWeight: FontWeight.w400,
              fontSize: 14),
        ]),
      ),
      list.isEmpty?Column(
        children: [
          SizedBox(height: 10,),
          Center(
            child: commonText("No Data Found",
                color: Colors.grey,
                fontFamily: LexendRegular,
                fontWeight: FontWeight.w500,
                fontSize: 15),
          ),
          SizedBox(height: 10,),
        ],
      ):ListView.builder(itemCount: list.length,shrinkWrap: true,physics: NeverScrollableScrollPhysics(),itemBuilder: (context, index) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 15,vertical: 5),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              commonText("${DateFormat('HH:mm').format(calenderCub.eventList[list[index]].requestFromDateTime!)} - ${DateFormat('HH:mm').format(calenderCub.eventList[list[index]].requestToDateTime!)}",
                  color: HexColor.Gray53,
                  fontFamily: LexendRegular,
                  fontWeight: FontWeight.w400,
                  fontSize: 14),
              const SizedBox(
                width: 10,
              ),
              Container(
                height: 10,
                width: 10,
                margin: EdgeInsets.only(top: 4),
                decoration: BoxDecoration(
                    color: Color.fromRGBO(int.parse(calenderCub.eventList[list[index]].zoneColor!.split("(").last.split(")").first.split(", ")[0]),int.parse(calenderCub.eventList[list[index]].zoneColor!.split("(").last.split(")").first.split(", ")[1]),int.parse(calenderCub.eventList[list[index]].zoneColor!.split("(").last.split(")").first.split(", ")[2]),1), shape: BoxShape.circle),
              ),
              horizontal(context, width: 15),
              Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      commonText("${calenderCub.eventList[list[index]].companyName}",
                          color: Colors.black,
                          fontFamily: LexendRegular,
                          fontWeight: FontWeight.w400,
                          fontSize: 14),
                      commonText("Sub project: ${calenderCub.eventList[list[index]].subProjectName}",
                          color: Colors.black,
                          fontFamily: LexendRegular,
                          fontWeight: FontWeight.w400,
                          fontSize: 14),
                      commonText("Responsible person: ${calenderCub.eventList[list[index]].responsiblePersonName}",
                          color: Colors.black,
                          fontFamily: LexendRegular,
                          fontWeight: FontWeight.w400,
                          fontSize: 14),
                      commonText("Email: ${calenderCub.eventList[list[index]].email}",
                          color: Colors.black,
                          fontFamily: LexendRegular,
                          fontWeight: FontWeight.w400,
                          fontSize: 14),
                      commonText("Phone: ${calenderCub.eventList[list[index]].phone}",
                          color: Colors.black,
                          fontFamily: LexendRegular,
                          fontWeight: FontWeight.w400,
                          fontSize: 14),
                    ],
                  ))
            ],
          ),
        );
      },)

    ]);
  }

  List monIndex=[];
  List tuesIndex=[];
  List wendIndex=[];
  List thursIndex=[];
  List friIndex=[];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(children: [
          Row(children: [
            IconButton(onPressed: () {
              dateTime=dateTime.subtract(Duration(days: 7));
              setState(() {});
              BlocProvider.of<CalendarCubit>(context).EventList(projectIdMain,orgId,mobileOrgId,"${dateTime.subtract(Duration(days: dateTime.weekday - 1)).toUtc().millisecondsSinceEpoch}","${dateTime.add(Duration(days: dateTime.weekday-5)).toUtc().millisecondsSinceEpoch}");

            }, icon: Icon(Icons.arrow_back_ios_outlined)),
            IconButton(onPressed: () {
              dateTime=dateTime.add(Duration(days: 7));
              setState(() {});
              BlocProvider.of<CalendarCubit>(context).EventList(projectIdMain,orgId,mobileOrgId,"${dateTime.subtract(Duration(days: dateTime.weekday - 1)).toUtc().millisecondsSinceEpoch}","${dateTime.add(Duration(days: dateTime.weekday-5)).toUtc().millisecondsSinceEpoch}");

            }, icon: Icon(Icons.arrow_forward_ios_outlined)),
            SizedBox(width: 25,),
            Expanded(child: commonText("${DateFormat('MMM dd').format(dateTime.subtract(Duration(days: dateTime.weekday - 1)))} - ${DateFormat('dd, yyyy').format(dateTime.subtract(Duration(days: dateTime.weekday - 5)))}",
                color: Colors.black,
                fontFamily: LexendRegular,
                fontWeight: FontWeight.w400,
                fontSize: 16))
          ]),
          SizedBox(height: 5,),
          BlocConsumer<CalendarCubit, CalendarState>(
            listener: (context, state) {
              if(state is EventListSuccess && calenderCub.isCalender==false){
                monIndex=[];
                tuesIndex=[];
                wendIndex=[];
                thursIndex=[];
                friIndex=[];
                for(int i=0;i<calenderCub.eventList.length;i++){
                  String mondayDate=DateFormat('yyyy-MM-dd').format(dateTime.subtract(Duration(days: dateTime.weekday - 1)));
                  String tuesdayDate=DateFormat('yyyy-MM-dd').format(dateTime.subtract(Duration(days: dateTime.weekday - 2)));
                  String wednesdayDate=DateFormat('yyyy-MM-dd').format(dateTime.subtract(Duration(days: dateTime.weekday - 3)));
                  String thursdayDate=DateFormat('yyyy-MM-dd').format(dateTime.subtract(Duration(days: dateTime.weekday - 4)));
                  String fridayDate=DateFormat('yyyy-MM-dd').format(dateTime.subtract(Duration(days: dateTime.weekday - 5)));
                  String eventDate=DateFormat('yyyy-MM-dd').format(calenderCub.eventList[i].requestFromDateTime!);
                  if(mondayDate==eventDate){
                    monIndex.add(i);
                  } else if(tuesdayDate==eventDate){
                    tuesIndex.add(i);
                  }else if(wednesdayDate==eventDate){
                    wendIndex.add(i);
                  }else if(thursdayDate==eventDate){
                    thursIndex.add(i);
                  }else if(fridayDate==eventDate){
                    friIndex.add(i);
                  }

                }
              }
            },
            builder: (context, state) {
              if(state is EventListLoading){
                return Padding(
                  padding: EdgeInsets.only(top: screenHeight(context,dividedBy: 4)),
                  child: loader(),
                );
              }else if (state is EventListError){
                return Padding(
                    padding: EdgeInsets.only(top: screenHeight(context,dividedBy: 4)),
                    child: errorLoadDataText());
              }
              else {
                return Container(
                  child: SingleChildScrollView(
                    child: Column(children: [
                      buildEventList("MONDAY",monIndex,"${DateFormat('MMMM dd, yyyy').format(dateTime.subtract(Duration(days: dateTime.weekday - 1)))}"),
                      buildEventList("TUESDAY",tuesIndex,"${DateFormat('MMMM dd, yyyy').format(dateTime.subtract(Duration(days: dateTime.weekday - 2)))}"),
                      buildEventList("WEDNESDAY",wendIndex,"${DateFormat('MMMM dd, yyyy').format(dateTime.subtract(Duration(days: dateTime.weekday - 3)))}"),
                      buildEventList("THURSDAY",thursIndex,"${DateFormat('MMMM dd, yyyy').format(dateTime.subtract(Duration(days: dateTime.weekday - 4)))}"),
                      buildEventList("FRIDAY",friIndex,"${DateFormat('MMMM dd, yyyy').format(dateTime.subtract(Duration(days: dateTime.weekday - 5)))}"),
                    ]),
                  ),
                );
              }

            },
          )
        ]),
      ),
    );
  }
}
