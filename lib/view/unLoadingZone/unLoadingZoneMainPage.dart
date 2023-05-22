import 'package:flutter/material.dart';
import 'package:ftx/navigationX.dart';
import 'package:proj_site/common/widget_constant/widget_constant.dart';
import 'package:proj_site/helper/helper.dart';
import 'package:proj_site/view/UnLoadingZone/zoneList.dart';
import 'package:proj_site/view/dashBoard.dart';
import 'package:proj_site/view/unLoadingZone/createNewZone.dart';

class UnLoadingZoneMainPage extends StatefulWidget {
  static const id = 'UnLoadingZoneMainPage_screen';
  @override
  _UnLoadingZoneMainPageState createState() => _UnLoadingZoneMainPageState();
}

class _UnLoadingZoneMainPageState extends State<UnLoadingZoneMainPage>
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
    return WillPopScope(
      onWillPop: () async {
        Navigation.instance.navigateAndReplace(DashBoard.id);
        return true;
      },
      child: getCommonContainer(
        color: Colors.transparent,
        margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top+(kToolbarHeight*0.1)),
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            getCommonContainer(
              height: screenHeight(context,dividedBy: 15),
              width: screenWidth(context),
              color: Colors.transparent,
              child: getContainerWithTralingIcon(ctx: context, text: 'Unloading Zone'),
            ),
            verticalSpaces(context, height: 100),
            getCommonTwoTabBar(
              ctx: context,
              controller: _tabController,
              tab1: "Zone List",
              tab2: "Create New Zone",),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children:  [
                  ZoneList(),
                  CreateNewZone(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
