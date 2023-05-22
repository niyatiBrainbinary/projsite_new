
import 'package:flutter/material.dart';
import 'package:ftx/navigationX.dart';
import 'package:proj_site/common/image_constant/image_constant.dart';
import 'package:proj_site/common/widget_constant/widget_constant.dart';
import 'package:proj_site/cubits/terminal_cubit.dart';
import 'package:proj_site/helper/helper.dart';
import 'package:proj_site/view/apdPlan/apdPlanMainPage.dart';
import 'package:proj_site/view/logisticList/logisticMainPage.dart';
import 'package:proj_site/view/logisticList/terminalList.dart';
import 'package:proj_site/view/projectDetails.dart';
import 'package:proj_site/view/projectName/calenderView.dart';
import 'package:proj_site/view/rentalList/rentalMainPage.dart';
import 'package:proj_site/view/statistics/statistic.dart';

class ProjectName extends StatefulWidget {
  static const id = 'ProjectName_screen';
  String? name;
   ProjectName({Key? key, this.name}) : super(key: key);

  @override
  State<ProjectName> createState() => _ProjectNameState();
}

class _ProjectNameState extends State<ProjectName> {
  List<String> tittle = [
    "Project Details",
    "Calendar",
    "APD Plan",
    "Statistics",
    "Terminals",
    "Rental list"
  ];
  List<String> icon = [
    icons.ic_projectName,
    icons.ic_cal,
    icons.ic_apdPlan,
    icons.ic_statistics,
    icons.ic_logisticList,
    icons.ic_renderList
  ];


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: getAppBarWithIcon(ctx: context) as PreferredSizeWidget?,
      body: getCommonContainer(
        color: Colors.white,
        height: screenHeight(context),
        width: screenWidth(context),
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            getCommonContainer(
              height: screenHeight(context, dividedBy: 16),
              width: screenWidth(context),
              color: Colors.transparent,
              alignment: Alignment.centerLeft,
              child: commonText(
                  //"Project Name",
                  widget.name.toString(),
                  color: Colors.black,
                  fontFamily: LexendBold,
                  fontWeight: FontWeight.w700,
                  fontSize: 20),
            ),
            verticalSpaces(context, height: 100),

            Expanded(
                child: ListView.builder(
              shrinkWrap: true,
              itemCount: tittle.length,
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return getContainerWithListTiles(
                    ctx: context, icon: icon[index], tittle: tittle[index],onTap: (){
                      if(index == 0){
                        Navigation.instance.navigate(ProjectDetails.id);
                      }else if(index == 1){
                        // Navigation.instance.navigate(CalenderView.id);
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => CalenderView(projectName: widget.name.toString())));
                      }else if(index == 2){
                        Navigation.instance.navigate(ApdPlanMainPage.id);
                      } else if(index == 3){
                        Navigation.instance.navigate(StatisticScreen.id);
                      }else if(index == 4){
                        Navigation.instance.navigate(TerminalList.id);
                      } else if(index == 5){
                        Navigation.instance.navigate(RentalMainPage.id);
                      }
                });
              },
            ))
          ],
        ),
      ),
    );
  }
}
