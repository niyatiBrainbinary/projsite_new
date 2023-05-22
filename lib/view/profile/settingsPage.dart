import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ftx/navigationX.dart';
import 'package:proj_site/common/colors/colors.dart';
import 'package:proj_site/common/image_constant/image_constant.dart';
import 'package:proj_site/common/widget_constant/widget_constant.dart';
import 'package:proj_site/cubits/auth_cubit.dart';
import 'package:proj_site/helper/helper.dart';
import 'package:proj_site/services/sharedpreference_service.dart';
import 'package:proj_site/view/signIn.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final List<String> _languageList = ["English", "Svenska"];
  final List<String> _dropdownValues = [];
  String? _languageVal;
  String? _organizationVal;
  bool isBox = false;
  String? organisation;
  SharedPreferenceService prefs = SharedPreferenceService();
  late AuthCubit authCub;

  // _dropDownItems(List<String> list) {
  //   return list
  //       .map((String val) => DropdownMenuItem<String>(
  //             value: val,
  //             child: Row(
  //               children: [
  //                 Text(val,
  //                     style: TextStyle(
  //                         color: val =="English"&& context.locale == Locale('en') || val =="Swedish" && context.locale == Locale('sv')
  //                             ? HexColor.orange
  //                             : Colors.black)),
  //               ],
  //             ),
  //           ))
  //       .toList();
  // }

  _dropDownItems(List<String> list, String val) {
    return list.map((item) {
      if (item == val) {
        return DropdownMenuItem(
          value: item,
          child: Row(
            children: [
              Text(
                item,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  fontFamily: LexendRegular,
                  color: HexColor.orange,
                ),
              ),
              SizedBox(width: 5,),
              Icon(Icons.check,
                  color: HexColor.orange),
            ],
          ),
        );
      } else {
        return DropdownMenuItem(
          value: item,
          child: Text(
            item,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              fontFamily: LexendRegular,
              color: Colors.black,
            ),
          ),
        );
      }
    }).toList();
  }


  _getDropDownButton({
    required BuildContext ctx,
    required List<String> items,
    Function? onChanged,
    String? value,
   // List<Widget>Function(BuildContext)? selectedItemBuilder
  }) {
    return Container(
      height: screenHeight(ctx, dividedBy: 15),
      width: screenWidth(ctx),
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          border:
              Border.all(color: HexColor.Gray53.withOpacity(0.6), width: 1.5)),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          icon: Image.asset(icons.ic_downArrow, height: 7),
          items: _dropDownItems(items,value.toString()),
          onChanged: onChanged as void Function(Object?)?,
          isExpanded: true,
          value: value,
          selectedItemBuilder: (BuildContext context) {
            return items.map<Widget>((String item) {
              return DropdownMenuItem(value: item, child: Text(
                item,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  fontFamily: LexendRegular,
                  color: Colors.black,
                ),
              ));
            }).toList();
          },
        ),
      ),
    );
  }

  logoutDialog(){
    showDialog(
      context: context,
      builder: (context) {
        return Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            children: [
              const Spacer(),
              Center(
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                      BorderRadius.circular(
                          10)),
                  padding:
                  const EdgeInsets.only(
                      left: 15,
                      right: 15,
                      top: 15,
                      bottom: 30),
                  margin: EdgeInsets.symmetric(
                      horizontal: 15),
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment
                        .start,
                    children: [
                      Align(
                          alignment: Alignment
                              .centerRight,
                          child: IconButton(
                              padding:
                              EdgeInsets
                                  .zero,
                              constraints:
                              BoxConstraints(),
                              onPressed: () {
                                Navigation
                                    .instance
                                    .goBack();
                              },
                              icon: Icon(
                                Icons
                                    .cancel_outlined,
                                color: HexColor
                                    .Gray53,
                              ))),
                      commonText(
                          "Log Out",
                          color: Colors.black,
                          fontFamily:
                          LexendRegular,
                          fontWeight:
                          FontWeight.w500,
                          fontSize: 20),
                      verticalSpaces(context,
                          height: 30),
                      commonText(
                          "Are you sure you want to logout?",
                          color: Colors.black,
                          textAlign:
                          TextAlign.center,
                          fontFamily:
                          LexendRegular,
                          fontWeight:
                          FontWeight.w400,
                          fontSize: 15),
                      verticalSpaces(context,
                          height: 25),
                      Row(
                        mainAxisAlignment:
                        MainAxisAlignment
                            .center,
                        children: [
                          commonButton(
                              context: context,
                              buttonName:
                              "close",
                              buttonColor: HexColor
                                  .Gray53
                                  .withOpacity(
                                  0.5),
                              onTap: () {
                                Navigator.pop(
                                    context);
                              }),
                          horizontal(context,
                              width: 10),
                          commonButton(
                              context: context,
                              buttonName:
                              "Logout",
                              onTap: () {
                                snackBar("Logout Successfully", true);
                                prefs.remove("userInfo");
                                prefs.remove("userId");
                                prefs.remove("role");
                                prefs.remove("userOrganization");
                                prefs.remove("accessToken");
                                prefs.remove("organizationId");
                                prefs.remove("organizationVal");
                                prefs.remove("mobile_organization_id");
                                authCub.userOrganization = [];
                                context.setLocale(Locale('en'));
                                Navigation.instance.navigateAndRemoveUntil(SignIn.id);
                              })
                        ],
                      )
                    ],
                  ),
                ),
              ),
              const Spacer(),
            ],
          ),
        );
      },
    );
  }

  // _getDropDownButton({
  //   required BuildContext ctx,
  //   required List<String> items,
  //   required String hitText,
  //   required Color color,
  //   Function? onChanged,
  //   String? value,
  //   List<Widget>Function(BuildContext)? selectedItemBuilder
  // }) {
  //   return Container(
  //     height: screenHeight(ctx, dividedBy: 15),
  //     width: screenWidth(ctx),
  //     padding: EdgeInsets.symmetric(horizontal: 10),
  //     decoration: BoxDecoration(
  //         borderRadius: BorderRadius.circular(10.0),
  //         border:
  //         Border.all(color: HexColor.Gray53.withOpacity(0.6), width: 1.5)),
  //     child: DropdownButtonHideUnderline(
  //       child: DropdownButton(
  //         hint: Text(
  //           hitText,
  //           style: TextStyle(
  //             fontSize: 14,
  //             fontWeight: FontWeight.w400,
  //             fontFamily: LexendRegular,
  //             color: HexColor.Gray53,
  //           ),
  //         ),
  //         icon: Image.asset(icons.ic_downArrow, height: 7),
  //         items: _dropDownItems(items),
  //         onChanged: onChanged as void Function(Object?)?,
  //         isExpanded: true,
  //         value: value,
  //         selectedItemBuilder: selectedItemBuilder,
  //         style: TextStyle(
  //           color: color,
  //           fontFamily: LexendRegular,
  //           fontWeight: FontWeight.w400,
  //         ),
  //       ),
  //     ),
  //   );
  // }

  @override
  void initState() {

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      authCub = BlocProvider.of<AuthCubit>(context);
      if (context.locale == Locale('en')) {
        _languageVal = "English";
      } else {
        _languageVal = "Svenska";
      }
      for (int i = 0; i < authCub.userOrganization.length; i++) {
        _dropdownValues.add(authCub.userOrganization[i].organizationName.toString());
      }

      _organizationVal=orgVal;

      setState(() {});

    });


    super.initState();
  }

  setOrganization(String orgVal){
    for(int i =0; i<authCub.userOrganization.length ;i++){
      if(orgVal == authCub.userOrganization[i].organizationName){
        String id = authCub.userOrganization[i].organizationId.toString();
        String mId = authCub.userInfoLogin!.mobileOrganizationId.toString();
        log("id$id");
        log("orgVal$orgVal");
        log("orgid$orgId");
        prefs.setStringData('organizationId', id);
        orgId = id;
        mobileOrgId = mId;

        projectIdList2 = authCub.userInfoLogin!.adminProjects!;

        authCub.updateOrg(id, authCub.userInfoLogin!.userId!);

      }
    }
  }

  @override
  Widget build(BuildContext context) {
    print("lang ${_languageVal}");
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        commonText("Organization",
            color: Colors.black,
            fontFamily: LexendRegular,
            fontWeight: FontWeight.w400,
            fontSize: 13),
        verticalSpaces(context, height: 80),
        _getDropDownButton(
            ctx: context,
            items: _dropdownValues,
            value: _organizationVal,
            onChanged: (val) async {
              // log("index${index}");
              _organizationVal = val;
               prefs.setStringData('organizationVal',val);
               orgVal = val;
              setOrganization(val);
              setState(() {});
            }),
        verticalSpaces(context, height: 40),
        commonText("Language",
            color: Colors.black,
            fontFamily: LexendRegular,
            fontWeight: FontWeight.w400,
            fontSize: 13),
        verticalSpaces(context, height: 80),
        _getDropDownButton(
            ctx: context,
            items: _languageList,
            value: _languageVal,
            onChanged: (val) {
              _languageVal = val;
              if (_languageVal == "English") {
                context.setLocale(Locale('en'));
              } else {
                context.setLocale(Locale('sv'));
              }
              setState(() {});
            }),
        verticalSpaces(context, height: 30),
        Align(
          alignment: Alignment.center,
          child: commonButton(
              context: context, buttonName: "Logout", onTap: () {
                logoutDialog();
          }),
        )
      ],
    );
  }
}

// class Settings extends StatefulWidget {
//   const Settings({Key? key}) : super(key: key);
//
//   @override
//   State<Settings> createState() => _SettingsState();
// }
//
// class _SettingsState extends State<Settings> {
//   final List<String> _languageList = ["English", "Swedish"];
//   final List<String> _dropdownValues = ["One", "Two", "Three", "Four", "Five"];
//   String? _languageVal;
//   String? _organizationVal;
//   Color _color = Colors.black;
//
//   _dropDownItems(List<String> list) {
//     return list
//         .map((String val) => DropdownMenuItem<String>(
//       value: val,
//       child: Row(
//         children: [
//           Text(val,
//               style: TextStyle(
//                   color: val =="English"&& context.locale == Locale('en') || val =="Swedish" && context.locale == Locale('sv')
//                       ? HexColor.orange
//                       : Colors.black)),
//         ],
//       ),
//     ))
//         .toList();
//   }
//
//   _getDropDownButton({
//     required BuildContext ctx,
//     required List<String> items,
//     required String hitText,
//     required Color color,
//     Function? onChanged,
//     String? value,
//   }) {
//     return Container(
//       height: screenHeight(ctx, dividedBy: 15),
//       width: screenWidth(ctx),
//       padding: EdgeInsets.symmetric(horizontal: 10),
//       decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(10.0),
//           border:
//           Border.all(color: HexColor.Gray53.withOpacity(0.6), width: 1.5)),
//       child: DropdownButtonHideUnderline(
//         child: DropdownButton(
//           hint: Text(
//             hitText,
//             style: TextStyle(
//               fontSize: 14,
//               fontWeight: FontWeight.w400,
//               fontFamily: LexendRegular,
//               color: HexColor.Gray53,
//             ),
//           ),
//           icon: Image.asset(icons.ic_downArrow, height: 7),
//           items: _dropDownItems(items),
//           onChanged: onChanged as void Function(Object?)?,
//           isExpanded: true,
//           value: value,
//           style: TextStyle(
//             color: color,
//             fontFamily: LexendRegular,
//             fontWeight: FontWeight.w400,
//           ),
//         ),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         commonText("Organization",
//             color: Colors.black,
//             fontFamily: LexendRegular,
//             fontWeight: FontWeight.w400,
//             fontSize: 13),
//         verticalSpaces(context, height: 80),
//         _getDropDownButton(
//             ctx: context,
//             items: _dropdownValues,
//             hitText: "",
//             color: Colors.black,
//             value: _organizationVal,
//             onChanged: (val) {
//               _organizationVal = val;
//               setState(() {});
//             }),
//         verticalSpaces(context, height: 40),
//         commonText("Language",
//             color: Colors.black,
//             fontFamily: LexendRegular,
//             fontWeight: FontWeight.w400,
//             fontSize: 13),
//         verticalSpaces(context, height: 80),
//         _getDropDownButton(
//             ctx: context,
//             items: _languageList,
//             hitText: "",
//             color: _color,
//             value: _languageVal,
//             onChanged: (val) {
//               _languageVal = val;
//               if (_languageVal == "English") {
//                 context.setLocale(Locale('en'));
//               } else {
//                 context.setLocale(Locale('sv'));
//               }
//               // if (context.locale == Locale('en') && _languageVal == "English") {
//               //   _color = HexColor.orange;
//               // } else {
//               //   _color = Colors.black;
//               // }
//               setState(() {});
//             }),
//         verticalSpaces(context, height: 30),
//         Align(
//           alignment: Alignment.center,
//           child: commonButton(
//               context: context, buttonName: "Logout", onTap: () {}),
//         )
//       ],
//     );
//   }
// }
