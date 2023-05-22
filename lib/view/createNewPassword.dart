import 'package:flutter/material.dart';
import 'package:ftx/navigationX.dart';
import 'package:proj_site/common/colors/colors.dart';
import 'package:proj_site/common/image_constant/image_constant.dart';
import 'package:proj_site/common/widget_constant/widget_constant.dart';
import 'package:proj_site/helper/helper.dart';
import 'package:proj_site/view/dashBoard.dart';
import 'package:proj_site/view/homePage.dart';
import 'package:proj_site/view/signIn.dart';

class NewPassword extends StatefulWidget {
  static const id = 'NewPassword_screen';
  const NewPassword({Key? key}) : super(key: key);

  @override
  State<NewPassword> createState() => _NewPasswordState();
}

class _NewPasswordState extends State<NewPassword> {
  TextEditingController emailTxt = TextEditingController();
  TextEditingController passTxt = TextEditingController();
  TextEditingController confirmPassTxt = TextEditingController();
  bool _obscureText = true;
  bool _obscureText1 = true;

  _buildImageWithText() {
    return getCommonContainer(
      padding: EdgeInsets.only(top: 20, right: 20, left: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildImage(
              context: context,
              child: circuleImage(
                  context: context,
                  padding: EdgeInsets.all(40),
                  imagePath: images.resetPasswordImg)),
          verticalSpaces(context, height: 40),
          tittleWithSubTittle(
              context: context,
              tittle: "Create New Password",
              subTittle:
                  "Your new password must be different from previously used password."),
          verticalSpaces(context, height: 40),
        ],
      ),
    );
  }

  _saveButton() {
    return Align(
        alignment: Alignment.center,

        child: commonButton(context: context, buttonName: "Save",onTap: (){
          if (passTxt.text.isEmpty) {
            snackBar( "Please Enter Password",false);
          }else if (confirmPassTxt.text.isEmpty) {
            snackBar( "Please Enter Confirm Password",false);
          }else if (passTxt.text!=confirmPassTxt.text) {
            snackBar("Password Not Matched", false);
          }else{
            Navigation.instance.navigateAndRemoveUntil(SignIn.id);
          }
        }));
  }

  _passwordTextField() {
    return commonTextfield(
        context: context,
        textInputType: TextInputType.text,
        controller: passTxt,
        hintText: "Password",
        HColor: HexColor.HColor,
        HfontWeight: FontWeight.w400,
        HfontFamily: LexendRegular,
        HfontSize: 14,
        obscureText: _obscureText1,
        suffixOnTap: () {
          setState(() {
            _obscureText1 = !_obscureText1;
          });
        },
        icon: icons.ic_password);
  }

  _confirmPasswordTextField() {
    return commonTextfield(
        context: context,
        textInputType: TextInputType.text,
        controller: confirmPassTxt,
        hintText: "Confirm Password",
        HColor: HexColor.HColor,
        HfontWeight: FontWeight.w400,
        HfontFamily: LexendRegular,
        HfontSize: 14,
        obscureText: _obscureText,
        suffixOnTap: () {
          setState(() {
            _obscureText = !_obscureText;
          });
        },
        icon: icons.ic_password);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SizedBox(
          height: screenHeight(context),
          width: screenWidth(context),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              _buildImageWithText(),
              getCommonContainer(
                margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    _passwordTextField(),
                    verticalSpaces(context, height: 40),
                    _confirmPasswordTextField(),
                    verticalSpaces(context, height: 15),
                  ],
                ),
              ),
              _saveButton(),
            ]),
          )),
    );
  }
}
