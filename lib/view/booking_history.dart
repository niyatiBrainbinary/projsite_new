import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ftx/navigationX.dart';
import 'package:intl/intl.dart';
import 'package:proj_site/common/colors/colors.dart';
import 'package:proj_site/common/image_constant/image_constant.dart';
import 'package:proj_site/common/widget_constant/widget_constant.dart';
import 'package:proj_site/cubits/auth_cubit.dart';
import 'package:proj_site/cubits/booking_cubit.dart';
import 'package:proj_site/cubits/project_list_cubit.dart';
import 'package:proj_site/cubits/terminal_cubit.dart';
import 'package:proj_site/helper/helper.dart';
import 'package:proj_site/view/dashBoard.dart';
import 'package:proj_site/view/logisticList/logisticList.dart';
import 'package:proj_site/view/logisticList/logisticMainPage.dart';
import 'package:proj_site/view/projectName.dart';

class BookingHistory extends StatefulWidget {
  String requestId;
  BookingHistory(this.requestId);

  @override
  State<BookingHistory> createState() => _BookingHistoryState();
}

class _BookingHistoryState extends State<BookingHistory> {

  late BookingCubit bookingCub;

  Widget getExpandedRowText({required String sub1, required String sub2}) {
    return getSimpleRowText(sub1: sub1, sub2: sub2);
  }

  @override
  void initState() {
    // TODO: implement initState

    bookingCub = BlocProvider.of<BookingCubit>(context);
    bookingCub.BookingHistory(widget.requestId);
    super.initState();
  }
  _bookingHistoryList({required String event,required String responsiblePerson, required String date}){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        getDivider(height: 25),
        // getExpandedRowText(
        //     sub1: "Date", sub2: date),
        getExpandedRowText(
            sub1: "Event", sub2: event ),
        SizedBox(height: 5,),
        getExpandedRowText(
            sub1: "Responsible Person", sub2: responsiblePerson),
        SizedBox(height: 5,),
        getExpandedRowText(
            sub1: "Date", sub2: date),

      ],
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: getAppBarWithIcon(ctx: context) as PreferredSizeWidget?,
      body: getCommonContainer(
        color: Colors.transparent,
        padding: EdgeInsets.symmetric(horizontal: 15),
        //margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top+(kToolbarHeight*0.1)),
        child: Column(
          children: [
            getCommonContainer(
              height: screenHeight(context, dividedBy: 15),
              width: screenWidth(context),
              color: Colors.transparent,
              alignment: Alignment.center,
              child: Row(
                children: [
                  commonText("Booking History",
                      color: Colors.black,
                      fontFamily: LexendBold,
                      fontWeight: FontWeight.w700,
                      fontSize: 20),
                ],
              ),
            ),
            Expanded(
              child: BlocBuilder<BookingCubit, BookingState>(
                builder: (context, state) {
                  if(state is BookingHistoryLoading){
                    return loader();
                  }else if (state is BookingHistoryError){
                    return errorLoadDataText();
                  } else{
                    if(bookingCub.bookingHistoryList!.isEmpty){
                      return noDataFoundText();
                    }else {
                      return ListView.builder(padding: EdgeInsets.zero,physics: const BouncingScrollPhysics(),shrinkWrap: true,itemCount: bookingCub.bookingHistoryList!.length,itemBuilder: (context, index) {
                        return  getCommonContainer(
                          width: screenWidth(context),
                          color: Colors.transparent,
                          child:_bookingHistoryList(
                              event: bookingCub.bookingHistoryList![index].event!,
                              responsiblePerson: bookingCub.bookingHistoryList![index].responsiblePersonName!,
                              date: "${DateFormat.yMd().format(DateTime.parse(bookingCub.bookingHistoryList![index].updatedAt!))}  ${DateFormat.jms().format(DateTime.parse(bookingCub.bookingHistoryList![index].updatedAt!))}",
                          ),
                        );
                      },);
                    }
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
