import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ftx/navigationX.dart';
import 'package:proj_site/common/colors/colors.dart';
import 'package:proj_site/common/image_constant/image_constant.dart';
import 'package:proj_site/common/widget_constant/widget_constant.dart';
import 'package:proj_site/cubits/logistic_list_cubit.dart';
import 'package:proj_site/helper/helper.dart';
import 'package:proj_site/view/logisticList/transportRequestShipment.dart';

class CheckOutHistory extends StatefulWidget {
  static const id = 'CheckOutHistory_screen';

  String logisticId;
  CheckOutHistory(this.logisticId);

  @override
  State<CheckOutHistory> createState() => _CheckOutHistoryState();
}

String fromDate = "Select Release Date";
DateTime? arriveDate;

TextEditingController _releaseTxt = TextEditingController();
TextEditingController _currentStock = TextEditingController();
String currentStockQty="Current Stock";

class _CheckOutHistoryState extends State<CheckOutHistory> {
  _onTap1() async {
    arriveDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2101));
    if (arriveDate != null) {
      print(arriveDate);
      String formattedDate = DateFormat('yyyy-MM-dd').format(arriveDate!);
      print("formattedDate${formattedDate}");
      setState(() {
        fromDate = formattedDate;
      });
    } else {
      print("Date is not selected");
    }
  }

  _checkout(
      {required LogisticListCubit logisticCub,
      required String release_quantity,
      required String release_date,
      required String current_stock,
      }) {
    return commonButton(
        context: context,
        buttonName: "Check Out",
        buttonTextSize: 15,
        onTap: () {
          FocusScope.of(context).unfocus();
          // Navigation.instance.navigate(ShipmentData.id);
          if (_releaseTxt.text.isEmpty) {
            snackBar("Release quantity is required", false);
          } else if (arriveDate == null) {
            snackBar("Release date is required", false);
          } else {
            Map<String, dynamic> body = {
              "logistic_id": logisticCub.logisticDetails!.result!.id.toString(),
              "release_date": release_date,
              "release_quantity": release_quantity,
              "current_stock": current_stock,
              "status": "not_transported",
              "created_by": ""
            };

            logisticCub.CheckoutLogistic(
                body);
          }
        });
  }

  @override
  void initState() {
    getLogisticListData();
    currentStockQty="Current Stock";
  }

  late LogisticListCubit logisticCub;
  // var arrivalDate;
  // var createdAt;
  // var updatedAt;

  getLogisticListData() {
    logisticCub = BlocProvider.of<LogisticListCubit>(context);
    logisticCub.LogisticDetails(widget.logisticId);
  }

  _result(
      {required String item_name,
      required String sub_project_name,
      required String company_name,
      required String arrival_date,
      required String no_of_pallets,
      required String in_stock,
      required String description}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
     // height: screenHeight(context, dividedBy: 2.5),
      width: screenWidth(context),
      color: Colors.transparent,
      child: Column(
        children: [
          getSimpleRowText(sub1: "Item name", sub2: item_name),
          SizedBox(height: 7,),
          getSimpleRowText(sub1: "Sub Project", sub2: sub_project_name),
          SizedBox(height: 7,),
          getSimpleRowText(sub1: "Entrepreneur", sub2: company_name),
          SizedBox(height: 7,),
          getSimpleRowText(sub1: "Arrival date", sub2: arrival_date),
          SizedBox(height: 7,),
          getSimpleRowText(sub1: "No of pallets", sub2: no_of_pallets),
          SizedBox(height: 7,),
          getSimpleRowText(sub1: "In stock", sub2: in_stock),
          SizedBox(height: 7,),
          getSimpleRowText(sub1: "Description", sub2: description),
          SizedBox(height: 7,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              commonText("Image",
                  color: HexColor.Gray53,
                  fontFamily: LexendRegular,
                  fontWeight: FontWeight.w400,
                  fontSize: 14),
              Container(
                height: screenHeight(context, dividedBy: 17),
                width: screenWidth(context, dividedBy: 5),
                color: Colors.transparent,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Image.asset(icons.ic_excavator),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  // _checkOutHistory(
  //     {required BuildContext ctx,
  //       required String release_quantity,
  //       required String arrival_date,
  //       required String item_name,
  //       required String created_at,
  //       required String updated_at}) {
  //   return Container(
  //       height: screenHeight(ctx, dividedBy: 3),
  //       width: screenWidth(ctx),
  //       margin: EdgeInsets.symmetric(horizontal: 15),
  //       padding: EdgeInsets.all(10),
  //       decoration: BoxDecoration(
  //         color: Colors.white,
  //         borderRadius: BorderRadius.circular(20),
  //         border: Border.all(color: HexColor.Gray53.withOpacity(0.3)),
  //         boxShadow: [
  //           BoxShadow(
  //               color: HexColor.Gray53.withOpacity(0.3),
  //               blurRadius: 5,
  //               offset: Offset(1, 1),
  //               spreadRadius: 1),
  //           BoxShadow(
  //               color: Colors.white.withOpacity(0.1),
  //               blurRadius: 1,
  //               offset: Offset(-1, -1),
  //               spreadRadius: 1)
  //         ],
  //       ),
  //       child: ListView.builder(
  //         physics: BouncingScrollPhysics(),
  //         padding: EdgeInsets.zero,
  //         shrinkWrap: true,
  //         itemCount: logisticCub.checkOuts?.length,
  //         itemBuilder: (context, index) {
  //           return getCheckOutHistory(
  //               ctx: ctx,
  //               release_quantity: release_quantity,
  //               arrival_date: arrival_date,
  //               item_name: item_name,
  //               created_at: created_at,
  //               updated_at: updated_at);
  //         },
  //       )
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBarWithIcon(
        ctx: context,
      ) as PreferredSizeWidget?,
      body: getCommonContainer(
        color: Colors.white,
        child: Column(
          children: [
            getCommonContainer(
                padding: EdgeInsets.symmetric(
                  horizontal: 15,
                ),
                height: screenHeight(context, dividedBy: 15),
                width: screenWidth(context),
                color: Colors.transparent,
                child: commonText("Logistic list",
                    color: Colors.black,
                    fontFamily: LexendRegular,
                    fontWeight: FontWeight.w700,
                    fontSize: 20)),
            Expanded(
              child: BlocBuilder<LogisticListCubit, LogisticListState>(
                builder: (context, state) {
                  var result =  logisticCub.logisticDetails?.result;
                  var checkOuts =  logisticCub.logisticDetails?.checkOuts;
                  if (state is LogisticDetailLoading) {
                    return loader();
                  } else if (state is LogisticDetailError) {
                    return errorLoadDataText();
                  } else {
                    // arrivalDate =DateTime.parse(result!.arrivalDate.toString());
                    // var arrival_date = "${arrivalDate.year}-${arrivalDate.month}-${arrivalDate.day}";
                    return SingleChildScrollView(
                      child: Container(
                        margin: EdgeInsets.only(bottom: 30),
                        child: Column(
                          children: [
                            _result(
                                item_name: result!.itemName.toString(),
                                sub_project_name: result.subProjectDetails!.subProjectName.toString(),
                                company_name:result.companyDetails!.companyName.toString(),
                                arrival_date: logisticCub.arrival_date.toString(),
                                no_of_pallets: result.noOfPallets.toString(),
                                in_stock: result.inStock.toString(),
                                description: result.description==null?"":result.description),
                            getCommonContainer(
                                alignment: Alignment.centerLeft,
                                padding:
                                EdgeInsets.symmetric(horizontal: 15),
                                height:
                                screenHeight(context, dividedBy: 15),
                                width: screenWidth(context),
                                color: Colors.transparent,
                                child: commonText("Check out history",
                                    color: Colors.black,
                                    fontFamily: LexendSemiBold,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16)),

                            checkOuts?.length==0?commonText("No Data Found",
                                color: Colors.black,
                                fontFamily: LexendRegular,
                                fontWeight: FontWeight.w400,
                                fontSize: 14)
                                :Container(
                                height: checkOuts?.length==1?screenHeight(context, dividedBy: 3.5):screenHeight(context, dividedBy: 1.75),
                                width: screenWidth(context),
                                margin: EdgeInsets.symmetric(horizontal: 15),
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: HexColor.Gray53.withOpacity(0.3)),
                                  boxShadow: [
                                    BoxShadow(
                                        color: HexColor.Gray53.withOpacity(0.3),
                                        blurRadius: 5,
                                        offset: Offset(1, 1),
                                        spreadRadius: 1),
                                    BoxShadow(
                                        color: Colors.white.withOpacity(0.1),
                                        blurRadius: 1,
                                        offset: Offset(-1, -1),
                                        spreadRadius: 1)
                                  ],
                                ),
                                child: ListView.builder(
                                  physics: BouncingScrollPhysics(),
                                  padding: EdgeInsets.zero,
                                  shrinkWrap: true,
                                  itemCount: checkOuts?.length,
                                  itemBuilder: (context, index) {

                                   // print("id${checkOuts?[index].requestUrl.split("/").last}");
                                    // createdAt =DateTime.parse(checkOuts![index].createdAt.toString());
                                    // updatedAt =DateTime.parse(checkOuts[index].createdAt.toString());
                                    // var created_at = "${createdAt.year}-${createdAt.month}-${createdAt.day}";
                                    // var updated_at = "${updatedAt.year}-${updatedAt.month}-${updatedAt.day}";
                                    return getCheckOutHistory(
                                        ctx: context,
                                        release_quantity: checkOuts![index].releaseQuantity,
                                        release_date: checkOuts[index].releaseDate,
                                        item_name: checkOuts[index].createdByPersonName,
                                        transported_date: checkOuts[index].status=="not_transported"?"":checkOuts[index].bookedBetween,
                                        status: checkOuts[index].status,
                                        requestId: checkOuts[index].status=="not_transported"?"":checkOuts[index].requestId,
                                      logisticId : widget.logisticId
                                    );
                                  },
                                )
                            ),
                            getCommonContainer(
                                alignment: Alignment.centerLeft,
                                padding:
                                EdgeInsets.symmetric(horizontal: 15),
                                height:
                                screenHeight(context, dividedBy: 15),
                                width: screenWidth(context),
                                color: Colors.transparent,
                                child: commonText("Check out entry",
                                    color: Colors.black,
                                    fontFamily: LexendSemiBold,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16)),
                            Container(
                              margin:
                              EdgeInsets.symmetric(horizontal: 15),
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  commonText("Release quantity",
                                      color: Colors.black,
                                      fontFamily: LexendRegular,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12),
                                  verticalSpaces(context, height: 80),
                                  getRoundedTexfield(
                                      hintText: "Enter Release Quantity",
                                      maxline: 1,
                                      textInputType: TextInputType.number,
                                      controller: _releaseTxt,
                                      onChanged: (value){
                                        int releaseQty=0;
                                        if(_releaseTxt.text.isEmpty){
                                          releaseQty=0;
                                        } else{
                                          releaseQty=int.parse(_releaseTxt.text);
                                          if (int.parse(logisticCub.logisticDetails!.result!.inStock.toString()) < releaseQty) {
                                            snackBar("Release Quantity Exceeded from In Stock Quantity", false);
                                            currentStockQty="Current Stock";
                                          } else {
                                            currentStockQty=(int.parse(logisticCub.logisticDetails!.result!.inStock.toString()) - releaseQty).toString();
                                          }
                                        }

                                        if(_releaseTxt.text.isEmpty){
                                          currentStockQty="Current Stock";
                                        }
                                        print("_releaseTxt=${_releaseTxt.text}");
                                        setState(() {});
                                      },
                                      ctx: context),
                                  verticalSpaces(context, height: 40),
                                  commonText("Desired release date",
                                      color: Colors.black,
                                      fontFamily: LexendRegular,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12),
                                  verticalSpaces(context, height: 80),
                                  getRoundedContainerWithTralingIcon(
                                      text: fromDate,
                                      image: icons.ic_calendar,
                                      onTap: _onTap1,
                                      height: screenHeight(context,
                                          dividedBy: 15)),
                                  verticalSpaces(context, height: 40),
                                  commonText("Current stock",
                                      color: Colors.black,
                                      fontFamily: LexendRegular,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12),
                                  verticalSpaces(context, height: 80),
                                  Container(
                                    height: screenHeight(context, dividedBy: 15),
                                    width: screenWidth(context),
                                    alignment: Alignment.centerLeft,
                                    padding: EdgeInsets.symmetric(horizontal: 10),
                                    decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      border: Border.all(color: HexColor.Gray53.withOpacity(0.5), width: 1.5),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: commonText(currentStockQty,
                                        color: currentStockQty=="Current Stock"? HexColor.Gray53:Colors.black,
                                        fontFamily: LexendRegular,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14),
                                  ),

                                  verticalSpaces(context, height: 10),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                    children: [
                                      commonButton(
                                          context: context,
                                          buttonName: "Close",
                                          buttonColor:
                                          HexColor.Gray53.withOpacity(
                                              0.3),
                                          onTap: () {
                                            Navigation.instance.goBack();
                                          }),
                                      BlocConsumer<LogisticListCubit,
                                          LogisticListState>(
                                        listener: (context, state){
                                          if(state is CheckoutLogisticSuccess){
                                            FocusScope.of(context).unfocus();
                                            _releaseTxt.clear();
                                            _currentStock.clear();
                                            fromDate="Select Release Date";
                                            currentStockQty="Current Stock";
                                            logisticCub.LogisticDetails(logisticCub.logisticDetails!.result!.id.toString());
                                          }
                                        },
                                        builder: (context, state) {
                                          if(state is CheckoutLogisticLoading){
                                            return commonLoadingButton(context: context);
                                          } else {
                                            return _checkout(
                                                logisticCub: logisticCub,
                                                release_quantity:
                                                _releaseTxt.text,
                                                release_date: fromDate,current_stock:currentStockQty);
                                          }
                                        },
                                      )
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
