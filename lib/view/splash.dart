import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ftx/navigationX.dart';
import 'package:proj_site/api%20service/models/auth_models/sign_in_model.dart';
import 'package:proj_site/common/image_constant/image_constant.dart';
import 'package:proj_site/cubits/auth_cubit.dart';
import 'package:proj_site/helper/helper.dart';
import 'package:proj_site/services/sharedpreference_service.dart';
import 'package:proj_site/view/dashBoard.dart';
import 'package:proj_site/view/signIn.dart';


class Splash extends StatefulWidget {
  static const id = 'Splash_screen';
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  SharedPreferenceService prefs=SharedPreferenceService();
  bool status=false;

  loadUserData() async {
    final authCub = BlocProvider.of<AuthCubit>(context);

    Map json1 = jsonDecode(await prefs.getStringData('userInfo') as String);
    authCub.userInfoLogin =UserInfo.fromJson(json1 as Map<String, dynamic>);

    Map json2 = jsonDecode(await prefs.getStringData('role') as String);
    authCub.role =Role.fromJson(json2 as Map<String, dynamic>);

    List<String> userOrganization1= await prefs.getListData('userOrganization') as List<String>;
    authCub.userOrganization=[];
    for(int i=0; i<userOrganization1.length;i++){
      Map json3 = jsonDecode(userOrganization1[i]);
      authCub.userOrganization.add(UserOrganization.fromJson(json3 as Map<String, dynamic>));
    }
    log("${authCub.userOrganization}");

  }

  loadData() async {
    final authCub = BlocProvider.of<AuthCubit>(context);
    accessToken = (await prefs.getStringData("accessToken")).toString();
    String userId = (await prefs.getStringData("userId")).toString();
   // String organizationId = (await prefs.getStringData("organizationId")).toString();
    orgId = (await prefs.getStringData("organizationId")).toString();
    orgVal = (await prefs.getStringData("organizationVal")).toString();
    Future.delayed(const Duration(seconds: 3)).then((_) async {
      if (accessToken == "" || accessToken == "null") {
        Navigation.instance.navigateAndReplace(SignIn.id);
      } else {
        loadUserData();
        authCub.profileDetails(userId, orgId);
        Navigation.instance.navigateAndReplace(DashBoard.id);
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: Container(
         height: screenHeight(context),
           width: screenWidth(context),
           child: Image.asset(images.splashScreenImg,fit: BoxFit.cover)
       ),
    );
  }
}
