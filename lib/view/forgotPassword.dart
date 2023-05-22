import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ftx/navigationX.dart';
import 'package:proj_site/common/colors/colors.dart';
import 'package:proj_site/common/image_constant/image_constant.dart';
import 'package:proj_site/common/widget_constant/widget_constant.dart';
import 'package:proj_site/cubits/auth_cubit.dart';
import 'package:proj_site/helper/helper.dart';
import 'package:proj_site/view/createNewPassword.dart';
import 'package:proj_site/view/userVerify.dart';

class ForgotPassword extends StatefulWidget {
  static const id = 'ForgotPassword_screen';

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController emailTxt = TextEditingController();

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
                  imagePath: images.forgotPasswordScreenImg)),
          verticalSpaces(context, height: 40),
          tittleWithSubTittle(
              context: context,
              tittle: "Forgot Password",
              subTittle:
                  "Enter the email address associated with your account."),
          verticalSpaces(context, height: 40),
        ],
      ),
    );
  }

  _sendButton(AuthCubit authCub) {
    return Align(
        alignment: Alignment.center,
        child: commonButton(
            context: context,
            buttonName: "Send",
            onTap: () {
              String pattern =
                  r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
              RegExp regex = RegExp(pattern);
              if (emailTxt.text.isEmpty) {
                snackBar("Please Enter Email", false);
              } else if (!regex.hasMatch(emailTxt.text)) {
                snackBar("Please Enter Valid Email", false);
              } else {
                authCub.forgotPassword(emailTxt.text);
              }
            }));
  }

  _emailTextField() {
    return getCommonContainer(
      margin: EdgeInsets.only(left: 20, right: 20, top: 20),
      child: commonTextfield(
          context: context,
          textInputType: TextInputType.text,
          controller: emailTxt,
          hintText: "Email",
          HColor: HexColor.HColor,
          HfontWeight: FontWeight.w400,
          HfontFamily: LexendRegular,
          HfontSize: 14,
          icon: icons.ic_email),
    );
  }

  @override
  Widget build(BuildContext context) {
    final authCub = BlocProvider.of<AuthCubit>(context);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SizedBox(
          height: screenHeight(context),
          width: screenWidth(context),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              _buildImageWithText(),
              _emailTextField(),
              verticalSpaces(context, height: 15),
              BlocBuilder<AuthCubit, AuthState>(
                builder: (context, state) {
                  if (state is ForgotPasswordLoading) {
                    return commonLoadingButton(context: context);
                  } else {
                    return _sendButton(authCub);
                  }
                },
              ),
            ]),
          )),
    );
  }
}
