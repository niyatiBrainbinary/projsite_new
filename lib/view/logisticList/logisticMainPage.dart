import 'package:flutter/material.dart';
import 'package:proj_site/common/widget_constant/widget_constant.dart';
import 'package:proj_site/helper/helper.dart';
import 'package:proj_site/view/logisticList/logisticList.dart';
import 'package:proj_site/view/logisticList/newEntry.dart';
import 'package:proj_site/view/logisticList/transportRequest.dart';

class LogisticMainPage extends StatefulWidget {
  static const id = 'LogisticMainPage_screen';

  String terminalId;
  LogisticMainPage(this.terminalId);

  @override
  _LogisticMainPageState createState() => _LogisticMainPageState();
}

class _LogisticMainPageState extends State<LogisticMainPage>
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
      resizeToAvoidBottomInset: true,
      appBar: getAppBarWithIcon(ctx: context) as PreferredSizeWidget?,
      body: Column(
        children: [
          getCommonContainer(
            color: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                getCommonContainer(
                  height: screenHeight(context,dividedBy: 16),
                  width: screenWidth(context),
                  color: Colors.transparent,
                  child: getContainerWithTralingIcon(ctx: context, text: 'Logistic list'),
                ),
                verticalSpaces(context, height: 100),
                getCommonThreeTabBar(
                  ctx: context,
                  controller: _tabController,
                  tab1: "Logistic list",
                  tab2: "Transport Request",
                  tab3: "New entry",),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children:   [
                LogisticListScreen(widget.terminalId),
                TransportRequest(widget.terminalId),
                NewEntry(widget.terminalId)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
