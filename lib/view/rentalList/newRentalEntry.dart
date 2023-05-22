import 'dart:developer';
import 'dart:io';

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
import 'package:proj_site/cubits/rental_list_cubit.dart';
import 'package:proj_site/cubits/auth_cubit.dart';
import 'package:proj_site/helper/helper.dart';

class NewRentalEntry extends StatefulWidget {
  @override
  _NewRentalEntryState createState() => _NewRentalEntryState();
}

class _NewRentalEntryState extends State<NewRentalEntry> {
  TextEditingController vendorNameTxt = TextEditingController();
  TextEditingController itemNameTxt = TextEditingController();
  TextEditingController quantityTxt = TextEditingController();
  TextEditingController descriptionTxt = TextEditingController(text: "");
  TextEditingController startDate = TextEditingController();
  TextEditingController endDate = TextEditingController();
  DateTime? arriveDate;
  DateTime? dueDate;
  final ImagePicker _picker = ImagePicker();
  String fromDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  String toDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  late RentalListCubit RentalCub;
  late AuthCubit AuthCub;

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

  _onTap2() async {
    dueDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2101));
    if (dueDate != null) {
      print(arriveDate);
      String formattedDate = DateFormat('yyyy-MM-dd').format(dueDate!);
      print(formattedDate);

      setState(() {
        toDate = formattedDate;
      });
    } else {
      print("Date is not selected");
    }
  }


  @override
  void initState() {
    RentalCub = BlocProvider.of<RentalListCubit>(context);
    AuthCub = BlocProvider.of<AuthCubit>(context);
    RentalCub.photo1==null?"":null;
    super.initState();
  }
  _saveButton({required RentalListCubit rentalCub,required String project_id,required String organization_id,}) {
    return Align(
        alignment: Alignment.center,
        child: commonButton(
            context: context,
            buttonName: "Save",
            onTap: () {
              log("tap");
              FocusScope.of(context).unfocus();
              if (vendorNameTxt.text.isEmpty) {
                snackBar("Please Enter Vendor Name", false);
              } else if (itemNameTxt.text.isEmpty) {
                snackBar("Please Enter Item Name", false);
              } else if (int.parse(quantityTxt.text) == 0 ) {
                snackBar("Please Enter positive numbers of Quantity", false);
              }
              // else if (arriveDate == null) {
              //   snackBar("Date is not selected", false);
              // } else if (dueDate == null) {
              //   snackBar("Date is not selected", false);
              // }
              else if (quantityTxt.text.isEmpty) {
                snackBar("Please Enter Quantity", false);
              }  else {
                rentalCub.AddRental(
                  context: context,
                    project_id: project_id,
                    organization_id: organization_id,
                    vendor_name: vendorNameTxt.text,
                    item_name: itemNameTxt.text,
                    arrival_date: fromDate,
                    due_date: toDate,
                    quantity: quantityTxt.text,
                    description: descriptionTxt.text,
                    created_by : "634fb7d1e0cc280265361743",
                    Image: RentalCub.photo1 == null?"":RentalCub.photo1!.path,
                    api: '1');
              }

            }));
  }

  Widget build(BuildContext context) {

    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: getCommonContainer(
        color: Colors.transparent,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            commonText("Vendor name",
                color: Colors.black,
                fontFamily: LexendRegular,
                fontWeight: FontWeight.w400,
                fontSize: 12),
            verticalSpaces(context, height: 80),
            getRoundedTexfield(
                hintText: "Enter vendor name",
                controller: vendorNameTxt,
                ctx: context),
            verticalSpaces(context, height: 40),
            commonText("Item name",
                color: Colors.black,
                fontFamily: LexendRegular,
                fontWeight: FontWeight.w400,
                fontSize: 12),
            verticalSpaces(context, height: 80),
            getRoundedTexfield(
                hintText: "Enter item name",
                controller: itemNameTxt,
                ctx: context),
            verticalSpaces(context, height: 40),
            commonText("Arrival date",
                color: Colors.black,
                fontFamily: LexendRegular,
                fontWeight: FontWeight.w400,
                fontSize: 12),
            verticalSpaces(context, height: 80),
            // getRoundedTexfield(
            //     hintText: "Select Arrival date",
            //     controller: startDate,
            //     ctx: context,
            //     readOnly: true,
            //     suffixIcon: true,
            //     onTap: () async {
            //       arriveDate = await showDatePicker(
            //           context: context,
            //           initialDate: DateTime.now(),
            //           firstDate: DateTime(2000),
            //           lastDate: DateTime(2101));
            //       if (arriveDate != null) {
            //         print(arriveDate);
            //         String formattedDate =
            //         DateFormat('yyyy-MM-dd').format(arriveDate!);
            //         print(formattedDate);
            //         setState(() {
            //           startDate.text = formattedDate;
            //         });
            //       } else {
            //         print("Date is not selected");
            //       }
            //     }),
            getRoundedContainerWithTralingIcon(
                height: screenHeight(context, dividedBy: 15),
                text: fromDate,
                image: icons.ic_calendar,
                onTap: _onTap1),
            verticalSpaces(context, height: 40),
            commonText("Due date",
                color: Colors.black,
                fontFamily: LexendRegular,
                fontWeight: FontWeight.w400,
                fontSize: 12),
            verticalSpaces(context, height: 80),
            getRoundedContainerWithTralingIcon(
                height: screenHeight(context, dividedBy: 15),
                text: toDate,
                image: icons.ic_calendar,
                onTap: _onTap2),
            verticalSpaces(context, height: 40),
            commonText("Quantity",
                color: Colors.black,
                fontFamily: LexendRegular,
                fontWeight: FontWeight.w400,
                fontSize: 12,),
            verticalSpaces(context, height: 80),
            getRoundedTexfield(
                hintText: "Enter quantity",
                controller: quantityTxt,
                textInputType: TextInputType.number,
                ctx: context,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
            ),
            verticalSpaces(context, height: 40),
            commonText("Item Image",
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
                              RentalCub.photo1 = await _picker.pickImage(imageQuality: 50,
                                  source: ImageSource.camera);
                              Navigation.instance.goBack();
                              RentalCub.setState();
                            },
                            onTapGallery: () async {
                              RentalCub.photo1 = await _picker.pickImage(
                                  source: ImageSource.gallery);
                              Navigation.instance.goBack();
                              RentalCub.setState();
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
                      BlocBuilder<RentalListCubit, RentalListState>(
                        builder: (context, state) {
                          return Expanded(
                            child: commonText(RentalCub.photo1==null?"No file chosen":RentalCub.photo1!.path.split("/").last,
                                color: HexColor.Gray53.withOpacity(0.6),
                                fontFamily: LexendRegular,
                                fontWeight: FontWeight.w400,
                                fontSize: 14),
                          );
                        },
                      ),
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
                controller: descriptionTxt,
                ctx: context),
            verticalSpaces(context, height: 20),
            BlocBuilder<RentalListCubit, RentalListState>(
              builder: (context, state) {

                if (state is AddRentalLoading) {
                  return commonLoadingButton(context: context);
                }else if (state is AddRentalError){
                return errorLoadDataText();
                }
                else {
                  return _saveButton(rentalCub: RentalCub,project_id: projectIdMain, organization_id: orgId,);
                }
              },
            ),
            verticalSpaces(context, height: 50),
          ],
        ),
      ),
    );
  }
}
