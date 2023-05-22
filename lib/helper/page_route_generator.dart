import 'package:flutter/material.dart';
import 'package:proj_site/main.dart';
import 'package:proj_site/view/apdPlan/apdPlanMainPage.dart';
import 'package:proj_site/view/createNewPassword.dart';
import 'package:proj_site/view/dashBoard.dart';
import 'package:proj_site/view/forgotPassword.dart';
import 'package:proj_site/view/homePage.dart';
import 'package:proj_site/view/logisticList/checkOutHistory.dart';
import 'package:proj_site/view/logisticList/editLogistics.dart';
import 'package:proj_site/view/logisticList/logisticMainPage.dart';
import 'package:proj_site/view/logisticList/terminalList.dart';
import 'package:proj_site/view/packageInformation.dart';
import 'package:proj_site/view/profile/profileSettingMainPage.dart';
import 'package:proj_site/view/project/calenderSetting.dart';
import 'package:proj_site/view/project/projectSettingMainPage.dart';
import 'package:proj_site/view/projectDetails.dart';
import 'package:proj_site/view/projectList.dart';
import 'package:proj_site/view/projectName.dart';
import 'package:proj_site/view/projectName/calenderView.dart';
import 'package:proj_site/view/rentalList/newRentalEntry.dart';
import 'package:proj_site/view/rentalList/rentalInformation.dart';
import 'package:proj_site/view/rentalList/rentalMainPage.dart';
import 'package:proj_site/view/logisticList/transportRequestShipment.dart';
import 'package:proj_site/view/signIn.dart';
import 'package:proj_site/view/splash.dart';
import 'package:proj_site/view/statistics/statistic.dart';
import 'package:proj_site/view/subProjectList/addNew.dart';
import 'package:proj_site/view/subProjectList/asignUsers.dart';
import 'package:proj_site/view/subProjectList/submitProjectList.dart';
import 'package:proj_site/view/unLoadingZone/createNewZone.dart';
import 'package:proj_site/view/unLoadingZone/editUnLoadingZone.dart';
import 'package:proj_site/view/unLoadingZone/unLoadingZoneMainPage.dart';
import 'package:proj_site/view/userVerify.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  final args = settings.arguments;
  switch (settings.name) {
    case Splash.id:
      return MaterialPageRoute(
        builder: (context) =>  const Splash(),
      );

    case ApdPlanMainPage.id:
      return MaterialPageRoute(
        builder: (context) => ApdPlanMainPage(),
      );

    case LogisticMainPage.id:
      return MaterialPageRoute(
        builder: (context) => LogisticMainPage(args as String),
      );

    case ProfileSettingMainPage.id:
      return MaterialPageRoute(
        builder: (context) => ProfileSettingMainPage(),
      );

    case ProjectSettingMainPage.id:
      return MaterialPageRoute(
        builder: (context) => ProjectSettingMainPage(),
      );

    case SubmitProjectList.id:
      return MaterialPageRoute(
        builder: (context) => SubmitProjectList(),
      );

    case AddNew.id:
      return MaterialPageRoute(
        builder: (context) => AddNew(),
      );

    case AssignUsers.id:
      return MaterialPageRoute(
        builder: (context) => AssignUsers(),
      );

    case UnLoadingZoneMainPage.id:
      return MaterialPageRoute(
        builder: (context) => UnLoadingZoneMainPage(),
      );

    case CreateNewZone.id:
      return MaterialPageRoute(
        builder: (context) => CreateNewZone(),
      );

    case EditUnLoadingZone.id:
      return MaterialPageRoute(
        builder: (context) => EditUnLoadingZone(),
      );

    case NewPassword.id:
      return MaterialPageRoute(
        builder: (context) => NewPassword(),
      );

    case DashBoard.id:
      return MaterialPageRoute(
        builder: (context) => DashBoard(),
      );

    case ForgotPassword.id:
      return MaterialPageRoute(
        builder: (context) => ForgotPassword(),
      );

    case HomePage.id:
      return MaterialPageRoute(
        builder: (context) => HomePage(),
      );

    case PackageInformation.id:
      return MaterialPageRoute(
        builder: (context) => PackageInformation(),
      );

    case ProjectDetails.id:
      return MaterialPageRoute(
        builder: (context) => ProjectDetails(),
      );

    case ProjectList.id:
      return MaterialPageRoute(
        builder: (context) => ProjectList(),
      );

    case ProjectName.id:
      return MaterialPageRoute(
        builder: (context) => ProjectName(),
      );

    case SignIn.id:
      return MaterialPageRoute(
        builder: (context) => SignIn(),
      );

    case UserVerify.id:
      return MaterialPageRoute(
        builder: (context) => UserVerify(),
      );
    case CheckOutHistory.id:
      return MaterialPageRoute(
        builder: (context) => CheckOutHistory(args as String),
      );
    case RentalMainPage.id:
      return MaterialPageRoute(
        builder: (context) => RentalMainPage(),
      );
    case StatisticScreen.id:
      return MaterialPageRoute(
        builder: (context) => StatisticScreen(),
      );
    case RentalInformation.id:
      return MaterialPageRoute(
        builder: (context) => RentalInformation(args as int),
      );
    case CalenderView.id:
      return MaterialPageRoute(
        builder: (context) => CalenderView(),
      );
    case EditLogistics.id:
      return MaterialPageRoute(
        builder: (context) => EditLogistics(args as String),
      );
  case TerminalList.id:
    return MaterialPageRoute(
      builder: (context) => TerminalList(),
    );

    default:
      return MaterialPageRoute(builder: (_) {
        return Scaffold(
          body: Center(
            child: Text('No route defined for ${settings.name}'),
          ),
        );
      });
  }
}