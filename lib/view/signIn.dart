import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ftx/navigationX.dart';
import 'package:proj_site/common/colors/colors.dart';
import 'package:proj_site/common/image_constant/image_constant.dart';
import 'package:proj_site/common/widget_constant/widget_constant.dart';
import 'package:proj_site/cubits/auth_cubit.dart';
import 'package:proj_site/helper/helper.dart';
import 'package:proj_site/services/sharedpreference_service.dart';
import 'package:proj_site/view/dashBoard.dart';
import 'package:proj_site/view/forgotPassword.dart';
import 'package:proj_site/view/homePage.dart';
import 'package:proj_site/view/userVerify.dart';

class SignIn extends StatefulWidget {
  static const id = 'SignIn_screen';

  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController emailTxt = TextEditingController();
  TextEditingController passTxt = TextEditingController();
  SharedPreferenceService prefs = SharedPreferenceService();
  bool _obscureText = true;

  forgotPasswordText({required String Text}) {
    return Container(
        height: screenHeight(context, dividedBy: 30),
        width: screenWidth(context, dividedBy: 2.1),
        color: Colors.transparent,
        child: Align(
            alignment: Alignment.topRight,
            child: commonText(Text,
                color: HexColor.lightOrange,
                fontFamily: LexendRegular,
                fontWeight: FontWeight.w400,
                fontSize: 14)));
  }

  _buildImageWithText() {
    return getCommonContainer(
      padding: EdgeInsets.only(top: 20, right: 20, left: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildImage(
              context: context, child: Image.asset(images.signInScreenImg)),
          verticalSpaces(context, height: 40),
          tittleWithSubTittle(
              context: context,
              tittle: "Login",
              subTittle: "Please sign in to continue"),
          verticalSpaces(context, height: 40),
        ],
      ),
    );
  }

  _loginButton(AuthCubit authCub) {
    return Align(
        alignment: Alignment.center,
        child: commonButton(
            context: context,
            buttonName: "Login",
            onTap: () {
              String pattern =
                  r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
              RegExp regex = RegExp(pattern);
              if (emailTxt.text.isEmpty) {
                snackBar( "Please Enter Email", false);
              } else if (!regex.hasMatch(emailTxt.text)) {
                snackBar( "Please Enter Valid Email", false);
              } else if (passTxt.text.isEmpty) {
                snackBar( "Please Enter Password", false);
              } else {
                authCub.signIn(emailTxt.text, passTxt.text);
              }
            }));
  }

  _emailTextField() {
    return commonTextfield(
        context: context,
        textInputType: TextInputType.text,
        controller: emailTxt,
        hintText: "Email",
        HColor: HexColor.HColor,
        HfontWeight: FontWeight.w400,
        HfontFamily: LexendRegular,
        HfontSize: 14,
        icon: icons.ic_email);
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
        icon: icons.ic_password,
        obscureText: _obscureText,
        suffixOnTap: () {
          setState(() {
            _obscureText = !_obscureText;
          });
        }
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
              Container(
                margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    _emailTextField(),
                    verticalSpaces(context, height: 40),
                    _passwordTextField(),
                    verticalSpaces(context, height: 50),
                    GestureDetector(
                      onTap: () {
                        Navigation.instance.navigate(ForgotPassword.id);
                      },
                      child: forgotPasswordText(Text: "Forgot Password?"),
                    )
                  ],
                ),
              ),
              verticalSpaces(context, height: 30),
              BlocBuilder<AuthCubit, AuthState>(
                builder: (context, state) {
                  if(state is SignInLoading){
                    return commonLoadingButton(context: context);
                  } else {
                    return _loginButton(authCub);
                  }
                },
              ),
            ]),
          )),
    );
  }
}
