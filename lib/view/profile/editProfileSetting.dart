import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proj_site/common/colors/colors.dart';
import 'package:proj_site/common/widget_constant/widget_constant.dart';
import 'package:proj_site/cubits/auth_cubit.dart';
import 'package:proj_site/helper/helper.dart';

class EditProfileSetting extends StatefulWidget {
  const EditProfileSetting({Key? key}) : super(key: key);

  @override
  State<EditProfileSetting> createState() => _EditProfileSettingState();
}

class _EditProfileSettingState extends State<EditProfileSetting> {
  List<TextEditingController> _controllers = [];
  List<String> hintText = ["First name", "Last name", "Phone", "Email"];

  TextEditingController firstNameCon = TextEditingController();
  TextEditingController lastNameCon = TextEditingController();
  TextEditingController phoneCon = TextEditingController();
  TextEditingController emailCon = TextEditingController();

  bool firstName = false;
  bool phone = false;
  bool phoneLength = false;

  List<bool> error = [];

  List<bool> enabled = [true, true, true, false];
  TextEditingController _company = TextEditingController();

  int totalItem = 4;
  late AuthCubit authCub;
  bool status=false;
  List controllersText=[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    authCub = BlocProvider.of<AuthCubit>(context);
    //  List controllersText=[authCub.userInfo!.userInfo!.firstName!,authCub.userInfo!.userInfo!.lastName!,authCub.userInfo!.userInfo!.phone!,authCub.userInfo!.userInfo!.email!];
    controllersText = [
      authCub.userInfo?.user?.firstName,
      (authCub.userInfo?.user?.lastName == "null") ? "" : authCub.userInfo?.user?.lastName,
      authCub.userInfo?.user?.phone,
      authCub.userInfo?.user?.email
    ];
    for (int i = 0; i < totalItem; i++) {
      _controllers.add(TextEditingController());
      _controllers[i].text = controllersText[i];
    }

    error = [firstName, false, phone, false];


    firstNameCon.text = authCub.userInfo?.user?.firstName ?? "";
    lastNameCon.text = (authCub.userInfo?.user?.lastName == "null") ? "" : authCub.userInfo?.user?.lastName ?? "";
    phoneCon.text = authCub.userInfo?.user?.phone ?? "";
    emailCon.text = authCub.userInfo?.user?.email ?? "";
  }


  // Widget _organization(){
  //   return   Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Row(
  //         children: [
  //           getRoundedCornerContainer(
  //               height: 43,
  //               width: 130,
  //               ctx: context,
  //               status: "Organization 1",
  //               textColor: HexColor.Gray53.withOpacity(0.7),
  //               fontSize: 14, boxColor: HexColor.Gray71.withOpacity(0.2)),
  //           horizontal(context, width: 30),
  //           getRoundedCornerContainer(
  //               height: 43,
  //               width: 130,
  //               ctx: context,
  //               status: "Organization 2",
  //               textColor:HexColor.Gray53.withOpacity(0.7),
  //               fontSize: 14, boxColor: HexColor.Gray71.withOpacity(0.2)),
  //         ],
  //       ),
  //       verticalSpaces(context, height: 80),
  //       getRoundedCornerContainer(
  //           height: 43,
  //           width: 130,
  //           ctx: context,
  //           status: "Organization 3",
  //           textColor:HexColor.Gray53.withOpacity(0.7),
  //           fontSize: 14, boxColor: HexColor.Gray71.withOpacity(0.2)),
  //     ],
  //   );
  // }

  Widget _organization(AuthCubit authCub) {
    return GridView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.only(top: 0,right: screenWidth(context,dividedBy: 5)),
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,mainAxisSpacing: 10,crossAxisSpacing: 10,childAspectRatio: 2.5),
      itemCount: authCub.userOrganization.length,
      itemBuilder: (context, index) {
      return getRoundedCornerContainer(
          ctx: context,
         // status: authCub.userInfo!.user!.projectInfos![index].projectName.toString(),
          status: authCub.userOrganization[index].organizationName!,
          textColor: authCub.userOrganization[index].organizationName! == orgVal?Colors.white:HexColor.Gray53.withOpacity(0.7),
          fontSize: 14,
          boxColor:authCub.userOrganization[index].organizationName! == orgVal?Colors.black.withOpacity(0.7):HexColor.yellow.withOpacity(0.3),
      );
    },);
  }

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        if (state is ProfileDetailsLoading) {
          return loader();
        } else if (state is ProfileDetailsError) {
          return errorLoadDataText();
        } else {
          return SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        commonText(
                            hintText[0],
                            color: Colors.black,
                            fontFamily: LexendRegular,
                            fontWeight: FontWeight.w400,
                            fontSize: 12),
                         SizedBox(width: 3),
                        (firstName ==true)?Text("*", style: TextStyle(fontSize: 14, color: Colors.red),):SizedBox()
                      ],
                    ),
                    verticalSpaces(context, height: 80),
                    getRoundedTexfield(
                        hintText: hintText[0],
                        maxline: 1,
                        controller: firstNameCon,
                        ctx: context
                    ),
                    (firstName ==true)?Column(
                      children: const [
                        SizedBox(height: 10,),
                        Text("First name required",style:TextStyle(
                          fontSize: 12,
                          fontFamily: LexendRegular,
                          color: Colors.red,
                        ),),
                      ],
                    ):const SizedBox(),
                    verticalSpaces(context, height: 80),
                    commonText(
                        hintText[1],
                        color: Colors.black,
                        fontFamily: LexendRegular,
                        fontWeight: FontWeight.w400,
                        fontSize: 12),
                    verticalSpaces(context, height: 80),

                    getRoundedTexfield(
                        hintText: hintText[1],
                        maxline: 1,
                        controller: lastNameCon,
                        ctx: context
                    ),
                    verticalSpaces(context, height: 80),
                  Row(
                    children: [
                      commonText(
                          hintText[2],
                          color: Colors.black,
                          fontFamily: LexendRegular,
                          fontWeight: FontWeight.w400,
                          fontSize: 12),
                      SizedBox(width: 3),
                      (phone ==true || phoneLength==true)?Text("*", style: TextStyle(fontSize: 14, color: Colors.red),):SizedBox()
                    ],
                  ),
                    verticalSpaces(context, height: 80),
                    getRoundedTexfield(
                        hintText: hintText[2],
                        maxline: 1,
                        controller: phoneCon,
                        ctx: context,
                        maxLength: 10,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        textInputType: TextInputType.phone,
                    ),
                    (phone ==true || phoneLength==true)?Column(
                      children:  [
                        const  SizedBox(height: 10,),
                        Text((phoneLength==true)?"Invalid phone":"Phone number required",style:const TextStyle(
                          fontSize: 12,
                          fontFamily: LexendRegular,
                          color: Colors.red,
                        ),),
                      ],
                    ):const SizedBox(),
                    verticalSpaces(context, height: 80),
                    commonText(
                        hintText[3],
                        color: Colors.black,
                        fontFamily: LexendRegular,
                        fontWeight: FontWeight.w400,
                        fontSize: 12),
                    verticalSpaces(context, height: 80),
                    getRoundedTexfield(
                        hintText: hintText[3],
                        maxline: 1,
                        enabled: false,
                        controller: emailCon,
                        ctx: context
                    ),
                    verticalSpaces(context, height: 80),


                  ],
                ),
                /*ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  itemCount: _controllers.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return getCommonContainer(
                      height: screenHeight(context, dividedBy: 9),
                      width: screenWidth(context),
                      color: Colors.transparent,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          commonText(
                              hintText[index],
                              color: Colors.black,
                              fontFamily: LexendRegular,
                              fontWeight: FontWeight.w400,
                              fontSize: 12),
                          verticalSpaces(context, height: 80),
                          getRoundedTexfield(
                              //errorText: "dsfdg",
                              hintText: hintText[index],
                              maxline: 1,
                              enabled: enabled[index],
                              controller: _controllers[index],
                              ctx: context
                          ),


                        ],
                      ),
                    );
                  },
                ),*/
                commonText("Roles",
                    color: Colors.black,
                    fontFamily: LexendRegular,
                    fontWeight: FontWeight.w400,
                    fontSize: 14),
                verticalSpaces(context, height: 80),
                // GridView.builder(
                //   shrinkWrap: true,
                //   padding: EdgeInsets.only(
                //       top: 0, right: screenWidth(context, dividedBy: 5)),
                //   physics: NeverScrollableScrollPhysics(),
                //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                //       crossAxisCount: 2,
                //       mainAxisSpacing: 10,
                //       crossAxisSpacing: 10,
                //       childAspectRatio: 2.5),
                //   itemCount: authCub.userInfo!.roles.length,
                //   itemBuilder: (context, index) {
                //     return getRoundedCornerContainer(
                //         border: Border.all(color: HexColor.yellow),
                //         height: 43,
                //         width: 130,
                //         ctx: context,
                //         // status: authCub.userInfo1!.roles![index].role.toString(),
                //         status: authCub.userInfo!.roles![index].role.toString(),
                //         boxColor: HexColor.yellow.withOpacity(0.3),
                //         textColor: Colors.black,
                //         fontSize: 14);
                //   },
                // ),
                getRoundedCornerContainer(
                    border: Border.all(color: HexColor.yellow),
                    height: 43,
                    width: 130,
                    ctx: context,
                    status: authCub.role!.role.toString(),
                    boxColor: HexColor.yellow.withOpacity(0.3),
                    textColor: Colors.black,
                    fontSize: 14),
                verticalSpaces(context, height: 60),
                commonText("Company",
                    color: Colors.black,
                    fontFamily: LexendRegular,
                    fontWeight: FontWeight.w400,
                    fontSize: 12),
                verticalSpaces(context, height: 80),
                getRoundedCornerContainer(
                    border: Border.all(color: HexColor.yellow),
                    height: 43,
                    width: 130,
                    ctx: context,
                    status: "Company",
                    boxColor: HexColor.yellow.withOpacity(0.3),
                    textColor: Colors.black,
                    fontSize: 14),
                // getRoundedTexfield(
                //     hintText: "Company", controller: _company, ctx: context,readOnly: true),
                verticalSpaces(context, height: 60),
                commonText("Organization",
                    color: Colors.black,
                    fontFamily: LexendRegular,
                    fontWeight: FontWeight.w400,
                    fontSize: 12),
                verticalSpaces(context, height: 80),
                _organization(authCub),
                verticalSpaces(context, height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // commonButton(context: context,
                    //     buttonName: "Cancel",
                    //     buttonColor: HexColor.Gray71.withOpacity(0.4)),
                    BlocBuilder<AuthCubit, AuthState>(
                      builder: (context, state) {

                        if(state is EditProfileLoading){
                          return commonLoadingButton(context: context);
                        } else {
                          return commonButton(context: context, buttonName: "Submit",
                              onTap: (){

                                List status = context.read<AuthCubit>().showError(firstNameCon.text.trim(),
                                    lastNameCon.text.trim(), phoneCon.text.trim()
                                    ,emailCon.text.trim(), context, controllersText.toString());

                                phone = status[2]['phone'];
                                firstName = status[1]['firstName'];
                                phoneLength = status[3]['phoneLength'];

                                if(status[0]['All'] == false&& status[2]['phone'] == false&&status[1]['firstName'] == false&&status[3]['phoneLength']== false)
                                  {
                                    FocusScope.of(context).unfocus();
                                    List finalText=[];

                                    finalText.add(firstNameCon.text);
                                    finalText.add(lastNameCon.text);
                                    finalText.add(phoneCon.text);
                                    finalText.add(emailCon.text);
                                    authCub.editProfile(
                                        authCub.userInfo!.user!.id!,
                                        firstNameCon.text,
                                        lastNameCon.text,
                                        phoneCon.text,
                                        emailCon.text,
                                        finalText.toString()== controllersText.toString()?false:true);
                                  }
                              });
                        }
                      },
                    ),

                  ],
                ),
                verticalSpaces(context, height: 80),
              ],
            ),
          );
        }
      },
    );
  }
}
