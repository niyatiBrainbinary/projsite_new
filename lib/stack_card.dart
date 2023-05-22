// import 'dart:math';
//
// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:loading_animation_widget/loading_animation_widget.dart';
// import 'package:proj_site/common/colors/colors.dart';
// import 'package:proj_site/common/widget_constant/widget_constant.dart';
// import 'package:proj_site/cubits/shipment_cubit.dart';
// import 'package:proj_site/helper/constants.dart';
// import 'package:proj_site/helper/helper.dart';
// import 'package:proj_site/view/updateShipmentRequest/updateShipment.dart';
// import 'package:stacked_card_carousel/stacked_card_carousel.dart';
//
// class StackCard extends StatefulWidget {
//   String date;
//
//   StackCard(this.date);
//
//   @override
//   State<StackCard> createState() => _StackCardState();
// }
//
// class _StackCardState extends State<StackCard> {
//   List<Widget> shipmentList = [];
//   List<Widget> itemData = [];
//   ScrollController controller = ScrollController();
//   double top = 0.0;
//
//   @override
//   void initState() {
//     getPostData();
//     controller.addListener(() {
//       double val = controller.offset / 220;
//       setState(() {
//         top = val;
//       });
//     });
//     //   shipmentList = [];
//     //   for (int i = 0; i <= 10; i++) {
//     //     shipmentList.add(
//     //       FancyCard(Date: widget.date, index: activeIndex,),
//     //     );
//     //   }
//     // shipmentList = [];
//     // for(int i=0 ; i<=10; i++){
//     //
//     //   shipmentList.add(FancyCard(
//     //       Date: widget.date, index: activeIndex,
//     //   ),);
//     // }
//   }
//
// // int activeIndex = 0;
//
//   getPostData() {
//     List<dynamic> repo = user_data;
//     List<Widget> list = [];
//     repo.forEach((post) {
//       list.add(Column(
//         children: <Widget>[
//           Container(
//               padding: EdgeInsets.all(20),
//               margin: EdgeInsets.all(10),
//
//               color:
//               Colors.primaries[Random().nextInt(Colors.primaries.length)],
//               child: Column(
//                 children: [
//                   // commonText(Date.toString(),
//                   //     color: Colors.black,
//                   //     fontFamily: LexendRegular,
//                   //     fontWeight: FontWeight.w400,
//                   //     fontSize: 18),
//                   // Container(
//                   //   margin: EdgeInsets.symmetric(vertical: 10),
//                   //   height: screenHeight(context, dividedBy: 25),
//                   //   width: screenWidth(context, dividedBy: 3.2),
//                   //   decoration: BoxDecoration(
//                   //       borderRadius: BorderRadius.circular(5),
//                   //       color: Colors.red),
//                   //   child: Center(
//                   //       child: Text(
//                   //     "Not Arrived",
//                   //     style: TextStyle(
//                   //         color: Colors.white,
//                   //         fontSize: 16,
//                   //         decoration: TextDecoration.none),
//                   //   )),
//                   Text(widget.date),
//                   Container(
//                     margin: EdgeInsets.symmetric(vertical: 10),
//                     height: 30,
//                     width: 100,
//                     decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(5),
//                         color: Colors.red),
//                     child: Center(
//                         child: Text(
//                           "Not Arrived",
//                           style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 16,
//                               decoration: TextDecoration.none),
//                         )),
//                   ),
//                   // Container(
//                   //   margin: EdgeInsets.symmetric(vertical: 10),
//                   //   height: screenHeight(context, dividedBy: 25),
//                   //   width: screenWidth(context, dividedBy: 3.2),
//                   //   decoration: BoxDecoration(
//                   //       borderRadius: BorderRadius.circular(5),
//                   //       color: Colors.indigo),
//                   //   child: Center(
//                   //       child: Text(
//                   //     "Approved",
//                   //     style: TextStyle(
//                   //         color: Colors.white,
//                   //         fontSize: 18,
//                   //         decoration: TextDecoration.none),
//                   //   ))),
//                   Container(
//                     margin: EdgeInsets.symmetric(vertical: 10),
//                     height: 30,
//                     width: 100,
//                     decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(5),
//                         color: Colors.indigo),
//                     child: Center(
//                         child: Text(
//                           "Approved",
//                           style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 18,
//                               decoration: TextDecoration.none),
//                         )),
//                   ),
//
//                   // commonText('skanska SN984',
//                   //     color: Colors.black,
//                   //     fontFamily: LexendMedium,
//                   //     fontWeight: FontWeight.w400,
//                   //     fontSize: 16),
//                   // commonText('Responsible person: SN984 Daniel',
//                   //     color: Colors.black,
//                   //     fontFamily: LexendMedium,
//                   //     fontWeight: FontWeight.w400,
//                   //     fontSize: 16),
//                   // commonText('Email:daniel@gmail.com',
//                   //     color: Colors.black,
//                   //     fontFamily: LexendMedium,
//                   //     fontWeight: FontWeight.w400,
//                   //     fontSize: 16),
//                   // commonText('Phone:0718469935',
//                   //     color: Colors.black,
//                   //     fontFamily: LexendMedium,
//                   //     fontWeight: FontWeight.w400,
//                   //     fontSize: 16),
//                   // verticalSpaces(context, height: 40),
//                   Text(post['name']),
//                   Text(post['Responsible person']),
//                   Text(post['email']),
//                   Text(post['Phone']),
//                   Align(
//                       alignment: Alignment.center,
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         children: [
//                           ElevatedButton(
//                             style: TextButton.styleFrom(
//                               backgroundColor:
//                               HexColor.carnation, // Background Color
//                             ),
//                             onPressed: () {
//                               Navigator.pop(context);
//                             },
//                             child: Text('Cancel'),
//                           ),
//                           ElevatedButton(
//                             style: TextButton.styleFrom(
//                               backgroundColor:
//                               HexColor.orange, // Background Color
//                             ),
//                             onPressed: () {
//                               // Navigator.push(context, MaterialPageRoute(
//                               //   builder: (context) {
//                               //     return UpdateShipment("");
//                               //   },
//                               // ));
//                             },
//                             child: Text('Update'),
//                           ),
//                         ],
//                       )),
//                 ],
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//               )),
//           // Container(
//           //   width: 250,
//           //   height: 250,
//           //   // child: image,
//           //   color: Colors.orange,
//           // ),
//           // Text(
//           //   title,
//           //   style: Theme.of(context).textTheme.headline5,
//           // ),
//           // ElevatedButton(
//           //   child: const Text("Learn more"),
//           //   onPressed: () => print("Button was tapped"),
//           // ),
//         ],
//       ));
//       setState(() {
//         itemData = list;
//       });
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // List<Widget> fancyCards = [
//     //   FancyCard(
//     //     //  image: Image.asset("image/pluto-done.png"),
//     //
//     //       Date: widget.date
//     //   ),
//     //   FancyCard(
//     //     //  image: Image.asset("image/pluto-fatal-error.png"),
//     //
//     //     Date: widget.date,
//     //   ),
//     //   FancyCard(
//     //     //  image: Image.asset("image/pluto-coming-soon.png"),
//     //
//     //     Date: widget.date,
//     //   ),
//     //   FancyCard(
//     //     //image: Image.asset("image/pluto-sign-up.png"),
//     //
//     //     Date: widget.date,
//     //   ),
//     //   FancyCard(
//     //     // image: Image.asset("image/pluto-waiting.png"),
//     //
//     //     Date: widget.date,
//     //   ),
//     //   FancyCard(
//     //     //  image: Image.asset("image/pluto-welcome.png"),
//     //
//     //     Date: widget.date,
//     //   ),
//     // ];
//     // return StackedCardCarousel(
//     //   initialOffset: 0,
//     //   onPageChanged: (pageIndex) {
//     //     setState(() {
//     //       activeIndex = pageIndex;
//     //       print("ind$activeIndex");
//     //     });
//     //   },
//     //   items: shipmentList,
//     // );
//     return ListView.builder(
//       controller: controller,
//       itemCount: itemData.length,
//       shrinkWrap: true,
//       physics: BouncingScrollPhysics(),
//       itemBuilder: (context, index) {
//         double scale = 1.0;
//         if(top>0.5){
//           scale = index+0.5-top;
//           print("scale$scale");
//           if(scale <0){
//             scale =0.0;
//           }
//           else if(scale >1){
//             scale =1;
//           }
//         }
//         return itemData[index];
//       },
//     );
//   }
// }
//
// class FancyCard extends StatelessWidget {
//   const FancyCard({
//     //  required this.image,
//     //   required this.title,
//     required this.Date,
//     required this.index,
//   }) : super();
//
//   // final Image image;
//   //final String title;
//   final String Date;
//   final int index;
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: <Widget>[
//         Container(
//             padding: EdgeInsets.all(20),
//             //margin: EdgeInsets.all(5),
//             width: screenWidth(context, dividedBy: 1.3),
//             height: screenHeight(context, dividedBy: 2),
//             color: Colors.primaries[Random().nextInt(Colors.primaries.length)],
//             child: Column(
//               children: [
//                 // commonText(Date.toString(),
//                 //     color: Colors.black,
//                 //     fontFamily: LexendRegular,
//                 //     fontWeight: FontWeight.w400,
//                 //     fontSize: 18),
//                 // Container(
//                 //   margin: EdgeInsets.symmetric(vertical: 10),
//                 //   height: screenHeight(context, dividedBy: 25),
//                 //   width: screenWidth(context, dividedBy: 3.2),
//                 //   decoration: BoxDecoration(
//                 //       borderRadius: BorderRadius.circular(5),
//                 //       color: Colors.red),
//                 //   child: Center(
//                 //       child: Text(
//                 //     "Not Arrived",
//                 //     style: TextStyle(
//                 //         color: Colors.white,
//                 //         fontSize: 16,
//                 //         decoration: TextDecoration.none),
//                 //   )),
//                 commonText(Date.toString(),
//                     color: Colors.black,
//                     fontFamily: LexendRegular,
//                     fontWeight: FontWeight.w400,
//                     fontSize: 18),
//                 BlocBuilder<ShipmentCubit, ShipmentState>(
//                   builder: (context, state) {
//                     if (state is UpdateTransportStatusLoading) {
//                       return Container(
//                         margin: EdgeInsets.symmetric(vertical: 10),
//                         height: screenHeight(context, dividedBy: 25),
//                         width: screenWidth(context, dividedBy: 3.2),
//                         alignment: Alignment.center,
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(5),
//                             color: Colors.red),
//                         child: LoadingAnimationWidget.prograssiveDots(
//                           color: Colors.white,
//                           size: 35,
//                         ),
//                       );
//                     } else {
//                       return GestureDetector(
//                         onTap: () {
//                           print("index of $index");
//
//                           BlocProvider.of<ShipmentCubit>(context)
//                               .UpdateTransportStatus();
//                         },
//                         child: Container(
//                           margin: EdgeInsets.symmetric(vertical: 10),
//                           height: screenHeight(context, dividedBy: 25),
//                           width: screenWidth(context, dividedBy: 3.2),
//                           decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(5),
//                               color: Colors.red),
//                           child: Center(
//                               child: Text(
//                                 "Not Arrived",
//                                 style: TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 16,
//                                     decoration: TextDecoration.none),
//                               )),
//                         ),
//                       );
//                     }
//                   },
//                 ),
//                 // Container(
//                 //   margin: EdgeInsets.symmetric(vertical: 10),
//                 //   height: screenHeight(context, dividedBy: 25),
//                 //   width: screenWidth(context, dividedBy: 3.2),
//                 //   decoration: BoxDecoration(
//                 //       borderRadius: BorderRadius.circular(5),
//                 //       color: Colors.indigo),
//                 //   child: Center(
//                 //       child: Text(
//                 //     "Approved",
//                 //     style: TextStyle(
//                 //         color: Colors.white,
//                 //         fontSize: 18,
//                 //         decoration: TextDecoration.none),
//                 //   ))),
//                 BlocBuilder<ShipmentCubit, ShipmentState>(
//                   builder: (
//                       context,
//                       state,
//                       ) {
//                     if (state is UpdateApprovalStatusLoading) {
//                       return Container(
//                         margin: EdgeInsets.symmetric(vertical: 10),
//                         height: screenHeight(context, dividedBy: 25),
//                         width: screenWidth(context, dividedBy: 3.2),
//                         alignment: Alignment.center,
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(5),
//                             color: Colors.indigo),
//                         child: LoadingAnimationWidget.prograssiveDots(
//                           color: Colors.white,
//                           size: 35,
//                         ),
//                       );
//                     } else {
//                       return GestureDetector(
//                         onTap: () {
//                           BlocProvider.of<ShipmentCubit>(context)
//                               .UpdateApprovalStatus();
//                         },
//                         child: Container(
//                           margin: EdgeInsets.symmetric(vertical: 10),
//                           height: screenHeight(context, dividedBy: 25),
//                           width: screenWidth(context, dividedBy: 3.2),
//                           decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(5),
//                               color: Colors.indigo),
//                           child: Center(
//                               child: Text(
//                                 "Approved",
//                                 style: TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 18,
//                                     decoration: TextDecoration.none),
//                               )),
//                         ),
//                       );
//                     }
//                   },
//                 ),
//
//                 // commonText('skanska SN984',
//                 //     color: Colors.black,
//                 //     fontFamily: LexendMedium,
//                 //     fontWeight: FontWeight.w400,
//                 //     fontSize: 16),
//                 // commonText('Responsible person: SN984 Daniel',
//                 //     color: Colors.black,
//                 //     fontFamily: LexendMedium,
//                 //     fontWeight: FontWeight.w400,
//                 //     fontSize: 16),
//                 // commonText('Email:daniel@gmail.com',
//                 //     color: Colors.black,
//                 //     fontFamily: LexendMedium,
//                 //     fontWeight: FontWeight.w400,
//                 //     fontSize: 16),
//                 // commonText('Phone:0718469935',
//                 //     color: Colors.black,
//                 //     fontFamily: LexendMedium,
//                 //     fontWeight: FontWeight.w400,
//                 //     fontSize: 16),
//                 // verticalSpaces(context, height: 40),
//                 commonText('skanska SN984',
//                     color: Colors.black,
//                     fontFamily: LexendMedium,
//                     fontWeight: FontWeight.w400,
//                     fontSize: 16),
//                 commonText('Responsible person: SN984 Daniel',
//                     color: Colors.black,
//                     fontFamily: LexendMedium,
//                     fontWeight: FontWeight.w400,
//                     fontSize: 16),
//                 commonText('Email:daniel@gmail.com',
//                     color: Colors.black,
//                     fontFamily: LexendMedium,
//                     fontWeight: FontWeight.w400,
//                     fontSize: 16),
//                 commonText('Phone:0718469935',
//                     color: Colors.black,
//                     fontFamily: LexendMedium,
//                     fontWeight: FontWeight.w400,
//                     fontSize: 16),
//                 verticalSpaces(context, height: 40),
//                 Align(
//                     alignment: Alignment.center,
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         ElevatedButton(
//                           style: TextButton.styleFrom(
//                             backgroundColor:
//                             HexColor.carnation, // Background Color
//                           ),
//                           onPressed: () {
//                             Navigator.pop(context);
//                           },
//                           child: commonText('Cancel',
//                               color: Colors.black,
//                               fontFamily: LexendRegular,
//                               fontWeight: FontWeight.w400,
//                               fontSize: 16),
//                         ),
//                         ElevatedButton(
//                           style: TextButton.styleFrom(
//                             backgroundColor:
//                             HexColor.orange, // Background Color
//                           ),
//                           onPressed: () {
//                             // Navigator.push(context, MaterialPageRoute(
//                             //   builder: (context) {
//                             //     return UpdateShipment("");
//                             //   },
//                             // ));
//                           },
//                           child: commonText('Update',
//                               color: Colors.black,
//                               fontFamily: LexendRegular,
//                               fontWeight: FontWeight.w400,
//                               fontSize: 16),
//                         ),
//                       ],
//                     )),
//               ],
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.start,
//             )),
//         // Container(
//         //   width: 250,
//         //   height: 250,
//         //   // child: image,
//         //   color: Colors.orange,
//         // ),
//         // Text(
//         //   title,
//         //   style: Theme.of(context).textTheme.headline5,
//         // ),
//         // ElevatedButton(
//         //   child: const Text("Learn more"),
//         //   onPressed: () => print("Button was tapped"),
//         // ),
//       ],
//     );
//   }
// }