import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ftx/navigationX.dart';
import 'package:proj_site/cubits/apd_plan_cubit.dart';
import 'package:proj_site/cubits/auth_cubit.dart';
import 'package:proj_site/cubits/booking_cubit.dart';
import 'package:proj_site/cubits/calendar_cubit.dart';
import 'package:proj_site/cubits/dashboard_cubit.dart';
import 'package:proj_site/cubits/drop_down_cubit.dart';
import 'package:proj_site/cubits/enviromental_cubit.dart';
import 'package:proj_site/cubits/internet_cubit.dart';
import 'package:proj_site/cubits/logistic_list_cubit.dart';
import 'package:proj_site/cubits/package_information_cubit.dart';
import 'package:proj_site/cubits/profile_setting_cubit.dart';
import 'package:proj_site/cubits/project_list_cubit.dart';
import 'package:proj_site/cubits/project_setting_cubit.dart';
import 'package:proj_site/cubits/rental_list_cubit.dart';
import 'package:proj_site/cubits/shipment_cubit.dart';
import 'package:proj_site/cubits/sub_project_list_cubit.dart';
import 'package:proj_site/cubits/sub_project_user_list_cubit.dart';
import 'package:proj_site/cubits/terminal_cubit.dart';
import 'package:proj_site/cubits/transport_request_cubit.dart';
import 'package:proj_site/cubits/unloading_zone_cubit.dart';
import 'package:proj_site/cubits/waste_disposal_cubit.dart';
import 'package:proj_site/helper/helper.dart';
import 'package:proj_site/helper/page_route_generator.dart';
import 'package:proj_site/model/event.dart';
import 'package:proj_site/src/calendar_controller_provider.dart';
import 'package:proj_site/src/calendar_event_data.dart';
import 'package:proj_site/src/event_controller.dart';
import 'package:proj_site/view/dashBoard.dart';
import 'package:proj_site/view/splash.dart';

import 'api service/models/logistic_list_models/logistic_list_model.dart';

DateTime get _now => DateTime.now();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(EasyLocalization(
      path: 'assets/translations',
      supportedLocales: const [Locale('en'), Locale('sv')],
      fallbackLocale: const Locale('en'),
      child: MyApp()));
}

class MyApp extends StatelessWidget {
  late  Connectivity connectivity;

  @override
  Widget build(BuildContext context) {
    return
      // CalendarControllerProvider(
      // controller: EventController<Event>()..addAll(_events),
      // child:
      MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => CalendarCubit(),
          ),
          BlocProvider(
            create: (context) => InternetCubit(connectivity: connectivity),
          ),
          BlocProvider(
            create: (context) => AuthCubit(),
          ),
          BlocProvider(
            create: (context) => ApdPlanCubit(),
          ),
          BlocProvider(
            create: (context) => RentalListCubit(),
          ),
          BlocProvider(create: (context) => UnLoadingZoneCubit(),),
          BlocProvider(create: (context) => LogisticListCubit(),),
          BlocProvider(create: (context) => ProfileSettingCubit(),),
          BlocProvider(create: (context) => ShipmentCubit(),),
          BlocProvider(create: (context) => ProjectSettingCubit(),),
          BlocProvider(create: (context) => ProjectListCubit(),),
          BlocProvider(create: (context) => TerminalCubit(),),
          BlocProvider(create: (context) => EnviromentalCubit(),),
          BlocProvider(create: (context) => DropDownCubit(),),
          BlocProvider(create: (context) => PackageInformationCubit(),),
          BlocProvider(create: (context) => BookingCubit(),),
          BlocProvider(create: (context) => DashBoardCubit(),),
          BlocProvider(create: (context) => WasteDisposalCubit(),),
          BlocProvider(create: (context) => TransportRequestCubit(),),
          BlocProvider(create: (context) => SubProjectListCubit(),),
          BlocProvider(create: (context) => SubProjectUserListCubit()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData.light(),
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          scaffoldMessengerKey: rootScaffoldMessengerKey,
          navigatorKey: Navigation.instance.navigatorKey,
          onGenerateRoute: generateRoute,
          initialRoute: Splash.id,
          scrollBehavior: ScrollBehavior().copyWith(
            dragDevices: {
              PointerDeviceKind.trackpad,
              PointerDeviceKind.mouse,
              PointerDeviceKind.touch,
            },
          ),
          // home: MyHomePage(),
        ),
      );
    //);
  }
}

