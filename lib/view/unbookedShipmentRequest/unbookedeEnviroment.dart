import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:proj_site/common/colors/colors.dart';
import 'package:proj_site/common/image_constant/image_constant.dart';
import 'package:proj_site/common/widget_constant/widget_constant.dart';
import 'package:proj_site/helper/helper.dart';
import 'package:proj_site/view/newShipmentRequest/packageInformation.dart';
import 'package:proj_site/view/unbookedShipmentRequest/unbookedPackageInformation.dart';

class UnbookedEnviroment extends StatefulWidget {
  const UnbookedEnviroment({Key? key}) : super(key: key);

  @override
  State<UnbookedEnviroment> createState() => _UnbookedEnviromentState();
}


class _UnbookedEnviromentState extends State<UnbookedEnviroment> {

  TextEditingController _startLocationCon = TextEditingController();
  TextEditingController _destinationLocationCon = TextEditingController();
  final List<String> _dropdownValues = ["One", "Two", "Three", "Four", "Five"];
  TextEditingController _weightTxt = TextEditingController();
  bool value = true;
  String fromDate = "Select Date";
  DateTime? arriveDate;

  String? _vehicle;
  String? _fuel;
  String? _euroClass;
  String? _vehicleCapacity;

  List vehicle=[];
  List fuel=[];
  List euroClass=[];
  List vehicleCapacity=[];
  List<TextEditingController> addLocationCon=[];

  List addDrivingRouteList = [];

  _onTap1() async {
    arriveDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2101));
    if (arriveDate != null) {
      print(arriveDate);
      String formattedDate = DateFormat('yyyy-MM-dd').format(arriveDate!);
      print(formattedDate);
      setState(() {
        fromDate = formattedDate;
      });
    } else {
      print("Date is not selected");
    }
  }

  Widget getDrivingRoute(int index) {
    return Column(
      children: [
        verticalSpaces(context, height: 40),
        Container(
          height: screenHeight(context, dividedBy: 2.2),
          width: screenWidth(context),
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: HexColor.Gray53.withOpacity(0.18),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  commonText("Add:",
                      color: Colors.black,
                      textAlign: TextAlign.center,
                      fontFamily: LexendRegular,
                      fontWeight: FontWeight.w400,
                      fontSize: 18),
                  Spacer(),
                  IconButton(
                      padding: EdgeInsets.zero,
                      constraints: BoxConstraints(),
                      onPressed: () {
                        addDrivingRouteList.removeAt(index);
                        vehicle.removeAt(index);
                        fuel.removeAt(index);
                        euroClass.removeAt(index);
                        vehicleCapacity.removeAt(index);
                        addLocationCon.removeAt(index);
                        setState(() {});
                      },
                      icon: Icon(
                        Icons.cancel_rounded,
                        color: Colors.grey,
                      ))
                ],
              ),
              getRoundedTexfield(
                  hintText: "Enter a Location",
                  controller: addLocationCon[index],
                  ctx: context),
              getDropDownButton(
                  ctx: context,
                  items: _dropdownValues,
                  hitText: "Select Vehicle",
                  value: vehicle[index],
                  onChnaged: (val) {
                    vehicle[index]=val;
                    setState(() {});
                  }),
              getDropDownButton(
                  ctx: context,
                  items: _dropdownValues,
                  hitText: "Select Fuel",
                  value: fuel[index],
                  onChnaged: (val) {
                    fuel[index] = val;
                    setState(() {});
                  }),
              getDropDownButton(
                  ctx: context,
                  items: _dropdownValues,
                  hitText: "Select Euro Class",
                  value: euroClass[index],
                  onChnaged: (val) {
                    euroClass[index] = val;
                    setState(() {});
                  }),
              getDropDownButton(
                  ctx: context,
                  items: _dropdownValues,
                  hitText: "Select Vehicle Capacity",
                  value: vehicleCapacity[index],
                  onChnaged: (val) {
                    vehicleCapacity[index] = val;
                    setState(() {});
                  }),
            ],
          ),
        ),
        verticalSpaces(context, height: 40),
        commonTextfieldWithPrefixIcon(
          context: context,
          textInputType: TextInputType.none,
          controller: _weightTxt,
          hintText: "",
          HColor: Colors.black,
          HfontWeight: FontWeight.w400,
          HfontFamily: LexendRegular,
          HfontSize: 14,
          text: 'Km',
        ),
      ],
    );
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
                      child: commonText("New unbooked shipment request",
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
                                  color: HexColor.Gray71,
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
                                  color: Colors.black,
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
                          commonText("Shipment Supplier",
                              color: Colors.black,
                              fontFamily: LexendRegular,
                              fontWeight: FontWeight.w400,
                              fontSize: 12),
                          verticalSpaces(context, height: 80),
                          Row(
                            children: [
                              Expanded(
                                  child: getRoundedContainerWithTralingIcon(
                                      text: fromDate,
                                      onTap: _onTap1,
                                      image: icons.ic_calendar,
                                      height: screenHeight(context,
                                          dividedBy: 15))),
                              horizontal(context, width: 70),
                              commonButton(
                                  context: context, buttonName: "Create New"),
                            ],
                          ),
                          verticalSpaces(context, height: 40),
                          commonText("Load Weight",
                              color: Colors.black,
                              fontFamily: LexendRegular,
                              fontWeight: FontWeight.w400,
                              fontSize: 12),
                          verticalSpaces(context, height: 80),
                          commonTextfieldWithPrefixIcon(
                            context: context,
                            textInputType: TextInputType.none,
                            controller: _weightTxt,
                            hintText: "",
                            HColor: Colors.black,
                            HfontWeight: FontWeight.w400,
                            HfontFamily: LexendRegular,
                            HfontSize: 14,
                            text: 'Kg',
                          ),
                          verticalSpaces(context, height: 30),
                          commonText("Driving route",
                              color: Colors.black,
                              fontFamily: LexendSemiBold,
                              fontWeight: FontWeight.w600,
                              fontSize: 16),
                          Column(
                            children: [
                              verticalSpaces(context, height: 40),
                              Container(
                                height: screenHeight(context, dividedBy: 2.2),
                                width: screenWidth(context),
                                padding: EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: HexColor.Gray53.withOpacity(0.18),
                                ),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    commonText("Start:",
                                        color: Colors.black,
                                        textAlign: TextAlign.center,
                                        fontFamily: LexendRegular,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 18),
                                    getRoundedTexfield(
                                        hintText: "Enter a Location",
                                        controller: _startLocationCon,
                                        ctx: context),
                                    getDropDownButton(
                                        ctx: context,
                                        items: _dropdownValues,
                                        hitText: "Select Vehicle",
                                        value: _vehicle,
                                        onChnaged: (val) {
                                          _vehicle = val;
                                          setState(() {});
                                        }),
                                    getDropDownButton(
                                        ctx: context,
                                        items: _dropdownValues,
                                        hitText: "Select Fuel",
                                        value: _fuel,
                                        onChnaged: (val) {
                                          _fuel = val;
                                          setState(() {});
                                        }),
                                    getDropDownButton(
                                        ctx: context,
                                        items: _dropdownValues,
                                        hitText: "Select Euro Class",
                                        value: _euroClass,
                                        onChnaged: (val) {
                                          _euroClass = val;
                                          setState(() {});
                                        }),
                                    getDropDownButton(
                                        ctx: context,
                                        items: _dropdownValues,
                                        hitText: "Select Vehicle Capacity",
                                        value: _vehicleCapacity,
                                        onChnaged: (val) {
                                          _vehicleCapacity = val;
                                          setState(() {});
                                        }),
                                  ],
                                ),
                              ),
                              verticalSpaces(context, height: 40),
                              commonTextfieldWithPrefixIcon(
                                context: context,
                                textInputType: TextInputType.none,
                                controller: _weightTxt,
                                hintText: "",
                                HColor: Colors.black,
                                HfontWeight: FontWeight.w400,
                                HfontFamily: LexendRegular,
                                HfontSize: 14,
                                text: 'Km',
                              ),
                            ],
                          ),
                          ListView.builder(
                            itemCount: addDrivingRouteList.length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return getDrivingRoute(index);
                            },
                          ),
                          //Column(children: getDrivingRouteListLength,),
                          verticalSpaces(context, height: 40),
                          commonText("Destination",
                              color: Colors.black,
                              fontFamily: LexendSemiBold,
                              fontWeight: FontWeight.w600,
                              fontSize: 16),
                          verticalSpaces(context, height: 80),
                          Container(
                            height: screenHeight(context, dividedBy: 5),
                            width: screenWidth(context),
                            padding: EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: HexColor.Gray53.withOpacity(0.18),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                getRoundedTexfield(
                                    hintText: "Enter a Location",
                                    controller: _destinationLocationCon,
                                    ctx: context),
                                Row(
                                  children: [
                                    Expanded(
                                        child: Container(
                                      height:
                                          screenHeight(context, dividedBy: 15),
                                      color: Colors.transparent,
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: GestureDetector(
                                              onTap: () {
                                                addDrivingRouteList.add(1);
                                                vehicle.add(null);
                                                fuel.add(null);
                                                euroClass.add(null);
                                                vehicleCapacity.add(null);
                                                addLocationCon.add((TextEditingController()));
                                                setState(() {});
                                              },
                                              child: Container(
                                                color: Colors.transparent,
                                                child: Row(
                                                  children: [
                                                    Image.asset(
                                                      icons.ic_add,
                                                      color: HexColor.orange,
                                                      width: 20,
                                                      height: 20,
                                                    ),
                                                    horizontal(context,
                                                        width: 80),
                                                    commonText('Add',
                                                        color: HexColor.orange,
                                                        fontFamily:
                                                            LexendRegular,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 12)
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Container(
                                              color: Colors.transparent,
                                              child: Row(
                                                children: [
                                                  simpleCheckBox(context,
                                                      value: value,
                                                      onChanged: (val) {
                                                    setState(() {
                                                      value = !value;
                                                    });
                                                  }),
                                                  horizontal(context,
                                                      width: 80),
                                                  Expanded(
                                                    child: commonText('Return?',
                                                        color: HexColor.Gray53,
                                                        fontFamily: LexendRegular,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 12),
                                                  )
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    )),
                                    commonButton(
                                        width:
                                            screenWidth(context, dividedBy: 3),
                                        context: context,
                                        buttonName: 'Calculate Distance',
                                        buttonTextSize: 14,
                                        padding: EdgeInsets.all(5))
                                  ],
                                ),
                              ],
                            ),
                          ),
                          verticalSpaces(context, height: 10)
                        ],
                      ),
                    ),
                  ),
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
                    commonButton(
                        context: context,
                        buttonName: "Next",
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return UnbookedPackageInformation();
                            },
                          ));
                        })
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
