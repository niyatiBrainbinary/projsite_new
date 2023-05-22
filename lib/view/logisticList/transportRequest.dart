import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ftx/navigationX.dart';
import 'package:intl/intl.dart';
import 'package:proj_site/api%20service/models/logistic_list_models/notTransported_checkouts_model.dart';
import 'package:proj_site/common/colors/colors.dart';
import 'package:proj_site/common/image_constant/image_constant.dart';
import 'package:proj_site/common/widget_constant/widget_constant.dart';
import 'package:proj_site/cubits/auth_cubit.dart';
import 'package:proj_site/cubits/logistic_list_cubit.dart';
import 'package:proj_site/helper/helper.dart';
import 'package:proj_site/view/logisticList/transportRequestShipment.dart';

class TransportRequest extends StatefulWidget {
  String terminalId;
  TransportRequest(this.terminalId);

  @override
  State<TransportRequest> createState() => _TransportRequestState();
}

class _TransportRequestState extends State<TransportRequest> {
  TextEditingController searchField = TextEditingController();
  List <String> userSearch = [];
  DateTime? arriveDate;
  DateTime? dueDate;
  List<bool> valueList = [];
  String fromDate = "Search by from date";
  String toDate = "Search by to date";
  List selectedCheckOutList = [];

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
      print(dueDate);
      String formattedDate = DateFormat('yyyy-MM-dd').format(dueDate!);
      print(formattedDate);

      setState(() {
        toDate = formattedDate;
      });
    } else {
      print("Date is not selected");
    }
  }

  late LogisticListCubit logisticCub;
  late AuthCubit authCub;
  var dateTime;

  @override
  void initState() {
    getNotTransportedCheckoutsList();
  }

  _transportRequestList({
    required String item_name,
    required String release_quantity,
    required String release_date,
    required String created_by_person_name,
    required int index,
  }) {
    return Container(
      width: screenWidth(context),
      color: Colors.transparent,
      margin: EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              commonText("${index+1}",
                  color: HexColor.Gray53,
                  fontFamily: LexendLight,
                  fontWeight: FontWeight.w300,
                  fontSize: 14),
              simpleCheckBox(context, value: valueList[index], onChanged: (val) {
                setState(() {
                  valueList[index] = !valueList[index];
                  if(valueList[index]==true){
                    selectedCheckOutList.add(logisticCub.checkOuts![index].id);
                  } else {
                    selectedCheckOutList.removeAt(index);
                  }
                  log("selectedCheckOutList=$selectedCheckOutList");
                });
              })
            ],
          ),
          SizedBox(height: 7,),
          getSimpleRowText(sub1: "Item name", sub2: item_name),
          SizedBox(height: 5,),
          getSimpleRowText(sub1: "Release quantity", sub2: release_quantity),
          SizedBox(height: 5,),
          getSimpleRowText(sub1: "Desired release date", sub2: release_date),
          SizedBox(height: 5,),
          getSimpleRowText(sub1: "Created By", sub2: created_by_person_name),
          getDivider(height: 25),
        ],
      ),
    );
  }

  getNotTransportedCheckoutsList() {
    logisticCub = BlocProvider.of<LogisticListCubit>(context);
    authCub = BlocProvider.of<AuthCubit>(context);
    logisticCub.NotTransportedCheckout(projectIdMain,widget.terminalId,"","","");
    // userSearch = logisticCub.userList;
    // setState(() {
    //
    // });
    // log("userSearch${logisticCub.userList}");
    // if (searchField.text != null) {
    //   for (int i = 0; i <logisticCub.userList.length; i++) {
    //     String data = logisticCub.userList[i];
    //     if (data
    //         .toLowerCase()
    //         .contains(searchField.text.toLowerCase())) {
    //       userSearch.add(data);
    //     }
    //   }
    // }
    // log("userSearch1${userSearch}");
  }


  @override
  Widget build(BuildContext context) {
    return getCommonContainer(
      color: Colors.white,
      child: Column(
        children: [
          Container(
            height: screenHeight(context, dividedBy: 6.5),
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
                    blurRadius: 1,
                    offset: Offset(0, 1),
                    spreadRadius: 1),
                BoxShadow(
                    color: Colors.white.withOpacity(0.1),
                    blurRadius: 4,
                    offset: Offset(-1, -1),
                    spreadRadius: 1)
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: getRoundedContainerWithTralingIcon(
                              text: fromDate,
                              image: icons.ic_calendar,
                              onTap: _onTap1),
                        ),
                        horizontal(context, width: 60),
                        Expanded(
                          child: getRoundedContainerWithTralingIcon(
                              text: toDate,
                              image: icons.ic_calendar,
                              onTap: _onTap2),
                        ),
                      ],
                    ),
                  ),
                ),
                verticalSpaces(context, height: 90),
                Expanded(
                    child: getRoundedTexfield(
                        height: screenHeight(context, dividedBy: 18),
                        contentPaddingTop: screenHeight(context, dividedBy: 65),
                        hintText: "Search by item name",
                        maxline: 1,
                        controller: searchField,
                        onChanged: (value){
                          userSearch = [];
                          if (searchField.text != null) {
                            for (int i = 0; i <logisticCub.userList.length; i++) {
                              String data = logisticCub.userList[i];
                              if (data
                                  .toLowerCase()
                                  .contains(searchField.text.toLowerCase())) {
                                userSearch.add(data);
                              }
                            }
                          }
                          setState(() {});
                        },
                        ctx: context))
              ],
            ),
          ),
          verticalSpaces(context, height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              commonButton(
                  context: context,
                  buttonName: "Reset",
                  buttonColor: HexColor.Gray53.withOpacity(0.2),onTap: () {
                fromDate = "Search by from date";
                toDate = "Search by to date";
                searchField.clear();
                logisticCub.NotTransportedCheckout(projectIdMain,widget.terminalId,"","","");
                setState(() {});
                  },),
              commonButton(context: context, buttonName: "Search",onTap: (){
                logisticCub.NotTransportedCheckout(projectIdMain,widget.terminalId,fromDate=="Search by from date"?"":fromDate,toDate=="Search by to date"?"":toDate,searchField.text);
                FocusScope.of(context).unfocus();
                userSearch = [];
                if (searchField.text != null) {
                  for (int i = 0; i <logisticCub.userList.length; i++) {
                    String data = logisticCub.userList[i];
                    if (data
                        .toLowerCase()
                        .contains(searchField.text.toLowerCase())) {
                      userSearch.add(data);
                    }
                  }
                }
                setState(() {});
              }),
            ],
          ),
          Container(
            height: screenHeight(context, dividedBy: 9),
            width: screenWidth(context),
            margin: EdgeInsets.symmetric(horizontal: 15),
            color: Colors.transparent,
            child: Row(
              children: [
                Expanded(
                    flex: 3,
                    child: commonText("Not Transported Checkouts",
                        color: Colors.black,
                        fontFamily: LexendBold,
                        fontWeight: FontWeight.w700,
                        fontSize: 14)),
                Expanded(
                    flex: 2,
                    child: commonButton(
                        context: context,
                        buttonTextSize: 14,
                        buttonName: "Transport Request",
                        padding: EdgeInsets.all(5),
                        onTap: () async {
                          if(valueList.contains(true)) {
                            String? returnVal= await Navigator.push(context, MaterialPageRoute(builder: (context) {
                              return TransportRequestShipment(selectedCheckOutList,logisticCub.checkOuts![0].logisticId);
                            },));
                            if(returnVal=="Success"){
                              valueList=[];
                              logisticCub.NotTransportedCheckout(projectIdMain,widget.terminalId,"","","");
                            }
                            setState(() {});
                          } else {
                            snackBar("No Items Selected for Transport Request", false);
                          }

                        }))
              ],
            ),
          ),
          Expanded(
            child: BlocConsumer<LogisticListCubit, LogisticListState>(
              listener: (context, state) {
                if(state is NotTransportedCheckoutSuccess){
                  valueList=[];
                  for(int i=0;i<logisticCub.checkOuts!.length;i++){
                    valueList.add(false);
                  }
                }
              },
              builder: (context, state) {
                List<CheckOutTransportHistory>? data = logisticCub.checkOuts;
                if (state is NotTransportedCheckoutLoading) {
                  return loader();
                } else if (state is NotTransportedCheckoutError) {
                  return errorLoadDataText();
                } else {
                  if (data!.length == 0) {
                    return Center(
                        child: commonText("No Data Found",
                            color: Colors.black,
                            fontFamily: LexendRegular,
                            fontWeight: FontWeight.w400,
                            fontSize: 20));
                  } else {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      padding: EdgeInsets.zero,
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        dateTime =DateTime.parse(data[index].releaseDate.toString());
                        var formate2 = "${dateTime.year}-${dateTime.month}-${dateTime.day}";
                        return _transportRequestList(
                            item_name: data[index].itemName,
                            release_quantity: data[index].releaseQuantity,
                            release_date:formate2,
                            created_by_person_name: data[index].createdByPersonName,index: index);
                      },
                    );
                  }
                  // for(int i=0;i<5;i++){
                  //   valueList.add(false);
                  // }
                  //   return ListView.builder(
                  //     shrinkWrap: true,
                  //     physics: BouncingScrollPhysics(),
                  //     padding: EdgeInsets.zero,
                  //     itemCount: 5,
                  //     itemBuilder: (context, index) {
                  //       return _transportRequestList(
                  //           item_name: "itemName",
                  //           release_quantity: "releaseQuantity",
                  //           release_date:"formate2",
                  //           created_by_person_name: "createdByPersonName",index: index);
                  //     },
                  //   );

                }
              },
            ),
          )
        ],
      ),
    );
  }
}
