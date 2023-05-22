import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_place/google_place.dart';
import 'package:proj_site/common/colors/colors.dart';
import 'package:proj_site/common/widget_constant/widget_constant.dart';
import 'package:proj_site/cubits/shipment_cubit.dart';
import 'package:proj_site/helper/helper.dart';
import 'package:proj_site/view/newShipmentRequest/enviroment.dart';

class AddLocation extends StatefulWidget {


  @override
  State<AddLocation> createState() => _AddLocationState();
}

class _AddLocationState extends State<AddLocation> {
  late GooglePlace googlePlace;
  TextEditingController _startLocationCon = TextEditingController();
  Completer<GoogleMapController> _controller = Completer();
  List<AutocompletePrediction> predictions = [];
  static final CameraPosition kGoogleplex =
      CameraPosition(target: LatLng(21.2469, 72.8515), zoom: 14);
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

  bool _visible = false;
  bool _enable = false;
  late ShipmentCubit shipmentCub;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _marker.addAll(_list);
    String apiKey = 'AIzaSyDtFavTh7_aJL9D3XGEmoFlIImXsibuREY';
    googlePlace = GooglePlace(apiKey);
    shipmentCub = BlocProvider.of<ShipmentCubit>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBarWithIcon(
        ctx: context,
      ) as PreferredSizeWidget?,
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                height: screenHeight(context, dividedBy: 4),
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(15),
                      bottomLeft: Radius.circular(15)),
                  boxShadow: [
                    BoxShadow(
                      color: HexColor.Gray53.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: Offset(0, 5), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      height: screenHeight(context, dividedBy: 15),
                      width: screenWidth(context),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(
                            color: HexColor.Gray53.withOpacity(0.5),
                            width: 1.5),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: TextField(
                        controller: _startLocationCon,
                        textAlignVertical: TextAlignVertical.center,
                        onChanged: (val) async {

                          if (val.isNotEmpty) {
                            autoCompleteSearch(val);
                            _visible = true;

                          } else {
                            if (predictions.length > 0 && mounted) {
                              predictions = [];
                              _visible = false;
                              _enable = false;
                            }
                          }
                          setState(() {});
                        },
                        decoration: InputDecoration(
                          isCollapsed: true,
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(left: 9, right: 9),
                          hintText: "Enter a Location",
                          hintStyle: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            fontFamily: LexendRegular,
                            color: HexColor.Gray53,
                          ),
                        ),
                      ),
                    ),
                    verticalSpaces(context, height: 80),
                    Visibility(
                      visible: _visible,
                      child: Expanded(
                        child: Container(
                          margin: EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.white,
                          ),
                          width: double.infinity,
                          child: ListView.builder(
                            itemCount: predictions.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                leading: CircleAvatar(
                                  child: Icon(
                                    Icons.pin_drop,
                                    color: Colors.white,
                                  ),
                                ),
                                title: Text(
                                    predictions[index].description.toString()),
                                onTap: () async {
                                  _startLocationCon.clear();
                                  _startLocationCon.text =
                                      predictions[index].description.toString();
                                  _visible = false;
                                  _enable = true;
                                  GoogleMapController controller =
                                      await _controller.future;
                                  controller.animateCamera(
                                      CameraUpdate.newCameraPosition(
                                          CameraPosition(
                                              target: LatLng(21.2469, 72.8515),
                                              zoom: 14)));
                                  setState(() {});
                                },
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  child: GoogleMap(
                    initialCameraPosition: kGoogleplex,
                    markers: Set<Marker>.of(_marker),
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                    },
                  ),
                ),
              ),
            ],
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                  margin: EdgeInsets.only(bottom: 30),
                  child: commonButton(
                      context: context,
                      buttonName: "Search",
                      buttonColor: _enable
                          ? HexColor.buttonColor
                          : HexColor.Gray53.withOpacity(0.5),onTap: () {
                            if(_enable == false ||_startLocationCon.text.isEmpty){
                              snackBar("Please Enter a Location", false);
                            }
                            else{
                              _sendDataBack(context);
                            }
                          },)))
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () async {
      //     // GoogleMapController controller = await _controller.future;
      //     // controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(lat,long),zoom: 14)));
      //     // setState(() {
      //     //   Marker destination = Marker(
      //     //       markerId: MarkerId('1'),
      //     //       position: LatLng(lat,long),
      //     //       infoWindow: InfoWindow(
      //     //           title: '${_address}'
      //     //       )
      //     //   );
      //     //   _marker.add(destination);
      //     //
      //     // });
      //   },
      //   tooltip: 'Location',
      //   child:  Icon(Icons.location_on_rounded),
      // ),
    );
  }

  void autoCompleteSearch(String value) async {
    var result = await googlePlace.autocomplete.get(value);
    if (result != null && result.predictions != null && mounted) {
      setState(() {
        predictions = result.predictions!;
        log("predictions${predictions[0].description}");
      });
    } else {
      throw Exception("Failed");
    }
  }
  void _sendDataBack(BuildContext context) {
    String textToSendBack = _startLocationCon.text;
    Navigator.pop(context, textToSendBack);
  }
}
