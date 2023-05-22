import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ftx/navigationX.dart';
import 'package:proj_site/common/colors/colors.dart';
import 'package:proj_site/common/image_constant/image_constant.dart';
import 'package:proj_site/common/widget_constant/widget_constant.dart';
import 'package:proj_site/cubits/auth_cubit.dart';
import 'package:proj_site/cubits/unloading_zone_cubit.dart';
import 'package:proj_site/helper/helper.dart';
import 'package:proj_site/view/unLoadingZone/editUnLoadingZone.dart';

class ZoneList extends StatefulWidget {
  static const id = 'ZoneList_screen';

  const ZoneList({Key? key}) : super(key: key);

  @override
  State<ZoneList> createState() => _ZoneListState();
}

class _ZoneListState extends State<ZoneList> {
  late UnLoadingZoneCubit unLoadingZoneCub;
  late AuthCubit authCub;

  _zoneList() {
    return Column(
      children: [
        getCommonContainer(
            height: screenHeight(context, dividedBy: 8),
            width: screenWidth(context),
            color: Colors.transparent,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: [
                    commonText("Zone 1",
                        color: Colors.black,
                        fontFamily: LexendRegular,
                        fontWeight: FontWeight.w400,
                        fontSize: 16),
                    getContainerWithImage(
                        ctx: context,
                        icons: icons.ic_edit,
                        onTap: () {
                          Navigation.instance.navigate(EditUnLoadingZone.id);
                        }),
                    getContainerWithImage(ctx: context, icons: icons.ic_delete),
                  ],
                ),
                getSimpleRowText(sub1: "Project", sub2: "Haga Norra"),
                getDivider(height: 15)
              ],
            )),
      ],
    );
  }

  _zoneListLoader() {
    return ListView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      itemCount: 10,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.only(bottom: 10),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(7),
            child: Container(
              height: 75,
              child: getShimmerEffect(),
            ),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    unLoadingZoneCub = BlocProvider.of<UnLoadingZoneCubit>(context);
    authCub = BlocProvider.of<AuthCubit>(context);
    //unLoadingZoneCub.unLoadingZoneDetails(zoneId, organizationId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UnLoadingZoneCubit, UnLoadingZoneState>(
      builder: (context, state) {
        if (state is UnLoadingZoneDetailsLoading) {
          return _zoneListLoader();
        } else if (state is UnLoadingZoneDetailsError) {
          return errorLoadDataText();
        } else {
          // if(){
          //   return noDataFoundText();
          // } else {
            return ListView.builder(
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.zero,
              itemCount: 10,
              itemBuilder: (context, index) {
                return _zoneList();
              },
            );
          //}
        }
      },
    );
  }
}
