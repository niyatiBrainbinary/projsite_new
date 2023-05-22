
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proj_site/common/colors/colors.dart';
import 'package:proj_site/common/image_constant/image_constant.dart';
import 'package:proj_site/common/widget_constant/widget_constant.dart';
import 'package:proj_site/cubits/apd_plan_cubit.dart';
import 'package:proj_site/cubits/auth_cubit.dart';
import 'package:proj_site/cubits/internet_cubit.dart';
import 'package:proj_site/helper/helper.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';


class ApdPlanList extends StatefulWidget {


  @override
  State<ApdPlanList> createState() => _ApdPlanListState();
}
class _ApdPlanListState extends State<ApdPlanList> {

  late ApdPlanCubit _apdPlanCub;
  late AuthCubit _authCub;

  static const String _BASE_URL = 'https://dev.projsite.com/delivery_management_api/public';


  _apdList({required String file_name,required int index}){
    return Column(
      children: [
        getCommonContainer(
            height: screenHeight(context,dividedBy: 10),
            width: screenWidth(context),
            color: Colors.transparent,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: [
                    commonText(file_name, color: Colors.black, fontFamily: LexendRegular, fontWeight: FontWeight.w400, fontSize: 16),
                    Spacer(),
                    getContainerWithImage(ctx: context, icons: icons.ic_pdf,onTap: (){
                      _showDilaoguePdf(context, index);
                    }),
                    getContainerWithImage(ctx: context, icons: icons.ic_delete,onTap: (){
                      _showDilaogue(context, index);
                    }),
                  ],
                ),
                getDivider(height: 15)
              ],
            )
        ),
      ],
    );
  }

  _showDilaogue(BuildContext context,int index){
    showDialog(
      barrierColor: Colors.black.withOpacity(0.4),barrierDismissible: false,
      builder: (context) {
        return Container(
          child: AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))
            ),
            contentPadding: EdgeInsets.only(left: 18,right: 18,top: 18,bottom: 18),
            content: Container(
              height: screenHeight(context,dividedBy: 5),
              width: screenWidth(context),
              color: Colors.transparent,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Center(child:Text("Are you sure you want to Delete?",style: TextStyle(color: Colors.black,fontFamily: LexendRegular,fontSize: 16,))),
                  Row(
                    children: [
                      commonButton(
                          context: context,
                          buttonName:
                          "close",
                          width: 95,
                          buttonColor: HexColor
                              .Gray53
                              .withOpacity(
                              0.5),
                          onTap: () {
                            Navigator.pop(
                                context);
                          }),
                      BlocBuilder<ApdPlanCubit, ApdPlanState>(
                        builder: (context, state) {
                          if(state is DeleteApdPlanLoading){
                            return commonLoadingButton(context: context,width: 95);
                          }
                          else {
                            return commonButton(context: context, buttonName: "Delete",width: 95,onTap: (){
                              _apdPlanCub.DeleteApdPlan(context: context, id: _apdPlanCub.ApdPlanList[index].id,);
                            });
                          }
                        },
                      ),


                    ],mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  )
                ],
              ),
            ),
          ),
        );
      }, context: context,
    );

  }

  _showDilaoguePdf(BuildContext context,int index){
    showDialog(
      barrierColor: Colors.black.withOpacity(0.4),barrierDismissible: false,
      builder: (context) {
        return Container(
          child: AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))
            ),
            contentPadding: EdgeInsets.only(left: 15,right: 15,top: 18,bottom: 18),
            content: Container(
              height: screenHeight(context,dividedBy: 1.7),
              width: screenWidth(context),
              color: Colors.transparent,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text("APD Plan - ${_apdPlanCub.ApdPlanList[index].fileName}"),
                    Container(
                        height: screenHeight(context,dividedBy: 2),
                        width: screenWidth(context),
                        decoration: BoxDecoration(
                            color: Colors.white,
                        ),
                        padding:const EdgeInsets.all(15),
                        child:  SfPdfViewer.network(
                          "${_BASE_URL}/apd_attachments/${_apdPlanCub.ApdPlanList[index].filePath}",
                        )

                    ),
                    commonButton(
                        context: context,
                        buttonName:
                        "close",
                        width: 95,
                        buttonColor: HexColor
                            .Gray53
                            .withOpacity(
                            0.5),
                        onTap: () {
                          Navigator.pop(
                              context);
                        }),
                  ],
                ),
              ),
            ),
          ),
        );
      }, context: context,
    );

  }



  @override
  void initState() {
    super.initState();
    getApdPlan();
  }

  getApdPlan(){
    _apdPlanCub = BlocProvider.of<ApdPlanCubit>(context);
    _authCub = BlocProvider.of<AuthCubit>(context);
    _apdPlanCub.ApdPlan(projectId: projectIdMain);
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ApdPlanCubit, ApdPlanState>(
      builder: (context, state) {
        List apdPlanList = _apdPlanCub.ApdPlanList;
          if(state is ApdPlanLoading){
            return loader();
          }else if (State is ApdPlanError)  {
            return errorLoadDataText();
          } else if(apdPlanList.length == 0){
            return Center(child: commonText("No Data Found", color: Colors.black, fontFamily: LexendRegular, fontWeight: FontWeight.w400, fontSize: 20));
          }
          else {
            return ListView.builder(shrinkWrap: true,physics: BouncingScrollPhysics(),padding: EdgeInsets.zero,itemCount: apdPlanList.length,itemBuilder: (context, index) {
              return _apdList(file_name: _apdPlanCub.ApdPlanList[index].fileName, index: index);
            },);
            // }
          }
        }
    );
  }
}
