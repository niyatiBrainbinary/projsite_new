import 'package:flutter/material.dart';
import 'package:proj_site/common/widget_constant/widget_constant.dart';
import 'package:proj_site/helper/helper.dart';
import 'package:proj_site/view/apdPlan/apdPlanList.dart';
import 'package:proj_site/view/apdPlan/newApdPlan.dart';

class ApdPlanMainPage extends StatefulWidget {
  static const id = 'ApdPlanMain_screen';
  @override
  _ApdPlanMainPageState createState() => _ApdPlanMainPageState();
}

class _ApdPlanMainPageState extends State<ApdPlanMainPage>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    _tabController?.addListener(() {
      if (_tabController!.indexIsChanging) {
        FocusScope.of(context).requestFocus(new FocusNode());
      }
    });
    super.initState();
  }


  @override
  void dispose() {
    super.dispose();
    _tabController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: getAppBarWithIcon(ctx: context) as PreferredSizeWidget?,
      body: getCommonContainer(
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            getCommonContainer(
              height: screenHeight(context,dividedBy: 16),
              width: screenWidth(context),
              color: Colors.transparent,
              alignment: Alignment.centerLeft,
              child: commonText("APD Plan", color: Colors.black, fontFamily: LexendBold, fontWeight: FontWeight.w700, fontSize: 20)
            ),
            verticalSpaces(context, height: 100),
            getCommonTwoTabBar(
              ctx: context,
              controller: _tabController,
              tab1: "APD Plan List",
              tab2: "New APD Plan",),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children:  [
                  ApdPlanList(),
                  NewApdPlan(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
