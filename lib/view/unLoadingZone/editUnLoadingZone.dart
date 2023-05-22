
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:proj_site/common/colors/colors.dart';
import 'package:proj_site/common/widget_constant/widget_constant.dart';
import 'package:proj_site/cubits/auth_cubit.dart';
import 'package:proj_site/cubits/unloading_zone_cubit.dart';
import 'package:proj_site/helper/helper.dart';
import 'package:ftx/navigationX.dart';

class EditUnLoadingZone extends StatefulWidget {
  static const id = 'EditUnLoadingZone_screen';
  @override
  _EditUnLoadingZoneState createState() => _EditUnLoadingZoneState();
}

class _EditUnLoadingZoneState extends State<EditUnLoadingZone> {
  final List<String> _dropdownValues = ["One", "Two", "Three", "Four", "Five"];
  TextEditingController _subName = TextEditingController();
  bool lightTheme = true;
  String _colorCode = "rgb(252, 175, 25)";
  Color _currentColor = HexColor.orange;
  late UnLoadingZoneCubit unLoadingZoneCub;
  late AuthCubit authCub;

  void showColorPicker() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Pick a color"),
            content: SingleChildScrollView(
              child: ColorPicker(
                pickerColor: _currentColor,
                paletteType: PaletteType.hueWheel,
                onColorChanged: (Color value) {
                  setState(() => _currentColor = value);
                  _colorCode = "rgb(${value.red}, ${value.blue}, ${value.green})";
                },
              ),
            ),
            actions: <Widget>[
              ElevatedButton(
                child: const Text('Got it'),
                onPressed: () {
                  Navigation.instance.goBack();
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: getAppBarWithIcon(ctx: context) as PreferredSizeWidget?,
      body: getCommonContainer(
        height: screenHeight(context),
        width: screenWidth(context),
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
         commonText("Edit Unloading Zone", color: Colors.black, fontFamily: LexendBold, fontWeight: FontWeight.w700, fontSize: 20),
            verticalSpaces(context, height: 15),
            Expanded(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child:
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    getSimpleTextWithAsteriskSymbol(text: "Unloading Zone Name"),
                    verticalSpaces(context, height: 80),
                    getRoundedTexfield(
                        hintText: "Enter Sub Project Name", controller: _subName, ctx: context),
                    verticalSpaces(context, height: 40),
                    getSimpleTextWithAsteriskSymbol(text: "Project"),
                    verticalSpaces(context, height: 80),
                    getDropDownButton(
                        ctx: context,
                        items:_dropdownValues,
                        hitText: "Select Project",
                        value: _dropdownValues.first,),
                    verticalSpaces(context, height: 40),
                    getSimpleTextWithAsteriskSymbol(text: "Sub Project Name"),
                    verticalSpaces(context, height: 80),
                    getColorWithContainer(
                        ctx: context,
                        currentColor: _currentColor,
                        colorCode: _colorCode,
                        onTap: () {
                          showColorPicker();
                        }),
                    verticalSpaces(context, height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        commonButton(context: context, buttonName: "Close",buttonColor: HexColor.Gray71.withOpacity(0.5),onTap:(){
                          Navigation.instance.goBack();
                        }),
                        BlocBuilder<UnLoadingZoneCubit, UnLoadingZoneState>(
                          builder: (context, state) {
                            if (state is CreateUnLoadingZoneLoading) {
                              return commonLoadingButton(context: context);
                            } else {
                              return commonButton(context: context, buttonName: "Update",onTap: (){
                               // unLoadingZoneCub.updateUnLoadingZone(authCub.userInfo!.projects![0], _subName.text, _colorCode, authCub.userInfo!.organizationId!);
                              });
                            }
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )

          ],
        ),
      ),
    );
  }
}
