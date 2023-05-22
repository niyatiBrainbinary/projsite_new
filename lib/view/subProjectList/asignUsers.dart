import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proj_site/common/colors/colors.dart';
import 'package:proj_site/common/image_constant/image_constant.dart';
import 'package:proj_site/common/widget_constant/widget_constant.dart';
import 'package:proj_site/cubits/auth_cubit.dart';
import 'package:proj_site/cubits/sub_project_user_list_cubit.dart';
import 'package:proj_site/helper/helper.dart';

class AssignUsers extends StatefulWidget {
  static const id = 'AssignUsers_screen';
  String? subProjectId;
  String? projectId;
  String? projectName;

  AssignUsers({Key? key, this.subProjectId, this.projectId, this.projectName}) : super(key: key);

  @override
  _AssignUsersState createState() => _AssignUsersState();
}

class _AssignUsersState extends State<AssignUsers> {

  List _dropdownValues = ["One", "Two", "Three", "Four", "Five"];

  late SubProjectUserListCubit _subProjectUserListCubit;
  late AuthCubit authCub;

  var dropDownVal;
  var userId;

  @override
  void initState() {

    // TODO: implement initState

    super.initState();
    authCub = BlocProvider.of<AuthCubit>(context);
    _subProjectUserListCubit = BlocProvider.of<SubProjectUserListCubit>(context);
    _subProjectUserListCubit.userListDropDown = [];
    _subProjectUserListCubit.UserListDropDown(widget.projectId ?? "");
    _subProjectUserListCubit.SubProjectUserList(widget.subProjectId ?? "",
        authCub.userInfoLogin!.mobileOrganizationId!, context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBarWithIcon(ctx: context) as PreferredSizeWidget?,
      body: getCommonContainer(
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            getSimpleTwoRowText(
                ctx: context,
                tittle1: "Sub Project List",
                tittle2: widget.projectName ?? ""),
            verticalSpaces(context, height: 20),
            Row(
              children: [
                BlocBuilder<SubProjectUserListCubit, SubProjectUserListState>(
                  builder: (context, state) {
                    if (state is SubProjectUserListLoading) {
                      return SizedBox();
                    } else if (_subProjectUserListCubit.userListDropDown.length ==
                        0) {
                      return noDataFoundText();
                    } else {
                      return Expanded(
                        child: Container(
                          height: 50,
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7.0),
                              border: Border.all(
                                  color: HexColor.Gray53.withOpacity(0.6),
                                  width: 1.5)),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              hint: Text('Select user'),
                              icon: Image.asset(icons.ic_downArrow, height: 7),
                              items: _subProjectUserListCubit.userListDropDown
                                  .map((value) {
                                    return DropdownMenuItem(
                                      child: Text(value["name"]!),
                                      value: value["name"]!,
                                    );
                              }).toList(),
                              onChanged: (value) {
                                print(value.runtimeType);
                                print(value);
                                dropDownVal = value!;
                                 _subProjectUserListCubit.userListDropDown.forEach((element) {
                                   if(element["name"] == value){
                                     userId = element["id"];
                                   }

                                 });
                                setState(() {});
                              },
                              isExpanded: true,
                              value: dropDownVal,
                            ),
                          ),
                        ),
                      );
                    }
                  },
                ),
                horizontal(context, width: 70),
                commonButton(
                  context: context,
                  buttonName: "Assign",
                  onTap: () {
                    if(userId == null){
                      snackBar("Please select user", false);
                    }else{
                      _subProjectUserListCubit.AssignUser(
                        context: context,
                        orgId: authCub
                            .userInfoLogin!.mobileOrganizationId!,
                        subProjectId: widget.subProjectId ?? "",
                        userId: userId??"",
                      );
                    }

                  },
                ),
              ],
            ),
            verticalSpaces(context, height: 13),
            commonText("Assigned Users",
                color: HexColor.Gray53,
                fontFamily: LexendBold,
                fontWeight: FontWeight.w800,
                fontSize: 14),
            verticalSpaces(context, height: 30),
            Expanded(
              child:
                  BlocBuilder<SubProjectUserListCubit, SubProjectUserListState>(
                builder: (context, state) {
                  if (state is SubProjectUserListLoading) {
                    return loader();
                  } else if (state is SubProjectUserListError) {
                    return errorLoadDataText();
                  } else if (_subProjectUserListCubit
                          .subProjectUserList.length ==
                      0) {
                    return noDataFoundText();
                  } else {
                    return ListView.builder(
                      itemCount:
                          _subProjectUserListCubit.subProjectUserList.length,
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                commonText(
                                    "${_subProjectUserListCubit.subProjectUserList[index].firstName.toString()} ${_subProjectUserListCubit.subProjectUserList[index].lastName.toString()}",
                                    color: Colors.black,
                                    fontFamily: LexendRegular,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16),
                                getIconWithUnderlineText(
                                    onTap: () {
                                      _showDilaogue(context, index);
                                    },
                                    text: "Remove",
                                    ctx: context,
                                    icon: icons.ic_assignUser,
                                    iconColor: HexColor.carnation,
                                    textColor: HexColor.carnation,
                                    underlineColor: HexColor.carnation),
                              ],
                            ),
                            getDivider(height: 20)
                          ],
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

  _showDilaogue(BuildContext context, int index) {
    showDialog(
      barrierColor: Colors.black.withOpacity(0.4),
      barrierDismissible: false,
      builder: (context) {
        return Container(
          child: AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            contentPadding:
                EdgeInsets.only(left: 18, right: 18, top: 18, bottom: 18),
            content: Container(
              height: screenHeight(context, dividedBy: 5),
              width: screenWidth(context),
              color: Colors.transparent,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Center(
                    child: Text(
                      "Are you sure, you want to un-assign this user?",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: LexendRegular,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      commonButton(
                          context: context,
                          buttonName: "close",
                          width: 95,
                          buttonColor: HexColor.Gray53.withOpacity(0.5),
                          onTap: () {
                            Navigator.pop(context);
                          }),
                      BlocBuilder<SubProjectUserListCubit,
                          SubProjectUserListState>(
                        builder: (context, state) {
                          if (state is RemoveUserLoading) {
                            return commonLoadingButton(
                                context: context, width: 95);
                          } else {
                            return commonButton(
                                context: context,
                                buttonName: "Remove",
                                width: 95,
                                onTap: () {
                                  _subProjectUserListCubit.RemoveUser(
                                    context: context,
                                    orgId: authCub
                                        .userInfoLogin!.mobileOrganizationId!,
                                    subProjectId: widget.subProjectId ?? "",
                                    userId: _subProjectUserListCubit
                                        .subProjectUserList[index].userId
                                        .toString(),
                                  );
                                });
                          }
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
      context: context,
    );
  }
}
