import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants.dart';
import '../widgets/backdrop.dart';
import '../widgets/button.dart';
import '../widgets/heading_card.dart';
import '../widgets/input_filed.dart';
import '../widgets/shift_tile.dart';

class SingleTimesheet extends StatelessWidget {
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
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.r)
                              ),
                              child: ShiftTile(hospital: "hospital", nurse: "nurse", shiftDate: "shiftDate", shiftTime: "shiftTime", showFrontStrip: true)
                          ),
                          SizedBox(height: 50.h),

                          //text fields
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15.w),
                            child: InputField(text: 'Shift Start Time',enabled: false),
                          ),
                          SizedBox(height: 25.h),

                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15.w),
                            child: InputField(text: 'Shift End Time', enabled: false,),
                          ),
                          SizedBox(height: 20.h),

                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15.w),
                            child: InputField(text: 'Meal Break',enabled: false),
                          ),
                          SizedBox(height: 25.h),

                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15.w),
                            child: InputField(text: 'Total Work Time',enabled: false),
                          ),
                          SizedBox(height: 25.h),

                          //additional details
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15.w),
                            child: InputField(
                              text: 'Additional Details (Optional)',
                              multiLine: true,
                            ),
                          ),

                          SizedBox(height: 40.h),

                          //signatures
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15.w),
                            child: SizedBox(
                              width: double.infinity,
                              child: Button(
                                text: 'Nurse Signature',
                                onPressed: () => (){},
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
                                text: 'Hospital Signature',
                                onPressed: () => (){},
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
              SizedBox(height: 50.h),

              //button
              SizedBox(
                width: double.infinity,
                child: Button(
                  text: 'Submit',
                  color: kRed,
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
