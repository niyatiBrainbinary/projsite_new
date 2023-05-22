import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ftx/navigationX.dart';
import 'package:intl/intl.dart';
import 'package:proj_site/common/colors/colors.dart';
import 'package:proj_site/common/image_constant/image_constant.dart';
import 'package:proj_site/common/widget_constant/widget_constant.dart';
import 'package:proj_site/cubits/auth_cubit.dart';
import 'package:proj_site/cubits/logistic_list_cubit.dart';
import 'package:proj_site/helper/helper.dart';
import 'package:proj_site/view/logisticList/checkOutHistory.dart';
import 'package:proj_site/view/logisticList/editLogistics.dart';

class LogisticListScreen extends StatefulWidget {
  String terminalId;

  LogisticListScreen(this.terminalId);

  @override
  State<LogisticListScreen> createState() => _LogisticListScreenState();
}

class _LogisticListScreenState extends State<LogisticListScreen> {
  _delete({Function? onTap}) {
    return getContainerWithImage(
      ctx: context,
      icons: icons.ic_delete,
      onTap: onTap as void Function()?,
    );
  }

  _edit({Function? onTap}) {
    return getContainerWithImage(
      ctx: context,
      icons: icons.ic_edit,
      onTap: onTap as void Function()?,
    );
  }

  _logisticList(
      {required Widget editButton,
      required Widget deleteButton,
      required int index}) {
    return getCommonContainer(
        height: screenHeight(context, dividedBy: 5.5),
        width: screenWidth(context),
        padding: EdgeInsets.symmetric(horizontal: 15),
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: screenHeight(context, dividedBy: 14),
              width: screenWidth(context),
              color: Colors.transparent,
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: screenWidth(context, dividedBy: 4),
                            color: Colors.transparent,
                            child: commonText(
                                logisticCub.LogisticsList[index].itemName==null?"":logisticCub.LogisticsList[index].itemName!,
                                color: Colors.black,
                                maxLines: 1,
                                fontFamily: LexendRegular,
                                fontWeight: FontWeight.w400,
                                fontSize: 16),
                          ),
                          editButton,
                          deleteButton,
                        ],
                      ),
                      commonText(
                          DateFormat('yyyy-MM-dd').format(DateTime.parse(
                              logisticCub.LogisticsList[index].arrivalDate
                                  .toString())),
                          color: HexColor.Gray53,
                          fontFamily: LexendLight,
                          fontWeight: FontWeight.w300,
                          fontSize: 12,
                          maxLines: 2),
                    ],
                  ),
                  Spacer(),
                  Image(image: AssetImage(icons.ic_excavator))
                ],
              ),
            ),
            getSimpleRowText(sub1: "Entrepreneur", sub2: logisticCub.LogisticsList[index].companyDetails==null?"":logisticCub.LogisticsList[index].companyDetails!.companyName.toString()),
            getSimpleRowText(
                sub1: "No. of pallets",
                sub2: logisticCub.LogisticsList[index].noOfPallets.toString()),
            getSimpleRowText(
                sub1: "In stock",
                sub2: logisticCub.LogisticsList[index].inStock.toString()),
            getDivider(height: 15)
          ],
        ));
  }

  _showDialogue(BuildContext context, int index) {
    showDialog(
      barrierColor: Colors.black.withOpacity(0.4),
      barrierDismissible: false,
      builder: (context) {
        return Container(
          child: AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            contentPadding:
                EdgeInsets.only(left: 18, right: 18, top: 18, bottom: 18),
            content: Container(
              height: screenHeight(context, dividedBy: 5),
              width: screenWidth(context),
              color: Colors.transparent,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Center(
                      child: Text("Are you sure you want to Delete?",
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: LexendRegular,
                            fontSize: 16,
                          ))),
                  Row(
                    children: [
                      commonButton(
                          context: context,
                          buttonName: "close",
                          width: 95,
                          buttonColor: HexColor.Gray53.withOpacity(0.5),
                          onTap: () {
                            Navigator.pop(context);
                          }),
                      BlocBuilder<LogisticListCubit, LogisticListState>(
                        builder: (context, state) {
                          if (state is DeleteLogisticLoading) {
                            return commonLoadingButton(
                                context: context, width: 95);
                          } else {
                            return commonButton(
                                context: context,
                                buttonName: "Delete",
                                buttonColor: HexColor.yellow,
                                width: 95,
                                onTap: () {
                                  logisticCub.DeleteLogistic(
                                      logisticCub.LogisticsList[index].id.toString(),
                                      projectIdMain,
                                      widget.terminalId
                                      // logisticCub.LogisticsList[index].projectId
                                      //     .toString(),
                                      // logisticCub
                                      //     .LogisticsList[index].terminalId!
                                      //     .toString()
                                  );
                                });
                          }
                        },
                      )
                    ],
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  )
                ],
              ),
            ),
          ),
        );
      },
      context: context,
    );
  }

  @override
  void initState() {
    getLogisticList();
  }

  late LogisticListCubit logisticCub;

  getLogisticList() {
    logisticCub = BlocProvider.of<LogisticListCubit>(context);
    logisticCub.LogisticListData(
        projectIdMain,
        widget.terminalId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LogisticListCubit, LogisticListState>(
      builder: (context, state) {
        if (state is LogisticListLoading) {
          return loader();
        } else if (state is LogisticListError) {
          return errorLoadDataText();
        } else {
          if(logisticCub.LogisticsList.isEmpty){
            return noDataFoundText();
          }else{
            return ListView.builder(
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.zero,
              itemCount: logisticCub.LogisticsList.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  child: _logisticList(
                      editButton: _edit(onTap: () {
                        Navigation.instance.navigate(EditLogistics.id,
                            args: logisticCub.LogisticsList[index].id);
                      }),
                      deleteButton: _delete(onTap: () {
                        _showDialogue(context, index);
                      }),
                      index: index),
                  onTap: () {
                    Navigation.instance.navigate(CheckOutHistory.id,args: logisticCub.LogisticsList[index].id);
                  },
                );
              },
            );
          }

        }
      },
    );
  }
}
