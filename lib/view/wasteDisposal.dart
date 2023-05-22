
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:proj_site/common/colors/colors.dart';
import 'package:proj_site/common/image_constant/image_constant.dart';
import 'package:proj_site/common/widget_constant/widget_constant.dart';
import 'package:proj_site/cubits/auth_cubit.dart';
import 'package:proj_site/cubits/waste_disposal_cubit.dart';
import 'package:proj_site/helper/helper.dart';


class WasteDisposal extends StatefulWidget {
  const WasteDisposal({Key? key}) : super(key: key);

  @override
  State<WasteDisposal> createState() => _WasteDisposalState();
}


class _WasteDisposalState extends State<WasteDisposal> {

  TextEditingController informationCon = TextEditingController();
  TextEditingController amountCon = TextEditingController();
  final List<String> bookingValues = ["Buy","Clearance", "Exhibit"];
  final ImagePicker _picker = ImagePicker();
  XFile? photo;
  String whenDate = "Select Date";
  DateTime? dateTime;
  bool whenStatus1 = false;
  bool whenStatus2 = false;

  String? containerVal;
  String? containerId;

  String? fractionVal;
  String? fractionId;

  String? bookingVal;
  late WasteDisposalCubit wasteDisposalCub;
  late AuthCubit authCub;

  _onTap1() async {
    dateTime = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2101));
    if (dateTime != null) {
      print(dateTime);
      String formattedDate = DateFormat('yyyy-MM-dd').format(dateTime!);
      print(formattedDate);
      setState(() {
        whenDate = formattedDate;
      });
    } else {
      print("Date is not selected");
    }
  }

  saveOnTap(){
    Map body = {
      "project_id": projectIdMain,
      "organization_id": orgId,
      "booking": bookingVal,
      "when": whenStatus1==true?"Soon":"date",
      "when_date": whenDate,
      "waste_container_id": containerId,
      "amount_of_container": amountCon.text,
      "waste_fraction_id": fractionId,
      "info": informationCon.text
    };
    wasteDisposalCub.bookWasteDisposal(body,context);
  }

  @override
  void initState() {
    wasteDisposalCub= BlocProvider.of<WasteDisposalCubit>(context);
    authCub = BlocProvider.of<AuthCubit>(context);
    wasteDisposalCub.wasteContainerList(projectIdMain);
    super.initState();
  }

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
                    child: commonText("Book Waste Disposal",
                        color: Colors.black,
                        fontFamily: LexendRegular,
                        fontWeight: FontWeight.w700,
                        fontSize: 20)),
                Expanded(
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        commonText("Booking",
                            color: Colors.black,
                            fontFamily: LexendRegular,
                            fontWeight: FontWeight.w400,
                            fontSize: 12),
                        verticalSpaces(context, height: 80),
                        getDropDownButton(
                            ctx: context,
                            items: bookingValues,
                            hitText: "Select Booking",
                            value: bookingVal,
                            onChnaged: (val) {
                              bookingVal = val;
                              setState(() {});
                            }),
                        verticalSpaces(context, height: 40),
                        Row(
                          children: [
                            Expanded(
                                child: commonText("When ?",
                                    color: Colors.black,
                                    fontFamily: LexendRegular,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12)),
                          ],
                        ),
                        verticalSpaces(context, height: 80),
                        Row(
                          children: [
                            simpleCheckBox(context, value: whenStatus1,
                                onChanged: (val) {
                                  setState(() {
                                    whenStatus1 = !whenStatus1;
                                    if (whenStatus1 == false) {
                                      whenDate = "Select Date";
                                    } else{
                                      whenStatus2=false;
                                    }
                                  });
                                }),
                            horizontal(context, width: 80),
                            commonText('Soon',
                                color: HexColor.Gray53,
                                fontFamily: LexendRegular,
                                fontWeight: FontWeight.w400,
                                fontSize: 14),
                            horizontal(context, width: 20),
                            simpleCheckBox(context, value: whenStatus2,
                                onChanged: (val) {
                                  setState(() {
                                    whenStatus2 = !whenStatus2;
                                    if (whenStatus2 == false) {
                                      whenDate = "Select Date";
                                    }else{
                                      whenStatus1=false;
                                    }
                                  });
                                }),
                            horizontal(context, width: 80),
                            commonText('Select Date',
                                color: HexColor.Gray53,
                                fontFamily: LexendRegular,
                                fontWeight: FontWeight.w400,
                                fontSize: 14)
                          ],
                        ),
                        whenStatus2==true?Column(
                          children: [
                            verticalSpaces(context, height: 60),
                            Container(
                              height: screenHeight(context, dividedBy: 16),
                              child: getRoundedContainerWithTralingIcon(
                                  text: whenDate,
                                  onTap: _onTap1,
                                  image: icons.ic_calendar),
                            ),
                          ],
                        ):Container(),
                        verticalSpaces(context, height: 40),
                        commonText("Waste Container",
                            color: Colors.black,
                            fontFamily: LexendRegular,
                            fontWeight: FontWeight.w400,
                            fontSize: 12),
                        verticalSpaces(context, height: 80),
                        BlocBuilder<WasteDisposalCubit, WasteDisposalState>(
                          builder: (context, state) {
                            return getDropDownButton(
                                ctx: context,
                                items: wasteDisposalCub.containerNameList,
                                hitText: state is WasteContainerListLoading?"":"Select Waste Container",
                                value: containerVal,
                                onChnaged: (val) {
                                  containerVal = val;
                                  for (int i = 0;
                                  i < wasteDisposalCub.containerNameList.length;
                                  i++) {
                                    if (val == wasteDisposalCub.containerList[i].wasteContainerName) {
                                      containerId = wasteDisposalCub.containerList[i].id;
                                    }
                                  }
                                  setState(() {});
                                });
                          },
                        ),
                        verticalSpaces(context, height: 40),
                        commonText("Amount of Waste Containers",
                            color: Colors.black,
                            fontFamily: LexendRegular,
                            fontWeight: FontWeight.w400,
                            fontSize: 12),
                        verticalSpaces(context, height: 80),
                        getRoundedTexfield(
                            hintText: "Enter Amount of Waste Containers",
                            controller: amountCon,
                            maxline: 1,
                            textInputType: TextInputType.number,
                            ctx: context),
                        verticalSpaces(context, height: 40),
                        commonText("Waste Fraction",
                            color: Colors.black,
                            fontFamily: LexendRegular,
                            fontWeight: FontWeight.w400,
                            fontSize: 12),
                        verticalSpaces(context, height: 80),
                        BlocBuilder<WasteDisposalCubit, WasteDisposalState>(
                          builder: (context, state) {
                            return getDropDownButton(
                                ctx: context,
                                items: wasteDisposalCub.fractionNameList,
                                hitText: state is WasteFractionListLoading?"":"Select Waste Fraction",
                                value: fractionVal,
                                onChnaged: (val) {
                                  fractionVal = val;
                                  for (int i = 0;
                                  i < wasteDisposalCub.fractionNameList.length;
                                  i++) {
                                    if (val == wasteDisposalCub.fractionList[i].wasteFractionName) {
                                      fractionId = wasteDisposalCub.fractionList[i].id;
                                    }
                                  }
                                  setState(() {});
                                });
                          },
                        ),
                        verticalSpaces(context, height: 40),
                        commonText("More Information",
                            color: Colors.black,
                            fontFamily: LexendRegular,
                            fontWeight: FontWeight.w400,
                            fontSize: 12),
                        verticalSpaces(context, height: 80),
                        getRoundedTexfield(
                            height: screenHeight(context, dividedBy: 7),
                            hintText: "Enter More Information",
                            controller: informationCon,
                            maxline: 10,
                            ctx: context),
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
                      buttonColor: HexColor.Gray53.withOpacity(0.5),
                      onTap: () {
                        Navigator.pop(context);
                      }),
                  horizontal(context, width: 20),
                  BlocBuilder<WasteDisposalCubit, WasteDisposalState>(
                    builder: (context, state) {
                      if(state is BookWasteDisposalLoading){
                        return Container(
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
                        );
                      } else {
                        return commonButton(
                            context: context,
                            buttonName: "Save",
                            onTap: () {
                              saveOnTap();
                            });
                      }
                    },
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
