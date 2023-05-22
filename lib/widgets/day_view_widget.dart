
import 'package:flutter/material.dart';
import 'package:proj_site/cubits/auth_cubit.dart';
import 'package:proj_site/helper/helper.dart';
import 'package:proj_site/src/day_view/day_view.dart';
import '../model/event.dart';
import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:proj_site/cubits/calendar_cubit.dart';
import 'package:proj_site/view/stack_card.dart';


class DayViewWidget extends StatefulWidget {
  final GlobalKey<DayViewState>? state;
  final double? width;

  const DayViewWidget({
    Key? key,
    this.state,
    this.width,
  }) : super(key: key);

  @override
  State<DayViewWidget> createState() => _DayViewWidgetState();
}

class _DayViewWidgetState extends State<DayViewWidget> {
  late CalendarCubit calendarCub;
  late AuthCubit authCub;
  List eventIndex=[];

  @override
  void initState() {
    calendarCub=BlocProvider.of<CalendarCubit>(context);
    authCub = BlocProvider.of<AuthCubit>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DayView<Event>(
      key: widget.state,
      width: widget.width,
      onEventTap: (events, date) async {
        eventIndex=[];
        for(int i=0;i<calendarCub.eventList.length;i++){
          String selectedDate=DateFormat('yyyy-MM-dd').format(date);
          String eventDate=DateFormat('yyyy-MM-dd').format(calendarCub.eventList[i].requestFromDateTime!);
          log("eventDate${eventDate}");
          log("eventDate1${calendarCub.eventList[i].requestFromDateTime!}");
          log("selectedDate${selectedDate}");
          if(selectedDate==eventDate){
            eventIndex.add(i);
            log("index$eventIndex");
          }
        }
        if(eventIndex.isNotEmpty){
          String? returnVal= await showDialog<String>(
            barrierDismissible: false,
            builder: (_) => StackCard("text",eventIndex), context: context,
          );
          if(returnVal=="Success"){
            calendarCub.EventList(projectIdMain,orgId,mobileOrgId,"${DateTime.now().subtract(Duration(days: 150)).toUtc().millisecondsSinceEpoch}","${DateTime.now().add(Duration(days: 150)).toUtc().millisecondsSinceEpoch}");
          };
          setState(() {});
        }

        log("date==date${date}");
      },
    );
  }
}
