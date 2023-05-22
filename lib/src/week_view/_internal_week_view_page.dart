// Copyright (c) 2021 Simform Solutions. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

import 'dart:developer';

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

/// A single page for week view.
class InternalWeekViewPage<T extends Object?> extends StatelessWidget {
  /// Width of the page.
  final double width;

  /// Height of the page.
  final double height;

  /// Dates to display on page.
  final List<DateTime> dates;

  /// Builds tile for a single event.
  final EventTileBuilder<T> eventTileBuilder;

  /// A calendar controller that controls all the events and rebuilds widget
  /// if event(s) are added or removed.
  final EventController<T> controller;

  /// A builder to build time line.
  final DateWidgetBuilder timeLineBuilder;

  /// Settings for hour indicator lines.
  final HourIndicatorSettings hourIndicatorSettings;

  /// Flag to display live line.
  final bool showLiveLine;

  /// Settings for live time indicator.
  final HourIndicatorSettings liveTimeIndicatorSettings;

  ///  Height occupied by one minute time span.
  final double heightPerMinute;

  /// Width of timeline.
  final double timeLineWidth;

  /// Offset of timeline.
  final double timeLineOffset;

  /// Height occupied by one hour time span.
  final double hourHeight;

  /// Arranger to arrange events.
  final EventArranger<T> eventArranger;

  /// Flag to display vertical line or not.
  final bool showVerticalLine;

  /// Offset for vertical line offset.
  final double verticalLineOffset;

  /// Builder for week day title.
  final DateWidgetBuilder weekDayBuilder;

  /// Height of week title.
  final double weekTitleHeight;

  /// Width of week title.
  final double weekTitleWidth;

  final ScrollController scrollController;

  /// Called when user taps on event tile.
  final CellTapCallback<T>? onTileTap;

  /// Defines which days should be displayed in one week.
  ///
  /// By default all the days will be visible.
  /// Sequence will be monday to sunday.
  final List<WeekDays> weekDays;

  /// Called when user long press on calendar.
  final DatePressCallback? onDateLongPress;

  /// Defines size of the slots that provides long press callback on area
  /// where events are not there.
  final MinuteSlotSize minuteSlotSize;

  final EventScrollConfiguration scrollConfiguration;

  /// A single page for week view.
  const InternalWeekViewPage({
    Key? key,
    required this.showVerticalLine,
    required this.weekTitleHeight,
    required this.weekDayBuilder,
    required this.width,
    required this.dates,
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
    required this.weekTitleWidth,
    required this.scrollController,
    required this.onTileTap,
    required this.onDateLongPress,
    required this.weekDays,
    required this.minuteSlotSize,
    required this.scrollConfiguration,
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
    final filteredDates = _filteredDate();
    log("weekTitleWidth${weekTitleWidth}");
    log("weekTitleHeight${weekTitleHeight}");
    log("width${width}");
    return Container(
      height: height + weekTitleHeight,
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          ///week of day
          // SizedBox(
          //   width: width,
          //   child: Row(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       SizedBox(
          //         height: weekTitleHeight,
          //         width: timeLineWidth,
          //       ),
          //       ...List.generate(
          //         filteredDates.length,
          //         (index) => SizedBox(
          //           height: weekTitleHeight,
          //           width: weekTitleWidth,
          //           child: weekDayBuilder(
          //             filteredDates[index],
          //           ),
          //         ),
          //       )
          //     ],
          //   ),
          // ),
          Expanded(
            child: SingleChildScrollView(
              controller: scrollController,
              child: SizedBox(
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
                    if (showLiveLine && liveTimeIndicatorSettings.height > 0)
                      LiveTimeIndicator(
                        liveTimeIndicatorSettings: liveTimeIndicatorSettings,
                        width: width,
                        height: height,
                        heightPerMinute: heightPerMinute,
                        timeLineWidth: timeLineWidth,
                      ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: SizedBox(
                        width: weekTitleWidth * filteredDates.length,
                        height: height,
                        child: Row(
                          children: [
                            ...List.generate(
                              filteredDates.length,
                              (index) => Container(
                                decoration: BoxDecoration(
                                  border: Border(
                                    right: BorderSide(
                                      color: hourIndicatorSettings.color,
                                      width: hourIndicatorSettings.height,
                                    ),
                                  ),
                                ),
                                height: height,
                                width: weekTitleWidth,
                                child: Stack(
                                  children: [
                                    PressDetector(
                                      width: weekTitleWidth,
                                      height: height,
                                      heightPerMinute: heightPerMinute,
                                      date: dates[index],
                                      onDateLongPress: onDateLongPress,
                                      minuteSlotSize: minuteSlotSize,
                                    ),
                                    EventGenerator<T>(
                                      height: height,
                                      date: filteredDates[index],
                                      onTileTap: onTileTap,
                                      // onTileTap: (events, date) {
                                      //   String text='';
                                      //   text = DateFormat('EEEE dd, MMMM yyyy').format(date).toString();
                                      //   calendarTapped(context: context,date: date);
                                      // },
                                      width: weekTitleWidth,
                                      eventArranger: eventArranger,
                                      eventTileBuilder: eventTileBuilder,
                                      scrollNotifier: scrollConfiguration,
                                      events: controller
                                          .getEventsOnDay(filteredDates[index]),
                                      heightPerMinute: heightPerMinute,
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    TimeLine(
                      timeLineWidth: timeLineWidth,
                      hourHeight: hourHeight,
                      height: height,
                      timeLineOffset: timeLineOffset,
                      timeLineBuilder: timeLineBuilder,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<DateTime> _filteredDate() {
    final output = <DateTime>[];

    final weekDays = this.weekDays.toList();

    for (final date in dates) {
      if (weekDays.any((weekDay) => weekDay.index + 1 == date.weekday)) {
        output.add(date);
      }
    }

    return output;
  }
}
