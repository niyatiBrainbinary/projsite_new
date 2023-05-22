import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:ftx/navigationX.dart';
import 'package:proj_site/common/colors/colors.dart';
import 'package:proj_site/common/widget_constant/widget_constant.dart';
import 'package:proj_site/cubits/auth_cubit.dart';
import 'package:proj_site/cubits/unloading_zone_cubit.dart';
import 'package:proj_site/helper/helper.dart';

class CreateNewZone extends StatefulWidget {
  static const id = 'CreateNewZone_screen';
  @override
  _CreateNewZoneState createState() => _CreateNewZoneState();
}

class _CreateNewZoneState extends State<CreateNewZone> {
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
  _submitButton(){
    return  Align(
      alignment: Alignment.center,
      child: commonButton(context: context, buttonName: "Submit",onTap: (){
        FocusScope.of(context).unfocus();
      unLoadingZoneCub.createUnLoadingZone(projectIdMain, _subName.text, _colorCode, authCub.userInfo!.user!.organizationId!);
    }),
    );
  }

  @override
  void initState() {
    unLoadingZoneCub=BlocProvider.of<UnLoadingZoneCubit>(context);
    authCub=BlocProvider.of<AuthCubit>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: getCommonContainer(
        height: screenHeight(context),
        width: screenWidth(context),
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                   commonText("Unloading Zone Name", color: Colors.black, fontFamily: LexendRegular, fontWeight: FontWeight.w400, fontSize: 12),
                    verticalSpaces(context, height: 80),
                    getRoundedTexfield(
                        hintText: "Enter Sub Project Name",
                        controller: _subName,
                        ctx: context),
                    verticalSpaces(context, height: 40),
                    commonText("Project", color: Colors.black, fontFamily: LexendRegular, fontWeight: FontWeight.w400, fontSize: 12),
                    verticalSpaces(context, height: 80),
                    getDropDownButton(
                        ctx: context,
                        items: _dropdownValues,
                      hitText: "Select Project",
                        value: _dropdownValues.first,),
                    verticalSpaces(context, height: 40),
                    commonText("Zone Color", color: Colors.black, fontFamily: LexendRegular, fontWeight: FontWeight.w400, fontSize: 12),
                    verticalSpaces(context, height: 80),
                    getColorWithContainer(
                        ctx: context,
                        currentColor: _currentColor,
                        colorCode: _colorCode,
                        onTap: () {
                          showColorPicker();
                        }),
                    verticalSpaces(context, height: 10),
                    BlocBuilder<UnLoadingZoneCubit, UnLoadingZoneState>(
                      builder: (context, state) {
                        if (state is CreateUnLoadingZoneLoading) {
                          return commonLoadingButton(context: context);
                        } else {
                          return _submitButton();
                        }
                      },
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
