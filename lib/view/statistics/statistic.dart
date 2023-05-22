import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:proj_site/common/colors/colors.dart';
import 'package:proj_site/common/widget_constant/widget_constant.dart';
import 'package:proj_site/helper/helper.dart';
import 'package:proj_site/common/image_constant/image_constant.dart';
import 'package:proj_site/view/statistics/statistic_table.dart';

class StatisticScreen extends StatefulWidget {
  static const id = 'Statistic_screen';

  const StatisticScreen({Key? key}) : super(key: key);

  @override
  State<StatisticScreen> createState() => _StatisticScreenState();
}

class _StatisticScreenState extends State<StatisticScreen> {
  List _dropdownValuesContainer = ["One", "Two", "Three", "Four"];
  List _dropdownValuesFraction = ["One", "Two", "Three", "Four"];

  var dropDownValContainer;
  var dropDownValFraction;

  TextEditingController numberOfWasteController = TextEditingController();
  TextEditingController amountOfFractionController = TextEditingController();
  TextEditingController numberOfTransportsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: getAppBarWithIcon(ctx: context) as PreferredSizeWidget?,
      body: getCommonContainer(
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            getCommonContainer(
              height: screenHeight(context, dividedBy: 16),
              width: screenWidth(context),
              color: Colors.transparent,
              child:
                  getContainerWithTralingIcon(ctx: context, text: 'Statistic'),
            ),
            verticalSpaces(context, height: 40),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    commonText("Waste container",
                        color: Colors.black,
                        fontFamily: LexendRegular,
                        fontWeight: FontWeight.w400,
                        fontSize: 14),
                    verticalSpaces(context, height: 80),

                    dropDown("Choose container", _dropdownValuesContainer, dropDownValContainer),
                    verticalSpaces(context, height: 30),
                    commonText("Number of waste containers",
                        color: Colors.black,
                        fontFamily: LexendRegular,
                        fontWeight: FontWeight.w400,
                        fontSize: 14),
                    verticalSpaces(context, height: 80),
                    numberTextFiled(numberOfWasteController),
                    verticalSpaces(context, height: 30),
                    commonText("Waste fraction",
                        color: Colors.black,
                        fontFamily: LexendRegular,
                        fontWeight: FontWeight.w400,
                        fontSize: 14),
                    verticalSpaces(context, height: 80),

                    dropDown("Choose fraction", _dropdownValuesFraction, dropDownValFraction),
                    verticalSpaces(context, height: 30),
                    commonText("Amount of fraction(Kg)",
                        color: Colors.black,
                        fontFamily: LexendRegular,
                        fontWeight: FontWeight.w400,
                        fontSize: 14),
                    verticalSpaces(context, height: 80),
                    numberTextFiled(amountOfFractionController),
                    verticalSpaces(context, height: 30),
                    commonText("Number of transports",
                        color: Colors.black,
                        fontFamily: LexendRegular,
                        fontWeight: FontWeight.w400,
                        fontSize: 14),
                    verticalSpaces(context, height: 80),
                    numberTextFiled(numberOfTransportsController),
                    verticalSpaces(context, height: 20),
                    Align(
                      alignment: Alignment.center,
                      child: commonButton(
                        context: context,
                        buttonName: "Add to list",
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => StatisticTableScreen()));
                        },
                      ),
                    ),
                    verticalSpaces(context, height: 30),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget dropDown(String hintText, List dropDownValList, var dropDownVal){
    return  Container(
      height: 45,
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
              color: HexColor.Gray53.withOpacity(0.6),
              width: 1)),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          hint: Text(
            hintText,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              fontFamily: LexendRegular,
              color: HexColor.Gray53,
            ),
          ),
          icon: Image.asset(icons.ic_downArrow, height: 7),
          items: dropDownValList.map((value) {
            return DropdownMenuItem(
              child: Text(value),
              value: value,
            );
          }).toList(),
          onChanged: (value) {
            print(value.runtimeType);
            print(value);
            dropDownVal = value!;
            setState(() {});
          },
          isExpanded: true,
          value: dropDownVal,
        ),
      ),
    );
  }

  Widget numberTextFiled(TextEditingController controller){
    return  Container(
      height: 45,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(
            color: HexColor.Gray53.withOpacity(0.5),
            width: 1.5),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          isCollapsed: true,
          border: InputBorder.none,
          contentPadding: EdgeInsets.only(left: 9, right: 9),
          hintText: "0".tr(),
          hintStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            fontFamily: LexendRegular,
            color: HexColor.Gray53,
          ),
        ),
      ),
    );
  }
}
