import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ftx/navigationX.dart';
import 'package:proj_site/common/colors/colors.dart';
import 'package:proj_site/common/image_constant/image_constant.dart';
import 'package:proj_site/common/widget_constant/widget_constant.dart';
import 'package:proj_site/cubits/auth_cubit.dart';
import 'package:proj_site/cubits/sub_project_list_cubit.dart';
import 'package:proj_site/helper/helper.dart';
import 'package:proj_site/view/subProjectList/asignUsers.dart';
import 'package:proj_site/view/subProjectList/viewSub%20Project.dart';

class AddNew extends StatefulWidget {
  static const id = 'AddNew_screen';
  String? projectName;


  AddNew({Key? key, this.projectName}) : super(key: key);

  @override
  _AddNewState createState() => _AddNewState();
}

class _AddNewState extends State<AddNew> {
  late SubProjectListCubit _subProjectListCubit;
  late AuthCubit authCub;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    authCub = BlocProvider.of<AuthCubit>(context);
    _subProjectListCubit = BlocProvider.of<SubProjectListCubit>(context);

    _subProjectListCubit.SubProjectList(projectIdMain, authCub.userInfoLogin!.mobileOrganizationId!, context);
  }

  _buildProject(
      {required String subProjectName, required String subProjectId}) {
    return Column(
      children: [
        Container(
          height: screenHeight(context, dividedBy: 22),
          width: screenWidth(context),
          color: Colors.transparent,
          child: Row(
            children: [
              SizedBox(
                width: screenWidth(context, dividedBy: 4),
                child: commonText(subProjectName,
                    color: Colors.black,
                    fontFamily: LexendRegular,
                    fontWeight: FontWeight.w400,
                    fontSize: 16),
              ),
              Spacer(),
              getIconWithUnderlineText(
                width: screenWidth(context, dividedBy: 5),
                text: "Edit",
                ctx: context,
                icon: icons.ic_eyes,
                iconColor: HexColor.aliceblue,
                textColor: HexColor.aliceblue,
                underlineColor: HexColor.aliceblue,
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ViewSubProject(
                        subProjectName: subProjectName,
                        projectId: projectIdMain,
                        orgId: authCub.userInfoLogin!.mobileOrganizationId!,
                        subProjectId: subProjectId,
                        projectName: widget.projectName,
                      )));
                },
              ),
              getIconWithUnderlineText(
                width: screenWidth(context, dividedBy: 3),
                text: "Assign Users",
                ctx: context,
                icon: icons.ic_assignUser,
                iconColor: HexColor.grren,
                textColor: HexColor.grren,
                underlineColor: HexColor.grren,
                onTap: () {

                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => AssignUsers(subProjectId: subProjectId, projectId: projectIdMain, projectName: widget.projectName,)));
                },
              )
            ],
          ),
        ),
        getDivider(height: 15)
      ],
    );
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
            getSimpleTwoRowTextAndButton(
                ctx: context,
                tittle1: "Sub Project List",
                tittle2: widget.projectName ?? "",
                buttonName: 'Add New',
              projectId: projectIdMain,
              orgId: authCub.userInfoLogin!.mobileOrganizationId!
            ),
            verticalSpaces(context, height: 20),
            Expanded(
              child: BlocBuilder<SubProjectListCubit, SubProjectListState>(
                builder: (context, state) {
                  if (state is SubProjectListLoading) {
                    return loader();
                  } else if (state is SubProjectListError) {
                    return errorLoadDataText();
                  } else if (_subProjectListCubit.subProjectList.length == 0) {
                    return noDataFoundText();
                  } else {
                    return ListView.builder(
                      padding: EdgeInsets.zero,
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: _subProjectListCubit.subProjectList.length,
                      itemBuilder: (context, index) {
                        return _buildProject(
                          subProjectName: _subProjectListCubit
                              .subProjectList[index].subProjectName
                              .toString(),
                          subProjectId: _subProjectListCubit
                              .subProjectList[index].id
                              .toString(),
                        );
                      },
                    );
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
