import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:top_admin/constants.dart';
import 'package:top_admin/widgets/badge.dart';

class AvailabilityTile extends StatelessWidget {
  final String dateString;
  final AvailabilityStatus am;
  final AvailabilityStatus pm;
  final AvailabilityStatus ns;

  const AvailabilityTile(
      {super.key, required this.dateString, required this.am, required this.pm, required this.ns});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.r),
      ),
      elevation: 3,
      margin: EdgeInsets.only(bottom: 16.h),
      child: Padding(
        padding: getDeviceType() == Device.Tablet?EdgeInsets.all(20.h):EdgeInsets.all(15.h),
        child: Row(
          children: [
            Text(
              dateString,
              style: GoogleFonts.sourceSansPro(
                fontSize: getDeviceType() == Device.Tablet?23.sp:20.sp,
                fontWeight: FontWeight.w600,
                color: kGreyText,
              ),
            ),
            Expanded(child: SizedBox.shrink()),
            Badge(
              text: 'AM',
              color: am == AvailabilityStatus.Available ? Colors.green : Colors.red,
              enabled: am != AvailabilityStatus.NotAvailable,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Badge(
                text: 'PM',
                color: pm == AvailabilityStatus.Available ? Colors.green : Colors.red,
                enabled: pm != AvailabilityStatus.NotAvailable,
              ),
            ),
            Badge(
              text: 'NS',
              color: ns == AvailabilityStatus.Available ? Colors.green : Colors.red,
              enabled: ns != AvailabilityStatus.NotAvailable,
            ),
          ],
        ),
      ),
    );
  }
}
