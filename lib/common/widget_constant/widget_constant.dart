import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ftx/navigationX.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:proj_site/common/colors/colors.dart';
import 'package:proj_site/common/image_constant/image_constant.dart';
import 'package:proj_site/cubits/auth_cubit.dart';
import 'package:proj_site/cubits/logistic_list_cubit.dart';
import 'package:proj_site/cubits/transport_request_cubit.dart';
import 'package:proj_site/helper/helper.dart';
import 'package:proj_site/utility/innerShadow.dart';
import 'package:proj_site/view/booking_history.dart';
import 'package:proj_site/view/logisticList/updateTransportRequestShipment.dart';
import 'package:proj_site/view/projectName/calenderView.dart';
import 'package:proj_site/view/subProjectList/submitProjectList.dart';
import 'package:shimmer/shimmer.dart';

Widget commonText(
  String text, {
  required Color color,
  required fontFamily,
  required FontWeight fontWeight,
  required double fontSize,
  int? maxLines,
  TextDecoration? decoration,
  Color? decorationColor,
  TextAlign? textAlign,
  double? minFontSize,
  double? maxFontSize,
  TextOverflow? overflow,
}) {
  return AutoSizeText(
    text.tr(),
    style: TextStyle(
        color: color,
        fontFamily: fontFamily,
        fontWeight: fontWeight,
        decoration: decoration,
        overflow: overflow,
        decorationColor: decorationColor,
        fontSize: fontSize),
    maxLines: maxLines,
    minFontSize: minFontSize ?? fontSize - 2,
    maxFontSize: maxFontSize ?? fontSize + 2,
    textAlign: textAlign,
  );
}

Widget verticalSpaces(BuildContext context, {required double height}) {
  return SizedBox(
    height: screenHeight(context, dividedBy: height),
  );
}

Widget horizontal(BuildContext context, {required double width}) {
  return SizedBox(
    width: screenWidth(context, dividedBy: width),
  );
}

Widget obsecure(BuildContext context,
    {Function? onTap, required bool obscureText}) {
  return GestureDetector(
    onTap: onTap as void Function()?,
    child: Container(
        width: screenHeight(context, dividedBy: 40),
        color: Colors.transparent,
        margin: EdgeInsets.only(
          right: screenHeight(context, dividedBy: 30),
        ),
        child: obscureText == false
            ? Icon(
                Icons.visibility,
                color: Colors.black.withOpacity(0.6),
              )
            : Icon(
                Icons.visibility_off,
                color: Colors.black.withOpacity(0.6),
              )),
  );
}

Widget commonTextfield(
    {required BuildContext context,
    TextInputType? textInputType,
    required TextEditingController controller,
    required String hintText,
    required Color HColor,
    required FontWeight HfontWeight,
    required String HfontFamily,
    required double HfontSize,
    required String icon,
    Function? suffixOnTap,
    bool obscureText = false,
    TextAlignVertical? textAlignVertical}) {
  return Container(
    height: screenHeight(context, dividedBy: 13),
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(color: Colors.white),
      boxShadow: [
        BoxShadow(
            color: HexColor.Gray53.withOpacity(0.3),
            blurRadius: 5,
            offset: Offset(1, 1),
            spreadRadius: 1),
        BoxShadow(
            color: Colors.white.withOpacity(0.1),
            blurRadius: 5,
            offset: Offset(-1, -1),
            spreadRadius: 1)
      ],
      borderRadius: BorderRadius.circular(15),
    ),
    child: TextField(
        keyboardType: textInputType ?? TextInputType.text,
        controller: controller,
        textAlignVertical: textAlignVertical,
        cursorColor: Colors.black45,
        obscureText: obscureText,
        decoration: InputDecoration(
          border: InputBorder.none,
          enabled: true,
          labelText: hintText,
          labelStyle: TextStyle(
              color: HColor,
              fontWeight: HfontWeight,
              fontFamily: HfontFamily,
              fontSize: HfontSize),
          prefixIcon: Container(
            padding: EdgeInsets.all(screenHeight(context, dividedBy: 50)),
            width: screenWidth(context, dividedBy: 7),
            color: Colors.transparent,
            child: Image.asset(icon),
          ),
          suffixIcon: hintText == "Password"
              ? obsecure(context, onTap: suffixOnTap, obscureText: obscureText)
              : hintText == "Confirm Password"
                  ? obsecure(context,
                      onTap: suffixOnTap, obscureText: obscureText)
                  : SizedBox.shrink(),
        )),
  );
}

Widget commonTextfieldWithPrefixIcon(
    {required BuildContext context,
    required String text,
    TextInputType? textInputType,
    required TextEditingController controller,
    required String hintText,
    required Color HColor,
    required FontWeight HfontWeight,
    required String HfontFamily,
    required double HfontSize,
    bool? readOnly,
    TextAlignVertical? textAlignVertical}) {
  return Container(
    height: 48,
    padding: EdgeInsets.only(left: 15),
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(color: HexColor.Gray53.withOpacity(0.4)),
      borderRadius: BorderRadius.circular(10),
    ),
    child: TextField(
      keyboardType: textInputType ?? TextInputType.text,
      controller: controller,
      textAlignVertical: textAlignVertical,
      cursorColor: Colors.black45,
      readOnly: readOnly == null ? false : readOnly,
      decoration: InputDecoration(
        border: InputBorder.none,
        enabled: true,
        hintText: hintText,
        hintStyle: TextStyle(
            color: HColor,
            fontWeight: HfontWeight,
            fontFamily: HfontFamily,
            fontSize: HfontSize),
        suffixIcon: Container(
          // padding: EdgeInsets.all(screenHeight(context, dividedBy: 50)),
          width: screenWidth(context, dividedBy: 7),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: HexColor.Gray53.withOpacity(0.3),
            border:
                Border.all(color: HexColor.Gray53.withOpacity(0.4), width: 1.5),
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(9), topRight: Radius.circular(9)),
          ),
          child: commonText(text,
              color: HexColor.Gray53,
              fontFamily: LexendRegular,
              fontWeight: FontWeight.w400,
              fontSize: 14,
              textAlign: TextAlign.center),
        ),
      ),
    ),
  );
}

Widget commonButton(
    {required BuildContext context,
    required String buttonName,
    VoidCallback? onTap,
    Color? buttonColor,
    double? buttonTextSize,
    EdgeInsetsGeometry? padding,
    double? height,
    double? width}) {
  return InnerShadow(
    blur: 6,
    color: Colors.black.withOpacity(0.08),
    offset: const Offset(5, 5),
    child: GestureDetector(
      onTap: onTap as void Function()?,
      child: Container(
        height: height ?? screenHeight(context, dividedBy: 18),
        width: width ?? screenWidth(context, dividedBy: 3.2),
        padding: padding,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32),
          color: buttonColor ?? HexColor.buttonColor,
        ),
        child: Center(
            child: commonText(buttonName,
                color: Colors.black,
                fontFamily: LexendMedium,
                fontWeight: FontWeight.w500,
                textAlign: TextAlign.center,
                maxLines: 1,
                fontSize: buttonTextSize ?? 16)),
      ),
    ),
  );
}

Widget commonLoadingButton({
  required BuildContext context,
  // required String buttonName,
  Function? onTap,
  Color? buttonColor,
  double? buttonTextSize,
  EdgeInsetsGeometry? padding,
  double? height,
  double? width,
}) {
  return Align(
    alignment: Alignment.center,
    child: Container(
      height: height ?? screenHeight(context, dividedBy: 18),
      width: width ?? screenWidth(context, dividedBy: 3.2),
      padding: padding,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        color: buttonColor ?? HexColor.buttonColor,
      ),
      child: LoadingAnimationWidget.prograssiveDots(
        color: Colors.black,
        size: 35,
      ),
    ),
  );
}

Widget loader() {
  return Container(
    child: Center(
      child: Container(
        height: 80,
        width: 200,
        decoration: BoxDecoration(
            color: Colors.transparent, borderRadius: BorderRadius.circular(5)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            commonText("    Please wait...",
                color: Colors.black,
                fontFamily: LexendRegular,
                fontWeight: FontWeight.w400,
                fontSize: 17)
          ],
        ),
      ),
    ),
  );
}

Widget buildImage({required BuildContext context, required Widget child}) {
  return Container(
      height: screenHeight(context, dividedBy: 2.5),
      width: screenWidth(context),
      color: Colors.transparent,
      child: child);
}

Widget tittleWithSubTittle(
    {required BuildContext context,
    required String tittle,
    required String subTittle}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      commonText(tittle,
          color: Colors.black,
          fontFamily: LexendBold,
          fontSize: 30,
          fontWeight: FontWeight.w700),
      verticalSpaces(context, height: 60),
      commonText(subTittle,
          color: HexColor.Gray53,
          fontFamily: LexendRegular,
          fontSize: 16,
          fontWeight: FontWeight.w400,
          maxLines: 2),
    ],
  );
}

Widget circuleImage(
    {required BuildContext context,
    required String imagePath,
    EdgeInsetsGeometry? padding}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Container(
        height: screenHeight(context, dividedBy: 3.5),
        width: screenHeight(context, dividedBy: 3.5),
        padding: padding,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: HexColor.circuleColor,
        ),
        child: Image.asset(imagePath),
      )
    ],
  );
}

Widget getTextWithUnderline(
    {required String textWithUnderline,
    double? minFontSize,
    double? maxFontSize,
    double? fontSize,
    Function? onTap}) {
  return Container(
    margin: EdgeInsets.only(left: 20),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        GestureDetector(
            onTap: onTap as void Function()?,
            child: AutoSizeText(
              textWithUnderline,
              style: TextStyle(
                  color: HexColor.lightOrange,
                  fontFamily: LexendRegular,
                  decoration: TextDecoration.underline,
                  fontWeight: FontWeight.w400,
                  fontSize: fontSize),
              maxLines: 1,
              minFontSize: minFontSize ?? fontSize! - 2,
              maxFontSize: maxFontSize ?? fontSize! + 2,
            )),
      ],
    ),
  );
}

Widget getAppBarWithText({
  required String title,
  required BuildContext ctx,
}) {
  return AppBar(
    automaticallyImplyLeading: true,
    backgroundColor: Colors.white,
    elevation: 0,
    centerTitle: false,
    leadingWidth: 0,
    title: commonText(title,
        color: Colors.black,
        fontFamily: LexendBold,
        fontWeight: FontWeight.w700,
        fontSize: 20),
    // actions: [
    //   Container(
    //       height: screenHeight(ctx, dividedBy: 15),
    //       width: screenHeight(ctx, dividedBy: 15),
    //       color: Colors.transparent,
    //       padding: EdgeInsets.all(screenHeight(ctx, dividedBy: 50)),
    //       child: Image.asset(
    //         icons.ic_search,
    //       ))
    // ],
  );
}

Widget getAppBarWithIcon({
  required BuildContext ctx,
}) {
  return AppBar(
    automaticallyImplyLeading: false,
    elevation: 0,
    leading: GestureDetector(
      onTap: () => Navigation.instance.goBack(),
      child: const Icon(Icons.arrow_back_ios, color: Colors.black),
    ),
    backgroundColor: Colors.white,
  );
}

Widget getUserStatus(
    {required BuildContext ctx,
    required String count,
    required String status,
    required Color color,
    required EdgeInsetsGeometry margin,
    required Color textColor}) {
  return Expanded(
    child: Container(
      height: screenHeight(ctx, dividedBy: 11),
      //width: screenWidth(ctx,dividedBy: 3.5),
      margin: margin,
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
              color: HexColor.Gray53.withOpacity(0.3),
              blurRadius: 2,
              offset: Offset(1, 1),
              spreadRadius: 1),
          BoxShadow(
              color: Colors.white.withOpacity(0.1),
              blurRadius: 1,
              offset: Offset(-1, -1),
              spreadRadius: 1),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.bottomLeft,
              color: Colors.transparent,
              child: commonText(count,
                  color: textColor,
                  fontFamily: LexendBold,
                  textAlign: TextAlign.start,
                  fontWeight: FontWeight.w700,
                  fontSize: 20),
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.topLeft,
              color: Colors.transparent,
              child: commonText(status,
                  color: textColor,
                  fontFamily: LexendBold,
                  fontWeight: FontWeight.w700,
                  fontSize: 10,
                  maxLines: 2),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget getContainerWithImage(
    {required BuildContext ctx, required String icons, Function? onTap}) {
  return GestureDetector(
    onTap: onTap as void Function()?,
    child: Container(
      height: screenHeight(ctx, dividedBy: 25),
      margin: EdgeInsets.symmetric(horizontal: 2),
      width: screenHeight(ctx, dividedBy: 18),
      padding: EdgeInsets.all(3),
      color: Colors.transparent,
      child: Image.asset(icons),
    ),
  );
}

Widget getDivider({double? height}) {
  return Divider(
    color: HexColor.Gray53.withOpacity(0.3),
    thickness: 1.5,
    height: height ?? 1,
  );
}

Widget getContainerWithTralingIcon(
    {required BuildContext ctx, required String text, Function? onTap_xlsx}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Row(
        children: [
          commonText(text,
              color: Colors.black,
              fontFamily: LexendSemiBold,
              fontWeight: FontWeight.w700,
              fontSize: 20),
          // Spacer(),
          // getContainerWithImage(
          //     ctx: ctx,
          //     icons: icons.ic_xlsx,
          //     onTap: onTap_xlsx as void Function()?),
          // getContainerWithImage(ctx: ctx, icons: icons.ic_csv),
        ],
      ),
    ],
  );
}

Widget getCommonContainer(
    {double? height,
    double? width,
    Color? color,
    AlignmentGeometry? alignment,
    Widget? child,
    EdgeInsetsGeometry? margin,
    EdgeInsetsGeometry? padding}) {
  return Container(
    height: height,
    width: width,
    color: color,
    child: child,
    padding: padding,
    margin: margin,
    alignment: alignment,
  );
}

Widget getRoundedCornerContainer(
    {required BuildContext ctx,
    required double fontSize,
    required String status,
    required Color boxColor,
    double? height,
    double? width,
    int? maxLines,
    BoxBorder? border,
    required Color textColor}) {
  return Container(
    height: height ?? screenHeight(ctx, dividedBy: 25),
    width: width ?? screenWidth(ctx),
    //padding: EdgeInsets.symmetric(horizontal: screenWidth(ctx, dividedBy: 70)),
    alignment: Alignment.center,
    decoration: BoxDecoration(
      color: boxColor,
      borderRadius: BorderRadius.circular(10),
      border: border,
    ),
    child: commonText(status,
        color: textColor,
        fontFamily: LexendRegular,
        fontWeight: FontWeight.w400,
        maxLines: maxLines,
        fontSize: fontSize,
        textAlign: TextAlign.center),
  );
}

Widget getCenterIconWithText(
    {required String startTime, required String endTime}) {
  return Row(
    children: [
      commonText(startTime,
          color: HexColor.Gray53,
          fontFamily: LexendLight,
          fontWeight: FontWeight.w300,
          fontSize: 12,
          maxLines: 2),
      Icon(Icons.arrow_forward, color: HexColor.Gray53, size: 12),
      commonText(endTime,
          color: HexColor.Gray53,
          fontFamily: LexendLight,
          fontWeight: FontWeight.w300,
          fontSize: 12),
    ],
  );
}

Widget getSimpleRowText({required String sub1, required String sub2}) {
  return Row(
    children: [
      Expanded(
        child: Container(
          color: Colors.transparent,
          child: commonText(sub1,
              color: HexColor.Gray53,
              fontFamily: LexendLight,
              fontWeight: FontWeight.w300,
              fontSize: 14),
        ),
      ),
      Expanded(
        child: Container(
          color: Colors.transparent,
          child: commonText(sub2,
              color: Colors.black,
              fontFamily: LexendRegular,
              fontWeight: FontWeight.w400,
              textAlign: TextAlign.end,
              fontSize: 14,
              maxLines: 1),
        ),
      ),
    ],
  );
}

getRoundedTexfield({
  required String hintText,
  required TextEditingController controller,
  bool? readOnly,
  int? maxLength,
  double? height,
  double? width,
  required BuildContext ctx,
  Function? onTap,
  List<TextInputFormatter>? inputFormatters,
  Function? onChanged,
  TextInputType? textInputType,
  int? maxline,
  double? contentPaddingTop,
  bool? suffixIcon,
  bool? prefixIcon,
  bool? enabled,
  String? errorText,
}) {
  return Container(
    height: height ?? screenHeight(ctx, dividedBy: 15),
    width: width ?? screenWidth(ctx),
    alignment: Alignment.center,
    decoration: BoxDecoration(
      color: (enabled == false)
          ? HexColor.Gray53.withOpacity(0.2)
          : Colors.transparent,
      border: Border.all(color: HexColor.Gray53.withOpacity(0.5), width: 1.5),
      borderRadius: BorderRadius.circular(10.0),
    ),
    child: TextField(
      onTap: onTap as void Function()?,
      controller: controller,
      readOnly: readOnly == null ? false : true,
      maxLines: maxline == null ? 1 : maxline,


      keyboardType: textInputType,
      textAlignVertical: TextAlignVertical.center,
      onChanged: onChanged as void Function(String)?,
      enabled: enabled,
      maxLength: maxLength,
      inputFormatters: inputFormatters ?? [

      ],
      decoration: InputDecoration(
        isCollapsed: true,
        border: InputBorder.none,
        contentPadding: EdgeInsets.only(left: 9, right: 9),
        // labelText: hintText,
        // labelStyle: TextStyle(
        //   fontSize: 14,
        //   fontWeight: FontWeight.w400,
        //   fontFamily: LexendRegular,
        // ),
        hintText: hintText.tr(),
        counterText: "",
        errorText: errorText,
        errorStyle: TextStyle(
          fontSize: 12,
          fontFamily: LexendRegular,
          color: Colors.red,
        ),
        hintStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          fontFamily: LexendRegular,
          color: HexColor.Gray53,
        ),
        suffixIcon: suffixIcon == true
            ? GestureDetector(
                child: Container(
                  height: screenHeight(ctx, dividedBy: 40),
                  width: screenHeight(ctx, dividedBy: 40),
                  padding: EdgeInsets.all(12),
                  color: Colors.transparent,
                  child: Image.asset(icons.ic_calendar),
                ),
              )
            : SizedBox.shrink(),
        //
        // prefixIcon: prefixIcon == true
        //     ? Container(
        //         height: screenHeight(ctx, dividedBy: 40),
        //         width: screenHeight(ctx, dividedBy: 40),
        //         padding: EdgeInsets.all(12),
        //         color: Colors.transparent,
        //         child: Image.asset(icons.ic_file),
        //       )
        //     : null,
      ),
    ),
  );
}

getContainerWithListTiles(
    {required BuildContext ctx,
    required String icon,
    required String tittle,
    Function? onTap}) {
  return GestureDetector(
    onTap: onTap as void Function()?,
    child: Column(
      children: [
        Container(
            height: screenHeight(ctx, dividedBy: 14),
            width: screenWidth(ctx),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.white),
              boxShadow: [
                BoxShadow(
                    color: HexColor.Gray53.withOpacity(0.3),
                    blurRadius: 3,
                    offset: Offset(1, 1),
                    spreadRadius: 1),
                BoxShadow(
                    color: Colors.white.withOpacity(0.1),
                    blurRadius: 5,
                    offset: Offset(-1, -1),
                    spreadRadius: 1),
              ],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                getCommonContainer(
                  width: screenWidth(ctx, dividedBy: 6),
                  height: screenHeight(ctx, dividedBy: 14),
                  color: Colors.transparent,
                  child: Image.asset(icon, height: 30),
                  padding: EdgeInsets.all(screenHeight(ctx, dividedBy: 80)),
                ),
                commonText(tittle,
                    color: HexColor.Gray53,
                    fontFamily: LexendRegular,
                    fontWeight: FontWeight.w400,
                    fontSize: 16),
                Spacer(),
                getCommonContainer(
                  width: screenWidth(ctx, dividedBy: 8),
                  height: screenHeight(ctx, dividedBy: 14),
                  color: Colors.transparent,
                  child: Icon(Icons.arrow_forward_ios_rounded,
                      color: HexColor.Gray53.withOpacity(0.7)),
                  padding: EdgeInsets.all(screenHeight(ctx, dividedBy: 80)),
                ),
              ],
            )),
        verticalSpaces(ctx, height: 40)
      ],
    ),
  );
}

getSwitchWithText(
    {required BuildContext ctx,
    required String tittle,
    required bool value,
    required MaterialStateProperty<Color?> trackColor,
    Function(bool?)? onChanged,
    required MaterialStateProperty<Color?> overlayColor}) {
  return Container(
    //   height: screenHeight(ctx, dividedBy: 14),
    width: screenWidth(ctx),
    color: Colors.transparent,
    child: Column(
      children: [
        Row(
          children: [
            commonText(tittle,
                color: HexColor.Gray71,
                fontFamily: LexendRegular,
                fontWeight: FontWeight.w400,
                fontSize: 16),
            Spacer(),
            Switch(
              value: value,
              activeColor: HexColor.orange,
              inactiveThumbColor: HexColor.Gray71.withOpacity(0.3),
              trackColor: trackColor,
              overlayColor: overlayColor,
              onChanged: onChanged,
            ),
          ],
        ),
        getDivider()
      ],
    ),
  );
}

getIconWithUnderlineText(
    {double? width,
    double? height,
    required String text,
    required BuildContext ctx,
    required String icon,
    required Color iconColor,
    required Color textColor,
    required Color underlineColor,
    VoidCallback? onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: height,
      width: width,
      color: Colors.transparent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Image(
              image: AssetImage(icon), height: 20, width: 20, color: iconColor),
          SizedBox(
            width: 5,
          ),
          commonText(text,
              color: textColor,
              fontFamily: LexendRegular,
              fontWeight: FontWeight.w400,
              fontSize: 14,
              decoration: TextDecoration.underline,
              decorationColor: underlineColor)
        ],
      ),
    ),
  );
}

getSimpleTwoRowText({
  required BuildContext ctx,
  required String tittle1,
  required String tittle2,
}) {
  return getCommonContainer(
    height: screenHeight(ctx, dividedBy: 16),
    width: screenWidth(ctx),
    color: Colors.transparent,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        commonText(tittle1,
            color: Colors.black,
            fontFamily: LexendBold,
            fontWeight: FontWeight.w700,
            fontSize: 20),
        const SizedBox(width: 10),
        SizedBox(
          width: screenWidth(ctx, dividedBy: 3),
          child: commonText(tittle2,
              color: HexColor.orange,
              fontFamily: LexendBold,
              fontWeight: FontWeight.w700,
              fontSize: 14),
        ),
      ],
    ),
  );
}

getCommonFourTabBar({
  required BuildContext ctx,
  TabController? controller,
  required String tab1,
  required String tab2,
  double? width,
  EdgeInsetsGeometry? padding,
  required String tab3,
  required String tab4,
  required Function? onTap(index),
}) {
  return Container(
    height: screenHeight(ctx, dividedBy: 16),
    width: width,
    padding: padding,
    decoration: BoxDecoration(
      color: HexColor.HColor.withOpacity(0.25),
      borderRadius: BorderRadius.circular(
        25.0,
      ),
    ),
    child: TabBar(
      controller: controller,
      indicator: BoxDecoration(
        borderRadius: BorderRadius.circular(
          25.0,
        ),
        color: Colors.black,
      ),
      labelColor: Colors.white,
      labelPadding: EdgeInsets.symmetric(horizontal: 2.0),
      labelStyle: TextStyle(
        fontSize: 11,
        fontFamily: LexendRegular,
        fontWeight: FontWeight.w400,
      ),
      onTap: onTap,
      unselectedLabelColor: Colors.black,
      tabs: [
        Tab(
          text: tab1.tr(),
        ),
        Tab(
          text: tab2.tr(),
        ),
        Tab(
          text: tab3.tr(),
        ),
        Tab(
          text: tab4.tr(),
        ),
      ],
    ),
  );
}

getCommonThreeTabBar(
    {required BuildContext ctx,
    TabController? controller,
    required String tab1,
    required String tab2,
    EdgeInsetsGeometry? padding,
    required String tab3}) {
  return Container(
    height: screenHeight(ctx, dividedBy: 16),
    margin: EdgeInsets.only(bottom: 30),
    padding: padding,
    decoration: BoxDecoration(
      color: HexColor.HColor.withOpacity(0.25),
      borderRadius: BorderRadius.circular(
        25.0,
      ),
    ),
    child: TabBar(
      controller: controller,
      indicator: BoxDecoration(
        borderRadius: BorderRadius.circular(
          25.0,
        ),
        color: Colors.black,
      ),
      labelColor: Colors.white,
      labelPadding: EdgeInsets.symmetric(horizontal: 2.0),
      labelStyle: TextStyle(
        fontSize: 11,
        fontFamily: LexendRegular,
        fontWeight: FontWeight.w400,
      ),
      unselectedLabelColor: Colors.black,
      tabs: [
        Tab(
          text: tab1.tr(),
        ),
        Tab(
          text: tab2.tr(),
        ),
        Tab(
          text: tab3.tr(),
        ),
      ],
    ),
  );
}

getCommonTwoTabBar(
    {required BuildContext ctx,
    TabController? controller,
    required String tab1,
    required String tab2}) {
  return Container(
    height: screenHeight(ctx, dividedBy: 16),
    margin: EdgeInsets.only(bottom: 30),
    decoration: BoxDecoration(
      color: HexColor.HColor.withOpacity(0.25),
      borderRadius: BorderRadius.circular(
        25.0,
      ),
    ),
    child: TabBar(
      controller: controller,
      indicator: BoxDecoration(
        borderRadius: BorderRadius.circular(
          25.0,
        ),
        color: Colors.black,
      ),
      labelColor: Colors.white,
      labelPadding: EdgeInsets.symmetric(horizontal: 2.0),
      labelStyle: TextStyle(
        fontSize: 13,
        fontFamily: LexendRegular,
        fontWeight: FontWeight.w400,
      ),
      unselectedLabelColor: Colors.black,
      tabs: [
        Tab(
          text: tab1.tr(),
        ),
        Tab(
          text: tab2.tr(),
        ),
      ],
    ),
  );
}

getSwitchWithTittleAndSubTittle(
    {required BuildContext ctx,
    required String tittle,
    required String subTittle,
    required bool value,
    required MaterialStateProperty<Color?> trackColor,
    Function(bool?)? onChanged,
    required MaterialStateProperty<Color?> overlayColor}) {
  return Container(
//   height: screenHeight(ctx, dividedBy: 14),
    width: screenWidth(ctx),
    color: Colors.transparent,
    child: Column(
      children: [
        Row(
          children: [
            commonText(tittle,
                color: HexColor.Gray71,
                fontFamily: LexendRegular,
                fontWeight: FontWeight.w400,
                fontSize: 16),
            Spacer(),
            Switch(
              value: value,
              activeColor: HexColor.orange,
              inactiveThumbColor: HexColor.Gray71.withOpacity(0.3),
              trackColor: trackColor,
              overlayColor: overlayColor,
              onChanged: onChanged,
            ),
          ],
        ),
        commonText(subTittle,
            color: HexColor.Gray53,
            fontFamily: LexendLight,
            fontWeight: FontWeight.w300,
            fontSize: 12),
        verticalSpaces(ctx, height: 60),
        getDivider()
      ],
    ),
  );
}

getSimpleTwoRowTextAndButton({
  required BuildContext ctx,
  required String tittle1,
  required String tittle2,
  required String buttonName,
  required String projectId,
  required String orgId,
}) {
  return getCommonContainer(
    height: screenHeight(ctx, dividedBy: 10),
    padding: EdgeInsets.all(3),
    alignment: Alignment.topLeft,
    width: screenWidth(ctx),
    color: Colors.transparent,
    child: Row(
      children: [
        commonText(tittle1,
            color: Colors.black,
            fontFamily: LexendBold,
            fontWeight: FontWeight.w800,
            fontSize: 18),
        horizontal(ctx, width: 80),
        SizedBox(
          width: screenWidth(ctx, dividedBy: 3),
          child: commonText(tittle2,
              color: HexColor.orange,
              fontFamily: LexendBold,
              fontWeight: FontWeight.w700,
              fontSize: 14),
        ),
        horizontal(ctx, width: 80),
        Expanded(
            child: commonButton(
          context: ctx,
          buttonName: buttonName,
          buttonTextSize: 12,
          onTap: () {
            Navigator.of(ctx).push(MaterialPageRoute(
                builder: (context) => SubmitProjectList(

                      projectName: tittle2,
projectId: projectId,
orgId: orgId,

                    )));
          },
        ))
      ],
    ),
  );
}

getSimpleTwoTextWithTralingIcon({
  required BuildContext ctx,
  required String tittle1,
  required String tittle2,
  required List<PopupMenuEntry<int>> popupMenuItems,
  required int mainIndex,
  required int subIndex,
}) {
  return getCommonContainer(
    height: screenHeight(ctx, dividedBy: 15),
    width: screenWidth(ctx),
    alignment: Alignment.center,
    color: Colors.transparent,
    child: Row(
      children: [
        commonText(tittle1,
            color: Colors.black,
            fontFamily: LexendBold,
            fontWeight: FontWeight.w700,
            fontSize: 20),
        SizedBox(
          width: 10,
        ),
        commonText(tittle2,
            color: HexColor.orange,
            fontFamily: LexendBold,
            fontWeight: FontWeight.w700,
            fontSize: 14),
        Spacer(),
        SizedBox(
          width: 30,
          child: StatefulBuilder(
            builder: (context, setState) {
              return PopupMenuButton(
                  constraints: BoxConstraints(maxWidth: 150),
                  icon: Icon(
                    Icons.more_vert_outlined,
                    size: 25,
                    color: Color(0xFF5F6368),
                  ),
//offset: index.isEven?Offset(-47, 0):Offset(0, 0),
// onSelected: (value) {
//   setState(() {
//     mainIndex = value;
//     print("main index=${mainIndex}");
//   });
// },
                  itemBuilder: (BuildContext context) => <PopupMenuEntry<int>>[
                        PopupMenuItem(
                          value: 0,
                          child: StatefulBuilder(
                            builder: (context, setState) {
                              return PopupMenuButton(
                                  offset: Offset(-200, 0),
                                  child: Container(
                                      height: 35,
                                      width: 150,
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        'Organization',
// style: TextStyle(
//     color: mainIndex==0
//         ? HexColor.orange
//         : HexColor.HColor)
                                      )),
//offset: index.isEven?Offset(-47, 0):Offset(0, 0),
                                  onSelected: (value) {
                                    setState(() {
                                      subIndex = value;
                                      print("main index=${subIndex}");
                                    });
                                  },
                                  itemBuilder: (BuildContext context) {
                                    final authCub =
                                        BlocProvider.of<AuthCubit>(context);
                                    popupMenuItems = [];
                                    for (int i = 0;
                                        i < authCub.userOrganization.length;
                                        i++) {
                                      popupMenuItems.add(PopupMenuItem(
                                        value: i,
                                        child: Row(
                                          children: [
                                            Text(
                                              authCub.userOrganization[i]
                                                  .organizationName!
                                                  .toString(),
                                              style: TextStyle(
                                                  color: subIndex == i
                                                      ? HexColor.orange
                                                      : HexColor.HColor),
                                            ),
                                            Spacer(),
                                            subIndex == i
                                                ? Icon(Icons.check,
                                                    color: HexColor.orange)
                                                : Container()
                                          ],
                                        ),
                                      ));
                                    }
                                    return popupMenuItems;
                                  });
                            },
                          ),
                        ),
                        PopupMenuItem(
                            value: 1,
                            child: PopupMenuButton(
                                constraints: BoxConstraints(
                                  maxWidth: 120,
                                ),
                                child: Container(
                                    height: 35,
                                    width: 150,
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Language',
// style: TextStyle(
// color: mainIndex==1
//     ? HexColor.orange
//     : HexColor.HColor)
                                    )),
                                offset: context.locale == Locale('en')
                                    ? Offset(-120, 0)
                                    : Offset(-127, 0),
                                onSelected: (value) {
                                  if (value == 0) {
                                    context.setLocale(Locale('en'));
                                  } else {
                                    context.setLocale(Locale('sv'));
                                  }
                                },
                                itemBuilder: (BuildContext context) =>
                                    <PopupMenuEntry<int>>[
                                      PopupMenuItem(
                                        value: 0,
                                        child: Row(
                                          children: [
                                            Text(
                                              'English',
                                              style: TextStyle(
                                                  color: context.locale ==
                                                          Locale('en')
                                                      ? HexColor.orange
                                                      : HexColor.HColor),
                                            ),
                                            Spacer(),
                                            context.locale == Locale('en')
                                                ? Icon(Icons.check,
                                                    color: HexColor.orange)
                                                : Container(),
                                          ],
                                        ),
                                      ),
                                      PopupMenuDivider(),
                                      PopupMenuItem(
                                        value: 1,
                                        child: Row(
                                          children: [
                                            Text('Svenska',
                                                style: TextStyle(
                                                    color: context.locale ==
                                                            Locale('sv')
                                                        ? HexColor.orange
                                                        : HexColor.HColor)),
                                            Spacer(),
                                            context.locale == Locale('sv')
                                                ? Icon(Icons.check,
                                                    color: HexColor.orange)
                                                : Container()
                                          ],
                                        ),
                                      ),
                                    ])),
                      ]);
            },
          ),
        )
      ],
    ),
  );
}

getSimpleTextWithAsteriskSymbol({required String text}) {
  return RichText(
    text: TextSpan(
        text: text,
        style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w400,
            fontSize: 12,
            fontFamily: LexendRegular),
        children: [
          TextSpan(
              text: ' *',
              style: TextStyle(
                  color: HexColor.carnation,
                  fontWeight: FontWeight.w400,
                  fontSize: 12))
        ]),
  );
}

getColorWithContainer(
    {required BuildContext ctx,
    required Color currentColor,
    required String colorCode,
    Function? onTap}) {
  return Container(
    height: screenHeight(ctx, dividedBy: 15),
    width: screenWidth(ctx),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: HexColor.Gray53.withOpacity(0.6), width: 1.5),
    ),
    child: Row(
      children: [
        GestureDetector(
          onTap: onTap as void Function()?,
          child: Container(
            height: screenHeight(ctx, dividedBy: 18),
            width: screenHeight(ctx, dividedBy: 15),
            color: Colors.transparent,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: screenHeight(ctx, dividedBy: 25),
                  width: screenHeight(ctx, dividedBy: 25),
                  decoration: BoxDecoration(
                      color: currentColor,
                      borderRadius: BorderRadius.circular(5)),
                ),
              ],
            ),
          ),
        ),
        commonText(colorCode,
            color: HexColor.Gray53,
            fontFamily: LexendRegular,
            fontWeight: FontWeight.w400,
            fontSize: 14)
      ],
    ),
  );
}

_dropDownItems(List<String> list) {
  return list
      .map((String val) => DropdownMenuItem<String>(
            value: val,
            child: Text(val),
          ))
      .toList();
}

getDropDownButton({
  required BuildContext ctx,
  required List<String> items,
  required String hitText,
  Function? onChnaged,
  String? value,
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
        hint: Text(
          hitText.tr(),
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            fontFamily: LexendRegular,
            color: HexColor.Gray53,
          ),
        ),
        icon: Image.asset(icons.ic_downArrow, height: 7),
        items: _dropDownItems(items),
        onChanged: onChnaged as void Function(Object?)?,
        isExpanded: true,
        value: value,
      ),
    ),
  );
}

Navigate(BuildContext context, {required Widget widget}) {
  return Navigator.push(context, MaterialPageRoute(
    builder: (context) {
      return widget;
    },
  ));
}

Widget simpleCheckBox(BuildContext context,
    {required bool value, Function(bool?)? onChanged}) {
  return Container(
      height: 18,
      width: 18,
      decoration: BoxDecoration(
          border: Border.all(color: HexColor.Gray53.withOpacity(0.4), width: 1),
          borderRadius: BorderRadius.circular(3)),
      child: Checkbox(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
        activeColor: HexColor.orange,
        side: BorderSide(color: Colors.black),
        checkColor: Colors.white,
        value: value,
        onChanged: onChanged,
      ));
}

getRoundedContainerWithTralingIcon({
  double? height,
  required String text,
  required String image,
  Function? onTap,
  double? width,
}) {
  return GestureDetector(
    onTap: onTap as void Function()?,
    child: Container(
      height: height,
      width: width,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: HexColor.Gray53.withOpacity(0.5), width: 1.5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
              child: Container(
                  child: commonText(text,
                      color: Colors.black.withOpacity(0.8),
                      fontFamily: LexendRegular,
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      maxLines: 1))),
          Container(
            child: Image.asset(image),
          )
        ],
      ),
    ),
  );
}

getCheckOutHistory({
  required BuildContext ctx,
  required String release_quantity,
  required String release_date,
  required String item_name,
  required String transported_date,
  required String status,
  required String requestId,
  required String logisticId,
}) {
  return Container(
    height: screenHeight(ctx, dividedBy: 3.5),
    color: Colors.transparent,
    child: Column(
      children: [
        getSimpleRowText(sub1: "Release quantity", sub2: release_quantity),
        getSimpleRowText(sub1: "Desired release date", sub2: release_date),
        Container(
          height: screenHeight(ctx, dividedBy: 13),
          width: screenWidth(ctx),
          color: Colors.transparent,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  child: commonText("Transport dates",
                      color: HexColor.Gray53,
                      fontFamily: LexendRegular,
                      fontWeight: FontWeight.w400,
                      fontSize: 14)),
              Expanded(
                  child: commonText(transported_date,
                      color: Colors.black,
                      textAlign: TextAlign.end,
                      fontFamily: LexendRegular,
                      fontWeight: FontWeight.w400,
                      fontSize: 14)),
            ],
          ),
        ),
        getSimpleRowText(sub1: "Created By", sub2: item_name),
        Expanded(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            commonText("Status",
                color: HexColor.Gray53,
                fontFamily: LexendRegular,
                fontWeight: FontWeight.w400,
                fontSize: 14),
            GestureDetector(
              onTap: () async {
                if (status != "not_transported") {
                  String? returnVal = await showDialog<String>(
                    barrierDismissible: false,
                    builder: (_) => GetCheckoutCard(
                      requestId: requestId,
                    ),
                    context: ctx,
                  );
                  if (returnVal == "Success") {
                    BlocProvider.of<LogisticListCubit>(ctx)
                        .LogisticDetails(logisticId);
                  }
                }
              },
              child: getRoundedCornerContainer(
                  ctx: ctx,
                  maxLines: 1,
                  status: status == "not_transported"
                      ? "Not Transported"
                      : status == "requested"
                          ? "Transport Requested"
                          : status == "approved"
                              ? "Approved"
                              : "Unloaded",
// border: Border.all(color: HexColor.orange),
                  boxColor: status == "not_transported"
                      ? Colors.red
                      : status == "not_transported"
                          ? HexColor.yellow
                          : Colors.green,
                  textColor:
                      status == "requested" ? Colors.black : Colors.white,
                  fontSize: 12),
            )
          ],
        )),
        getDivider(height: 15),
      ],
    ),
  );
}

class GetCheckoutCard extends StatefulWidget {
  GetCheckoutCard({
    required this.requestId,
  }) : super();

  final String requestId;

  @override
  State<GetCheckoutCard> createState() => _GetCheckoutCardState();
}

class _GetCheckoutCardState extends State<GetCheckoutCard> {
  int currentIndex = -1;
  bool isApprove = false;
  late TransportRequestCubit transportRequestCub;
  late AuthCubit authCub;

  closeRequestDialogue(BuildContext context) {
    showDialog(
      barrierColor: Colors.black.withOpacity(0.4),
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
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
                Center(
                    child: Text("Are you sure you want to close this request?",
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: LexendRegular,
                          fontSize: 16,
                        ))),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    commonButton(
                        context: context,
                        buttonName: "No",
                        width: 95,
                        buttonColor: HexColor.Gray53.withOpacity(0.5),
                        onTap: () {
                          Navigator.pop(context);
                        }),
                    BlocBuilder<TransportRequestCubit, TransportRequestState>(
                      builder: (context, state) {
                        if (state is CloseTransportRequestLoading) {
                          return commonLoadingButton(
                              context: context, width: 95);
                        } else {
                          return commonButton(
                              context: context,
                              buttonName: "Yes",
                              width: 95,
                              onTap: () {
                                transportRequestCub.CloseTransportRequest(
                                    context, widget.requestId);
                              });
                        }
                      },
                    )
                  ],
                )
              ],
            ),
          ),
        );
      },
      context: context,
    );
  }

  statusUpdateDialogue(BuildContext context) {
    showDialog(
      barrierColor: Colors.black.withOpacity(0.4),
      barrierDismissible: false,
      builder: (context) {
        return Container(
          child: AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            contentPadding:
                EdgeInsets.only(left: 18, right: 18, top: 7, bottom: 18),
            content: Container(
              height: screenHeight(context, dividedBy: 5),
              width: screenWidth(context),
              color: Colors.transparent,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                        padding: EdgeInsets.zero,
                        constraints: BoxConstraints(),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.cancel_rounded,
                          size: 30,
                          color: Colors.black,
                        )),
                  ),
                  Text("Status : Transport Requested",
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: LexendRegular,
                        fontSize: 14,
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      BlocBuilder<TransportRequestCubit, TransportRequestState>(
                        builder: (context, state) {
                          if (state is UpdateTransportRequestStatusLoading &&
                              isApprove == true) {
                            return commonLoadingButton(
                                context: context, width: 95);
                          } else {
                            return commonButton(
                                context: context,
                                buttonName: "Approve",
                                width: 100,
                                onTap: () {
                                  isApprove = true;
                                  setState(() {});
                                  transportRequestCub
                                      .UpdateTransportRequestStatus(
                                          widget.requestId,
                                          "approved",
                                          context);
                                });
                          }
                        },
                      ),
                      BlocBuilder<TransportRequestCubit, TransportRequestState>(
                        builder: (context, state) {
                          if (state is UpdateTransportRequestStatusLoading &&
                              isApprove == false) {
                            return commonLoadingButton(
                                context: context, width: 95);
                          } else {
                            return commonButton(
                                context: context,
                                buttonColor: HexColor.Gray53.withOpacity(0.5),
                                buttonName: "Reject",
                                width: 100,
                                onTap: () {
                                  isApprove = false;
                                  setState(() {});
                                  transportRequestCub
                                      .UpdateTransportRequestStatus(
                                          widget.requestId,
                                          "rejected",
                                          context);
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

  @override
  void initState() {
    transportRequestCub = BlocProvider.of<TransportRequestCubit>(context);
    authCub = BlocProvider.of<AuthCubit>(context);
    transportRequestCub.GetTransportRequest(
        widget.requestId, projectIdMain, context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransportRequestCubit, TransportRequestState>(
      builder: (context, state) {
        if (state is GetTransportRequestLoading) {
          return Center(
            child: Container(
              height: 80,
              width: 200,
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(5)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  commonText("    Please wait...",
                      color: Colors.white,
                      fontFamily: LexendRegular,
                      fontWeight: FontWeight.w400,
                      fontSize: 17)
                ],
              ),
            ),
          );
        } else if (state is GetTransportRequestError) {
          return Container(
            color: Colors.white,
            height: screenHeight(context),
            width: screenWidth(context),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(Icons.cancel_rounded, size: 40)),
                  ],
                ),
                Spacer(),
                Container(
                  alignment: Alignment.center,
                  child: commonText("Error to Load Data",
                      color: Colors.black,
                      fontFamily: LexendRegular,
                      fontWeight: FontWeight.w500,
                      fontSize: 18),
                ),
                Spacer()
              ],
            ),
          );
        } else {
          return Center(
            child: Container(
                padding: EdgeInsets.all(15),
//margin: EdgeInsets.all(5),
                width: screenWidth(context, dividedBy: 1.3),
                height: screenHeight(context, dividedBy: 2.5),
// color: Colors.primaries[Random().nextInt(Colors.primaries.length)],
                color: Colors.orange,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        commonText(
                            "${DateFormat('HH:mm').format(transportRequestCub.transportRequestData!.result!.requestFromDateTime!)} - ${DateFormat('HH:mm').format(transportRequestCub.transportRequestData!.result!.requestToDateTime!)}",
                            color: Colors.black,
                            fontFamily: LexendRegular,
                            fontWeight: FontWeight.w400,
                            fontSize: 16),
                        Spacer(),
                        GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(
                              Icons.cancel_rounded,
                              size: 30,
                              color: Colors.black,
                            ))
// IconButton(padding: EdgeInsets.zero,constraints: BoxConstraints(),onPressed: () {
//   Navigator.pop(context);
// }, icon: Icon(Icons.cancel_rounded,size: 30,color: Colors.black,))
                      ],
                    ),
                    transportRequestCub.transportRequestData!.result!.status ==
                            "pending"
                        ? GestureDetector(
                            onTap: () {
                              statusUpdateDialogue(context);
                            },
                            child: Container(
                              padding: EdgeInsets.all(5),
                              margin: EdgeInsets.symmetric(vertical: 10),
                              height: screenHeight(context, dividedBy: 25),
                              width: screenWidth(context, dividedBy: 3.2),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.yellow),
                              child: Center(
                                  child: commonText("Transport Requested",
                                      color: Colors.black,
                                      fontFamily: LexendRegular,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                      maxLines: 1)),
                            ),
                          )
                        : Container(
                            margin: EdgeInsets.symmetric(vertical: 10),
                            height: screenHeight(context, dividedBy: 25),
                            width: screenWidth(context, dividedBy: 3.2),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: transportRequestCub.transportRequestData!
                                                .result!.status ==
                                            "approved" ||
                                        transportRequestCub
                                                .transportRequestData!
                                                .result!
                                                .status ==
                                            "unloaded"
                                    ? Colors.green
                                    : Colors.red),
                            child: Center(
                                child: Text(
                              transportRequestCub
                                  .transportRequestData!.result!.status!,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  decoration: TextDecoration.none),
                            )),
                          ),
                    commonText('Transport From Terminal',
                        color: Colors.black,
                        fontFamily: LexendMedium,
                        fontWeight: FontWeight.w400,
                        fontSize: 14),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          style: TextButton.styleFrom(
                            backgroundColor:
                                HexColor.orange, // Background Color
                          ),
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return UpdateTransportRequestShipment(
                                    widget.requestId, projectIdMain);
                              },
                            ));
                          },
                          child: commonText('Update',
                              color: Colors.black,
                              fontFamily: LexendRegular,
                              fontWeight: FontWeight.w400,
                              fontSize: 14),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        ElevatedButton(
                          style: TextButton.styleFrom(
                            backgroundColor:
                                HexColor.orange, // Background Color
                          ),
                          onPressed: () {
                            closeRequestDialogue(context);
                          },
                          child: commonText('Close Request',
                              color: Colors.black,
                              fontFamily: LexendRegular,
                              fontWeight: FontWeight.w400,
                              fontSize: 14),
                        ),
                      ],
                    ),
                    verticalSpaces(context, height: 80),
                    Align(
                      alignment: Alignment.center,
                      child: ElevatedButton(
                        style: TextButton.styleFrom(
                          backgroundColor: HexColor.orange, // Background Color
                        ),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return BookingHistory(widget.requestId);
                            },
                          ));
                        },
                        child: commonText('Booking History',
                            color: Colors.black,
                            fontFamily: LexendRegular,
                            fontWeight: FontWeight.w400,
                            fontSize: 15),
                      ),
                    ),
                  ],
                )),
          );
        }
      },
    );
  }
}

getSelectPictureDialog(
    {required BuildContext ctx,
    required VoidCallback onTapCamera,
    required VoidCallback onTapGallery}) {
  showDialog(
    context: ctx,
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
                    borderRadius: BorderRadius.circular(5)),
                padding: const EdgeInsets.only(
                    left: 18, right: 10, top: 22, bottom: 20),
                margin: EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        commonText("Select Picture",
                            color: Colors.black,
                            fontFamily: LexendRegular,
                            fontWeight: FontWeight.w500,
                            fontSize: 20),
                        Spacer(),
                        Align(
                            alignment: Alignment.centerRight,
                            child: IconButton(
                                onPressed: () {
                                  Navigation.instance.goBack();
                                },
                                icon: Icon(
                                  Icons.cancel_outlined,
                                  color: HexColor.Gray53,
                                ))),
                      ],
                    ),
                    verticalSpaces(ctx, height: 70),
                    ListTile(
                      title: commonText("Camera",
                          color: Colors.grey,
                          fontFamily: LexendRegular,
                          fontWeight: FontWeight.w300,
                          fontSize: 18),
                      leading: const Icon(
                        Icons.camera_alt,
                        color: Colors.grey,
                      ),
                      onTap: onTapCamera,
                    ),
                    ListTile(
                        title: commonText("Gallery",
                            color: Colors.grey,
                            fontFamily: LexendRegular,
                            fontWeight: FontWeight.w300,
                            fontSize: 18),
                        leading: const Icon(
                          Icons.photo,
                          color: Colors.grey,
                        ),
                        onTap: onTapGallery)
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

snackBar(String? message, bool status) {
  return rootScaffoldMessengerKey.currentState!.showSnackBar(
    SnackBar(
      backgroundColor: status ? Colors.green : Colors.red,
      content: Text(message!),
      duration: const Duration(seconds: 2),
    ),
  );
}

Widget getShimmerEffect() {
  return Shimmer.fromColors(
      baseColor: Color(0xffECECEC),
      highlightColor: Color(0xffe3e3e3),
//highlightColor: Color(0xEAEAEAFF),
      child: Container(
        color: Color(0xffECECEC),
      ));
}

Widget errorLoadDataText() {
  return Center(
    child: commonText("No matching records found",
        color: Colors.black,
        fontFamily: LexendRegular,
        fontWeight: FontWeight.w500,
        fontSize: 18),
  );
}

Widget noDataFoundText() {
  return Center(
    child: commonText("No Data Found",
        color: Colors.black,
        fontFamily: LexendRegular,
        fontWeight: FontWeight.w500,
        fontSize: 18),
  );
}
