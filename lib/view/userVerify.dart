import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ftx/navigationX.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:proj_site/common/colors/colors.dart';
import 'package:proj_site/common/image_constant/image_constant.dart';
import 'package:proj_site/common/widget_constant/widget_constant.dart';
import 'package:proj_site/helper/helper.dart';
import 'package:proj_site/services/sharedpreference_service.dart';
import 'package:proj_site/view/createNewPassword.dart';
import 'package:proj_site/view/dashBoard.dart';

class UserVerify extends StatefulWidget {
  static const id = 'UserVerify_screen';
  const UserVerify({Key? key}) : super(key: key);

  @override
  State<UserVerify> createState() => _UserVerifyState();
}

class _UserVerifyState extends State<UserVerify> {
  TextEditingController emailTxt = TextEditingController();
  final formKey = GlobalKey<FormState>();
  StreamController<ErrorAnimationType>? errorController;
  String currentText = "";
  bool hasError = false;
  SharedPreferenceService prefs = SharedPreferenceService();


  @override
  void dispose() {
    errorController!.close();

    super.dispose();
  }

  @override
  void initState() {
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  // snackBar(String? message) {
  //   return ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(
  //       content: Text(message!),
  //       duration: const Duration(seconds: 2),
  //     ),
  //   );
  // }

  Widget otp_textfiled() {
    return getCommonContainer(
      margin: EdgeInsets.only(left: 20, right: 20, top: 20),
      child: Form(
        key: formKey,
        child: PinCodeTextField(
          appContext: context,
          pastedTextStyle: TextStyle(
            color: Colors.green.shade600,
            fontWeight: FontWeight.bold,
          ),
          length: 6,
          obscureText: true,
          obscuringCharacter: '*',
          // obscuringWidget: const FlutterLogo(
          //   size: 24,
          // ),
          blinkWhenObscuring: true,
          animationType: AnimationType.fade,
          validator: (v) {
            if (v!.length < 3) {
              return "Please Enter Your OTP";
            } else {
              return null;
            }
          },
          pinTheme: PinTheme(
              shape: PinCodeFieldShape.box,
              borderRadius: BorderRadius.circular(10),
              fieldHeight: screenHeight(context, dividedBy: 15),
              fieldWidth: screenHeight(context, dividedBy: 18),
              activeFillColor: Colors.white,
              inactiveColor: Colors.white,
              inactiveFillColor: Colors.white,
              selectedFillColor: Colors.white,
              // selectedColor: Colors.greenAccent,
              activeColor: Colors.white),
          cursorColor: Colors.black,
          animationDuration: const Duration(milliseconds: 300),
          enableActiveFill: true,
          errorAnimationController: errorController,
          controller: emailTxt,
          keyboardType: TextInputType.number,
          boxShadows: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                blurRadius: 3,
                offset: Offset(1, 1),
                spreadRadius: 1),
            BoxShadow(
                color: Colors.white.withOpacity(0.1),
                blurRadius: 5,
                offset: Offset(-1, -1),
                spreadRadius: 1)
          ],
          onCompleted: (v) {
            debugPrint("Completed");
          },

          onChanged: (value) {
            debugPrint(value);
            setState(() {
              currentText = value;
            });
          },
          beforeTextPaste: (text) {
            debugPrint("Allowing to paste $text");
            return true;
          },
        ),
      ),
    );
  }

  _buildImageWithTwxt() {
    return getCommonContainer(
      padding: EdgeInsets.only(top: 20, right: 20, left: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildImage(
              context: context,
              child: circuleImage(
                  context: context,
                  padding: EdgeInsets.all(50),
                  imagePath: images.userVerifyImg)),
          verticalSpaces(context, height: 40),
          tittleWithSubTittle(
              context: context,
              tittle: "Verfiy Your Email",
              subTittle: "Please enter code we sent you on username@gmail.com"),
          verticalSpaces(context, height: 40),
        ],
      ),
    );
  }

  _verifyButton() {
    return Align(
        alignment: Alignment.center,
        child: commonButton(
            context: context,
            buttonName: "Verify",
            onTap: () {
              formKey.currentState!.validate();
              // conditions for validating
              if (currentText.length != 6 || currentText != "123456") {
                errorController!.add(ErrorAnimationType
                    .shake); // Triggering error shake animation
                setState(() => hasError = true);
              } else {
                setState(
                  () {
                    hasError = false;
                    snackBar( "OTP Verified!!",true);
                    Navigation.instance.navigate(NewPassword.id);
                    // snackBar(context, "Login Successfully",true);
                    // prefs.setBoolData('isLogin', true);
                    // Navigation.instance.navigate(DashBoard.id);
                  },
                );
              }
            }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SizedBox(
          height: screenHeight(context),
          width: screenWidth(context),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              _buildImageWithTwxt(),
              otp_textfiled(),
              getTextWithUnderline(
                  textWithUnderline: "Resend Code",
                  fontSize: 14,
                  onTap: () {
                    snackBar("OTP resend!!",true);
                  }),
              verticalSpaces(context, height: 15),
              _verifyButton(),
            ]),
          )),
    );
  }
}
