import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ftx/navigationX.dart';
import 'package:proj_site/common/colors/colors.dart';
import 'package:proj_site/common/image_constant/image_constant.dart';
import 'package:proj_site/common/widget_constant/widget_constant.dart';
import 'package:proj_site/cubits/auth_cubit.dart';
import 'package:proj_site/cubits/project_list_cubit.dart';
import 'package:proj_site/cubits/terminal_cubit.dart';
import 'package:proj_site/helper/helper.dart';
import 'package:proj_site/view/dashBoard.dart';
import 'package:proj_site/view/logisticList/logisticList.dart';
import 'package:proj_site/view/logisticList/logisticMainPage.dart';
import 'package:proj_site/view/projectName.dart';

class TerminalList extends StatefulWidget {
  static const id = 'TerminalList_screen';
  const TerminalList({Key? key}) : super(key: key);

  @override
  State<TerminalList> createState() => _TerminalListState();
}

Widget getExpandedRowText({required String sub1, required String sub2}) {
  return getSimpleRowText(sub1: sub1, sub2: sub2);
}


class _TerminalListState extends State<TerminalList> {

  late TerminalCubit terminalCub;


  @override
  void initState() {
    // TODO: implement initState

    terminalCub = BlocProvider.of<TerminalCubit>(context);
    terminalCub.TerminalList(projectIdMain);
    super.initState();
  }
  _terminalList({required String name,required String address,required String terminalId}){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        getDivider(height: 15),
        getExpandedRowText(
            sub1: "Name", sub2: name),
        getExpandedRowText(
            sub1: "Address", sub2: address),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            getIconWithUnderlineText(
              ctx: context,
              icon: icons.ic_eyes,
              iconColor: HexColor.aliceblue,
              textColor: HexColor.aliceblue,
              underlineColor: HexColor.aliceblue, text: 'View', width: screenWidth(context,dividedBy: 5), height: screenHeight(context,dividedBy: 28),
              onTap: () {
                Navigation.instance.navigate(LogisticMainPage.id,args: terminalId);
              },
            ),
          ],
        ),
        verticalSpaces(context, height: 100),
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
                  commonText("Terminal List",
                      color: Colors.black,
                      fontFamily: LexendBold,
                      fontWeight: FontWeight.w700,
                      fontSize: 20),
                ],
              ),
            ),
            Expanded(
              child: BlocBuilder<TerminalCubit, TerminalState>(
                builder: (context, state) {
                  if(state is TerminalListLoading){
                    return loader();
                  }else if (state is TerminalListError){
                    return errorLoadDataText();
                  } else{
                    if(terminalCub.terminalList!.isEmpty){
                      return noDataFoundText();
                    }else {
                      return ListView.builder(padding: EdgeInsets.zero,physics: const BouncingScrollPhysics(),shrinkWrap: true,itemCount: terminalCub.terminalList!.length,itemBuilder: (context, index) {
                        return  getCommonContainer(
                          height: screenHeight(context, dividedBy: 5.5),
                          width: screenWidth(context),
                          color: Colors.transparent,
                          child:_terminalList(
                              name: terminalCub.terminalList![index].name!, address: terminalCub.terminalList![index].address!,terminalId: terminalCub.terminalList![index].id!
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

