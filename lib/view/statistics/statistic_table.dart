import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:proj_site/common/colors/colors.dart';
import 'package:proj_site/common/widget_constant/widget_constant.dart';
import 'package:proj_site/cubits/auth_cubit.dart';
import 'package:proj_site/cubits/statistic_cubit.dart';
import 'package:proj_site/helper/helper.dart';
import 'package:proj_site/common/image_constant/image_constant.dart';
import 'package:proj_site/view/packageInformation.dart';

class StatisticTableScreen extends StatefulWidget {
  const StatisticTableScreen({Key? key}) : super(key: key);

  @override
  State<StatisticTableScreen> createState() => _StatisticTableScreenState();
}

class _StatisticTableScreenState extends State<StatisticTableScreen> {

  late StatisticsCubit _statisticsCubit;
  late AuthCubit authCub;


  List table = [
    {"wc" : "test99", "nc": "2", "wf": "fraction1", "af" : "5", "t" : "3"},
    {"wc" : "test99", "nc": "3", "wf": "fraction2", "af" : "2", "t" : "1"},
    {"wc" : "test99", "nc": "1", "wf": "fraction3", "af" : "3", "t" : "1"},
  ];

  @override
  void initState() {
    _statisticsCubit = BlocProvider.of<StatisticsCubit>(context);
    authCub = BlocProvider.of<AuthCubit>(context);

    _statisticsCubit.subProjectDropDownList(projectId: projectIdMain, orgId: authCub.userInfoLogin!.mobileOrganizationId!);

    super.initState();
  }



  DateTime? dueDate;

  _onTap2() async {
    dueDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2101));
    if (dueDate != null) {

      String formattedDate = DateFormat('yyyy-MM-dd').format(dueDate!);
      print(formattedDate);

      setState(() {
        _statisticsCubit.toDate = formattedDate;
      });
    } else {
      print("Date is not selected");
    }
  }

  List _dropdownValuesSubProject = ["One", "Two", "Three", "Four"];



 bool isDrop = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBarWithIcon(ctx: context) as PreferredSizeWidget?,
      body: GestureDetector(
        onTap: (){
          isDrop = false;
          setState(() {});
        },
        child: getCommonContainer(
          color: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              getCommonContainer(
                height: screenHeight(context, dividedBy: 16),
                width: screenWidth(context),
                color: Colors.transparent,
                child: Row(
                  children: [
                    getContainerWithTralingIcon(ctx: context, text: 'Statistic'),
                    Spacer(),
                    commonButton(
                      context: context,
                      buttonName: "Add more",
                      buttonTextSize: 14,
                      height: screenHeight(context, dividedBy: 22),
                      width: screenWidth(context, dividedBy: 4),
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              ),
              verticalSpaces(context, height: 40),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      /// table
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                            columns: const [
                              DataColumn(
                                label: Text('Waste\ncontainer'),
                              ),
                              DataColumn(
                                label: Text('Number of\ncontainers'),
                              ),
                              DataColumn(
                                label: Text('Waste\nfraction'),
                              ),
                              DataColumn(
                                label: Text('Amount of\nfraction'),
                              ),
                              DataColumn(
                                label: Text('Amount of\ntransports'),
                              ),
                            ],
                            rows: List.generate(_statisticsCubit.wasteData.length, (index) {
                              return DataRow(
                                  cells: [
                                    DataCell(Text(_statisticsCubit.wasteData[index]["waste_container"])),
                                    DataCell(Text(_statisticsCubit.wasteData[index]["number_of_containers"].toString())),
                                    DataCell(Text(_statisticsCubit.wasteData[index]["waste_fraction"])),
                                    DataCell(Text(_statisticsCubit.wasteData[index]["amount_of_fraction"].toString())),
                                    DataCell(Text(_statisticsCubit.wasteData[index]["amount_of_transports"].toString())),
                                  ]);
                            })
                        ),
                      ),


                      /// bottom ui
                      verticalSpaces(context, height: 30),
                      commonText("Date",
                          color: Colors.black,
                          fontFamily: LexendRegular,
                          fontWeight: FontWeight.w400,
                          fontSize: 12),
                      verticalSpaces(context, height: 80),

                      BlocBuilder<StatisticsCubit, StatisticsState>(
                        builder: (context, state) {
                          return  GestureDetector(
                            onTap: _onTap2 as void Function()?,
                            child: Container(
                              height: 45,
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  border: Border.all(
                                      color: HexColor.Gray53.withOpacity(0.6),
                                      width: 1)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                      child: Container(
                                          child: commonText(
                                              _statisticsCubit.toDate == null ? "No date selected" :  _statisticsCubit.toDate!,
                                              color:   _statisticsCubit.toDate == null ? HexColor.Gray53 : Colors.black.withOpacity(0.8),
                                              fontFamily: LexendRegular,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14,
                                              maxLines: 1))),
                                  Container(
                                    child: Image.asset(icons.ic_calendar),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),


                      verticalSpaces(context, height: 30),
                      commonText("Sub Project",
                          color: Colors.black,
                          fontFamily: LexendRegular,
                          fontWeight: FontWeight.w400,
                          fontSize: 14),
                      verticalSpaces(context, height: 80),


                      /* BlocBuilder<StatisticsCubit, StatisticsState>(
                      builder: (context, state) {
                        return Container(
                          height: 45,
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(
                                  color: HexColor.Gray53.withOpacity(0.6),
                                  width: 1)),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              hint: Text(
                                "Select Sub Project",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: LexendRegular,
                                  color: HexColor.Gray53,
                                ),
                              ),
                              icon:
                              Image.asset(icons.ic_downArrow, height: 7),
                              items: _statisticsCubit
                                  .subProjectList
                                  .map((value) {
                                return DropdownMenuItem(
                                  child: Text(value["name"]),
                                  value: value["name"],
                                );
                              }).toList(),
                              onChanged: (value) {
                                print(value.runtimeType);
                                print(value);
                                _statisticsCubit.subProjectName = value!;
                                _statisticsCubit.subProjectList.forEach((element) {
                                  if(element["name"] == value){
                                    _statisticsCubit.subProjectId = element["id"];
                                  }

                                });
                                setState(() {});
                              },
                              isExpanded: true,
                              value:  _statisticsCubit.subProjectName,
                            ),
                          ),
                        );
                      },

                    ),*/

                      /// drop down,  id,  save button

                      Stack(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              /// drop down sub project
                              BlocBuilder<StatisticsCubit, StatisticsState>(
                                builder: (context, state) {
                                  return    InkWell(
                                    onTap: (){
                                      if(isDrop == false){
                                        isDrop = true;
                                      }
                                      else{
                                        isDrop = false;
                                      }
                                      setState(() {});
                                    },
                                    child: Container(
                                      height: screenHeight(context, dividedBy: 15),
                                      width: screenWidth(context),
                                      padding: EdgeInsets.symmetric(horizontal: 10),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10.0),
                                          border:
                                          Border.all(color: HexColor.Gray53.withOpacity(0.6), width: 1)),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          ( _statisticsCubit.subProjectName == null) ? Text("Select Sub Project",  style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: LexendRegular,
                                            color: HexColor.Gray53,
                                          ),) : Text("${_statisticsCubit.subProjectName}", style: const TextStyle(fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: LexendRegular,),),
                                          Icon(Icons.keyboard_arrow_down_rounded, color: HexColor.Gray53,),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),



                              /// id

                              verticalSpaces(context, height: 30),
                              commonText("ID",
                                  color: Colors.black,
                                  fontFamily: LexendRegular,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14),
                              verticalSpaces(context, height: 80),
                              Container(
                                height: 45,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  border: Border.all(color: HexColor.Gray53.withOpacity(0.5), width: 1),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: TextField(
                                  controller: _statisticsCubit.idController,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  decoration: InputDecoration(
                                    isCollapsed: true,
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.only(left: 9, right: 9),
                                    hintText: "".tr(),
                                    hintStyle: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: LexendRegular,
                                      color: HexColor.Gray53,
                                    ),


                                  ),
                                ),
                              ),
                              verticalSpaces(context, height: 30),

                              /// save
                              BlocBuilder<StatisticsCubit, StatisticsState>(
                                builder: (context, state) {
                                  if(state is SaveStatisticLoading){
                                    return Align(
                                      alignment: Alignment.center,
                                      child: Container(
                                        height: screenHeight(context, dividedBy: 18),
                                        width: screenWidth(context, dividedBy: 3.2),
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(32),
                                          color: HexColor.buttonColor,
                                        ),
                                        child: LoadingAnimationWidget.prograssiveDots(
                                          color: Colors.black,
                                          size: 35,
                                        ),
                                      ),
                                    );
                                  } else {
                                    return  Align(
                                      alignment: Alignment.center,
                                      child: commonButton(
                                          context: context, buttonName: "Save", onTap: () {
                                        FocusScope.of(context).unfocus();
                                        if(_statisticsCubit.idController.text.trim() == ""){
                                          snackBar("Please enter id", false);
                                        } else if( _statisticsCubit.toDate == null){
                                          snackBar("Please select date", false);
                                        } else if (_statisticsCubit.subProjectId == null) {
                                          snackBar("Please select sub project", false);
                                        } else{

                                          _statisticsCubit.saveStatistic(
                                            projectId: projectIdMain,
                                            wasteListId: _statisticsCubit.idController.text,
                                            subprojectId: _statisticsCubit.subProjectId,
                                            date:  _statisticsCubit.toDate!,
                                          );

                                        }
                                      }),
                                    );
                                  }

                                },
                              ),

                              verticalSpaces(context, height: 30),
                            ],
                          ),

                          (isDrop == true)
                              ? Container(
                            //height: screenHeight(context,  dividedBy: 5),
                            width: screenWidth(context, dividedBy: 0.5),
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade300,
                                  blurRadius: 10.0,
                                  spreadRadius: 2.0,
                                ),
                              ],
                            ),
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: List.generate(_statisticsCubit
                                    .subProjectList.length, (index) => InkWell(
                                  onTap: (){
                                    _statisticsCubit.subProjectName =  _statisticsCubit.subProjectList[index]["name"];
                                    isDrop = false;
                                    setState(() {});
                                    for (int i = 0; i < _statisticsCubit.subProjectList.length; i++) {
                                      if( _statisticsCubit.subProjectList[index]["name"] ==  _statisticsCubit.subProjectName){
                                        _statisticsCubit.subProjectId =  _statisticsCubit.subProjectList[index]["id"];
                                      }
                                    }
                                    setState(() {});

                                  },
                                  child: Row(
                                    children: [
                                      Padding(
                                          child: Text("${_statisticsCubit.subProjectList[index]["name"]}", style: TextStyle(fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: LexendRegular,),
                                          ),
                                          padding : EdgeInsets.only(left: 20, top: 10, bottom: 10)
                                      ),
                                    ],
                                  ),
                                )
                                ),

                              ),
                            ),

                          )
                              : SizedBox(),
                        ],
                      ),

                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

}

