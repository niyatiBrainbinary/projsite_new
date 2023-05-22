import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:proj_site/common/colors/colors.dart';
import 'package:proj_site/common/widget_constant/widget_constant.dart';
import 'package:proj_site/helper/helper.dart';
import 'package:proj_site/common/image_constant/image_constant.dart';

class StatisticTableScreen extends StatefulWidget {
  const StatisticTableScreen({Key? key}) : super(key: key);

  @override
  State<StatisticTableScreen> createState() => _StatisticTableScreenState();
}

class _StatisticTableScreenState extends State<StatisticTableScreen> {


  List table = [
    {"wc" : "test99", "nc": "2", "wf": "fraction1", "af" : "5", "t" : "3"},
    {"wc" : "test99", "nc": "3", "wf": "fraction2", "af" : "2", "t" : "1"},
    {"wc" : "test99", "nc": "1", "wf": "fraction3", "af" : "3", "t" : "1"},
  ];


  String? toDate;
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
        toDate = formattedDate;
      });
    } else {
      print("Date is not selected");
    }
  }

  List _dropdownValuesSubProject = ["One", "Two", "Three", "Four"];
  var dropDownValSubProject;

  TextEditingController idController = TextEditingController();



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
                          rows: List.generate(table.length, (index) {
                        return DataRow(
                            cells: [
                              DataCell(Text(table[index]["wc"])),
                              DataCell(Text(table[index]["nc"])),
                              DataCell(Text(table[index]["wf"])),
                              DataCell(Text(table[index]["af"])),
                              DataCell(Text(table[index]["t"])),
                            ]);
                      })
                      ),
                    ),
                    bottomUi(),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
  Widget bottomUi(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        verticalSpaces(context, height: 30),
        commonText("Date",
            color: Colors.black,
            fontFamily: LexendRegular,
            fontWeight: FontWeight.w400,
            fontSize: 12),
        verticalSpaces(context, height: 80),


        GestureDetector(
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
                            toDate == null ? "No date selected" : toDate!,
                            color:  toDate == null ? HexColor.Gray53 : Colors.black.withOpacity(0.8),
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
        ),

        verticalSpaces(context, height: 30),
        commonText("Sub Project",
            color: Colors.black,
            fontFamily: LexendRegular,
            fontWeight: FontWeight.w400,
            fontSize: 14),
        verticalSpaces(context, height: 80),
        Container(
          height: 45,
          padding: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(
                  color: HexColor.Gray53.withOpacity(0.6),
                  width: 1)),
          child: DropdownButtonHideUnderline(
            child: DropdownButton(
              hint: Text('Select Sub Project', style:  TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                fontFamily: LexendRegular,
                color: HexColor.Gray53,
              ),),
              icon: Image.asset(icons.ic_downArrow, height: 7),
              items: _dropdownValuesSubProject
                  .map((value) {
                return DropdownMenuItem(
                  child: Text(value),
                  value: value,
                );
              }).toList(),
              onChanged: (value) {
                print(value.runtimeType);
                print(value);
                dropDownValSubProject = value!;
                setState(() {});

              },
              isExpanded: true,
              value: dropDownValSubProject,
            ),
          ),
        ),
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
            controller: idController,
            keyboardType: TextInputType.number,
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
        Align(
          alignment: Alignment.center,
          child: commonButton(
              context: context, buttonName: "Save", onTap: () {}),
        ),
        verticalSpaces(context, height: 30),
      ],
    );
  }
}

