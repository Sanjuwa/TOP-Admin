import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:top_admin/controllers/job_controller.dart';
import 'package:top_admin/models/job_model.dart';
import 'package:top_admin/models/timesheet_model.dart';
import 'package:top_admin/views/single_timesheet.dart';
import 'package:top_admin/widgets/shift_tile.dart';
import 'package:top_admin/constants.dart';
import 'package:top_admin/widgets/backdrop.dart';
import 'package:top_admin/widgets/heading_card.dart';

class TimeSheets extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var jobController = Provider.of<JobController>(context);

    return Scaffold(
      body: Backdrop(
        child: Padding(
          padding: getDeviceType() == Device.Tablet
              ? EdgeInsets.symmetric(horizontal: 40.w, vertical: 30.h)
              : EdgeInsets.all(30.w),
          child: Column(
            children: [
              SizedBox(height: ScreenUtil().statusBarHeight),

              //details
              Expanded(
                child: HeadingCard(
                  title: 'Time Sheets',
                  phoneSize: EdgeInsets.symmetric(horizontal: 35.w, vertical: 15.h),
                  tabletSize: EdgeInsets.symmetric(horizontal: 25.w, vertical: 12.h),
                  child: Expanded(
                    child: Padding(
                      padding: getDeviceType() == Device.Tablet
                          ? EdgeInsets.fromLTRB(15.w, 35.h, 15.w, 20.h)
                          : EdgeInsets.fromLTRB(15.w, 30.h, 15.w, 25.h),
                      child: Column(
                        children: [
                          //calendar
                          Align(
                            alignment: Alignment.centerRight,
                            child: GestureDetector(
                              onTap: () async {
                                DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2022, 1, 1),
                                  lastDate: DateTime(2099, 12, 31),
                                );

                                jobController.timeSheetDate = pickedDate?.toYYYYMMDDFormat();
                              },
                              child: Material(
                                elevation: 5,
                                borderRadius: BorderRadius.circular(5.r),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.horizontal(left: Radius.circular(5.r)),
                                        color: kGreen,
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.all(10.h),
                                        child: Icon(Icons.calendar_today,
                                            color: Colors.white,
                                            size: getDeviceType() == Device.Tablet ? 30 : 16),
                                      ),
                                    ),
                                    SizedBox(width: 15.w),
                                    Text(
                                      jobController.timeSheetDate ?? 'All',
                                      style: GoogleFonts.outfit(
                                          fontSize:
                                              getDeviceType() == Device.Tablet ? 19.sp : 14.sp,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black),
                                    ),
                                    SizedBox(width: 15.w),
                                  ],
                                ),
                              ),
                            ),
                          ),

                          //data
                          Expanded(
                            child: RefreshIndicator(
                              onRefresh: () async => jobController.refresh(),
                              child:
                                  FutureBuilder<List<TimeSheet>>(
                                future: jobController.getTimeSheets(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState == ConnectionState.waiting) {
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
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
                                      TimeSheet timeSheet = snapshot.data![i];

                                      return Padding(
                                        padding: EdgeInsets.only(
                                          bottom: getDeviceType() == Device.Tablet ? 30.h : 25.h,
                                        ),
                                        child: GestureDetector(
                                          onTap: () => Navigator.push(
                                            context,
                                            CupertinoPageRoute(
                                              builder: (_) => SingleTimesheet(),
                                            ),
                                          ),
                                          child: Material(
                                            elevation: 5,
                                            borderRadius: BorderRadius.circular(10.r),
                                            child: IntrinsicHeight(
                                              child: Row(
                                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                                children: [
                                                  Expanded(
                                                    child: ShiftTile(
                                                      hospital: timeSheet.job.hospital,
                                                      nurse: timeSheet.job.nurseID!,
                                                      shiftDate: timeSheet.job.shiftDate.toEEEMMMddFormat(),
                                                      shiftTime: "${timeSheet.startTime} to ${timeSheet.endTime}",
                                                      showBackStrip: true,
                                                    ),
                                                  ),
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      color: kRed,
                                                      borderRadius: BorderRadius.horizontal(
                                                          right: Radius.circular(10.r)),
                                                    ),
                                                    child: SizedBox(
                                                      width: getDeviceType() == Device.Tablet
                                                          ? 20.w
                                                          : null,
                                                      child: Icon(
                                                        Icons.arrow_forward_ios,
                                                        color: Colors.white,
                                                        size: getDeviceType() == Device.Tablet
                                                            ? 35
                                                            : 20,
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                          ),
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
