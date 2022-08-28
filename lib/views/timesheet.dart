import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:top_admin/widgets/approval_tile.dart';
import 'package:top_admin/widgets/shift_tile.dart';

import '../constants.dart';
import '../widgets/backdrop.dart';
import '../widgets/heading_card.dart';

class TimeSheet extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Backdrop(
        child: SingleChildScrollView(
          child: Padding(
            padding: getDeviceType() == Device.Tablet?EdgeInsets.symmetric(horizontal: 40.w, vertical: 30.h):EdgeInsets.all(30.w),
            child: Column(
              children: [
                SizedBox(
                  height: ScreenUtil().statusBarHeight,
                ),

                //details
                HeadingCard(
                  title: 'Time Sheets',
                  phoneSize: EdgeInsets.symmetric(horizontal: 35.w,vertical: 15.h),
                  tabletSize: EdgeInsets.symmetric(horizontal: 25.w,vertical: 12.h),
                  child: Padding(
                    padding: getDeviceType() == Device.Tablet?EdgeInsets.fromLTRB(15.w,35.h,15.w,20.h):EdgeInsets.fromLTRB(15.w,30.h,15.w,25.h),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerRight,
                          child: Material(
                            elevation: 5,
                            borderRadius: BorderRadius.circular(5.r),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.horizontal(left: Radius.circular(5.r)),
                                    color: kGreen,
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(10.h),
                                    child: Icon(Icons.calendar_today,color: Colors.white,size: getDeviceType() == Device.Tablet?30:16),
                                  ),
                                ),
                                SizedBox(
                                  width: 15.w,
                                ),
                                Text(
                                  "02 Aug 2022",
                                  style: GoogleFonts.outfit(
                                      fontSize: getDeviceType() == Device.Tablet?19.sp:14.sp, fontWeight: FontWeight.w400, color: Colors.black),
                                ),
                                SizedBox(
                                  width: 15.w,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: getDeviceType() == Device.Tablet?30.h:25.h),
                          child: Material(
                            elevation: 5,
                            borderRadius: BorderRadius.circular(10.r),
                            child: IntrinsicHeight(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Expanded(
                                    child: ShiftTile(hospital: "hospital", nurse: "nurse", shiftDate: "shiftDate", shiftTime: "shiftTime", showBackStrip: true),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: kRed,
                                      borderRadius: BorderRadius.horizontal(
                                          right: Radius.circular(10.r)),
                                    ),
                                    child: SizedBox(
                                      width: getDeviceType() == Device.Tablet?20.w:null,
                                      child: Icon(
                                        Icons.arrow_forward_ios,
                                        color: Colors.white,
                                        size: getDeviceType() == Device.Tablet?35:20,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
