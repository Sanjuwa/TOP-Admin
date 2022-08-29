import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:top_admin/constants.dart';
import 'package:top_admin/models/timesheet_model.dart';
import 'package:top_admin/widgets/backdrop.dart';
import 'package:top_admin/widgets/button.dart';
import 'package:top_admin/widgets/heading_card.dart';
import 'package:top_admin/widgets/image_popup.dart';
import 'package:top_admin/widgets/input_filed.dart';
import 'package:top_admin/widgets/shift_tile.dart';

class SingleTimesheet extends StatelessWidget {
  final TimeSheet timeSheet;

  SingleTimesheet({super.key, required this.timeSheet});

  final TextEditingController startTime = TextEditingController();
  final TextEditingController endTime = TextEditingController();
  final TextEditingController mealBreakTime = TextEditingController();
  final TextEditingController totalTime = TextEditingController();
  final TextEditingController additionalDetails = TextEditingController();

  String calculateTotalTime(String startTime, String endTime, int? breakTime) {
    DateTime start = DateFormat("HH:mm").parse(startTime);
    DateTime end = DateFormat("HH:mm").parse(endTime);

    if (start.isAfter(end)) {
      end = end.add(Duration(days: 1));
    }

    end = end.subtract(Duration(minutes: breakTime ?? 0));

    Duration diff = end.difference(start);
    final hours = diff.inHours;
    final minutes = diff.inMinutes % 60;

    if (hours == 0) {
      return "$minutes minutes";
    } else {
      return "$hours hours $minutes minutes";
    }
  }

  @override
  Widget build(BuildContext context) {
    startTime.text = timeSheet.startTime;
    endTime.text = timeSheet.endTime;
    mealBreakTime.text = "${timeSheet.mealBreakTime?.toString() ?? "0"} minute(s)";
    additionalDetails.text = timeSheet.additionalDetails ?? "";
    totalTime.text =
        calculateTotalTime(timeSheet.startTime, timeSheet.endTime, timeSheet.mealBreakTime);

    return Scaffold(
      body: Backdrop(
        child: Padding(
          padding: EdgeInsets.all(30.w),
          child: Column(
            children: [
              SizedBox(height: ScreenUtil().statusBarHeight),
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

                          //text fields
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15.w),
                            child: InputField(
                              text: 'Shift Start Time',
                              enabled: false,
                              controller: startTime,
                            ),
                          ),
                          SizedBox(height: 25.h),

                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15.w),
                            child: InputField(
                              text: 'Shift End Time',
                              enabled: false,
                              controller: endTime,
                            ),
                          ),
                          SizedBox(height: 20.h),

                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15.w),
                            child: InputField(
                              text: 'Meal Break',
                              enabled: false,
                              controller: mealBreakTime,
                            ),
                          ),
                          SizedBox(height: 25.h),

                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15.w),
                            child: InputField(
                              text: 'Total Work Time',
                              enabled: false,
                              controller: totalTime,
                            ),
                          ),

                          if (additionalDetails.text.isNotEmpty) SizedBox(height: 25.h),

                          //additional details
                          if (additionalDetails.text.isNotEmpty)
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15.w),
                              child: InputField(
                                text: 'Additional Details (Optional)',
                                multiLine: true,
                                enabled: false,
                                controller: additionalDetails,
                              ),
                            ),

                          SizedBox(height: 40.h),

                          //signatures
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15.w),
                            child: SizedBox(
                              width: double.infinity,
                              child: Button(
                                text: 'Nurse\'s Signature',
                                onPressed: () => showDialog(
                                  context: context,
                                  builder: (context) => ImagePopUp(
                                    imageURL: timeSheet.nurseSignatureURL!,
                                    role: "Nurse's",
                                  ),
                                ),
                                color: Colors.green,
                                fontSize: 18.sp,
                                padding: 10.h,
                              ),
                            ),
                          ),
                          SizedBox(height: 10.h),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15.w),
                            child: SizedBox(
                              width: double.infinity,
                              child: Button(
                                text: 'Hospital\'s Signature',
                                onPressed: () => showDialog(
                                  context: context,
                                  builder: (context) => ImagePopUp(
                                    imageURL: timeSheet.hospitalSignatureURL!,
                                    role: "Hospital's",
                                    name: timeSheet.hospitalSignatureName,
                                  ),
                                ),
                                color: Colors.green,
                                fontSize: 18.sp,
                                padding: 10.h,
                              ),
                            ),
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
