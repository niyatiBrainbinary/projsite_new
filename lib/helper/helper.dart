import 'package:flutter/material.dart';

Size screenSize(BuildContext context) {
  return MediaQuery.of(context).size;
}

double screenHeight(BuildContext context, {double dividedBy = 1}) {
  return screenSize(context).height / dividedBy;
}

double screenWidth(BuildContext context, {double dividedBy = 1}) {
  return screenSize(context).width / dividedBy;
}

const String LexendLight ='Lexend-Light';
const String LexendRegular ='Lexend-Regular';
const String LexendMedium ='Lexend-Medium';
const String LexendSemiBold ='Lexend-SemiBold';
const String LexendBold ='Lexend-Bold';
const String LexendExtraBold ='Lexend-ExtraBold';

String accessToken="";
String orgId="";
String mobileOrgId="";
String orgVal="";
String projectIdMain="";
List projectIdList2 = [];

Map? userInfoUpdate;

String googleMapKey = 'AIzaSyDtFavTh7_aJL9D3XGEmoFlIImXsibuREY';
final GlobalKey<ScaffoldMessengerState> rootScaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

PageController datePageController=PageController();
PageController chartPageController=PageController();
DateTime matchDate=DateTime.now();
int matchIndex=0;
bool isSwipe=false;




