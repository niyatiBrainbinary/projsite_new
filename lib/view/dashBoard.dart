import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:proj_site/common/colors/colors.dart';
import 'package:proj_site/common/widget_constant/widget_constant.dart';
import 'package:proj_site/helper/helper.dart';
import 'package:proj_site/view/homePage.dart';
import 'package:proj_site/view/profile/profileSettingMainPage.dart';
import 'package:proj_site/view/project/projectSettingMainPage.dart';
import 'package:proj_site/view/projectList.dart';


import 'unLoadingZone/unLoadingZoneMainPage.dart';

class DashBoard extends StatefulWidget {
  static const id = 'DashBoard_screen';
  const DashBoard({Key? key}) : super(key: key);

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  List<Widget> screenList = [
    HomePage(),
    //UnLoadingZoneMainPage(),
    ProjectList(),
    ProfileSettingMainPage()
  ];

  int _indexSelected = 0;

  void _onSelected(int index) {
    setState(() {
      _indexSelected = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: screenList[_indexSelected],
        bottomNavigationBar: BottomNavyBar(
          onItemSelected: _onSelected,
          selectedIndex: _indexSelected,
          backgroundColor: Colors.white,
          showElevation: true,
          items: [
            BottomNavyBarItem(
              icon: Image.asset('assets/icons/ic_home.png',
                  height: screenHeight(context, dividedBy: 40),
                  width: screenHeight(context, dividedBy: 40),
                  color: _indexSelected == 0 ? HexColor.orange : Colors.black),
              title: commonText("Dashboard",
                  color: HexColor.orange,
                  fontFamily: LexendRegular,
                  fontWeight: FontWeight.w400,
                  fontSize: 14),
              activeColor: HexColor.orange.withOpacity(0.5),
              inactiveColor: Colors.black,
            ),
            // BottomNavyBarItem(
            //     icon: Image.asset('assets/icons/ic_location.png',
            //         height: screenHeight(context, dividedBy: 40),
            //         width: screenHeight(context, dividedBy: 40),
            //         color:
            //             _indexSelected == 1 ? HexColor.orange : Colors.black),
            //     title: commonText("Zones",
            //         color: HexColor.orange,
            //         fontFamily: LexendRegular,
            //         fontWeight: FontWeight.w400,
            //         fontSize: 14),
            //     activeColor: HexColor.orange,
            //     inactiveColor: Colors.black),
            BottomNavyBarItem(
                icon: Image.asset('assets/icons/ic_project.png',
                    height: screenHeight(context, dividedBy: 40),
                    width: screenHeight(context, dividedBy: 40),
                    color:
                        _indexSelected == 1 ? HexColor.orange : Colors.black),
                title: commonText("Projects",
                    color: HexColor.orange,
                    fontFamily: LexendRegular,
                    fontWeight: FontWeight.w400,
                    fontSize: 14),
                activeColor: HexColor.orange,
                inactiveColor: Colors.black),
            BottomNavyBarItem(
                icon: Image.asset('assets/icons/ic_user.png',
                    height: screenHeight(context, dividedBy: 40),
                    width: screenHeight(context, dividedBy: 40),
                    color:
                        _indexSelected == 2 ? HexColor.orange : Colors.black),
                title: commonText("Profile",
                    color: HexColor.orange,
                    fontFamily: LexendRegular,
                    fontWeight: FontWeight.w400,
                    fontSize: 14),
                activeColor: HexColor.orange,
                inactiveColor: Colors.black),
          ],
        ));
  }
}

