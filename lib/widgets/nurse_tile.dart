import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants.dart';

class NurseTile extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.r),
      ),
      elevation: 3,
      margin: EdgeInsets.only(bottom: 16.h, left: 8, right: 5),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Padding(
                padding: getDeviceType() == Device.Tablet?EdgeInsets.all(20.h):EdgeInsets.all(15.h),
                child: Text(
                  "Alannah Kirkcaldie",
                  style: GoogleFonts.sourceSansPro(
                    fontSize: getDeviceType() == Device.Tablet?24.sp:20.sp,
                    fontWeight: FontWeight.w600,
                    color: kGreyText,
                  ),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: kRed,
                borderRadius: BorderRadius.horizontal(right: Radius.circular(10.r)),
              ),
              child: SizedBox(
                width: getDeviceType() == Device.Tablet?20.w:null,
                child: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white,
                  size: getDeviceType() == Device.Tablet?30:20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
