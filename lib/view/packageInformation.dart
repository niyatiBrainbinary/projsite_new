import 'package:flutter/material.dart';
import 'package:proj_site/common/colors/colors.dart';
import 'package:proj_site/common/image_constant/image_constant.dart';
import 'package:proj_site/common/widget_constant/widget_constant.dart';
import 'package:proj_site/helper/helper.dart';
import 'package:ftx/navigationX.dart';

class PackageInformation extends StatefulWidget {
  static const id = 'PackageInformation_screen';
  const PackageInformation({Key? key}) : super(key: key);

  @override
  State<PackageInformation> createState() => _PackageInformationState();
}

TextEditingController _subName = TextEditingController();
final List<String> _dropdownValues = ["One", "Two", "Three", "Four", "Five"];
TextEditingController _weightTxt = TextEditingController();
TextEditingController controller = TextEditingController();
bool value = false;

class _PackageInformationState extends State<PackageInformation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: getAppBarWithIcon(
          ctx: context,
          ) as PreferredSizeWidget?,
      body: getCommonContainer(
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            getCommonContainer(
                height: screenHeight(context, dividedBy: 15),
                width: screenWidth(context),
                color: Colors.transparent,
                child: commonText("New shipment request",
                    color: Colors.black,
                    fontFamily: LexendRegular,
                    fontWeight: FontWeight.w700,
                    fontSize: 20)),
            Container(
              height: screenHeight(context, dividedBy: 12),
              width: screenWidth(context),
              color: Colors.transparent,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: screenHeight(context, dividedBy: 100),
                    width: screenWidth(context),
                    decoration: BoxDecoration(
                        color: HexColor.orange,
                        borderRadius: BorderRadius.circular(30)),
                    child: Row(
                      children: [
                        Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: HexColor.orange,
                              ),
                            )),
                        Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: HexColor.orange),
                            )),
                        Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color:HexColor.orange,
                              ),
                            ))
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Container(
                            color: Colors.transparent,
                            child: commonText("Shipment Data",
                                color: HexColor.orange,
                                textAlign: TextAlign.center,
                                fontFamily: LexendRegular,
                                fontWeight: FontWeight.w400,
                                fontSize: 14),
                          )),
                      Expanded(
                          child: Container(
                            color: Colors.transparent,
                            child: commonText("Environmental Data",
                                color: HexColor.orange,
                                textAlign: TextAlign.center,
                                fontFamily: LexendRegular,
                                fontWeight: FontWeight.w400,
                                fontSize: 14),
                          )),
                      Expanded(
                          child: Container(
                            color: Colors.transparent,
                            child: commonText("Package Information",
                                color: HexColor.orange,
                                textAlign: TextAlign.center,
                                fontFamily: LexendRegular,
                                fontWeight: FontWeight.w400,
                                fontSize: 14),
                          )),
                    ],
                  )
                ],
              ),
            ),
            verticalSpaces(context, height: 40),
            commonText("Package Information",
                color: Colors.black,
                fontFamily: LexendRegular,
                fontWeight: FontWeight.w600,
                fontSize: 18),
            verticalSpaces(context, height: 40),
            Row(children: [
              commonText("Package type",
                  color: Colors.black,
                  fontFamily: LexendRegular,
                  fontWeight: FontWeight.w400,
                  fontSize: 16),
              horizontal(context, width: 6),
              Expanded(
                child: commonText("Number of Packages",
                    color: Colors.black,
                    fontFamily: LexendRegular,
                    fontWeight: FontWeight.w400,
                    fontSize: 16),
              ),
            ],),
            verticalSpaces(context, height: 60),
            Row(
              children: [
                Row(children: [
                  simpleCheckBox(context, value: value, onChanged: (
                      val) {
                    setState(() {
                      value = !value;
                    });
                  }),
                  horizontal(context, width: 60),
                  commonText("Package type",
                      color: HexColor.HColor,
                      fontFamily: LexendRegular,
                      fontWeight: FontWeight.w400,
                      fontSize: 16),
                ],),
                horizontal(context, width: 10),
                Expanded(
                    child: getRoundedTexfield(height: 45, hintText: "", controller: controller, ctx: context,contentPaddingTop: screenHeight(context, dividedBy: 65),))
              ],
            ),
            verticalSpaces(context, height: 40),
            Row(
              children: [
                Row(children: [
                  simpleCheckBox(context, value: value),
                  horizontal(context, width: 60),
                  commonText("Package type",
                      color: HexColor.HColor,
                      fontFamily: LexendRegular,
                      fontWeight: FontWeight.w400,
                      fontSize: 16),
                ],),
                horizontal(context, width: 10),
                Expanded(
                    child: getRoundedTexfield(height: 45, hintText: "", controller: controller, ctx: context,contentPaddingTop: screenHeight(context, dividedBy: 65),))
              ],
            ),
            verticalSpaces(context, height: 40),
            Row(
              children: [
                Row(children: [
                  simpleCheckBox(context, value: value),
                  horizontal(context, width: 60),
                  commonText("Package type",
                      color: HexColor.HColor,
                      fontFamily: LexendRegular,
                      fontWeight: FontWeight.w400,
                      fontSize: 16),
                ],),
                horizontal(context, width: 10),
                Expanded(
                    child: getRoundedTexfield(height: 45, hintText: "", controller: controller, ctx: context,contentPaddingTop: screenHeight(context, dividedBy: 65),))
              ],
            ),
            verticalSpaces(context, height: 40),
            Row(
              children: [
                Row(children: [
                  simpleCheckBox(context, value: value),
                  horizontal(context, width: 60),
                  commonText("Package type",
                      color: HexColor.HColor,
                      fontFamily: LexendRegular,
                      fontWeight: FontWeight.w400,
                      fontSize: 16),
                ],),
                horizontal(context, width: 10),
                Expanded(
                    child: getRoundedTexfield(height: 45, hintText: "", controller: controller, ctx: context,contentPaddingTop: screenHeight(context, dividedBy: 65),))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
