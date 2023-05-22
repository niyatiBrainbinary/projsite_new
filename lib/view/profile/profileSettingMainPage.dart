import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ftx/navigationX.dart';
import 'package:proj_site/common/colors/colors.dart';
import 'package:proj_site/common/widget_constant/widget_constant.dart';
import 'package:proj_site/cubits/auth_cubit.dart';
import 'package:proj_site/helper/helper.dart';
import 'package:proj_site/view/dashBoard.dart';
import 'package:proj_site/view/profile/changePasswordSetting.dart';
import 'package:proj_site/view/profile/editProfileSetting.dart';
import 'package:proj_site/view/profile/profileNotification.dart';
import 'package:proj_site/view/profile/settingsPage.dart';

class ProfileSettingMainPage extends StatefulWidget {
  static const id = 'ProfileSettingMainPage_screen';

  @override
  _ProfileSettingMainPageState createState() => _ProfileSettingMainPageState();
}

class _ProfileSettingMainPageState extends State<ProfileSettingMainPage>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  List<PopupMenuEntry<int>> popupMenuItems = [];
  int mainIndex = -1;
  int subIndex = -1;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
    _tabController?.addListener(() {
      if (_tabController!.indexIsChanging) {
        FocusScope.of(context).unfocus();
      }
    });

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
      child: Scaffold(
        body: getCommonContainer(
          color: Colors.transparent,
          padding: EdgeInsets.symmetric(horizontal: 15),
          margin: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + (kToolbarHeight * 0.1)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // getSimpleTwoTextWithTralingIcon(
              //     ctx: context,
              //     tittle1: 'Profile',
              //     tittle2: 'Robel Selemun',
              //     popupMenuItems: popupMenuItems,
              //   mainIndex: mainIndex,
              //   subIndex: subIndex
              // ),
              getCommonContainer(
                height: screenHeight(context, dividedBy: 15),
                width: screenWidth(context),
                color: Colors.transparent,
                alignment: Alignment.center,
                child: Row(
                  children: [
                    commonText("Profile",
                        color: Colors.black,
                        fontFamily: LexendBold,
                        fontWeight: FontWeight.w700,
                        fontSize: 20),
                  ],
                ),
              ),
              verticalSpaces(context, height: 100),
              getCommonTwoTabBar(
                  ctx: context,
                  controller: _tabController,
                  tab1: "Edit Profile",
                  tab2: "Settings",
                  // tab2: "Change Password",
                  // tab3: "Notification"
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: const [
                    EditProfileSetting(),
                    Settings()
                    // ChangePasswordSetting(),
                    // ProfileNotification()
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
