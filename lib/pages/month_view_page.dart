
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proj_site/common/colors/colors.dart';
import 'package:proj_site/common/widget_constant/widget_constant.dart';
import 'package:proj_site/cubits/auth_cubit.dart';
import 'package:proj_site/cubits/calendar_cubit.dart';
import 'package:proj_site/helper/extension.dart';
import 'package:proj_site/helper/helper.dart';
import 'package:proj_site/src/calendar_controller_provider.dart';
import 'package:proj_site/src/calendar_event_data.dart';
import 'package:proj_site/src/event_controller.dart';
import 'package:proj_site/view/newShipmentRequest/shipment.dart';
import 'package:proj_site/view/terminalTransportBooking/terminalTransportshipment.dart';
import 'package:proj_site/view/wasteDisposal.dart';

import '../model/event.dart';
import '../widgets/month_view_widget.dart';
import 'create_event_page.dart';

class MonthViewPage extends StatefulWidget {
  const MonthViewPage({
    Key? key,
  }) : super(key: key);

  @override
  _MonthViewPageState createState() => _MonthViewPageState();
}

class _MonthViewPageState extends State<MonthViewPage> {

  late AuthCubit authCub;
  late CalendarCubit calenderCub;

  @override
  void initState() {
    calenderCub = BlocProvider.of<CalendarCubit>(context);
    authCub = BlocProvider.of<AuthCubit>(context);
    calenderCub.EventList(projectIdMain, orgId,mobileOrgId,"${DateTime.now().subtract(Duration(days: 150)).toUtc().millisecondsSinceEpoch}","${DateTime.now().add(Duration(days: 150)).toUtc().millisecondsSinceEpoch}");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CalendarCubit,CalendarState>(
      builder: (context, state) {
        if(state is EventListLoading && calenderCub.isCalender==true){
          return CalendarControllerProvider(
            controller: EventController<Event>()..addAll([]),
            child: Scaffold(
              body: Container(
                child: loader(),
              ),
            ),
          );
        } else {
          return  CalendarControllerProvider(
            controller: EventController<Event>()..addAll(calenderCub.events),
            child:Scaffold(
              floatingActionButton: FloatingActionButton(
               /* child: Icon(Icons.add),

                //onPressed: _addEvent,
                onPressed: () async {
                  // final event =
                  //     await context.pushRoute<CalendarEventData<Event>>(CreateEventPage(
                  //   withDuration: true,
                  // ));
                  // if (event == null) return;
                  // CalendarControllerProvider.of<Event>(context).controller.add(event);
                  String? returnVal= await Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return Shipment(false);
                  },));
                  if(returnVal=="Success"){
                    calenderCub.EventList(projectIdMain, orgId,"${DateTime.now().subtract(Duration(days: 150)).toUtc().millisecondsSinceEpoch}","${DateTime.now().add(Duration(days: 150)).toUtc().millisecondsSinceEpoch}");
                  };
                  setState(() {});
                },*/
                elevation: 8,
               onPressed: (){},
                child: PopupMenuButton(
                    constraints: BoxConstraints(maxWidth: 150),
                    icon: Icon(
                      Icons.add,
                      size: 25,
                      color: Color(0xFFFFFFFF),
                    ),
                     offset: Offset(-55, 0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0))
                    ),
                    onSelected: (value) async {
                      if(value == 1){
                        // Navigator.push(context, MaterialPageRoute(builder: (context) {
                        //   return UnbookedShipment();
                        // },));
                        String? returnVal= await Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return Shipment(true);
                        },));
                        if(returnVal=="Success"){
                          calenderCub.EventList(projectIdMain,orgId,mobileOrgId,"${DateTime.now().subtract(Duration(days: 150)).toUtc().millisecondsSinceEpoch}","${DateTime.now().add(Duration(days: 150)).toUtc().millisecondsSinceEpoch}");
                        };
                        setState(() {});
                      }
                      else if(value == 2){
                        String? returnVal= await Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return TerminalTransportShipment();
                        },));
                        if(returnVal=="Success"){
                          calenderCub.EventList(projectIdMain,orgId,mobileOrgId,"${DateTime.now().subtract(Duration(days: 150)).toUtc().millisecondsSinceEpoch}","${DateTime.now().add(Duration(days: 150)).toUtc().millisecondsSinceEpoch}");
                        };
                        setState(() {});

                      }
                      else if(value == 3){
                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return WasteDisposal();
                        },));
                      }

                    },
                    // onSelected: (value) {
                    //   setState(() {
                    //     mainIndex = value;
                    //     print("main index=${mainIndex}");
                    //   });
                    // },
                    itemBuilder: (BuildContext context) => <PopupMenuEntry<int>>
                    [
                      PopupMenuItem(
                        height: 35,
                        value: 0,
                        child: Text(
                          'Show Weekends',
                          style: TextStyle(
                              color: HexColor.Gray53,fontSize: 14),
                        ),
                      ),
                      PopupMenuDivider(height: 0),
                      PopupMenuItem(
                        height: 40,
                        value: 1,
                        child: Text(
                          'Unbooked',
                          style: TextStyle(
                              color: HexColor.Gray53,fontSize: 14),
                        ),
                      ),
                      PopupMenuDivider(height: 0,),
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
                              color: HexColor.Gray53,fontSize: 14),
                        ),
                      ),
                      PopupMenuDivider(height: 0,),
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
                              color: HexColor.Gray53,fontSize: 14),
                        ),
                      ),
                    ]
                ),
              ),
              body: MonthViewWidget(),
            ),
          );
        }
      },);
  }

  Future<void> _addEvent() async {
    final event = await context.pushRoute<CalendarEventData<Event>>(
      CreateEventPage(
        withDuration: true,
      ),
    );
    if (event == null) return;
    CalendarControllerProvider.of<Event>(context).controller.add(event);
  }
}
