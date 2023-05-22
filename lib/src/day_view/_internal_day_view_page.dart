// Copyright (c) 2021 Simform Solutions. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

import 'dart:math';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:proj_site/view/stack_card.dart';
import '../components/_internal_components.dart';
import '../components/event_scroll_notifier.dart';
import '../enumerations.dart';
import '../event_arrangers/event_arrangers.dart';
import '../event_controller.dart';
import '../modals.dart';
import '../painters.dart';
import '../typedefs.dart';

/// Defines a single day page.
class InternalDayViewPage<T extends Object?> extends StatelessWidget {
  /// Width of the page
  final double width;

  /// Height of the page.
  final double height;

  /// Date for which we are displaying page.
  final DateTime date;

  /// A builder that returns a widget to show event on screen.
  final EventTileBuilder<T> eventTileBuilder;

  /// Controller for calendar
  final EventController<T> controller;

  /// A builder that builds time line.
  final DateWidgetBuilder timeLineBuilder;

  /// Settings for hour indicator lines.
  final HourIndicatorSettings hourIndicatorSettings;

  /// Flag to display live time indicator.
  /// If true then indicator will be displayed else not.
  final bool showLiveLine;

  /// Settings for live time indicator.
  final HourIndicatorSettings liveTimeIndicatorSettings;

  /// Height occupied by one minute of time span.
  final double heightPerMinute;

  /// Width of time line.
  final double timeLineWidth;

  /// Offset for time line widgets.
  final double timeLineOffset;

  /// Height occupied by one hour of time span.
  final double hourHeight;

  /// event arranger to arrange events.
  final EventArranger<T> eventArranger;

  /// Flag to display vertical line.
  final bool showVerticalLine;

  /// Offset  of vertical line.
  final double verticalLineOffset;

  /// Called when user taps on event tile.
  final CellTapCallback<T>? onTileTap;

  /// Called when user long press on calendar.
  final DatePressCallback? onDateLongPress;

  /// Defines size of the slots that provides long press callback on area
  /// where events are not there.
  final MinuteSlotSize minuteSlotSize;

  /// Notifies if there is any event that needs to be visible instantly.
  final EventScrollConfiguration scrollNotifier;

  /// Defines a single day page.
  const  InternalDayViewPage({
    Key? key,
    required this.showVerticalLine,
    required this.width,
    required this.date,
    required this.eventTileBuilder,
    required this.controller,
    required this.timeLineBuilder,
    required this.hourIndicatorSettings,
    required this.showLiveLine,
    required this.liveTimeIndicatorSettings,
    required this.heightPerMinute,
    required this.timeLineWidth,
    required this.timeLineOffset,
    required this.height,
    required this.hourHeight,
    required this.eventArranger,
    required this.verticalLineOffset,
    required this.onTileTap,
    required this.onDateLongPress,
    required this.minuteSlotSize,
    required this.scrollNotifier,
  }) : super(key: key);


  void calendarTapped({required BuildContext context, required DateTime date}) {

     String text='', _titleText='';

     text = DateFormat('EEEE dd, MMMM yyyy').format(date).toString();

    // print("DareTime${details.date}");
    // if (details.targetElement == CalendarElement.header) {
    //   _text = DateFormat('MMMM yyyy').format(details.date!).toString();
    //   _titleText = 'Header';
    // } else if (details.targetElement == CalendarElement.viewHeader) {
    //   _text = DateFormat('EEEE dd, MMMM yyyy').format(details.date!).toString();
    //   _titleText = 'View Header';
    // } else if (details.targetElement == CalendarElement.calendarCell) {
    //   _text = DateFormat('EEEE dd, MMMM yyyy').format(details.date!).toString();
    //   _titleText = 'Calendar cell';
    // }
    // showDialog(
    //     context: context,
    //     builder: (BuildContext context) {
    //       return AlertDialog(
    //         title: Container(child: new Text(" $_titleText")),
    //         content: Container(child: new Text(" $_text")),
    //         actions: <Widget>[
    //           new TextButton(
    //               onPressed: () {
    //                 Navigator.of(context).pop();
    //               },
    //               child: new Text('close'))
    //         ],
    //       );
    //     });
    showDialog(
      barrierDismissible: false,
      builder: (_) => StackCard(text,[]), context: context,
      //     AlertDialog(
      //   title:
      //   Text(date.month.monthName + " " + date.day.toString()),
      //   content: Container(
      //     height: 400,
      //     child: SingleChildScrollView(
      //       physics: BouncingScrollPhysics(),
      //       child: Column(
      //         mainAxisSize: MainAxisSize.min,
      //         children: eventsOnTheDate
      //             .map(
      //               (event) => Container(
      //             width: double.infinity,
      //             padding: EdgeInsets.all(4),
      //             margin: EdgeInsets.only(bottom: 12),
      //             color: event.eventBackgroundColor,
      //             child: Text(
      //               event.eventName,
      //               style: TextStyle(color: event.eventTextColor),
      //             ),
      //           ),
      //         )
      //             .toList(),
      //       ),
      //     ),
      //   ),
      // )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      child: Stack(
        children: [
          CustomPaint(
            size: Size(width, height),
            painter: HourLinePainter(
              lineColor: hourIndicatorSettings.color,
              lineHeight: hourIndicatorSettings.height,
              offset: timeLineWidth + hourIndicatorSettings.offset,
              minuteHeight: heightPerMinute,
              verticalLineOffset: verticalLineOffset,
              showVerticalLine: showVerticalLine,
            ),
          ),
          PressDetector(
            width: width,
            height: height,
            heightPerMinute: heightPerMinute,
            date: date,
            onDateLongPress: onDateLongPress,
            minuteSlotSize: minuteSlotSize,
          ),
          Align(
            alignment: Alignment.centerRight,
            child: EventGenerator<T>(
              height: height,
              date: date,
              onTileTap: onTileTap,
              // onTileTap: (events, date) {
              //   String text='';
              //   text = DateFormat('EEEE dd, MMMM yyyy').format(date).toString();
              //   calendarTapped(context: context,date: date);
              // },
              eventArranger: eventArranger,
              events: controller.getEventsOnDay(date),
              heightPerMinute: heightPerMinute,
              eventTileBuilder: eventTileBuilder,
              scrollNotifier: scrollNotifier,
              width: width -
                  timeLineWidth -
                  hourIndicatorSettings.offset -
                  verticalLineOffset,
            ),
          ),
          TimeLine(
            height: height,
            hourHeight: hourHeight,
            timeLineBuilder: timeLineBuilder,
            timeLineOffset: timeLineOffset,
            timeLineWidth: 50,
            key: ValueKey(heightPerMinute),
          ),
          if (showLiveLine && liveTimeIndicatorSettings.height > 0)
            IgnorePointer(
              child: LiveTimeIndicator(
                liveTimeIndicatorSettings: liveTimeIndicatorSettings,
                width: width,
                height: height,
                heightPerMinute: heightPerMinute,
                timeLineWidth: timeLineWidth,
              ),
            ),
        ],
      ),
    );
  }
}
