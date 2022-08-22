import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:top_admin/constants.dart';
import 'package:top_admin/controllers/role_controller.dart';
import 'package:top_admin/models/shift_model.dart';
import 'package:top_admin/models/user_model.dart';
import 'package:top_admin/widgets/availability_tile.dart';
import 'package:top_admin/widgets/backdrop.dart';
import 'package:top_admin/widgets/badge.dart';
import 'package:top_admin/widgets/heading_card.dart';

class Availability extends StatelessWidget {
  final User user;

  const Availability({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    var roleController = Provider.of<RoleController>(context);

    return Scaffold(
      body: Backdrop(
        child: Padding(
          padding: EdgeInsets.all(30.w),
          child: Column(
            children: [
              Expanded(
                child: HeadingCard(
                  title: 'Availability',
                  child: Expanded(
                    child: Column(
                      children: [
                        SizedBox(height: ScreenUtil().statusBarHeight),
                        Padding(
                          padding: getDeviceType() == Device.Tablet?EdgeInsets.fromLTRB(15.w,15.h,15.w,26.h):EdgeInsets.fromLTRB(15.w,0,15.w,25.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(right: 6.w),
                                child: SizedBox(
                                  width: 25.w,
                                  height: getDeviceType() == Device.Tablet?25.h:20.h,
                                  child: Badge(text: '', color: Colors.green, enabled: true),
                                ),
                              ),
                              Text('Available', style: TextStyle(fontSize: getDeviceType() == Device.Tablet?18.sp:14.sp)),
                              Expanded(child: SizedBox()),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 6.w),
                                child: SizedBox(
                                  width: 25.w,
                                  height: getDeviceType() == Device.Tablet?25.h:20.h,
                                  child: Badge(text: '', color: Colors.red, enabled: true),
                                ),
                              ),
                              Text('Booked', style: TextStyle(fontSize: getDeviceType() == Device.Tablet?18.sp:14.sp)),
                              Expanded(child: SizedBox()),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 6.w),
                                child: SizedBox(
                                  width: 25.w,
                                  height: getDeviceType() == Device.Tablet?25.h:20.h,
                                  child: Badge(text: '', color: Colors.green, enabled: false),
                                ),
                              ),
                              Text('Not Available', style: TextStyle(fontSize: getDeviceType() == Device.Tablet?18.sp:14.sp)),
                            ],
                          ),
                        ),

                        //data
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15.w),
                            child: RefreshIndicator(
                              onRefresh: () async => roleController.refresh(),
                              child: FutureBuilder<List<Shift>>(
                                future: roleController.getAllAvailability(user.uid),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState == ConnectionState.waiting) {
                                    return Center(child: CircularProgressIndicator());
                                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                                    return Stack(
                                      children: [
                                        Center(
                                          child: Text('No data to show!'),
                                        ),
                                        ListView(
                                          physics: AlwaysScrollableScrollPhysics(),
                                        ),
                                      ],
                                    );
                                  }

                                  return ListView.builder(
                                    physics: BouncingScrollPhysics(
                                      parent: AlwaysScrollableScrollPhysics(),
                                    ),
                                    itemCount: snapshot.data!.length,
                                    itemBuilder: (context, i) {

                                      Shift shift = snapshot.data![i];

                                      return AvailabilityTile(
                                        dateString: shift.dateAsDateTime.toEEEMMMddFormat(),
                                        am: shift.am,
                                        pm: shift.pm,
                                        ns: shift.ns,
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
