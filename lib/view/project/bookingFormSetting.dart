import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proj_site/common/colors/colors.dart';
import 'package:proj_site/common/widget_constant/widget_constant.dart';
import 'package:proj_site/cubits/project_setting_cubit.dart';
import 'package:proj_site/helper/helper.dart';
import 'package:proj_site/services/custom_function.dart';

class BookingFormSetting extends StatefulWidget {
  const BookingFormSetting({Key? key}) : super(key: key);

  @override
  State<BookingFormSetting> createState() => _BookingFormSettingState();
}

class _BookingFormSettingState extends State<BookingFormSetting> {

  List<String> _shipmentList = ["Resources","Available Unloading Zones","Contractor","Responsible person","Sub Project"];
  List<String> _enviromentList = ["Shipment Supplier","Euroclass","Type of Fuel","Load Weight","Vehicle Capacity","Distance","Driving route",'Type of Vehicle'];
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
          commonText(
            """With this view, you can control how the validation of 
the booking form should work. That is, you can force the 
user to enter values ​​in certain input fields to proceed 
with the booking""",
            color: HexColor.Gray53,
            fontFamily: LexendLight,
            fontWeight: FontWeight.w300,
            fontSize: 12,
            textAlign: TextAlign.center
          ),
          verticalSpaces(context, height: 20),
          BlocBuilder<ProjectSettingCubit, ProjectSettingState>(
            builder: (context, state) {
              if(state is BookingFormNotificationLoading){
                return Expanded(child: loader());
              }else if (state is BookingFormNotificationError){
                return Expanded(child: errorLoadDataText());
              }
              else{
                return Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        commonText("Shipment Data",
                            color: Colors.black,
                            fontFamily: LexendBold,
                            fontWeight: FontWeight.w700,
                            fontSize: 14),
                        ListView.builder(
                          itemCount: _shipmentList.length,
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return getSwitchWithText(
                                ctx: context,
                                tittle: _shipmentList[index],
                                value: _projectSettingCubit.shipmentData![index],
                                trackColor: trackColor,
                                overlayColor: overlayColor,
                                onChanged: (value) {
                                  setState(() {
                                    _projectSettingCubit.shipmentData![index] = value;
                                  });
                                  log("new${_projectSettingCubit.shipmentData![index]}");
                                  log("new${_projectSettingCubit.shipmentData!}");
                                  // _projectSettingCubit.SaveBookingFormNotification(shipment:_projectSettingCubit.shipmentData!, environment:_projectSettingCubit.environmentData!);
                                });
                          },
                        ),
                        verticalSpaces(context, height: 20),
                        commonText("Environment Data",
                            color: Colors.black,
                            fontFamily: LexendBold,
                            fontWeight: FontWeight.w700,
                            fontSize: 14),
                        ListView.builder(
                          itemCount: _enviromentList.length,
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return getSwitchWithText(
                                ctx: context,
                                tittle: _enviromentList[index],
                                value: _projectSettingCubit.environmentData![index],
                                trackColor: trackColor,
                                overlayColor: overlayColor,
                                onChanged: (value) {
                                  setState(() {
                                    _projectSettingCubit.environmentData![index] = value!;
                                  });
                                // _projectSettingCubit.SaveBookingFormNotification(shipment:_projectSettingCubit.shipmentData!, environment:_projectSettingCubit.environmentData!);
                                });
                          },
                        ),
                        verticalSpaces(context, height: 20),
                        Align(
                          alignment: Alignment.center,
                          child: commonButton(context: context, buttonName: "Save", onTap: (){
                            _projectSettingCubit.SaveBookingFormNotification(
                                type: "booking",
                                id: _projectSettingCubit.id ?? "",
                                shipment: _projectSettingCubit.shipmentData,
                                environment: _projectSettingCubit.environmentData,
                            );
                          }),
                        ),
                        verticalSpaces(context, height: 20),
                      ],
                    ),
                  ),
                );
              }

            },
          ),

        ],
      ),
    );
  }
}
