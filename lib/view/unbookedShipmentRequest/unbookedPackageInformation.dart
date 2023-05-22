import 'package:flutter/material.dart';
import 'package:proj_site/common/colors/colors.dart';
import 'package:proj_site/common/image_constant/image_constant.dart';
import 'package:proj_site/common/widget_constant/widget_constant.dart';
import 'package:proj_site/helper/helper.dart';

class UnbookedPackageInformation extends StatefulWidget {
  const UnbookedPackageInformation({Key? key}) : super(key: key);

  @override
  State<UnbookedPackageInformation> createState() => _UnbookedPackageInformationState();
}

TextEditingController _subName = TextEditingController();
final List<String> _dropdownValues = ["One", "Two", "Three", "Four", "Five"];
TextEditingController _weightTxt = TextEditingController();
bool value = true;

class _UnbookedPackageInformationState extends State<UnbookedPackageInformation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: getAppBarWithIcon(
          ctx: context,
        ) as PreferredSizeWidget?,
        body: Stack(
          children: [
            getCommonContainer(
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  getCommonContainer(
                      height: screenHeight(context, dividedBy: 15),
                      width: screenWidth(context),
                      color: Colors.transparent,
                      child: commonText("New unbooked shipment request",
                          color: Colors.black,
                          fontFamily: LexendBold,
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
                                  color: HexColor.orange,
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
                  Expanded(
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          verticalSpaces(context, height: 80),
                          commonText("Package Information",
                              color: Colors.black,
                              fontFamily: LexendRegular,
                              fontWeight: FontWeight.w600,
                              fontSize: 17),
                          verticalSpaces(context, height: 50),
                          Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: commonText("Package type",
                                    color: Colors.black,
                                    fontFamily: LexendRegular,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 13),
                              ),
                              Expanded(
                                flex: 4,
                                child: commonText("Number of Packages",
                                    color: Colors.black,
                                    fontFamily: LexendRegular,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 13),
                              ),
                            ],
                          ),
                          verticalSpaces(context, height: 40),
                          ListView.builder(itemCount: 10,physics: NeverScrollableScrollPhysics(),shrinkWrap: true,itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: Container(
                                      color: Colors.transparent,
                                      child: Row(
                                        children: [
                                          simpleCheckBox(context, value: value,
                                              onChanged: (val) {
                                                setState(() {
                                                  value = !value;
                                                });
                                              }),
                                          horizontal(context, width: 80),
                                          commonText('Package type',
                                              color: HexColor.Gray53,
                                              fontFamily: LexendRegular,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 13)
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                      flex: 4,
                                      child: getRoundedTexfield(
                                          hintText: "",
                                          controller: _subName,height: 45,
                                          ctx: context))
                                ],
                              ),
                            );
                          },),

                        ],
                      ),
                    ),
                  ),
                  verticalSpaces(context, height: 10)
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: HexColor.Gray53.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: Offset(0, -5), // changes position of shadow
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    commonButton(
                        context: context,
                        buttonName: "close",
                        onTap: () {
                          Navigator.pop(context);
                        },
                        buttonColor: HexColor.Gray53.withOpacity(0.5)),
                    horizontal(context, width: 20),
                    commonButton(
                        context: context, buttonName: "Save", onTap: () {})
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
