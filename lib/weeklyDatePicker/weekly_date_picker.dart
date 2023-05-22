library weekly_date_picker;

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:proj_site/cubits/calendar_cubit.dart';
import 'package:proj_site/helper/helper.dart';
import 'package:proj_site/weeklyDatePicker/date_week_extension.dart';
import 'package:proj_site/weeklyDatePicker/datetime_apis.dart';


class WeeklyDatePicker extends StatefulWidget {
  WeeklyDatePicker({
    Key? key,
    required this.selectedDay,
    required this.changeDay,
    this.weekdayText = 'Week',
    this.weekdays = const ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
    this.backgroundColor = const Color(0xFFFAFAFA),
    this.selectedBackgroundColor = const Color(0xFF2A2859),
    this.selectedDigitColor = const Color(0xFFFFFFFF),
    this.digitsColor = const Color(0xFF000000),
    this.weekdayTextColor = const Color(0xFF303030),
    this.enableWeeknumberText = true,
    this.weeknumberColor = const Color(0xFFB2F5FE),
    this.weeknumberTextColor = const Color(0xFF000000),
    this.daysInWeek = 7,
  })  : assert(weekdays.length == daysInWeek,
            "weekdays must be of length $daysInWeek"),
        super(key: key);

  /// The current selected day
  final DateTime selectedDay;

  /// Callback function with the new selected date
  final Function(DateTime) changeDay;

  /// Specifies the weekday text: default is 'Week'
  final String weekdayText;

  /// Specifies the weekday strings ['Mon', 'Tue'...]
  final List<String> weekdays;

  /// Background color
  final Color backgroundColor;

  /// Color of the selected digits text
  final Color selectedBackgroundColor;

  /// Color of the unselected digits text
  final Color selectedDigitColor;

  /// Color of the unselected digits text
  final Color digitsColor;

  /// Is the color of the weekdays 'Mon', 'Tue'...
  final Color weekdayTextColor;

  /// Set to false to hide the weeknumber textfield to the left of the slider
  final bool enableWeeknumberText;

  /// Color of the weekday container
  final Color weeknumberColor;

  /// Color of the weekday text
  final Color weeknumberTextColor;

  /// Specifies the number of weekdays to render, default is 7, so Monday to Sunday
  final int daysInWeek;

  @override
  _WeeklyDatePickerState createState() => _WeeklyDatePickerState();
}

class _WeeklyDatePickerState extends State<WeeklyDatePicker> {
  final DateTime _todaysDateTime = DateTime.now();

  // About 100 years back in time should be sufficient for most users, 52 weeks * 100
  final int _weekIndexOffset = 5200;

 // late final PageController _controller;
  late final DateTime _initialSelectedDay;
  late int _weeknumberInSwipe;

  @override
  void initState() {
    super.initState();
    datePageController  = PageController(initialPage: _weekIndexOffset);
    _initialSelectedDay = widget.selectedDay;
    _weeknumberInSwipe = widget.selectedDay.weekOfYear;
  }

  @override
  void dispose() {
    datePageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: widget.backgroundColor,
        child: Row(
          children: <Widget>[
            widget.enableWeeknumberText
                ? Container(
                    padding: EdgeInsets.all(8.0),
                    color: widget.weeknumberColor,
                    child: Text(
                      '${widget.weekdayText} $_weeknumberInSwipe',
                      style: TextStyle(color: widget.weeknumberTextColor),
                    ),
                  )
                : Container(),
            Container(
              width: screenWidth(context),
              color: Colors.transparent,
              child: PageView.builder(
                controller: datePageController,
                onPageChanged: (int index) {
                  setState(() {
                    _weeknumberInSwipe = _initialSelectedDay
                        .add(Duration(days: 7 * (index - _weekIndexOffset)))
                        .weekOfYear;
                    log("_weekNumberInSwipe${_weeknumberInSwipe}");
                  });
                },
                scrollDirection: Axis.horizontal,
                itemBuilder: (_, weekIndex) => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: _weekdays(weekIndex - _weekIndexOffset),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Builds a 5 day list of DateButtons
  List<Widget> _weekdays(int weekIndex) {
    List<Widget> weekdays = [
      Container(
        width: screenWidth(context, dividedBy: 7),
        color: Colors.transparent,
      ),
    ];
    for (int i = 0; i < widget.daysInWeek; i++) {
      final int offset = i + 1 - _initialSelectedDay.weekday;
      final int daysToAdd = weekIndex * 7 + offset;
      final DateTime dateTime =
          _initialSelectedDay.add(Duration(days: daysToAdd));
      weekdays.add(_dateButton(dateTime));
      if(i==0){
        matchDate=dateTime;
      //  log("weekdays=${matchDate}");
      }

    }


    return weekdays;

  }

  Widget _dateButton(DateTime dateTime) {
    final String weekday = widget.weekdays[dateTime.weekday - 1];
    final bool isSelected = dateTime.isSameDateAs(widget.selectedDay);

    return Expanded(
      child: GestureDetector(
        //onTap: () => widget.changeDay(dateTime),
        onTap: () {
          isSwipe=true;
          final calenderCub = BlocProvider.of<CalendarCubit>(context);
          DateTime _dateTime= DateTime.parse("${DateFormat('yyyy-MM-dd').format(DateTime.parse("${dateTime}"))} 00:00:00.000");
          DateTime _projectDate= DateTime.parse("${DateFormat('yyyy-MM-dd').format(DateTime.parse("${calenderCub.projectDate}"))} 00:00:00.000");

          int a = _dateTime.compareTo(_projectDate) == 1
              ? _dateTime.difference(_projectDate).inDays
              : -_projectDate.difference(_dateTime).inDays;

          matchIndex=matchIndex+a;
           chartPageController.jumpToPage(matchIndex);

          print("onTap_matchIndex=${matchIndex}");
          calenderCub.projectDate = _dateTime;
          widget.changeDay(dateTime);
          calenderCub.status = true;

        },
        child: Container(
          // Bugfix, the transparent container makes the GestureDetector fill the Expanded
          color: Colors.transparent,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                '$weekday',
                style:
                    TextStyle(fontSize: 14.0, color: Colors.black,fontFamily: LexendRegular,fontWeight: FontWeight.w400),
              ),
              Container(
                //padding: const EdgeInsets.all(1.0),
                decoration: BoxDecoration(
                    // Border around today's date
                    color: dateTime.isSameDateAs(_todaysDateTime)
                        ? widget.selectedBackgroundColor
                        : Colors.transparent,
                    shape: BoxShape.circle),
                child: CircleAvatar(
                  backgroundColor: isSelected
                      ? widget.selectedBackgroundColor
                      : widget.backgroundColor,
                  radius: 14.0,
                  child: Text(
                    '${dateTime.day}',
                    style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w400,
                        fontFamily: LexendRegular,
                        color: isSelected
                            ? widget.selectedDigitColor
                            : widget.digitsColor),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
