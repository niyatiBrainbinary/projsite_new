
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:proj_site/cubits/auth_cubit.dart';
import 'package:proj_site/cubits/calendar_cubit.dart';
import 'package:proj_site/helper/helper.dart';
import 'package:proj_site/src/month_view/month_view.dart';
import 'package:proj_site/view/stack_card.dart';

import '../model/event.dart';

class MonthViewWidget extends StatefulWidget {
  final GlobalKey<MonthViewState>? state;
  final double? width;

  const MonthViewWidget({
    Key? key,
    this.state,
    this.width,
  }) : super(key: key);

  @override
  State<MonthViewWidget> createState() => _MonthViewWidgetState();
}

class _MonthViewWidgetState extends State<MonthViewWidget> {

  late CalendarCubit calendarCub;
  late AuthCubit authCub;
  List eventIndex=[];
  @override
  void initState() {
    calendarCub=BlocProvider.of<CalendarCubit>(context);
    authCub = BlocProvider.of<AuthCubit>(context);
    super.initState();
  }

  eventOnTap (DateTime date)async {
    eventIndex=[];
    for(int i=0;i<calendarCub.eventList.length;i++){
      String selectedDate=DateFormat('yyyy-MM-dd').format(date);
      String eventDate=DateFormat('yyyy-MM-dd').format(calendarCub.eventList[i].requestFromDateTime!);
      if(selectedDate==eventDate){
        eventIndex.add(i);
      }
    }
    if(eventIndex.isNotEmpty){
     String? returnVal= await showDialog<String>(
        barrierDismissible: false,
        builder: (_) => StackCard("text",eventIndex), context: context,
      );
     if(returnVal=="Success"){
       calendarCub.EventList(projectIdMain,orgId,mobileOrgId,"${DateTime.now().subtract(Duration(days: 150)).toUtc().millisecondsSinceEpoch}","${DateTime.now().add(Duration(days: 150)).toUtc().millisecondsSinceEpoch}");
     }
     setState(() {});
    }

    log("date==date${date}");
  }

  @override
  Widget build(BuildContext context) {
    return MonthView<Event>(
      key: widget.state,
      width: widget.width,
      onEventTap: (event, date) {
        eventOnTap(date);
      },
      onCellTap: (events, date) {
        eventOnTap(date);
      },
    );
  }
}
