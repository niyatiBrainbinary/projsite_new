import 'package:flutter/material.dart';
import 'package:proj_site/common/widget_constant/widget_constant.dart';
import 'package:proj_site/view/project/bookingFormSetting.dart';
import 'package:proj_site/view/project/calenderSetting.dart';
import 'package:proj_site/view/project/projectNotification.dart';

class ProjectSettingMainPage extends StatefulWidget {
  static const id = 'ProjectSettingMainPage_screen';
    String? name;
  ProjectSettingMainPage({Key? key, this.name}) : super(key: key);
  @override
  _ProjectSettingMainPageState createState() => _ProjectSettingMainPageState();
}

class _ProjectSettingMainPageState extends State<ProjectSettingMainPage>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
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
      appBar: getAppBarWithIcon(ctx: context) as PreferredSizeWidget?,
      body: getCommonContainer(
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            getSimpleTwoRowText(
                ctx: context,
                tittle1: "Project Settings",
                tittle2: widget.name ?? ""
            ),
            verticalSpaces(context, height: 100),
            getCommonThreeTabBar(
                ctx: context,
                controller: _tabController,
                tab1: "Booking form",
                tab2: "Calender Settings",
                tab3: "Notification"
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: const [
                  BookingFormSetting(),
                  CalenderSetting(),
                  ProjectNotification(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
