import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:top_admin/controllers/role_controller.dart';
import 'package:top_admin/models/user_model.dart';
import 'package:top_admin/widgets/custom_icon_btn.dart';

import '../constants.dart';
import 'button.dart';

class ShiftTile extends StatelessWidget {
  final String hospital;
  final String nurse;
  final String shiftDate;
  final String shiftTime;
  final bool showFrontStrip;
  final bool showBackStrip;

  final TextEditingController additionalDetailsController = TextEditingController();

  ShiftTile(
      {super.key,
      required this.hospital,
      required this.nurse,
      required this.shiftDate,
      required this.shiftTime,
      this.showFrontStrip = false,
      this.showBackStrip = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        color: showFrontStrip ? kRed : Colors.transparent,
      ),
      child: Container(
        margin: showFrontStrip ? EdgeInsets.only(left: 12.w) : EdgeInsets.zero,
        decoration: BoxDecoration(
          borderRadius: showFrontStrip
              ? BorderRadius.horizontal(right: Radius.circular(10.r))
              : showBackStrip
                  ? BorderRadius.horizontal(left: Radius.circular(10.r))
                  : BorderRadius.circular(10.r),
          color: Colors.white,
        ),
        child: Padding(
          padding: EdgeInsets.all(15.h),
          child: Column(
            children: [
              //Name
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 90.w,
                    child: Text(
                      'Hospital',
                      style: TextStyle(
                        fontSize: getDeviceType() == Device.Tablet ? 21.sp : 18.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      hospital,
                      style: GoogleFonts.sourceSansPro(
                          fontSize: getDeviceType() == Device.Tablet ? 21.sp : 17.sp,
                          fontWeight: FontWeight.w400,
                          color: kGreyText),
                    ),
                  ),
                ],
              ),
              SizedBox(height: getDeviceType() == Device.Tablet ? 10.h : 8.h),

              //Hospital
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 90.w,
                    child: Text(
                      'Nurse',
                      style: TextStyle(
                        fontSize: getDeviceType() == Device.Tablet ? 21.sp : 17.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Expanded(
                    child: FutureBuilder<User?>(
                        future: Provider.of<RoleController>(context).getSingleNurse(nurse),
                        builder: (context, snapshot) {
                          return Text(
                            (snapshot.connectionState == ConnectionState.waiting ||
                                    !snapshot.hasData)
                                ? 'Loading'
                                : snapshot.data!.name!,
                            style: GoogleFonts.sourceSansPro(
                                fontSize: getDeviceType() == Device.Tablet ? 21.sp : 17.sp,
                                fontWeight: FontWeight.w400,
                                color: kGreyText),
                          );
                        }),
                  ),
                ],
              ),
              SizedBox(height: getDeviceType() == Device.Tablet ? 10.h : 8.h),

              //Speciality
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 90.w,
                    child: Text(
                      'Shift Date',
                      style: TextStyle(
                        fontSize: getDeviceType() == Device.Tablet ? 21.sp : 17.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      shiftDate,
                      style: GoogleFonts.sourceSansPro(
                          fontSize: getDeviceType() == Device.Tablet ? 21.sp : 17.sp,
                          fontWeight: FontWeight.w400,
                          color: kGreyText),
                    ),
                  ),
                ],
              ),
              SizedBox(height: getDeviceType() == Device.Tablet ? 10.h : 8.h),

              //Email
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 90.w,
                    child: Text(
                      'Shift Time',
                      style: TextStyle(
                        fontSize: getDeviceType() == Device.Tablet ? 21.sp : 17.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      shiftTime,
                      style: GoogleFonts.sourceSansPro(
                          fontSize: getDeviceType() == Device.Tablet ? 21.sp : 17.sp,
                          fontWeight: FontWeight.w400,
                          color: kGreyText),
                    ),
                  ),
                ],
              ),
              SizedBox(height: getDeviceType() == Device.Tablet ? 10.h : 8.h),
            ],
          ),
        ),
      ),
    );
  }
}
