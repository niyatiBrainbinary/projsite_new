import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ftx/navigationX.dart';
import 'package:proj_site/common/colors/colors.dart';
import 'package:proj_site/common/image_constant/image_constant.dart';
import 'package:proj_site/common/widget_constant/widget_constant.dart';
import 'package:proj_site/cubits/auth_cubit.dart';
import 'package:proj_site/cubits/project_list_cubit.dart';
import 'package:proj_site/helper/helper.dart';
import 'package:proj_site/view/dashBoard.dart';
import 'package:proj_site/view/projectName.dart';
import 'package:proj_site/view/project/projectSettingMainPage.dart';
import 'package:proj_site/view/projectName.dart';
import 'package:proj_site/view/subProjectList/addNew.dart';

class ProjectList extends StatefulWidget {
  static const id = 'ProjectList_screen';

  const ProjectList({Key? key}) : super(key: key);

  @override
  State<ProjectList> createState() => _ProjectListState();
}

Widget getExpandedRowText({required String sub1, required String sub2}) {
  return getSimpleRowText(sub1: sub1, sub2: sub2);
}

class _ProjectListState extends State<ProjectList> {
  late ProjectListCubit _projectListCubit;
  late AuthCubit authCub;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    authCub = BlocProvider.of<AuthCubit>(context);
    _projectListCubit = BlocProvider.of<ProjectListCubit>(context);

    _projectListCubit.ProjectList(projectIdMain, authCub.userInfoLogin!.toJson(), context);
  }

  _projectList({
    required String projectName,
    required String Id,
    required String location,
    required String admin,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        getExpandedRowText(sub1: "Project Name", sub2: projectName),
        getExpandedRowText(sub1: "Location", sub2: location),
        getExpandedRowText(sub1: "Project Admin", sub2: admin),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            getIconWithUnderlineText(
              ctx: context,
              icon: icons.ic_eyes,
              iconColor: HexColor.aliceblue,
              textColor: HexColor.aliceblue,
              underlineColor: HexColor.aliceblue,
              text: 'View',
              width: screenWidth(context, dividedBy: 5),
              height: screenHeight(context, dividedBy: 28),
              onTap: () {
                // Navigation.instance.navigate(ProjectSettingMainPage.id);
                projectIdMain = Id;
                setState(() {});

                //Navigation.instance.navigate(AddNew.id);

                //Navigation.instance.navigate(ProjectName.id, args: projectName);

                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ProjectName(name: projectName)));
              },
            ),
            getIconWithUnderlineText(
              ctx: context,
              icon: icons.ic_setting,
              iconColor: HexColor.orange,
              textColor: HexColor.orange,
              underlineColor: HexColor.orange,
              text: 'Settings',
              width: screenWidth(context, dividedBy: 4),
              height: screenHeight(context, dividedBy: 40),
              onTap: () {

                projectIdMain = Id;
                setState(() {});
                // Navigation.instance.navigate(ProjectSettingMainPage.id);
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ProjectSettingMainPage(
                          name: projectName,
                        )));
              },
            ),
            getIconWithUnderlineText(
              ctx: context,
              icon: icons.ic_eyes,
              iconColor: HexColor.lavender,
              textColor: HexColor.lavender,
              underlineColor: HexColor.lavender,
              text: 'View Sub Project',
              width: screenWidth(context, dividedBy: 2.5),
              height: screenHeight(context, dividedBy: 40),
              onTap: () {

                projectIdMain = Id;
                setState(() {});
                //Navigation.instance.navigate(AddNew.id);
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => AddNew(
                      projectName: projectName
                    )));
              },
            ),
          ],
        ),
        verticalSpaces(context, height: 100),
        getDivider(height: 15),
      ],
    );
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
          padding: EdgeInsets.symmetric(horizontal: 15),
          margin: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + (kToolbarHeight * 0.1)),
          child: Column(
            children: [
              getCommonContainer(
                height: screenHeight(context, dividedBy: 15),
                width: screenWidth(context),
                color: Colors.transparent,
                alignment: Alignment.center,
                child: Row(
                  children: [
                    commonText("Project List",
                        color: Colors.black,
                        fontFamily: LexendBold,
                        fontWeight: FontWeight.w700,
                        fontSize: 20),
                  ],
                ),
              ),
              Expanded(
                child: BlocBuilder<ProjectListCubit, ProjectListState>(
                  builder: (context, state) {
                    if (state is ProjectListLoading) {
                      return loader();
                    } else if (state is ProjectListError) {
                      return errorLoadDataText();
                    } else if (_projectListCubit.projectsList.length == 0) {
                      return noDataFoundText();
                    } else {
                      return ListView.builder(
                        padding: EdgeInsets.zero,
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: _projectListCubit.projectsList.length,
                        itemBuilder: (context, index) {
                          return getCommonContainer(
                              height: screenHeight(context, dividedBy: 5.5),
                              width: screenWidth(context),
                              color: Colors.transparent,
                              child: _projectList(
                                projectName: _projectListCubit
                                    .projectsList[index].projectName,
                                Id: _projectListCubit.projectsList[index].id,
                                location: _projectListCubit
                                    .projectsList[index].projectLocation,
                                admin: _projectListCubit
                                    .organization[index].firstName,
                              ));
                        },
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ));
  }
}
