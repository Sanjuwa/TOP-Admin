import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:top_admin/constants.dart';

import '../widgets/availability_tile.dart';
import '../widgets/backdrop.dart';
import '../widgets/badge.dart';
import '../widgets/button.dart';
import '../widgets/heading_card.dart';

class Availability extends StatefulWidget {

  @override
  State<Availability> createState() => _AvailabilityState();
}

class _AvailabilityState extends State<Availability> {
  @override
  Widget build(BuildContext context) {

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
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15.w),
                            child: RefreshIndicator(
                              onRefresh: () async => setState(() {}),
                              child: ListView.builder(
                                padding: EdgeInsets.zero,
                                physics: BouncingScrollPhysics(
                                  parent: AlwaysScrollableScrollPhysics(),
                                ),
                                itemCount: 5,
                                itemBuilder: (context, i) {

                                  return AvailabilityTile(
                                    dateString: DateFormat('EEE MMM dd').format(DateTime.now()),
                                    am: AvailabilityStatus.Available,
                                    pm: AvailabilityStatus.NotAvailable,
                                    ns: AvailabilityStatus.Booked,
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
