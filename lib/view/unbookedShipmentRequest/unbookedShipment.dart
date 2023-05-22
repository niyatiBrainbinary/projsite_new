import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:ftx/navigationX.dart';
import 'package:image_picker/image_picker.dart';
import 'package:proj_site/common/colors/colors.dart';
import 'package:proj_site/common/image_constant/image_constant.dart';
import 'package:proj_site/common/widget_constant/widget_constant.dart';
import 'package:proj_site/helper/helper.dart';
import 'package:proj_site/view/logisticList/checkOutHistory.dart';
import 'package:proj_site/view/newShipmentRequest/enviroment.dart';
import 'package:proj_site/view/unbookedShipmentRequest/unbookedeEnviroment.dart';

class UnbookedShipment extends StatefulWidget {
  const UnbookedShipment({Key? key}) : super(key: key);

  @override
  State<UnbookedShipment> createState() => _UnbookedShipmentState();
}

TextEditingController _description = TextEditingController();
TextEditingController _instruction = TextEditingController();
final List<String> _dropdownValues = ["One", "Two", "Three", "Four", "Five"];
final ImagePicker _picker = ImagePicker();
XFile? photo;
String fromDate = "Select Date";
String toDate = "Select Date";
DateTime? arriveDate;
DateTime? dueDate;

String? _resource;
String? _unloadingZone;
String? _contractor;
String? _person;
String? _subProject;

class _UnbookedShipmentState extends State<UnbookedShipment> {
  _onTap1() async {
    arriveDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2101));
    if (arriveDate != null) {
      print(arriveDate);
      String formattedDate =
      DateFormat('yyyy-MM-dd').format(arriveDate!);
      print(formattedDate);
      setState(() {
        fromDate = formattedDate;
      });
    } else {
      print("Date is not selected");
    }

  }
  _onTap2() async {
    dueDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2101));
    if (dueDate != null) {
      print(dueDate);
      String formattedDate =
      DateFormat('yyyy-MM-dd').format(dueDate!);
      print(formattedDate);
      setState(() {
        toDate = formattedDate;
      });
    } else {
      print("Date is not selected");
    }

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
                            color: HexColor.Gray53.withOpacity(0.4),
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
                                      color: Colors.transparent),
                                )),
                            Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: Colors.transparent),
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
                                    color: Colors.black,
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
                        Row(
                          children: [
                            Expanded(
                                child: commonText("From",
                                    color: Colors.black,
                                    fontFamily: LexendRegular,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12)),
                            horizontal(context, width: 60),
                            Expanded(
                                child: commonText("To",
                                    color: Colors.black,
                                    fontFamily: LexendRegular,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12)),
                          ],
                        ),
                        verticalSpaces(context, height: 80),
                        Container(
                          height: screenHeight(context, dividedBy: 16),
                          child: Row(
                            children: [
                              Expanded(
                                child: getRoundedContainerWithTralingIcon(
                                    text: fromDate,
                                    onTap: _onTap1,
                                    image: icons.ic_calendar),
                              ),
                              horizontal(context, width: 60),
                              Expanded(
                                child: getRoundedContainerWithTralingIcon(
                                    text: toDate,
                                    onTap:  _onTap2,
                                    image: icons.ic_calendar),
                              ),
                            ],
                          ),
                        ),
                        verticalSpaces(context, height: 40),
                        commonText("Resources",
                            color: Colors.black,
                            fontFamily: LexendRegular,
                            fontWeight: FontWeight.w400,
                            fontSize: 12),
                        verticalSpaces(context, height: 80),
                        getDropDownButton(
                            ctx: context,
                            items: _dropdownValues,
                            hitText: "Select resource",
                            value:_resource,
                            onChnaged: (val){
                              _resource = val;
                              setState(() {
                              });
                            }
                        ),
                        verticalSpaces(context, height: 40),
                        commonText("Available Unloading Zones",
                            color: Colors.black,
                            fontFamily: LexendRegular,
                            fontWeight: FontWeight.w400,
                            fontSize: 12),
                        verticalSpaces(context, height: 80),
                        getDropDownButton(
                            ctx: context,
                            items: _dropdownValues,
                            hitText: "Select unloading zone",
                            value:_unloadingZone,
                            onChnaged: (val){
                              _unloadingZone = val;
                              setState(() {
                              });
                            }
                        ),
                        verticalSpaces(context, height: 40),
                        commonText("Contractor",
                            color: Colors.black,
                            fontFamily: LexendRegular,
                            fontWeight: FontWeight.w400,
                            fontSize: 12),
                        verticalSpaces(context, height: 80),
                        getDropDownButton(
                            ctx: context,
                            items: _dropdownValues,
                            hitText: "Select contractor",
                            value:_contractor,
                            onChnaged: (val){
                              _contractor = val;
                              setState(() {
                              });
                            }
                        ),
                        verticalSpaces(context, height: 40),
                        commonText("Responsible Person",
                            color: Colors.black,
                            fontFamily: LexendRegular,
                            fontWeight: FontWeight.w400,
                            fontSize: 12),
                        verticalSpaces(context, height: 80),
                        getDropDownButton(
                            ctx: context,
                            items: _dropdownValues,
                            hitText: "Select responsible person",
                            value:_person,
                            onChnaged: (val){
                              _person = val;
                              setState(() {
                              });
                            }
                        ),
                        verticalSpaces(context, height: 40),
                        commonText("Sub Project",
                            color: Colors.black,
                            fontFamily: LexendRegular,
                            fontWeight: FontWeight.w400,
                            fontSize: 12),
                        verticalSpaces(context, height: 80),
                        getDropDownButton(
                            ctx: context,
                            items: _dropdownValues,
                            hitText: "Select Sub Project",
                            value:_subProject,
                            onChnaged: (val){
                              _subProject = val;
                              setState(() {
                              });
                            }
                        ),
                        verticalSpaces(context, height: 40),
                        commonText("Description",
                            color: Colors.black,
                            fontFamily: LexendRegular,
                            fontWeight: FontWeight.w400,
                            fontSize: 12),
                        verticalSpaces(context, height: 80),
                        getRoundedTexfield(
                            height: screenHeight(context, dividedBy: 7),
                            hintText: "Description",
                            controller: _description,
                            maxline: 10,
                            ctx: context),
                        verticalSpaces(context, height: 40),
                        commonText("Instruction",
                            color: Colors.black,
                            fontFamily: LexendRegular,
                            fontWeight: FontWeight.w400,
                            fontSize: 12),
                        verticalSpaces(context, height: 80),
                        getRoundedTexfield(
                            height: screenHeight(context, dividedBy: 7),
                            hintText: "Instruction",
                            controller: _instruction,
                            maxline: 10,
                            ctx: context),
                        verticalSpaces(context, height: 40),
                        commonText("Picture",
                            color: Colors.black,
                            fontFamily: LexendRegular,
                            fontWeight: FontWeight.w400,
                            fontSize: 12),
                        verticalSpaces(context, height: 80),
                        DottedBorder(
                            radius: Radius.circular(10),
                            borderType: BorderType.RRect,
                            color: HexColor.Gray53.withOpacity(0.6),
                            dashPattern: [5, 5],
                            child: Container(
                              height: screenHeight(context, dividedBy: 16),
                              width: screenWidth(context),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10)),
                              child: Row(
                                children: [
                                  horizontal(context, width: 30),
                                  GestureDetector(
                                    onTap: () {
                                      getSelectPictureDialog(
                                        ctx: context,
                                        onTapCamera: () async {
                                          photo = await _picker.pickImage(
                                              source: ImageSource.camera);
                                          Navigation.instance.goBack();
                                        },
                                        onTapGallery: () async {
                                          photo = await _picker.pickImage(
                                              source: ImageSource.gallery);
                                          Navigation.instance.goBack();
                                        },
                                      );
                                    },
                                    child: Container(
                                      height:
                                      screenHeight(context, dividedBy: 23),
                                      width: screenWidth(context, dividedBy: 4),
                                      decoration: BoxDecoration(
                                          color:
                                          HexColor.Gray53.withOpacity(0.4),
                                          borderRadius:
                                          BorderRadius.circular(10),
                                          border: Border.all(
                                              color: HexColor.Gray53)),
                                      child: Center(
                                          child: commonText("Choose file",
                                              color: HexColor.Gray53,
                                              fontFamily: LexendRegular,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14)),
                                    ),
                                  ),
                                  horizontal(context, width: 30),
                                  commonText(
                                      photo == null
                                          ? "No file chosen"
                                          : photo!.path.split("/").last,
                                      color: HexColor.Gray53.withOpacity(0.6),
                                      fontFamily: LexendRegular,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14)
                                ],
                              ),
                            )),
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
                        // if(fromDate=="Select Date"){
                        //   snackBar("Please Select From Date", false);
                        // } else if(toDate=="Select Date"){
                        //   snackBar("Please Select To Date", false);
                        // } else if(_resource==null){
                        //   snackBar("Please Select Resource", false);
                        // } else if(_unloadingZone==null){
                        //   snackBar("Please Select UnloadingZone", false);
                        // } else if(_contractor==null){
                        //   snackBar("Please Select Contractor", false);
                        // } else if(_person==null){
                        //   snackBar("Please Select Responsible Person", false);
                        // } else if(_subProject==null){
                        //   snackBar("Please Select  Sub Project", false);
                        // } else if(_description.text.isEmpty){
                        //   snackBar("Please Enter Description", false);
                        // } else if(_instruction.text.isEmpty){
                        //   snackBar("Please Enter Instruction", false);
                        // }else if(photo == null){
                        //   snackBar("Please Select Picture", false);
                        // } else {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return UnbookedEnviroment();
                          },
                        ));
                        //}
                      })
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
