import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proj_site/common/colors/colors.dart';
import 'package:proj_site/common/widget_constant/widget_constant.dart';
import 'package:proj_site/cubits/project_setting_cubit.dart';
import 'package:proj_site/helper/helper.dart';
import 'package:proj_site/services/custom_function.dart';

class CalenderSetting extends StatefulWidget {

  const CalenderSetting({Key? key}) : super(key: key);

  @override
  State<CalenderSetting> createState() => _CalenderSettingState();
}

class _CalenderSettingState extends State<CalenderSetting> {
  // bool isZone = false;
  // bool isAutomatic = false;
  // bool isWaste = false;
  final MaterialStateProperty<Color?> trackColor =
      MaterialStateProperty.resolveWith<Color?>(
    (Set<MaterialState> states) {
      if (states.contains(MaterialState.selected)) {
        return HexColor.orange.withOpacity(0.5);
      }
      return null;
    },
  );
  final MaterialStateProperty<Color?> overlayColor =
      MaterialStateProperty.resolveWith<Color?>(
    (Set<MaterialState> states) {
      if (states.contains(MaterialState.selected)) {
        return Colors.amber.withOpacity(0.54);
      }
      if (states.contains(MaterialState.disabled)) {
        return Colors.grey.shade400;
      }
      return null;
    },
  );

  late ProjectSettingCubit _projectSettingCubit;

  @override
  void initState() {

    _projectSettingCubit = BlocProvider.of<ProjectSettingCubit>(context);
    _projectSettingCubit.GetBookingFormNotification(projectIdMain);

  }


  @override
  Widget build(BuildContext context) {
    return getCommonContainer(
      child: Column(
        children: [

          BlocBuilder<ProjectSettingCubit, ProjectSettingState>(
            builder: (context, state) {
              if(state is BookingFormNotificationLoading){
                return loader();
              }else if (state is BookingFormNotificationError){
                return  errorLoadDataText();
              }
              else{
                return Column(
                  children: [
                    commonText(
                        "Here you can control various functionalities in the project calendar view.",
                        color: HexColor.Gray53,
                        fontFamily: LexendLight,
                        fontWeight: FontWeight.w300,
                        fontSize: 12,
                        textAlign: TextAlign.center
                    ),
                    verticalSpaces(context, height: 20),
                    getSwitchWithTittleAndSubTittle(
                        ctx: context,
                        tittle: "Zone at the same time",
                        value: _projectSettingCubit.zone,
                        trackColor: trackColor,
                        overlayColor: overlayColor,
                        onChanged: (value) {
                          setState(() {
                            _projectSettingCubit.zone = value!;
                          });
                        },
                        subTittle:
                        'If this is on, users do NOT have the opportunity to create a booking in the same zone during the same time interval'),
                    getSwitchWithTittleAndSubTittle(
                        ctx: context,
                        tittle: "Automatic approval",
                        value:  _projectSettingCubit.auto,
                        trackColor: trackColor,
                        overlayColor: overlayColor,
                        onChanged: (value) {
                          setState(() {
                            _projectSettingCubit.auto = value!;
                          });
                        },
                        subTittle:
                        'If this is on, no approval is required for a booking to go through'),
                    getSwitchWithText(
                        ctx: context,
                        tittle: "Waste Disposal",
                        value:  _projectSettingCubit.waste,
                        trackColor: trackColor,
                        overlayColor: overlayColor,
                        onChanged: (value) {
                          setState(() {
                            _projectSettingCubit.waste = value!;
                          });
                        }),
                    verticalSpaces(context, height: 20),
                    commonButton(context: context, buttonName: "Save", onTap: (){
                      _projectSettingCubit.SaveCalender(
                            type: "calender",
                            id: _projectSettingCubit.id ?? "",
                            zone: _projectSettingCubit.zone,
                            auto: _projectSettingCubit.auto,
                            waste: _projectSettingCubit.waste,
                      );
                    }),
                  ],
                );
              }

            },
          ),


        ],
      ),
    );
  }
}
