import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ftx/navigationX.dart';
import 'package:proj_site/common/colors/colors.dart';
import 'package:proj_site/common/widget_constant/widget_constant.dart';
import 'package:proj_site/cubits/auth_cubit.dart';
import 'package:proj_site/cubits/project_list_cubit.dart';
import 'package:proj_site/helper/helper.dart';

class ProjectDetails extends StatefulWidget {
  static const id = 'ProjectDetails_screen';
  const ProjectDetails({Key? key}) : super(key: key);

  @override
  State<ProjectDetails> createState() => _ProjectDetailsState();
}

class _ProjectDetailsState extends State<ProjectDetails> {
  List<TextEditingController> _controllers = [];
  int totalItem = 5;
  final List<String> _text = ["Project","Organization","Duration","Location","Project Admin"];
  final List<String> _hintText = ["Project Name","Organization Name","04-Mar-2021 to 04-Mar-2022","Frösundaleden 4, 169 70 Solna, Sverige","Mahan Vosoughi"];
  late ProjectListCubit projectListCub;
  late AuthCubit authCub;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for (int i = 0; i < totalItem; i++) {
      _controllers.add(TextEditingController());
    }
    authCub = BlocProvider.of<AuthCubit>(context);
    projectListCub=BlocProvider.of<ProjectListCubit>(context);
    projectListCub.ProjectDetails(projectIdMain);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: getAppBarWithIcon(ctx: context) as PreferredSizeWidget?,
      body: getCommonContainer(
        color: Colors.white,
        height: screenHeight(context),
        width: screenWidth(context),
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            getCommonContainer(
              height: screenHeight(context,dividedBy: 16),
              width: screenWidth(context),
              color: Colors.transparent,
              alignment: Alignment.centerLeft,
              child: commonText("Project Details",
                  color: Colors.black,
                  fontFamily: LexendBold,
                  fontWeight: FontWeight.w700,
                  fontSize: 20),
            ),
            verticalSpaces(context, height: 100),
            Expanded(child: BlocBuilder<ProjectListCubit, ProjectListState>(
              builder: (context, state) {
                if(state is ProjectDetailsLoading){
                  return loader();
                }else if (state is ProjectDetailsError){
                  return errorLoadDataText();
                }
                else{
                  _controllers[0].text=projectListCub.projectDetails!.projectDetails!.projectName.toString();
                  _controllers[1].text=projectListCub.projectDetails!.organizationDetails!.organizationName.toString();
                  _controllers[2].text= "${projectListCub.projectDetails!.projectDetails!.fromDate!} to ${projectListCub.projectDetails!.projectDetails!.toDate!}";
                  _controllers[3].text=projectListCub.projectDetails!.projectDetails!.projectLocation.toString();
                  _controllers[4].text="${projectListCub.projectDetails!.organizationDetails!.firstName.toString()} ${projectListCub.projectDetails!.organizationDetails!.lastName==null?"":projectListCub.projectDetails!.organizationDetails!.lastName.toString()}";
                  return ListView.builder(padding: EdgeInsets.zero,scrollDirection: Axis.vertical,physics: BouncingScrollPhysics(),shrinkWrap: true,itemCount: _controllers.length,
                    itemBuilder: (context, index) {
                      return getCommonContainer(
                        margin: EdgeInsets.only(bottom: 15),
                        color: Colors.transparent,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            commonText(_text[index],
                                color: Colors.black,
                                fontFamily: LexendRegular,
                                fontWeight: FontWeight.w400,
                                fontSize: 12),
                            verticalSpaces(context, height: 80),
                            getRoundedTexfield(
                                readOnly: true,
                                hintText: "",
                                controller: _controllers[index], ctx: context),
                          ],
                        ),
                      );
                    },
                  );
                }

              },
            )),
          ],
        ),
      ),
    );
  }
}
