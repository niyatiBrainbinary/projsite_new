import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:proj_site/common/widget_constant/widget_constant.dart';
import 'package:proj_site/helper/helper.dart';
import 'package:proj_site/view/UnLoadingZone/zoneList.dart';
import 'package:proj_site/view/rentalList/newRentalEntry.dart';
import 'package:proj_site/view/rentalList/rentalList.dart';
import 'package:ftx/navigationX.dart';

class RentalMainPage extends StatefulWidget {
  static const id = 'RentalMainPage_screen';
  @override
  _RentalMainPageState createState() => _RentalMainPageState();
}

class _RentalMainPageState extends State<RentalMainPage>
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
      resizeToAvoidBottomInset: true,
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
              child: getContainerWithTralingIcon(ctx: context, text: 'Rental list'),
            ),
            verticalSpaces(context, height: 100),
            getCommonTwoTabBar(
              ctx: context,
              controller: _tabController,

              tab1: "Rental list",
              tab2: "New rental entry"),

            Expanded(
              child: TabBarView(
                controller: _tabController,
                children:  [
                  RentalList(),
                  NewRentalEntry(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
