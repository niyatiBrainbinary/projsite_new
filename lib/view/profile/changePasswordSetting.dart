import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proj_site/common/colors/colors.dart';
import 'package:proj_site/common/widget_constant/widget_constant.dart';
import 'package:proj_site/cubits/auth_cubit.dart';
import 'package:proj_site/helper/helper.dart';

class ChangePasswordSetting extends StatefulWidget {
  const ChangePasswordSetting({Key? key}) : super(key: key);

  @override
  State<ChangePasswordSetting> createState() => _ChangePasswordSettingState();
}

class _ChangePasswordSettingState extends State<ChangePasswordSetting> {
  List<TextEditingController> _controllers = [];
  List<String> hintText = ["Enter old password", "Enter new password", "Enter confirm password"];
  List<String> tittle = [
    "Old Password",
    "New Password",
    "Confirm Password",
  ];


  int totalItem = 3;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for (int i = 0; i < totalItem; i++) {
      _controllers.add(TextEditingController());
    }
  }

  Widget _organization(){
    return   Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            getRoundedCornerContainer(
                height: 43,
                width: 130,
                ctx: context,
                status: "Organization 1",
                textColor: HexColor.Gray53.withOpacity(0.7),
                fontSize: 14, boxColor: HexColor.Gray71.withOpacity(0.2)),
            horizontal(context, width: 30),
            getRoundedCornerContainer(
                height: 43,
                width: 130,
                ctx: context,
                status: "Organization 2",
                textColor:HexColor.Gray53.withOpacity(0.7),
                fontSize: 14, boxColor: HexColor.Gray71.withOpacity(0.2)),
          ],
        ),
        verticalSpaces(context, height: 80),
        getRoundedCornerContainer(
            height: 43,
            width: 130,
            ctx: context,
            status: "Organization 3",
            textColor:HexColor.Gray53.withOpacity(0.7),
            fontSize: 14, boxColor: HexColor.Gray71.withOpacity(0.2)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final authCub = BlocProvider.of<AuthCubit>(context);
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            itemCount: _controllers.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return getCommonContainer(
                height: screenHeight(context, dividedBy: 9),
                width: screenWidth(context),
                color: Colors.transparent,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    commonText(tittle[index],
                        color: Colors.black,
                        fontFamily: LexendRegular,
                        fontWeight: FontWeight.w400,
                        fontSize: 12),
                    verticalSpaces(context, height: 80),
                    getRoundedTexfield(
                        hintText: hintText[index],
                        controller: _controllers[index], ctx: context),
                  ],
                ),
              );
            },
          ),
          verticalSpaces(context, height: 20),
          BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) {
              if(state is UpdatePasswordLoading){
                return commonLoadingButton(context: context);
              } else {
                return commonButton(context: context, buttonName: "Submit",onTap: (){
                  if(_controllers[0].text.isEmpty){
                    snackBar("Please Enter Old Password", false);
                  } else if(_controllers[1].text.isEmpty){
                    snackBar("Please Enter New Password", false);
                  } else if(_controllers[2].text.isEmpty){
                    snackBar("Please Enter Confirm Password", false);
                  } else if(_controllers[0].text != authCub.userInfo!.user!.password!){
                    snackBar("Old Password is Wrong", false);
                  } else if(_controllers[1].text != _controllers[1].text){
                    snackBar("Password Not Matched", false);
                  } else {
                    authCub.updatePassword(_controllers[1].text, authCub.userInfo!.user!.id!);
                  }
                });
              }
            },
          ),

        ],
      ),
    );
  }
}
