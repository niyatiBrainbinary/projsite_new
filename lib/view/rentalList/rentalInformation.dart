import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:proj_site/api%20service/api_routes.dart';
import 'package:proj_site/common/colors/colors.dart';
import 'package:proj_site/common/image_constant/image_constant.dart';
import 'package:proj_site/common/widget_constant/widget_constant.dart';
import 'package:proj_site/cubits/auth_cubit.dart';
import 'package:proj_site/cubits/rental_list_cubit.dart';
import 'package:proj_site/helper/helper.dart';
import 'package:ftx/navigationX.dart';

class RentalInformation extends StatefulWidget {
  static const id = 'RentalInformation_screen';
  int index;

  RentalInformation(this.index);

  @override
  _RentalInformationState createState() => _RentalInformationState();
}

class _RentalInformationState extends State<RentalInformation> {
  TextEditingController _vendor = TextEditingController();
  TextEditingController _item = TextEditingController();
  TextEditingController _quantity = TextEditingController();
  TextEditingController _description = TextEditingController();
  TextEditingController _arrivalDate = TextEditingController();
  TextEditingController _dueDate = TextEditingController();
  DateTime? arriveDate;
  DateTime? dueDate;
  final ImagePicker _picker = ImagePicker();
  late RentalListCubit rentalCub;
  late AuthCubit authCub;
  String image = "";

  @override
  void initState() {
    rentalCub = BlocProvider.of<RentalListCubit>(context);
    rentalCub.photo2 = null;
    authCub = BlocProvider.of<AuthCubit>(context);
    image = rentalCub.rentalList[widget.index].itemImage.toString();
    _vendor.text = rentalCub.rentalList[widget.index].vendorName.toString();
    _item.text = rentalCub.rentalList[widget.index].itemName.toString();
    _quantity.text = rentalCub.rentalList[widget.index].quantity.toString();
    _description.text =
        rentalCub.rentalList[widget.index].description.toString();
    _arrivalDate.text =
        "${DateFormat('yyyy-MM-dd').format(DateTime.parse(rentalCub.rentalList[widget.index].arrivalDate.toString()))}";
    _dueDate.text =
        "${DateFormat('yyyy-MM-dd').format(DateTime.parse(rentalCub.rentalList[widget.index].dueDate.toString()))}";
    super.initState();

    log('image${image}');
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
                child: commonText("Rental info",
                    color: Colors.black,
                    fontFamily: LexendRegular,
                    fontWeight: FontWeight.w700,
                    fontSize: 20)),
            verticalSpaces(context, height: 100),
            Expanded(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
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
                        controller: _vendor,
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
                        controller: _item,
                        ctx: context),
                    verticalSpaces(context, height: 40),
                    commonText("Arrival date",
                        color: Colors.black,
                        fontFamily: LexendRegular,
                        fontWeight: FontWeight.w400,
                        fontSize: 12),
                    verticalSpaces(context, height: 80),
                    getRoundedTexfield(
                        hintText: "Select Arrival date",
                        controller: _arrivalDate,
                        ctx: context,
                        readOnly: true,
                        suffixIcon: true,
                        onTap: () async {
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
                              _arrivalDate.text = formattedDate;
                            });
                          } else {
                            print("Date is not selected");
                          }
                        }),
                    verticalSpaces(context, height: 40),
                    commonText("Due date",
                        color: Colors.black,
                        fontFamily: LexendRegular,
                        fontWeight: FontWeight.w400,
                        fontSize: 12),
                    verticalSpaces(context, height: 80),
                    getRoundedTexfield(
                        hintText: "Enter Due date",
                        controller: _dueDate,
                        ctx: context,
                        readOnly: true,
                        suffixIcon: true,
                        onTap: () async {
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
                              _dueDate.text = formattedDate;
                            });
                          } else {
                            print("Date is not selected");
                          }
                        }),
                    verticalSpaces(context, height: 40),
                    commonText("Quantity",
                        color: Colors.black,
                        fontFamily: LexendRegular,
                        fontWeight: FontWeight.w400,
                        fontSize: 12),
                    verticalSpaces(context, height: 80),
                    getRoundedTexfield(
                        hintText: "Enter quantity",
                        controller: _quantity,
                        ctx: context,
                        textInputType: TextInputType.number),
                    verticalSpaces(context, height: 40),
                    commonText("Item Image",
                        color: Colors.black,
                        fontFamily: LexendRegular,
                        fontWeight: FontWeight.w400,
                        fontSize: 12),
                    image != 'null'
                        ? Container(
                            height: screenHeight(context, dividedBy: 17),
                            width: screenHeight(context, dividedBy: 17),
                            padding: EdgeInsets.all(2),
                            color: Colors.transparent,
                            child: Image.network(
                                '${ApiRoutes.Image_URL}' + '${image}',
                                fit: BoxFit.cover,
                                frameBuilder: (_, image, loadingBuilder, __) {
                              if (loadingBuilder == null) {
                                return const SizedBox(
                                  height: 300,
                                  child: Center(
                                      child: CircularProgressIndicator()),
                                );
                              }
                              return image;
                            }, loadingBuilder: (BuildContext context,
                                    Widget image,
                                    ImageChunkEvent? loadingProgress) {
                              if (loadingProgress == null) return image;
                              return SizedBox(
                                height: 300,
                                child: Center(
                                  child: CircularProgressIndicator(
                                    value: loadingProgress.expectedTotalBytes !=
                                            null
                                        ? loadingProgress
                                                .cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes!
                                        : null,
                                  ),
                                ),
                              );
                            }))
                        : Container(),
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
                                      rentalCub.photo2 =
                                          await _picker.pickImage(
                                              source: ImageSource.camera);
                                      Navigation.instance.goBack();
                                      rentalCub.setState();
                                    },
                                    onTapGallery: () async {
                                      rentalCub.photo2 =
                                          await _picker.pickImage(
                                              source: ImageSource.gallery);
                                      Navigation.instance.goBack();
                                      rentalCub.setState();
                                    },
                                  );
                                },
                                child: Container(
                                  height: screenHeight(context, dividedBy: 23),
                                  width: screenWidth(context, dividedBy: 4),
                                  decoration: BoxDecoration(
                                      color: HexColor.Gray53.withOpacity(0.4),
                                      borderRadius: BorderRadius.circular(10),
                                      border:
                                          Border.all(color: HexColor.Gray53)),
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
                                    child: commonText(
                                        rentalCub.photo2 == null
                                            ? "No file chosen"
                                            : rentalCub.photo2!.path
                                                .split("/")
                                                .last,
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
                        controller: _description,
                        maxline: 1,
                        ctx: context),
                    verticalSpaces(context, height: 20),
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
                        BlocBuilder<RentalListCubit, RentalListState>(
                          builder: (context, state) {
                            if (state is UpdateRentalLoading) {
                              return commonLoadingButton(context: context);
                            } else {
                              return commonButton(
                                context: context,
                                buttonName: "Update",
                                onTap: () async {
                                  if (_vendor.text.isEmpty) {
                                    snackBar("Please Enter Vendor Name", false);
                                  } else if (_item.text.isEmpty) {
                                    snackBar("Please Enter Item Name", false);
                                  } else if (_arrivalDate.text.isEmpty) {
                                    snackBar(
                                        "Please Select Arrival Date", false);
                                  } else if (_dueDate.text.isEmpty) {
                                    snackBar("Please Due Date", false);
                                  } else if (_quantity.text.isEmpty) {
                                    snackBar("Please Enter Quantity", false);
                                  }  else if (int.parse(_quantity.text) <= 0 ) {
                                    snackBar("Quantity cannot be zero or negative", false);
                                  }
                                  else {
                                    if (rentalCub.photo2 == null) {
                                      rentalCub.UpdateRental(
                                        context: context,
                                        rental_id: rentalCub
                                            .rentalList[widget.index].id
                                            .toString(),
                                        vendor_name: _vendor.text,
                                        item_name: _item.text,
                                        arrival_date: _arrivalDate.text,
                                        due_date: _dueDate.text,
                                        quantity: _quantity.text,
                                        description: _description.text,
                                        api: '1',
                                      );
                                    } else {
                                      rentalCub.UpdateRental(
                                        context: context,
                                        rental_id: rentalCub
                                            .rentalList[widget.index].id
                                            .toString(),
                                        vendor_name: _vendor.text,
                                        item_name: _item.text,
                                        arrival_date: _arrivalDate.text,
                                        due_date: _dueDate.text,
                                        quantity: _quantity.text,
                                        description: _description.text,
                                        api: '1',
                                        file: File(rentalCub.photo2!.path),
                                      );
                                    }
                                  }
                                },
                              );
                            }
                          },
                        ),
                      ],
                    ),
                    verticalSpaces(context, height: 50),
                  ],
                ),
              ),
            ),
          ])),
    );
  }
}
