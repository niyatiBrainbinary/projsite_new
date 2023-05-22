import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proj_site/common/colors/colors.dart';
import 'package:proj_site/common/widget_constant/widget_constant.dart';
import 'package:proj_site/cubits/auth_cubit.dart';
import 'package:proj_site/cubits/sub_project_user_list_cubit.dart';

class ViewSubProject extends StatefulWidget {
  String? subProjectName;
  String? subProjectId;
  String? projectId;
  String? orgId;
  String? projectName;

   ViewSubProject({Key? key, this.subProjectName, this.subProjectId, this.projectId, this.orgId, this.projectName}) : super(key: key);

  @override
  State<ViewSubProject> createState() => _ViewSubProjectState();
}

class _ViewSubProjectState extends State<ViewSubProject> {
  late SubProjectUserListCubit _subProjectUserListCubit;
  late AuthCubit authCub;

  TextEditingController _subName = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _subName.text = widget.subProjectName ?? "";

    authCub = BlocProvider.of<AuthCubit>(context);
    _subProjectUserListCubit = BlocProvider.of<SubProjectUserListCubit>(context);



  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBarWithIcon(ctx: context) as PreferredSizeWidget?,
      body: getCommonContainer(
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            getSimpleTwoRowText(
                ctx: context,
                tittle1: "Sub Project List",
                tittle2: widget.projectName ?? ""),
            verticalSpaces(context, height: 20),
            /* getSimpleTextWithAsteriskSymbol(text: "Project"),
            verticalSpaces(context, height: 100),
            Container(
              height: 52,
              width: screenWidth(context),
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(
                      color: HexColor.Gray53.withOpacity(0.6),
                      width: 1.5)),
              child: DropdownButtonHideUnderline(
                child: DropdownButton(
                  hint: Text('Select'),
                  icon: Image.asset(icons.ic_downArrow, height: 7),
                  items: _dropdownValues
                      .map((value) => DropdownMenuItem(
                    child: Text(value),
                    value: value,
                  ))
                      .toList(),
                  onChanged: (value) {},
                  isExpanded: true,
                  value: _dropdownValues.first,
                ),
              ),
            ),*/
            verticalSpaces(context, height: 40),
            getSimpleTextWithAsteriskSymbol(text: "Sub Project Name"),
            verticalSpaces(context, height: 100),
            getRoundedTexfield(hintText: "Enter Sub Project Name", controller: _subName, ctx: context),
            verticalSpaces(context, height: 10),
            Align(alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    commonButton(context: context, buttonName: "Submit", onTap: (){
                      _subProjectUserListCubit.UpdateSubProject(
                        context: context,
                        projectId: widget.projectId ?? "",
                        subProjectId: widget.subProjectId ?? "",
                        subProjectName:  _subName.text,
                        orgId: widget.orgId ?? "",
                      );
                    }),
                    horizontal(context, width: 20),
                    commonButton(
                        context: context,
                        buttonName: "Cancel",
                        width: 95,
                        buttonColor: HexColor.Gray53.withOpacity(0.5),
                        onTap: () {
                          Navigator.pop(context);
                        }),
                  ],
                ),
            )
          ],
        ),
      ),
    );
  }
}
