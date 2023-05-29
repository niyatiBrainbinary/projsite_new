import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:proj_site/common/colors/colors.dart';
import 'package:proj_site/common/widget_constant/widget_constant.dart';
import 'package:proj_site/cubits/statistic_cubit.dart';
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
  late StatisticsCubit _statisticsCubit;

  List _dropdownValuesContainer = ["One", "Two", "Three", "Four"];
  List _dropdownValuesFraction = ["One", "Two", "Three", "Four"];



  @override
  void initState() {
    _statisticsCubit = BlocProvider.of<StatisticsCubit>(context);

    _statisticsCubit.containerDropDownList(projectId: projectIdMain);
    _statisticsCubit.fractionDropDownList(projectId: projectIdMain);
    super.initState();
  }

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

                    // dropDown("Choose container", _statisticsCubit.wasteContainerDropDownList, dropDownValContainer),
                    BlocBuilder<StatisticsCubit, StatisticsState>(
                      builder: (context, state) {
                        return Container(
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
                                "Choose container",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: LexendRegular,
                                  color: HexColor.Gray53,
                                ),
                              ),
                              icon:
                              Image.asset(icons.ic_downArrow, height: 7),
                              items: _statisticsCubit
                                  .wasteContainerDropDownList
                                  .map((value) {
                                return DropdownMenuItem(
                                  child: Text(value["name"]),
                                  value: value["name"],
                                );
                              }).toList(),
                              onChanged: (value) {
                                print(value.runtimeType);
                                print(value);
                                _statisticsCubit.containerName = value!;
                                _statisticsCubit.wasteContainerDropDownList.forEach((element) {
                                  if(element["name"] == value){
                                    _statisticsCubit.containerId = element["id"];
                                  }

                                });
                                setState(() {});
                              },
                              isExpanded: true,
                              value:  _statisticsCubit.containerName,
                            ),
                          ),
                        );
                      },
                    ),

                    verticalSpaces(context, height: 30),
                    commonText("Number of waste containers",
                        color: Colors.black,
                        fontFamily: LexendRegular,
                        fontWeight: FontWeight.w400,
                        fontSize: 14),
                    verticalSpaces(context, height: 80),
                    numberTextFiled( _statisticsCubit.numberOfWasteController),
                    verticalSpaces(context, height: 30),
                    commonText("Waste fraction",
                        color: Colors.black,
                        fontFamily: LexendRegular,
                        fontWeight: FontWeight.w400,
                        fontSize: 14),
                    verticalSpaces(context, height: 80),

                    //dropDown("Choose fraction", _dropdownValuesFraction, dropDownValFraction),
                    BlocBuilder<StatisticsCubit, StatisticsState>(
                      builder: (context, state) {
                        return Container(
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
                                "Choose fraction",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: LexendRegular,
                                  color: HexColor.Gray53,
                                ),
                              ),
                              icon:
                              Image.asset(icons.ic_downArrow, height: 7),
                              items: _statisticsCubit
                                  .wasteFractionDropDownList
                                  .map((value) {
                                return DropdownMenuItem(
                                  child: Text(value["name"]),
                                  value: value["name"],
                                );
                              }).toList(),
                              onChanged: (value) {
                                print(value.runtimeType);
                                print(value);
                                _statisticsCubit.fractionName = value!;
                                _statisticsCubit.wasteFractionDropDownList.forEach((element) {
                                  if(element["name"] == value){
                                    _statisticsCubit.fractionId = element["id"];
                                  }

                                });
                                setState(() {});
                              },
                              isExpanded: true,
                              value:  _statisticsCubit.fractionName,
                            ),
                          ),
                        );
                      },
                    ),

                    verticalSpaces(context, height: 30),
                    commonText("Amount of fraction(Kg)",
                        color: Colors.black,
                        fontFamily: LexendRegular,
                        fontWeight: FontWeight.w400,
                        fontSize: 14),
                    verticalSpaces(context, height: 80),
                    numberTextFiled( _statisticsCubit.amountOfFractionController),
                    verticalSpaces(context, height: 30),
                    commonText("Number of transports",
                        color: Colors.black,
                        fontFamily: LexendRegular,
                        fontWeight: FontWeight.w400,
                        fontSize: 14),
                    verticalSpaces(context, height: 80),
                    numberTextFiled( _statisticsCubit.numberOfTransportsController),
                    verticalSpaces(context, height: 20),

                    BlocBuilder<StatisticsCubit, StatisticsState>(
                      builder: (context, state) {
                        if(state is AddToListLoading){
                          return Align(
                            alignment: Alignment.center,
                            child: Container(
                              height: screenHeight(context, dividedBy: 18),
                              width: screenWidth(context, dividedBy: 3.2),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(32),
                                color: HexColor.buttonColor,
                              ),
                              child: LoadingAnimationWidget.prograssiveDots(
                                color: Colors.black,
                                size: 35,
                              ),
                            ),
                          );
                        } else {
                          return Align(
                            alignment: Alignment.center,
                            child: commonButton(
                              context: context,
                              buttonName: "Add to list",
                              onTap: () {

                                FocusScope.of(context).unfocus();

                                if( _statisticsCubit.containerName == null){
                                  snackBar("Please select waste container", false);
                                } else if( _statisticsCubit.numberOfWasteController.text.trim() == ""){
                                  snackBar("Please enter number of waste containers", false);
                                } else if( _statisticsCubit.fractionName == null){
                                  snackBar("Please select waste fraction", false);
                                } else if( _statisticsCubit.amountOfFractionController.text.trim() == ""){
                                  snackBar("Please enter amount of fraction", false);
                                } else if( _statisticsCubit.numberOfTransportsController.text.trim() == ""){
                                  snackBar("Please enter number of transports", false);
                                }
                                else {
                                  _statisticsCubit.addToWasteList(
                                    context: context,
                                    projectId: projectIdMain,
                                    wasteContainerId:  _statisticsCubit.containerId,
                                    wasteFractionId:  _statisticsCubit.fractionId,
                                    numberOfContainers: int.parse( _statisticsCubit.numberOfWasteController.text),
                                    amountOfFraction: int.parse( _statisticsCubit.amountOfFractionController.text),
                                    amountOfTransports: int.parse( _statisticsCubit.numberOfTransportsController.text),
                                  );



                                }






                              },
                            ),
                          );
                        }

                      },
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

  Widget dropDown(String hintText, List dropDownValList, var dropDownVal) {
    return BlocBuilder<StatisticsCubit, StatisticsState>(
      builder: (context, state) {
        return Container(
          height: 45,
          padding: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(
                  color: HexColor.Gray53.withOpacity(0.6), width: 1)),
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
      },
    );
  }

  Widget numberTextFiled(TextEditingController controller) {
    return Container(
      height: 45,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(color: HexColor.Gray53.withOpacity(0.5), width: 1.5),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly
        ],
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
