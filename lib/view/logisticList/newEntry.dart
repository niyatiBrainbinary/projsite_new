import 'dart:developer';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ftx/navigationX.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:proj_site/common/colors/colors.dart';
import 'package:proj_site/common/image_constant/image_constant.dart';
import 'package:proj_site/common/widget_constant/widget_constant.dart';
import 'package:proj_site/cubits/auth_cubit.dart';
import 'package:proj_site/cubits/drop_down_cubit.dart';
import 'package:proj_site/cubits/logistic_list_cubit.dart';
import 'package:proj_site/helper/helper.dart';
import 'package:proj_site/view/logisticList/checkOutHistory.dart';

class NewEntry extends StatefulWidget {
  String terminalId;
  NewEntry(this.terminalId);
  @override
  State<NewEntry> createState() => _NewEntryState();
}

class _NewEntryState extends State<NewEntry> {
  TextEditingController _itemNameCon = TextEditingController();
  TextEditingController _palletCon = TextEditingController();
  TextEditingController _descriptionCon = TextEditingController();
  DateTime? dateTime;
  String _arrivalDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  final ImagePicker _picker = ImagePicker();
  XFile? photo;
  String? subProject;
  String subProjectId = "";
  String? entrepreneurs;
  String entrepreneursId = "";
  String? organizationId;

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
        _arrivalDate = formattedDate;
      });
    } else {
      print("Date is not selected");
    }
  }


  late AuthCubit authCub;
  late DropDownCubit dropDownCub;
  late LogisticListCubit logisticCub;
  @override
  void initState() {
    getLogisticNewEntryData();
  }

  getLogisticNewEntryData() {

    authCub = BlocProvider.of<AuthCubit>(context);
    dropDownCub = BlocProvider.of<DropDownCubit>(context);
    logisticCub = BlocProvider.of<LogisticListCubit>(context);

    dropDownCub.Organizations(
      organization_id: authCub.userInfo!.user!.organizationId!
    );
    dropDownCub.UserSubProjectList(user_id: authCub.userInfo!.user!.id!, project_id: projectIdMain, organization_id: authCub.userInfo!.user!.organizationId!);
  }

  @override
  Widget build(BuildContext context) {
    return getCommonContainer(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            commonText("Item name",
                color: Colors.black,
                fontFamily: LexendRegular,
                fontWeight: FontWeight.w400,
                fontSize: 12),
            verticalSpaces(context, height: 80),
            getRoundedTexfield(
                hintText: "Enter item name",
                controller: _itemNameCon,
                ctx: context),
            verticalSpaces(context, height: 40),
            commonText("Arrival date",
                color: Colors.black,
                fontFamily: LexendRegular,
                fontWeight: FontWeight.w400,
                fontSize: 12),
            verticalSpaces(context, height: 80),
            getRoundedContainerWithTralingIcon(
                height: screenHeight(context, dividedBy: 15),
                text: _arrivalDate,
                image: icons.ic_calendar,
                onTap: _onTap1),
            verticalSpaces(context, height: 40),
            commonText("Sub project",
                color: Colors.black,
                fontFamily: LexendRegular,
                fontWeight: FontWeight.w400,
                fontSize: 12),
            verticalSpaces(context, height: 80),
            BlocBuilder<DropDownCubit, DropDownState>(
              builder: (context, state) {
                if (state is OrganizationsLoading) {
                  return loader();
                } else if (State is OrganizationsError) {
                  return errorLoadDataText();
                } else {
                  return getDropDownButton(
                      ctx: context,
                      items: dropDownCub.enterpreneurs,
                      hitText: "Select Sub Project",
                      value: subProject,
                      onChnaged: (val) {
                        subProject = val;
                        for (int i = 0;
                            i < dropDownCub.subProjects!.length;
                            i++) {
                          if (val ==
                              dropDownCub.subProjects![i].subProjectName) {
                            subProjectId = dropDownCub.subProjects![i].id;
                          }
                        }
                        setState(() {});
                      });
                }
              },
            ),
            verticalSpaces(context, height: 40),
            commonText("No of pallets",
                color: Colors.black,
                fontFamily: LexendRegular,
                fontWeight: FontWeight.w400,
                fontSize: 12),
            verticalSpaces(context, height: 80),
            getRoundedTexfield(
                hintText: "Enter no. of pallets",
                controller: _palletCon,
                ctx: context,
                textInputType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
            ),
            verticalSpaces(context, height: 40),
            commonText("Entrepreneurs",
                color: Colors.black,
                fontFamily: LexendRegular,
                fontWeight: FontWeight.w400,
                fontSize: 12),
            verticalSpaces(context, height: 80),
            BlocBuilder<LogisticListCubit, LogisticListState>(
              builder: (context, state) {
                return getDropDownButton(
                    ctx: context,
                    items: dropDownCub.organization,
                    hitText: "Select Entrepreneur",
                    value: entrepreneurs,
                    onChnaged: (val) {
                      entrepreneurs = val;
                      for (int i = 0;
                          i < dropDownCub.organization.length;
                          i++) {
                        if (val == dropDownCub.companyList![i].companyName) {
                          entrepreneursId = dropDownCub.companyList![i].id;
                        }
                      }
                      setState(() {});
                    });
                // }
              },
            ),
            verticalSpaces(context, height: 40),
            commonText("Image",
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
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(10)),
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
                          height: screenHeight(context, dividedBy: 23),
                          width: screenWidth(context, dividedBy: 4),
                          decoration: BoxDecoration(
                              color: HexColor.Gray53.withOpacity(0.4),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: HexColor.Gray53)),
                          child: Center(
                              child: commonText("Choose file",
                                  color: HexColor.Gray53,
                                  fontFamily: LexendRegular,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14)),
                        ),
                      ),
                      horizontal(context, width: 30),
                      commonText("No file chosen",
                          color: HexColor.Gray53.withOpacity(0.6),
                          fontFamily: LexendRegular,
                          fontWeight: FontWeight.w400,
                          fontSize: 14)
                    ],
                  ),
                )),
            verticalSpaces(context, height: 40),
            commonText("Description",
                color: Colors.black,
                fontFamily: LexendRegular,
                fontWeight: FontWeight.w400,
                fontSize: 12),
            verticalSpaces(context, height: 80),
            getRoundedTexfield(
                hintText: "Enter description",
                controller: _descriptionCon,
                ctx: context),
            verticalSpaces(context, height: 10),
            BlocBuilder<LogisticListCubit, LogisticListState>(
              builder: (context, state) {
                if (state is AddLogisticLoading) {
                  return commonLoadingButton(context: context);
                } else {
                  return Align(
                      alignment: Alignment.center,
                      child: commonButton(
                          context: context,
                          buttonName: "Save",
                          onTap: () {
                            if (_itemNameCon.text.isEmpty) {
                              snackBar("Please Enter Item Name", false);
                            } else if (_arrivalDate == "Select Arrival Date") {
                              snackBar("Please Select Arrival Date", false);
                            } else if (subProjectId=="") {
                              snackBar("Please Select Sub Project", false);
                            }else if (_palletCon.text.isEmpty) {
                              snackBar("Please Enter Pallet", false);
                            }else if(int.parse(_palletCon.text) == 0) {
                              snackBar("Please Enter positive numbers in No of Pallet", false);
                            } else if (entrepreneursId=="") {
                              snackBar("Please Select Entrepreneur", false);
                            } else {
                              Map<String, dynamic> body = {
                                //"_token": accessToken,
                                "project_id": projectIdMain,
                                "terminal_id": widget.terminalId,
                                "item_name": _itemNameCon.text,
                                "arrival_date": _arrivalDate,
                                "sub_project_id": subProjectId,
                                "no_of_pallets": _palletCon.text,
                                "description": _descriptionCon.text,
                                "company_id": entrepreneursId,
                                "logistics_image_file": "undefined",
                                "organization_id": orgId,
                              };
                              log("body=${body}");
                              logisticCub.AddLogistic(body);
                            }
                          }));
                }
              },
            ),
            verticalSpaces(context, height: 40),
          ],
        ),
      ),
    );
  }
}
