import 'dart:developer';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:proj_site/common/colors/colors.dart';
import 'package:proj_site/common/image_constant/image_constant.dart';
import 'package:proj_site/common/widget_constant/widget_constant.dart';
import 'package:proj_site/cubits/auth_cubit.dart';
import 'package:proj_site/cubits/drop_down_cubit.dart';
import 'package:proj_site/cubits/logistic_list_cubit.dart';
import 'package:proj_site/cubits/rental_list_cubit.dart';
import 'package:proj_site/helper/helper.dart';
import 'package:ftx/navigationX.dart';

class EditLogistics extends StatefulWidget {
  static const id = 'EditLogistics_screen';

  String logisticId;

  EditLogistics(this.logisticId);

  @override
  _EditLogisticsState createState() => _EditLogisticsState();
}

class _EditLogisticsState extends State<EditLogistics> {
  TextEditingController _itemNameCon = TextEditingController();
  TextEditingController _palletCon = TextEditingController();
  TextEditingController _inStockCon = TextEditingController();

  //TextEditingController _locationCon = TextEditingController();
  TextEditingController _descriptionCon = TextEditingController();
  TextEditingController startDate = TextEditingController();
  TextEditingController endDate = TextEditingController();
  DateTime? arriveDate;
  DateTime? dueDate;
  final ImagePicker _picker = ImagePicker();
  final List<String> _dropdownValues = ["One", "Two", "Three", "Four", "Five"];

  String? value;
  String? subProject;
  String subProjectId = "";
  String? entrepreneurs;
  String entrepreneursId = "";

  late LogisticListCubit logisticCub;
  late AuthCubit authCub;
  late DropDownCubit dropDownCub;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    logisticCub = BlocProvider.of<LogisticListCubit>(context);
    authCub = BlocProvider.of<AuthCubit>(context);
    dropDownCub = BlocProvider.of<DropDownCubit>(context);
    dropDownCub.Organizations(
        organization_id: authCub.userInfo!.user!.organizationId!
     );
    dropDownCub.UserSubProjectList(
        user_id: authCub.userInfo!.user!.id!,
        project_id: projectIdMain,
        organization_id: authCub.userInfo!.user!.organizationId!);
    logisticCub.LogisticDetails(widget.logisticId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBarWithIcon(ctx: context) as PreferredSizeWidget?,
      body: getCommonContainer(
          color: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Column(children: [
            getCommonContainer(
                height: screenHeight(context, dividedBy: 15),
                width: screenWidth(context),
                color: Colors.transparent,
                alignment: Alignment.centerLeft,
                child: commonText("Edit Logistics Information",
                    color: Colors.black,
                    fontFamily: LexendRegular,
                    fontWeight: FontWeight.w700,
                    fontSize: 20)),
            verticalSpaces(context, height: 100),
            BlocConsumer<LogisticListCubit, LogisticListState>(
              listener: (context, state) {
                if (state is LogisticDetailSuccess) {
                  _itemNameCon.text =
                      logisticCub.logisticDetails!.result!.itemName;
                  _palletCon.text =
                      logisticCub.logisticDetails!.result!.noOfPallets;
                  _inStockCon.text =
                      logisticCub.logisticDetails!.result!.inStock;
                  //_locationCon.text=logisticCub.logisticDetails!.result!.address;
                  _descriptionCon.text =
                      logisticCub.logisticDetails!.result!.description;
                  subProject = logisticCub.logisticDetails!.result!
                      .subProjectDetails!.subProjectName;
                  subProjectId =
                      logisticCub.logisticDetails!.result!.subProjectId;
                  entrepreneurs = logisticCub
                      .logisticDetails!.result!.companyDetails!.companyName;
                  entrepreneursId =
                      logisticCub.logisticDetails!.result!.companyId;
                }
              },
              builder: (context, state) {
                if (state is LogisticDetailLoading) {
                  return Expanded(child: loader());
                } else if (state is LogisticDetailError) {
                  return Expanded(child: errorLoadDataText());
                } else {
                  return Expanded(
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
                                            dropDownCub.subProjects![i]
                                                .subProjectName) {
                                          subProjectId = dropDownCub.subProjects![i].id;
                                        }
                                      }
                                      setState(() {});
                                    });
                              }
                            },
                          ),
                          verticalSpaces(context, height: 40),
                          commonText("Entrepreneurs",
                              color: Colors.black,
                              fontFamily: LexendRegular,
                              fontWeight: FontWeight.w400,
                              fontSize: 12),
                          verticalSpaces(context, height: 80),
                          BlocBuilder<DropDownCubit, DropDownState>(
                            builder: (context, state) {
                              return getDropDownButton(
                                  ctx: context,
                                  items: dropDownCub.organization,
                                  hitText: "Select Entrepreneurs",
                                  value: entrepreneurs,
                                  onChnaged: (val) {
                                    entrepreneurs = val;
                                    for (int i = 0;
                                        i < dropDownCub.organization.length;
                                        i++) {
                                      if (val ==
                                          dropDownCub
                                              .companyList![i].companyName) {
                                        entrepreneursId =
                                            dropDownCub.companyList![i].id;
                                      }
                                    }
                                    log("Entrepreneurs=${dropDownCub.companyList}");
                                    setState(() {});
                                  });
                              // }
                            },
                          ),
                          verticalSpaces(context, height: 40),
                          commonText("No. of pallets",
                              color: Colors.black,
                              fontFamily: LexendRegular,
                              fontWeight: FontWeight.w400,
                              fontSize: 12),
                          verticalSpaces(context, height: 80),
                          getRoundedTexfield(
                            hintText: "Enter No. of pallets",
                            controller: _palletCon,
                            ctx: context,
                            textInputType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ], // Only nu
                          ),
                          verticalSpaces(context, height: 40),
                          commonText("In stock",
                              color: Colors.black,
                              fontFamily: LexendRegular,
                              fontWeight: FontWeight.w400,
                              fontSize: 12),
                          verticalSpaces(context, height: 80),
                          getRoundedTexfield(
                              hintText: "Enter stock",
                              controller: _inStockCon,
                              ctx: context,
                              textInputType: TextInputType.number),
                          verticalSpaces(context, height: 40),
                          commonText("Image",
                              color: Colors.black,
                              fontFamily: LexendRegular,
                              fontWeight: FontWeight.w400,
                              fontSize: 12),
                          Container(
                            height: screenHeight(context, dividedBy: 17),
                            width: screenWidth(context, dividedBy: 5),
                            color: Colors.transparent,
                            child: Row(
                              children: [
                                Image.asset(icons.ic_excavator),
                              ],
                            ),
                          ),
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
                                            // rentalCub.photo2 = await _picker.pickImage(
                                            //     source: ImageSource.camera);
                                            // Navigation.instance.goBack();
                                            // rentalCub.setState();
                                          },
                                          onTapGallery: () async {
                                            // rentalCub.photo2 = await _picker.pickImage(
                                            //     source: ImageSource.gallery);
                                            // Navigation.instance.goBack();
                                            // rentalCub.setState();
                                          },
                                        );
                                      },
                                      child: Container(
                                        height: screenHeight(context,
                                            dividedBy: 23),
                                        width:
                                            screenWidth(context, dividedBy: 4),
                                        decoration: BoxDecoration(
                                            color: HexColor.Gray53.withOpacity(
                                                0.4),
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
                                    BlocBuilder<RentalListCubit,
                                        RentalListState>(
                                      builder: (context, state) {
                                        return Expanded(
                                          child: commonText("No file chosen",
                                              color:
                                                  HexColor.Gray53.withOpacity(
                                                      0.6),
                                              fontFamily: LexendRegular,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              )),
                          // verticalSpaces(context, height: 40),
                          // commonText("Location",
                          //     color: Colors.black,
                          //     fontFamily: LexendRegular,
                          //     fontWeight: FontWeight.w400,
                          //     fontSize: 12),
                          // verticalSpaces(context, height: 80),
                          // getRoundedTexfield(
                          //     hintText: "Enter Location",
                          //     controller: _locationCon,
                          //     ctx: context),
                          verticalSpaces(context, height: 40),
                          commonText("Description",
                              color: Colors.black,
                              fontFamily: LexendRegular,
                              fontWeight: FontWeight.w400,
                              fontSize: 12),
                          verticalSpaces(context, height: 80),
                          getRoundedTexfield(
                              hintText: "Enter quantity",
                              controller: _descriptionCon,
                              ctx: context),
                          verticalSpaces(context, height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              commonButton(
                                  context: context,
                                  buttonName: "Close",
                                  buttonColor: HexColor.Gray53.withOpacity(0.3),
                                  onTap: () {
                                    Navigation.instance.goBack();
                                  }),
                              BlocBuilder<LogisticListCubit, LogisticListState>(
                                builder: (context, state) {
                                  if (state is EditLogisticLoading) {
                                    return commonLoadingButton(
                                        context: context);
                                  } else {
                                    return commonButton(
                                        context: context,
                                        buttonName: "Update",
                                        onTap: () {
                                          if (_itemNameCon.text.isEmpty) {
                                            snackBar("Please Enter Item Name",
                                                false);
                                          } else if (_palletCon.text.isEmpty) {
                                            snackBar(
                                                "Please Enter Pallet", false);
                                          } else if (_inStockCon.text.isEmpty) {
                                            snackBar("Please Enter Pallet", false);
                                          } else if(int.parse(_palletCon.text) == 0) {
                                            snackBar("Please Enter positive numbers in No of Pallet", false);
                                          } else if(int.parse(_inStockCon.text) == 0) {
                                            snackBar("Please Enter positive numbers In Stock", false);
                                          } else {
                                            Map<String, dynamic> body = {
                                              "logistic_id": widget.logisticId,
                                              "item_name": _itemNameCon.text,
                                              "sub_project_id": subProjectId,
                                              "company_id": entrepreneursId,
                                              //  "address": _locationCon.text,
                                              "description":
                                                  _descriptionCon.text,
                                              "no_of_pallets": _palletCon.text,
                                              "in_stock": _inStockCon.text
                                            };
                                            logisticCub.EditLogistic(
                                                body,
                                                logisticCub.logisticDetails!
                                                    .result!.projectId,
                                                logisticCub.logisticDetails!
                                                    .result!.terminalId!);
                                          }
                                        });
                                  }
                                },
                              ),
                            ],
                          ),
                          verticalSpaces(context, height: 40),
                        ],
                      ),
                    ),
                  );
                }
              },
            )
          ])),
    );
  }
}
