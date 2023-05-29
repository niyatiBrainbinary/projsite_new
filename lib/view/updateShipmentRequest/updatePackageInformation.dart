import 'package:flutter/material.dart';
import 'package:proj_site/common/colors/colors.dart';
import 'package:proj_site/common/widget_constant/widget_constant.dart';
import 'package:proj_site/cubits/booking_cubit.dart';
import 'package:proj_site/cubits/calendar_cubit.dart';
import 'package:proj_site/helper/helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:proj_site/cubits/package_information_cubit.dart';
import 'package:proj_site/cubits/shipment_cubit.dart';

import '../../api service/models/shipment_models/update_shipment_model.dart';


class UpdatePackageInformation extends StatefulWidget {
  Map shipmentMap;
  Map enviromentMap;
  String responsiblePersonId;
  String requestId;
  bool isUpdated;
  bool isUpdatedSecond;
  UpdatePackageInformation(
      {
        required  this.requestId,
        required  this.shipmentMap,
        required  this.enviromentMap,
        required this.responsiblePersonId,
  required this.isUpdated,
  required this.isUpdatedSecond,

      }
      );

  @override
  State<UpdatePackageInformation> createState() => _UpdatePackageInformationState();
}
class _UpdatePackageInformationState extends State<UpdatePackageInformation> {

  final List<String> _dropdownValues = ["One", "Two", "Three", "Four", "Five"];
  TextEditingController _weightTxt = TextEditingController();
  List<bool> values = [];
  List<TextEditingController> _amountCon = [];
  late PackageInformationCubit _packageInformationCub;
  List _id=["eu_pall","sjo_pall","langgods","bunts","paket","stycke_gods"];
  late CalendarCubit calendarCub;
  late ShipmentCubit shipmentCub;
  late BookingCubit bookingCub;

  Map <dynamic, dynamic> finalMap = {};

  List updatedThirdValues=[];
  List updatedThirdAmounts=[];

  void saveOnTap(){
    List<Map> kollis=[];
    for(int i=0;i<_id.length;i++){
      kollis.add({"id": _id[i], "value": values[i], "amount": _amountCon[i].text});
    }

    bool isUpdatedThird = false;
    bool isUpdatedThirdValue = false;



    for(int i=0;i< updatedThirdAmounts.length;i++)
    {
      if(updatedThirdAmounts[i] != _amountCon[i].text)
      {
        isUpdatedThird = false;
        break;
      }
      else
      {
        isUpdatedThird = true;
      }
    }
    for(int i=0;i< updatedThirdValues.length;i++)
    {
      if(updatedThirdValues[i] != values[i])
      {
        isUpdatedThirdValue = false;
        break;
      }
      else
      {
        isUpdatedThirdValue = true;
      }
    }



    Map <dynamic, dynamic> packageInformationMap = {
      "kollis" : kollis
    };

    finalMap = {...widget.shipmentMap,...widget.enviromentMap,...packageInformationMap};


    bool finalUpdatedValue = false;

    if(widget.isUpdated ==true && widget.isUpdatedSecond ==true && isUpdatedThird ==true && isUpdatedThirdValue == true)
      {
        finalUpdatedValue =true;
      }
    else{
      finalUpdatedValue = false;
    }
    shipmentCub.UpdateShipment(finalMap,context,finalUpdatedValue);

   bookingCub.AddBooking(widget.requestId, widget.responsiblePersonId);

  }

  initThird(){

    // updatedThirdValues = values;
    // updatedThirdAmounts = _amountCon;

  }

  initData(){
    _packageInformationCub = BlocProvider.of<PackageInformationCubit>(context);
    calendarCub = BlocProvider.of<CalendarCubit>(context);
    shipmentCub = BlocProvider.of<ShipmentCubit>(context);
    _packageInformationCub.PackageInformation();

    bookingCub = BlocProvider.of<BookingCubit>(context);

    if(calendarCub.requestData!.result!.kollis!=null){
      for(int i=0;i<_id.length;i++){
        values.add(bool.hasEnvironment(calendarCub.requestData!.result!.kollis![i].value.toString()));
        _amountCon.add(TextEditingController());
        _amountCon[i].text=calendarCub.requestData!.result!.kollis![i].amount;
        updatedThirdValues.add(bool.hasEnvironment(calendarCub.requestData!.result!.kollis![i].value.toString()));
        updatedThirdAmounts.add(calendarCub.requestData!.result!.kollis![i].amount);
      }
    }

  }
  @override
  void initState() {

 loadData();

    // TODO: implement initState
    super.initState();

  }
  loadData()async{
    await initData();
    initThird();
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
                      child: commonText("Shipment request info",
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
                          BlocBuilder<PackageInformationCubit, PackageInformationState>(
                            builder: (context, state) {
                              if(state is PackageInformationLoading){
                                return loader();
                              }else if (state is PackageInformationError){
                                return errorLoadDataText();
                              } else{
                                if(_packageInformationCub.packageInfo.isEmpty){
                                  return noDataFoundText();
                                }else {
                                  return  ListView.builder(
                                    itemCount: _packageInformationCub.packageInfo.length,
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      if(calendarCub.requestData!.result!.kollis==null){
                                        values.add(_packageInformationCub.packageInfo[index].value);
                                        _amountCon.add(TextEditingController());
                                      }
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
                                                    simpleCheckBox(context,
                                                        value: values[index],
                                                        onChanged: (val) {
                                                          setState(() {
                                                            values[index] = !values[index];
                                                          });
                                                        }),
                                                    horizontal(context, width: 80),
                                                    commonText(_packageInformationCub.packageInfo[index].name,
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
                                                    controller: _amountCon[index],
                                                    textInputType: TextInputType.number,
                                                    height: 45,
                                                    ctx: context))
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                }
                              }

                            },
                          ),

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
                    BlocBuilder<ShipmentCubit, ShipmentState>(
                      builder: (context, state) {
                        if(state is UpdateShipmentLoading){
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
        ));
  }
}
