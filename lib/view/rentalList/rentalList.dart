import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ftx/navigationX.dart';
import 'package:proj_site/api%20service/api_routes.dart';
import 'package:proj_site/common/colors/colors.dart';
import 'package:intl/intl.dart';
import 'package:proj_site/common/colors/colors.dart';
import 'package:proj_site/common/image_constant/image_constant.dart';
import 'package:proj_site/common/widget_constant/widget_constant.dart';
import 'package:proj_site/cubits/auth_cubit.dart';
import 'package:proj_site/cubits/rental_list_cubit.dart';
import 'package:proj_site/helper/helper.dart';
import 'package:proj_site/view/rentalList/rentalInformation.dart';
import 'package:proj_site/view/rentalList/rentalList.dart';
import 'package:proj_site/view/unLoadingZone/editUnLoadingZone.dart';

class RentalList extends StatefulWidget {
  static const id = 'RentalList_screen';

  const RentalList({Key? key}) : super(key: key);

  @override
  State<RentalList> createState() => _RentalListState();
}

class _RentalListState extends State<RentalList> {
  late RentalListCubit RentalCub;
  late AuthCubit AuthCub;

  _rentalList(int index) {
    return getCommonContainer(
        //height: screenHeight(context, dividedBy: 5.5),
        width: screenWidth(context),
        color: Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: screenWidth(context, dividedBy: 1.8),
                  child: commonText(
                      RentalCub.rentalList[index].vendorName
                          .toString(),
                      color: Colors.black,
                      //overflow: TextOverflow.ellipsis,
                      fontFamily: LexendRegular,
                      fontWeight: FontWeight.w400,
                      fontSize: 16),
                ),

                SizedBox(width: screenWidth(context, dividedBy: 8.5)),

                Row(
                  children: [
                    getContainerWithImage(
                        ctx: context,
                        icons: icons.ic_edit,
                        onTap: () {
                          Navigation.instance.navigate(
                              RentalInformation.id,
                              args: index);
                        }),
                    getContainerWithImage(
                        ctx: context,
                        icons: icons.ic_delete,
                        onTap: () {
                          _showDialogue(context, index);
                        }),
                  ],
                ),

              ],
            ),
            getCenterIconWithText(
                startTime:
                "${DateFormat('yyyy-MM-dd').format(DateTime.parse(RentalCub.rentalList[index].arrivalDate.toString()))}",
                endTime:
                "${DateFormat('yyyy-MM-dd').format(DateTime.parse(RentalCub.rentalList[index].dueDate.toString()))}"),
            getSimpleRowText(
                sub1: "Item name",
                sub2: RentalCub.rentalList[index].itemName.toString()),
            getSimpleRowText(
                sub1: "Quantity",
                sub2: RentalCub.rentalList[index].quantity.toString()),
            getSimpleRowText(
                sub1: "Description",
                sub2:
                    RentalCub.rentalList[index].description.toString() == "null"
                        ? ""
                        : RentalCub.rentalList[index].description.toString()),
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
                      BlocBuilder<RentalListCubit, RentalListState>(
                        builder: (context, state) {
                          if (state is DeleteRentalLoading) {
                            return commonLoadingButton(
                                context: context, width: 95);
                          } else {
                            return commonButton(
                                context: context,
                                buttonName: "Delete",
                                width: 95,
                                onTap: () {
                                  RentalCub.DeleteRental(
                                      RentalCub.rentalList[index].id.toString(),
                                      context);
                                });
                          }
                        },
                      ),
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
    super.initState();
    RentalCub = BlocProvider.of<RentalListCubit>(context);
    AuthCub = BlocProvider.of<AuthCubit>(context);
    RentalCub.RentalListData(projectId: projectIdMain);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RentalListCubit, RentalListState>(
      builder: (context, state) {
        List rentalList = RentalCub.rentalList;
        if (state is RentalLoading) {
          return loader();
        } else if (state is RentalError) {
          return errorLoadDataText();
        } else if (rentalList.length == 0) {
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
            padding: EdgeInsets.all(0),
            itemCount: rentalList.length,
            itemBuilder: (context, index) {
              return _rentalList(index);
            },
          );
          //}
        }
      },
    );
  }
}
