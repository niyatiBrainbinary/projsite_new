import 'dart:developer';
import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:proj_site/common/colors/colors.dart';
import 'package:proj_site/common/image_constant/image_constant.dart';
import 'package:proj_site/common/widget_constant/widget_constant.dart';
import 'package:proj_site/cubits/apd_plan_cubit.dart';
import 'package:proj_site/cubits/auth_cubit.dart';
import 'package:proj_site/helper/helper.dart';

class NewApdPlan extends StatefulWidget {
  const NewApdPlan({Key? key}) : super(key: key);

  @override
  State<NewApdPlan> createState() => _NewApdPlanState();
}

class _NewApdPlanState extends State<NewApdPlan> {

  File? file;
  late ApdPlanCubit _apdPlanCub;
  int percentage = 0;
  late AuthCubit _authCub;
  TextEditingController fileNameCon=TextEditingController();
  @override
  Widget build(BuildContext context) {
    _apdPlanCub = BlocProvider.of<ApdPlanCubit>(context);
    return getCommonContainer(
        child: Column(
      children: [
        // Container(
        //   height: screenHeight(context, dividedBy: 15),
        //   padding: EdgeInsets.all(7),
        //   decoration: BoxDecoration(
        //       borderRadius: BorderRadius.circular(10),
        //       border: Border.all(
        //           color: HexColor.Gray53.withOpacity(0.5), width: 1.5)),
        //   child: Row(
        //     children: [
        //       horizontal(context, width: 80),
        //       Container(
        //         child: Image.asset(icons.ic_file),
        //       ),
        //       horizontal(context, width: 20),
        //       Expanded(
        //         child: commonText("File Name",
        //             color: HexColor.Gray53.withOpacity(0.4),
        //             fontFamily: LexendRegular,
        //             fontWeight: FontWeight.w400,
        //             fontSize: 14),
        //       )
        //     ],
        //   ),
        // ),
        getRoundedTexfield(
            hintText: "File Name", controller: fileNameCon, ctx: context,prefixIcon: true,),
        verticalSpaces(context, height: 30),
        DottedBorder(
            radius: Radius.circular(10),
            borderType: BorderType.RRect,
            color: HexColor.Gray53.withOpacity(0.6),
            dashPattern: [5, 5],
            child: Container(
              height: screenHeight(context, dividedBy: 16),
              width: screenWidth(context),
              decoration:
              BoxDecoration(borderRadius: BorderRadius.circular(10)),
              child: Row(
                children: [
                  horizontal(context, width: 30),
                  GestureDetector(
                    onTap: () async {
                      FilePickerResult? result = await FilePicker.platform.pickFiles(
                        type: FileType.custom,
                        allowedExtensions: ['jpg', 'pdf', 'doc', 'docx', 'png'],allowMultiple: true);
                      if (result != null) {
                        file = File(result.files.single.path!);
                      } else {
                        // User canceled the picker
                      }
                      setState(() {});
                    },
                    child: Container(
                      height: screenHeight(context, dividedBy: 23),
                      width: screenWidth(context, dividedBy: 4),
                      decoration: BoxDecoration(
                          color: HexColor.Gray53.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: HexColor.Gray53)),
                      child: Center(
                          child: commonText("Choose file",
                              color: HexColor.Gray53,
                              fontFamily: LexendRegular,
                              fontWeight: FontWeight.w400,
                              fontSize: 14)),
                    ),
                  ),
                  horizontal(context, width: 30),
                  Expanded(
                    child: commonText(file==null? "No file chosen": file!.path.split("/").last,
                        color: HexColor.Gray53.withOpacity(0.6),
                        fontFamily: LexendRegular,
                        fontWeight: FontWeight.w400,
                        fontSize: 14),
                  )
                ],
              ),
            )),
        verticalSpaces(context, height: 10),
        BlocBuilder<ApdPlanCubit, ApdPlanState>(
            builder: (context, state) {
              if(state is UploadApdPlanLoading){
                return commonLoadingButton(context: context);
              }
              else {
                return  Align(
                    alignment: Alignment.center,
                    child: commonButton(context: context, buttonName: "Submit",onTap: (){
                      FocusScope.of(context).unfocus();
                      log("fileName$file");
                      if(fileNameCon.text.isEmpty){
                        snackBar("Please enter file name", false);

                      }else if(file ==null)
                      {
                        snackBar("Invalid file choosen!", false);
                      }
                      else{
                        _apdPlanCub.UploadApdPlan(apd_file_name: fileNameCon.text, file: File(file!.path),project_id: projectIdMain, context: context);
                      }

                    }));
              }
            }
        ),



      ],
    ));
  }
}
