
import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ftx/navigationX.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_place/google_place.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:proj_site/common/colors/colors.dart';
import 'package:proj_site/common/image_constant/image_constant.dart';
import 'package:proj_site/common/widget_constant/widget_constant.dart';
import 'package:proj_site/cubits/auth_cubit.dart';
import 'package:proj_site/cubits/enviromental_cubit.dart';
import 'package:proj_site/cubits/logistic_list_cubit.dart';
import 'package:proj_site/cubits/shipment_cubit.dart';
import 'package:proj_site/cubits/terminal_cubit.dart';
import 'package:proj_site/cubits/transport_request_cubit.dart';
import 'package:proj_site/helper/helper.dart';
import 'package:proj_site/view/logisticList/transportRequest.dart';
import 'package:proj_site/view/newShipmentRequest/packageInformation.dart';
import 'package:proj_site/view/pick_location.dart';
import 'package:uuid/uuid.dart';

class TerminalTransportEnviromental extends StatefulWidget {
  Map shipmentMap;

  TerminalTransportEnviromental(
    this.shipmentMap,
  );

  @override
  State<TerminalTransportEnviromental> createState() => _TerminalTransportEnviromentalState();
}

class _TerminalTransportEnviromentalState extends State<TerminalTransportEnviromental> {
  TextEditingController _startLocationCon = TextEditingController();
  TextEditingController _destinationLocationCon = TextEditingController();
  TextEditingController _supplierNameCon = TextEditingController();
  TextEditingController _loadWeightCon = TextEditingController();
  TextEditingController _distanceCon = TextEditingController();
  final List<String> vehicleCapacityList = [
    "10%",
    "20%",
    "30%",
    "40%",
    "50%",
    "60%",
    "70%",
    "80%",
    "90%",
    "100%"
  ];
  bool value = true;
  String fromDate = "Select Date";
  DateTime? arriveDate;
  late ShipmentCubit shipmentCub;
  String? _supplier;
  String _supplierId = "";
  String? _vehicle;
  String? _vehicleId;
  String? _fuel;
  String? _fuelId;
  String? _euroClass;
  String? _euroClassId;
  String? _vehicleCapacity;
  List vehicle = [];
  List fuel = [];
  List euroClass = [];
  List vehicleCapacity = [];
  List<TextEditingController> addLocationCon = [];
  List<TextEditingController> addFirstLocationCon = [];
  List<TextEditingController> addLastLocationCon = [];
  List<TextEditingController> distanceCon = [];
  List<AutocompletePrediction> predictions = [];
  List<bool> _enable = [];
  List<double> _addFirstlat = [];
  List<double> _addFirstlon = [];
  List<double> _addSecondtlat = [];
  List<double> _addSecondtlon = [];
  List addDrivingRouteList = [];
  bool isReturn = false;
  String token = '123456';
  bool _visible = false;
  var uuid = Uuid();
  List<dynamic> placeList = [];
  bool isHidden = false;
  late GooglePlace googlePlace;
  late EnviromentalCubit _enviromentalCubit;
  Completer<GoogleMapController> _controller = Completer();
  static final CameraPosition kGoogleplex =
  CameraPosition(target: LatLng(21.2469, 72.8515), zoom: 14);
  double lat = 0.0;
  double lon = 0.0;
  double lat1 = 0.0;
  double lon1 = 0.0;
  List<Marker> _marker = [];
  List<Marker> _list = [
    Marker(
        markerId: MarkerId('1'),
        position: LatLng(21.2469, 72.8515),
        infoWindow: InfoWindow(title: 'My Location')),
    Marker(
        markerId: MarkerId('1'),
        position: LatLng(21.2423, 72.878132),
        infoWindow: InfoWindow(title: 'Mota Varachha '))
  ];
  Map finalMap = {};

  void saveOnTap() {
    List<dynamic> addresses = [
      {
        "id": "add_general_request_environment_section_ac1",
        "place": _startLocationCon.text,
        "lat": lat,
        "lng": lon,
        "airport": false,
        "type_of_vehicle": _vehicleId,
        "euro_class": _euroClassId,
        "type_of_fuel": _fuelId,
        // "vehicle_capacity": int.parse(_vehicleCapacity!.split("%").first),
        "vehicle_capacity": _vehicleCapacity,
        "part_distance": _distanceCon.text
      },
      {
        "id": "add_general_request_environment_section_ac2",
        // "place": addLocationCon[i].text,
        "place": _destinationLocationCon.text,
        "lat": lat1,
        "lng": lon1,
      },
    ];
    for (int i = 0; i < addDrivingRouteList.length; i++) {
      addresses.add( {
        "id" : "add_general_request_environment_section_ac${i+3}",
        "place" : addFirstLocationCon[i].text,
        "lat" : _addFirstlat[i].toString(),
        "lng" : _addFirstlon[i].toString(),
        "airport" : false,
        "type_of_vehicle" : vehicle[i],
        "euro_class" : euroClass[i],
        "type_of_fuel" : fuel[i],
        "vehicle_capacity" : vehicleCapacity[i],
        "part_distance" : distanceCon[i]
      },);
      addresses.add({
        "id" : "add_general_request_environment_section_ac${i+4}",
        "place" : addLastLocationCon[i].text,
        "lat" : _addSecondtlat[i].toString(),
        "lng" : _addSecondtlon[i].toString(),
      });
    }

   if(_startLocationCon.text.isEmpty){
     snackBar("Please Enter Location", false);
    }else if(_vehicle == "" || _vehicle == null){
     snackBar("Please Select Vehicle", false);
    }else if(_fuel == "" || _fuel == null){
     snackBar("Please Select Fuel", false);
    }else if(_euroClass == "" || _euroClass == null){
     snackBar("Please Select EuroClass", false);
    }else if(_vehicleCapacity == "" || _vehicleCapacity == null){
     snackBar("Please Select VehicleCapacity", false);
    }else if(_distanceCon.text.isEmpty){
     snackBar("Please Enter distance", false);
    }
   else{
     Map enviromentMap = {
       "delivery_supplier": _supplierId,
       "load_weight": _loadWeightCon.text == null?"":_loadWeightCon.text,
       "driving_distance": _distanceCon.text,
       "is_return": isReturn,
       "address": addresses,
       "is_recurring": "false",
       "recurring_id": "",
       "recurring_days": "",
       "recurring_to_date": "",
       "is_hidden": isHidden,
       "is_hidden_environment": isHidden,
     };
     finalMap = {...widget.shipmentMap,...enviromentMap};
     BlocProvider.of<TerminalCubit>(context).AddTerminal(finalMap,context);
   }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _startLocationCon.dispose();
    super.dispose();
  }

  @override
  void initState() {
    shipmentCub = BlocProvider.of<ShipmentCubit>(context);
    shipmentCub.ShipmentSupplierList(
        projectIdMain);
    _enviromentalCubit = BlocProvider.of<EnviromentalCubit>(context);
    _enviromentalCubit.Euroclass();
    _enviromentalCubit.Vehicle();
    _enviromentalCubit.Fuel();
    String apiKey = 'AIzaSyDtFavTh7_aJL9D3XGEmoFlIImXsibuREY';
    googlePlace = GooglePlace(apiKey);
    super.initState();
  }

  Widget getDrivingRoute(int index) {
    // return Column(
    //   children: [
    //     verticalSpaces(context, height: 40),
    //     Container(
    //       height: screenHeight(context, dividedBy: 2.2),
    //       width: screenWidth(context),
    //       padding: EdgeInsets.all(15),
    //       decoration: BoxDecoration(
    //         borderRadius: BorderRadius.circular(10),
    //         color: HexColor.Gray53.withOpacity(0.18),
    //       ),
    //       child: Column(
    //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //         children: [
    //           Row(
    //             children: [
    //               commonText("Add:",
    //                   color: Colors.black,
    //                   textAlign: TextAlign.center,
    //                   fontFamily: LexendRegular,
    //                   fontWeight: FontWeight.w400,
    //                   fontSize: 18),
    //               Spacer(),
    //               IconButton(
    //                   padding: EdgeInsets.zero,
    //                   constraints: BoxConstraints(),
    //                   onPressed: () {
    //                     addDrivingRouteList.removeAt(index);
    //                     vehicle.removeAt(index);
    //                     fuel.removeAt(index);
    //                     euroClass.removeAt(index);
    //                     vehicleCapacity.removeAt(index);
    //                     addLocationCon.removeAt(index);
    //                     distanceCon.removeAt(index);
    //                     setState(() {});
    //                   },
    //                   icon: Icon(
    //                     Icons.cancel_rounded,
    //                     color: Colors.grey,
    //                   ))
    //             ],
    //           ),
    //           getRoundedTexfield(
    //               hintText: "Enter a Location",
    //               controller: addLocationCon[index],
    //               ctx: context),
    //           getDropDownButton(
    //               ctx: context,
    //               items: _enviromentalCubit.vehicleList,
    //               hitText: "Select Vehicle",
    //               value: vehicle[index],
    //               onChnaged: (val) {
    //                 vehicle[index] = val;
    //                 setState(() {});
    //               }),
    //           getDropDownButton(
    //               ctx: context,
    //               items: _enviromentalCubit.fuelList,
    //               hitText: "Select Fuel",
    //               value: fuel[index],
    //               onChnaged: (val) {
    //                 fuel[index] = val;
    //                 setState(() {});
    //               }),
    //           getDropDownButton(
    //               ctx: context,
    //               items: _enviromentalCubit.euroclassList,
    //               hitText: "Select Euro Class",
    //               value: euroClass[index],
    //               onChnaged: (val) {
    //                 euroClass[index] = val;
    //                 setState(() {});
    //               }),
    //           getDropDownButton(
    //               ctx: context,
    //               items: vehicleCapacityList,
    //               hitText: "Select Vehicle Capacity",
    //               value: vehicleCapacity[index],
    //               onChnaged: (val) {
    //                 vehicleCapacity[index] = val;
    //                 setState(() {});
    //               }),
    //         ],
    //       ),
    //     ),
    //     verticalSpaces(context, height: 40),
    //     commonTextfieldWithPrefixIcon(
    //       context: context,
    //       textInputType: TextInputType.number,
    //       controller: distanceCon[index],
    //       hintText: "Distance",
    //       HColor: Colors.grey,
    //       HfontWeight: FontWeight.w400,
    //       HfontFamily: LexendRegular,
    //       HfontSize: 14,
    //       text: 'Km',
    //     ),
    //     verticalSpaces(context, height: 40),
    //     Align(
    //         alignment: Alignment.bottomRight,
    //         child: commonButton(
    //             context: context,
    //             buttonName: "Calculate Distance",
    //             width: screenWidth(context, dividedBy: 2.7),
    //             padding: EdgeInsets.all(5),
    //             buttonTextSize: 12))
    //   ],
    // );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start ,
      children: [
        Column(
          children: [
            verticalSpaces(context, height: 40),
            Container(
              //height: screenHeight(context, dividedBy: 2.2),
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
                  Row(
                    children: [
                      commonText("Add",
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
                            distanceCon.removeAt(index);
                            addLastLocationCon.removeAt(index);
                            addFirstLocationCon.removeAt(index);
                            _addFirstlat.removeAt(index);
                            _addFirstlon.removeAt(index);
                            _addSecondtlat.removeAt(index);
                            _addSecondtlon.removeAt(index);
                            _enable.removeAt(index);
                            setState(() {});
                          },
                          icon: Icon(
                            Icons.cancel_rounded,
                            color: Colors.grey,
                          ))
                    ],
                  ),
                  verticalSpaces(context, height: 80),
                  getRoundedTexfield(
                      hintText: "Enter a Location",
                      controller: addFirstLocationCon[index],
                      readOnly: true,
                      onTap: () async {
                        // _awaitStartLocation(context);
                        String result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddLocation(),
                            ));
                        setState(() {
                          addFirstLocationCon[index].text = result;
                          print("update${ addFirstLocationCon[index].text}");
                        });
                      },

                      ctx: context),
                  verticalSpaces(context, height: 80),
                  getDropDownButton(
                      ctx: context,
                      items: _enviromentalCubit.vehicleList,
                      hitText: "Select Vehicle",
                      value: vehicle[index],
                      onChnaged: (val) {
                        vehicle[index] = val;
                        setState(() {});
                      }),
                  verticalSpaces(context, height: 80),
                  getDropDownButton(
                      ctx: context,
                      items: _enviromentalCubit.fuelList,
                      hitText: "Select Fuel",
                      value: fuel[index],
                      onChnaged: (val) {
                        fuel[index] = val;
                        setState(() {});
                      }),
                  verticalSpaces(context, height: 80),
                  getDropDownButton(
                      ctx: context,
                      items: _enviromentalCubit.euroclassList,
                      hitText: "Select Eurolass",
                      value: euroClass[index],
                      onChnaged: (val) {
                        euroClass[index] = val;
                        setState(() {});
                      }),
                  verticalSpaces(context, height: 80),
                  getDropDownButton(
                      ctx: context,
                      items: vehicleCapacityList,
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
              textInputType: TextInputType.number,
              controller: distanceCon[index],
              readOnly: true,
              hintText: "Distance",
              HColor: Colors.grey,
              HfontWeight: FontWeight.w400,
              HfontFamily: LexendRegular,
              HfontSize: 14,
              text: 'Km',
            ),
          ],
        ),
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
                  controller: addLastLocationCon[index],
                  readOnly: true,
                  onTap: () async {
                    //_awaitDestinationLocation(context);
                    String result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddLocation(),
                        ));
                    setState(() {
                      addLastLocationCon[index].text = result;
                    });
                  },
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
                              child: Container(
                                color: Colors.transparent,
                                child: Row(
                                  children: [
                                    simpleCheckBox(context,
                                        value: _enable[index],
                                        onChanged: (val) {
                                          setState(() {
                                            _enable[index] = !_enable[index];
                                          });
                                        }),
                                    horizontal(context,
                                        width: 80),
                                    Expanded(
                                      child: commonText('Return?',
                                          color: HexColor.Gray53,
                                          fontFamily:
                                          LexendRegular,
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
                      width: screenWidth(context,
                          dividedBy: 2.7),
                      onTap: () async {
                        if (addFirstLocationCon[index].text.isEmpty ||
                            addLastLocationCon[index]
                                .text.isEmpty) {
                          snackBar(
                              "location field is required",
                              false);
                        } else {
                          try {
                            var addresses = await Geocoder.local.findAddressesFromQuery(addFirstLocationCon[index].text);
                            var first = addresses.first;
                            _addFirstlat[index] = first.coordinates.latitude!;
                            _addFirstlon[index] = first.coordinates.longitude!;
                            var addresses1 = await Geocoder.local.findAddressesFromQuery(addLastLocationCon[index].text);
                            var first1 = addresses1.first;
                            _addSecondtlat[index] =
                                first1.coordinates.latitude!;
                            _addSecondtlon[index] =
                                first1.coordinates.longitude!;
                            print("lat${_addFirstlat[index]}");
                            print("lon${_addFirstlon[index]}");
                            print("lat1${_addSecondtlat[index]}");
                            print("lon1${_addSecondtlon[index]}");
                            var p = 0.017453292519943295;
                            var a = 0.5 -
                                cos((_addSecondtlat[index] - _addFirstlat[index]) * p) / 2 +
                                cos(_addSecondtlat[index] * p) *
                                    cos(_addSecondtlat[index] * p) *
                                    (1 -
                                        cos((_addSecondtlon[index] - _addFirstlon[index]) *
                                            p)) /
                                    2;
                            print("Distance$a");
                            double cal =
                                12742 * asin(sqrt(a));

                            print("DistanceKm${cal}");
                            print("isHidden${_enable[index]}");
                            if (_enable[index] == true) {
                              double multiple = cal * 2;
                              distanceCon[index].text = multiple
                                  .toStringAsFixed(2)
                                  .toString();
                            } else {
                              distanceCon[index].text = cal
                                  .toStringAsFixed(2)
                                  .toString();
                            }
                          } catch (e) {
                            snackBar(
                                "Better get on a plan.There are no roads between ${addFirstLocationCon[index].text} and ${addLastLocationCon[index].text}",
                                false);
                          }

                          setState(() {});
                        }
                      },
                      context: context,
                      buttonName: 'Calculate Distance',
                      buttonTextSize: 12,
                      padding: EdgeInsets.all(5))
                ],
              ),
            ],
          ),
        ),
        verticalSpaces(context, height: 40),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
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
                      child: commonText("Terminal Transport Booking",
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
                                child:
                                BlocBuilder<ShipmentCubit, ShipmentState>(
                                  builder: (context, state) {
                                    return getDropDownButton(
                                        ctx: context,
                                        items: shipmentCub.shipmentSuppName,
                                        hitText:
                                        state is ShipmentSupplierListLoading
                                            ? ""
                                            : "Select Supplier",
                                        value: _supplier,
                                        onChnaged: (val) {
                                          _supplier = val;
                                          for (int i = 0;
                                          i <
                                              shipmentCub
                                                  .shipmentSuppId.length;
                                          i++) {
                                            if (val ==
                                                shipmentCub
                                                    .shipmentSuppName[i]) {
                                              _supplierId =
                                              shipmentCub.shipmentSuppId[i];
                                            }
                                          }
                                          setState(() {});
                                        });
                                  },
                                ),
                              ),
                              horizontal(context, width: 70),
                              commonButton(
                                  context: context,
                                  buttonName: "Create New",
                                  buttonTextSize: 14,
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return Scaffold(
                                          backgroundColor: Colors.transparent,
                                          body: Column(
                                            children: [
                                              const Spacer(),
                                              Center(
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                                  padding:
                                                  const EdgeInsets.only(
                                                      left: 15,
                                                      right: 15,
                                                      top: 15,
                                                      bottom: 30),
                                                  margin: EdgeInsets.symmetric(
                                                      horizontal: 15),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment
                                                        .start,
                                                    children: [
                                                      Align(
                                                          alignment: Alignment
                                                              .centerRight,
                                                          child: IconButton(
                                                              padding:
                                                              EdgeInsets
                                                                  .zero,
                                                              constraints:
                                                              BoxConstraints(),
                                                              onPressed: () {
                                                                Navigation
                                                                    .instance
                                                                    .goBack();
                                                              },
                                                              icon: Icon(
                                                                Icons
                                                                    .cancel_outlined,
                                                                color: HexColor
                                                                    .Gray53,
                                                              ))),
                                                      Align(
                                                        alignment:
                                                        Alignment.center,
                                                        child: commonText(
                                                            "Create Shipment Supplier",
                                                            color: Colors.black,
                                                            fontFamily:
                                                            LexendRegular,
                                                            fontWeight:
                                                            FontWeight.w500,
                                                            fontSize: 18),
                                                      ),
                                                      verticalSpaces(context,
                                                          height: 30),
                                                      commonText(
                                                          "Supplier Name",
                                                          color: Colors.black,
                                                          textAlign:
                                                          TextAlign.center,
                                                          fontFamily:
                                                          LexendRegular,
                                                          fontWeight:
                                                          FontWeight.w400,
                                                          fontSize: 15),
                                                      verticalSpaces(context,
                                                          height: 80),
                                                      getRoundedTexfield(
                                                          hintText:
                                                          "Enter Supplier Name",
                                                          controller:
                                                          _supplierNameCon,
                                                          ctx: context),
                                                      verticalSpaces(context,
                                                          height: 20),
                                                      Row(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                        children: [
                                                          commonButton(
                                                              context: context,
                                                              buttonName:
                                                              "close",
                                                              buttonColor: HexColor
                                                                  .Gray53
                                                                  .withOpacity(
                                                                  0.5),
                                                              onTap: () {
                                                                Navigator.pop(
                                                                    context);
                                                              }),
                                                          horizontal(context,
                                                              width: 30),
                                                          BlocBuilder<
                                                              ShipmentCubit,
                                                              ShipmentState>(
                                                            builder: (context,
                                                                state) {
                                                              if (state
                                                              is CreateShipmentSupplierLoading) {
                                                                return Container(
                                                                  height: screenHeight(
                                                                      context,
                                                                      dividedBy:
                                                                      18),
                                                                  width: screenWidth(
                                                                      context,
                                                                      dividedBy:
                                                                      3.2),
                                                                  alignment:
                                                                  Alignment
                                                                      .center,
                                                                  decoration:
                                                                  BoxDecoration(
                                                                    borderRadius:
                                                                    BorderRadius.circular(
                                                                        32),
                                                                    color: HexColor
                                                                        .buttonColor,
                                                                  ),
                                                                  child: LoadingAnimationWidget
                                                                      .prograssiveDots(
                                                                    color: Colors
                                                                        .black,
                                                                    size: 35,
                                                                  ),
                                                                );
                                                              } else {
                                                                return commonButton(
                                                                    context:
                                                                    context,
                                                                    buttonName:
                                                                    "Save",
                                                                    onTap: () {
                                                                      shipmentCub.CreateShipmentSupplier(
                                                                          projectIdMain,
                                                                          _supplierNameCon.text);
                                                                    });
                                                              }
                                                            },
                                                          )
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              const Spacer(),
                                            ],
                                          ),
                                        );
                                      },
                                    );
                                  }),
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
                            textInputType: TextInputType.number,
                            controller: _loadWeightCon,
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
                                //height: screenHeight(context, dividedBy: 2.2),
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
                                    verticalSpaces(context, height: 80),
                                    getRoundedTexfield(
                                        hintText: "Enter a Location",
                                        controller: _startLocationCon,
                                        readOnly: true,
                                        onTap: () {
                                          _awaitStartLocation(context);
                                        },
                                        // onChanged: (val) {
                                        //   setState(() {
                                        //     _visible = true;
                                        //   });
                                        // },
                                        ctx: context),
                                    verticalSpaces(context, height: 80),
                                    getDropDownButton(
                                        ctx: context,
                                        items: _enviromentalCubit.vehicleList,
                                        hitText: "Select Vehicle",
                                        value: _vehicle,
                                        onChnaged: (val) {
                                          _vehicle = val;
                                          for (int i = 0;
                                          i <
                                              _enviromentalCubit
                                                  .vehicleList.length;
                                          i++) {
                                            if (val ==
                                                _enviromentalCubit
                                                    .vehicleList[i]) {
                                              _vehicleId = _enviromentalCubit
                                                  .vehicleListId[i];
                                            }
                                          }
                                          setState(() {});
                                        }),
                                    verticalSpaces(context, height: 80),
                                    getDropDownButton(
                                        ctx: context,
                                        items: _enviromentalCubit.fuelList,
                                        hitText: "Select Fuel",
                                        value: _fuel,
                                        onChnaged: (val) {
                                          _fuel = val;
                                          for (int i = 0;
                                          i <
                                              _enviromentalCubit
                                                  .fuelList.length;
                                          i++) {
                                            if (val ==
                                                _enviromentalCubit
                                                    .vehicleList[i]) {
                                              _fuelId = _enviromentalCubit
                                                  .fuelListId[i];
                                            }
                                          }
                                          setState(() {});
                                        }),
                                    verticalSpaces(context, height: 80),
                                    getDropDownButton(
                                        ctx: context,
                                        items: _enviromentalCubit.euroclassList,
                                        hitText: "Select Eurolass",
                                        value: _euroClass,
                                        onChnaged: (val) {
                                          _euroClass = val;
                                          for (int i = 0;
                                          i <
                                              _enviromentalCubit
                                                  .euroclassList.length;
                                          i++) {
                                            if (val ==
                                                _enviromentalCubit
                                                    .euroclassList[i]) {
                                              _euroClassId = _enviromentalCubit
                                                  .euroclassListId[i];
                                            }
                                          }
                                          setState(() {});
                                        }),
                                    verticalSpaces(context, height: 80),
                                    getDropDownButton(
                                        ctx: context,
                                        items: vehicleCapacityList,
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
                                textInputType: TextInputType.number,
                                controller: _distanceCon,
                                hintText: "Distance",
                                HColor: Colors.grey,
                                HfontWeight: FontWeight.w400,
                                HfontFamily: LexendRegular,
                                HfontSize: 14,
                                text: 'Km',
                              ),
                            ],
                          ),
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
                                    readOnly: true,
                                    onTap: () {
                                      _awaitDestinationLocation(context);
                                    },
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
                                                child: Container(
                                                  color: Colors.transparent,
                                                  child: Row(
                                                    children: [
                                                      simpleCheckBox(context,
                                                          value: isReturn,
                                                          onChanged: (val) {
                                                            setState(() {
                                                              isReturn = !isReturn;
                                                            });
                                                          }),
                                                      horizontal(context,
                                                          width: 80),
                                                      Expanded(
                                                        child: commonText('Return?',
                                                            color: HexColor.Gray53,
                                                            fontFamily:
                                                            LexendRegular,
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
                                        width: screenWidth(context,
                                            dividedBy: 2.7),
                                        onTap: () async {
                                          if (_startLocationCon.text.isEmpty ||
                                              _destinationLocationCon
                                                  .text.isEmpty) {
                                            snackBar(
                                                "location field is required",
                                                false);
                                          } else {
                                            try {
                                              var addresses = await Geocoder
                                                  .local
                                                  .findAddressesFromQuery(
                                                  _startLocationCon.text);
                                              var first = addresses.first;
                                              lat = first.coordinates.latitude!;
                                              lon = first.coordinates.longitude!;
                                              var addresses1 = await Geocoder
                                                  .local
                                                  .findAddressesFromQuery(
                                                  _destinationLocationCon
                                                      .text);
                                              var first1 = addresses1.first;
                                              lat1 =
                                                  first1.coordinates.latitude!;
                                              lon1 =
                                                  first1.coordinates.longitude!;
                                              print("lat$lat");
                                              print("lon$lon");
                                              print("lat1$lat1");
                                              print("lon1$lon1");
                                              var p = 0.017453292519943295;
                                              var a = 0.5 -
                                                  cos((lat1 - lat) * p) / 2 +
                                                  cos(lat1 * p) *
                                                      cos(lat1 * p) *
                                                      (1 -
                                                          cos((lon1 - lon) *
                                                              p)) /
                                                      2;
                                              print("Distance$a");
                                              double cal =
                                                  12742 * asin(sqrt(a));

                                              print("DistanceKm${cal}");
                                              print("isHidden${isReturn}");
                                              if (isReturn == true) {
                                                double multiple = cal * 2;
                                                _distanceCon.text = multiple
                                                    .toStringAsFixed(2)
                                                    .toString();
                                              } else {
                                                _distanceCon.text = cal
                                                    .toStringAsFixed(2)
                                                    .toString();
                                              }
                                            } catch (e) {
                                              snackBar(
                                                  "Better get on a plan.There are no roads between ${_startLocationCon.text} and ${_destinationLocationCon.text}",
                                                  false);
                                            }

                                            setState(() {});
                                          }
                                        },
                                        context: context,
                                        buttonName: 'Calculate Distance',
                                        buttonTextSize: 12,
                                        padding: EdgeInsets.all(5))
                                  ],
                                ),
                              ],
                            ),
                          ),
                          verticalSpaces(context, height: 40),
                          ListView.builder(
                            itemCount: addDrivingRouteList.length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return getDrivingRoute(index);
                            },
                          ),
                          Row(
                            children: [
                              simpleCheckBox(context, value: isHidden,
                                  onChanged: (val) {
                                    setState(() {
                                      isHidden = !isHidden;
                                    });
                                  }),
                              horizontal(context, width: 80),
                              commonText('Hide in statistics',
                                  color: HexColor.Gray53,
                                  fontFamily: LexendRegular,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14),
                              Spacer(),
                              GestureDetector(
                                onTap: () {
                                  addDrivingRouteList.add(1);
                                  vehicle.add(null);
                                  fuel.add(null);
                                  euroClass.add(null);
                                  vehicleCapacity.add(null);
                                  addLastLocationCon.add(TextEditingController());
                                  addFirstLocationCon.add(TextEditingController());
                                  addLocationCon.add(
                                      (TextEditingController()));
                                  distanceCon.add(
                                      (TextEditingController()));
                                  _addFirstlat.add(0.0);
                                  _addFirstlon.add(0.0);
                                  _addSecondtlat.add(0.0);
                                  _addSecondtlon.add(0.0);
                                  _enable.add(false);
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
                            ],
                          ),
                          verticalSpaces(context, height: 9),

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
                    BlocBuilder<TerminalCubit, TerminalState>(
                      builder: (context, state) {
                        if(state is AddTerminalLoading){
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

  void _awaitStartLocation(BuildContext context) async {
    String result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AddLocation(),
        ));
    setState(() {
      _startLocationCon.text = result;
    });
  }

  void _awaitDestinationLocation(BuildContext context) async {
    String result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AddLocation(),
        ));
    setState(() {
      _destinationLocationCon.text = result;
    });
  }
}
