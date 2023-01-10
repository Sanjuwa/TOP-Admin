import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:top_admin/constants.dart';
import 'package:top_admin/models/image_timesheet_model.dart';
import 'package:top_admin/widgets/backdrop.dart';
import 'package:top_admin/widgets/heading_card.dart';
import 'package:top_admin/widgets/shift_tile.dart';

class SingleImageTimesheet extends StatelessWidget {
  final ImageTimesheet timeSheet;

  const SingleImageTimesheet({super.key, required this.timeSheet});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Backdrop(
        child: Padding(
          padding: EdgeInsets.only(left: 30.w, right: 30.w, bottom: 30.w),
          child: Column(
            children: [
              SizedBox(height: ScreenUtil().statusBarHeight),
              Align(
                alignment: Alignment.topLeft,
                child: BackButton(
                  color: kGreyText,
                ),
              ),

              Expanded(
                child: HeadingCard(
                  title: 'Time Sheet',
                  child: Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(height: 30.h),

                          //shift details
                          Card(
                            margin: EdgeInsets.symmetric(horizontal: 15.w),
                            elevation: 5,
                            shape:
                                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
                            child: ShiftTile(
                              hospital: timeSheet.job.hospital,
                              nurse: timeSheet.job.nurseID!,
                              shiftDate: timeSheet.job.shiftDate.toEEEMMMddFormat(),
                              shiftTime:
                                  "${timeSheet.job.shiftStartTime} to ${timeSheet.job.shiftEndTime}",
                              showFrontStrip: true,
                            ),
                          ),
                          SizedBox(height: 50.h),

                          //image
                          Padding(
                            padding: EdgeInsets.all(30.h),
                            child: Image.network(timeSheet.url),
                          ),
                          SizedBox(height: 30.h),
                        ],
                      ),
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
