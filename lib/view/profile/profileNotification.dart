import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proj_site/common/colors/colors.dart';
import 'package:proj_site/common/widget_constant/widget_constant.dart';
import 'package:proj_site/cubits/profile_setting_cubit.dart';
import 'package:proj_site/helper/helper.dart';
import 'package:proj_site/services/custom_function.dart';

class ProfileNotification extends StatefulWidget {
  const ProfileNotification({Key? key}) : super(key: key);

  @override
  State<ProfileNotification> createState() => _ProfileNotificationState();
}

class _ProfileNotificationState extends State<ProfileNotification> {

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


  @override
  void initState() {
    getNotification();
  }

  late ProfileSettingCubit _profileSettingCubit;


  getNotification() {
    _profileSettingCubit = BlocProvider.of<ProfileSettingCubit>(context);
    _profileSettingCubit.GetNotification();
  }

  @override
  Widget build(BuildContext context) {

    return getCommonContainer(
      // padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          commonText(
              "Here you can turn off and on the notification features of your account.",
              color: HexColor.Gray53,
              fontFamily: LexendLight,
              fontWeight: FontWeight.w300,
              fontSize: 12,
              maxLines: 2),
          verticalSpaces(context, height: 20),
          BlocBuilder<ProfileSettingCubit, ProfileSettingState>(
            builder: (context, state) {
              if(state is NotificationLoading){
                return Expanded(child: loader());
              }else if (state is NotificationError){
                return errorLoadDataText();
              }
              else{
                return Column(
                  children: [
                    getSwitchWithText(ctx: context, tittle: "Send Email Notification", value: _profileSettingCubit.email!, trackColor: trackColor, overlayColor: overlayColor,onChanged: (value){
                       setState(() {
                         _profileSettingCubit.email = value!;
                       });
                      _profileSettingCubit.EditNotification(email_notify:_profileSettingCubit.email == true?"1":"0" ,sms_notify:_profileSettingCubit.sms  == true?"1":"0");
                    }),
                    getSwitchWithText(ctx: context, tittle: "Send SMS Notification", value: _profileSettingCubit.sms!, trackColor: trackColor, overlayColor: overlayColor,onChanged: (value){
                        setState(() {
                          _profileSettingCubit.sms = value!;
                        });
                      _profileSettingCubit.EditNotification(email_notify:_profileSettingCubit.email  == true?"1":"0" ,sms_notify:_profileSettingCubit.sms  == true?"1":"0");
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
