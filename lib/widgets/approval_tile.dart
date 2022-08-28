import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:top_admin/widgets/custom_icon_btn.dart';

import '../constants.dart';
import 'button.dart';

class ApprovalTile extends StatelessWidget {
  final String name;
  final String hospital;
  final String speciality;
  final String email;
  final bool showAcceptButton;
  final Function? onAcceptButtonPressed;

  ApprovalTile({
    super.key,
    this.showAcceptButton = false,
    required this.name,
    required this.email,
    this.onAcceptButtonPressed,
    required this.hospital,
    required this.speciality,
  });

  final TextEditingController additionalDetailsController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(10.r),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          color: kRed,
        ),
        child: Container(
          margin: EdgeInsets.only(left: 12.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.horizontal(right: Radius.circular(10.r)),
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
                      width:90.w,
                      child: Text(
                        'Name',
                        style: TextStyle(
                          fontSize: getDeviceType() == Device.Tablet?21.sp:18.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Expanded(
                      child:Text(
                        name,
                        style: GoogleFonts.sourceSansPro(
                            fontSize: getDeviceType() == Device.Tablet?21.sp:17.sp, fontWeight: FontWeight.w400, color: kGreyText),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: getDeviceType() == Device.Tablet?10.h:8.h),

                //Hospital
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width:90.w,
                      child: Text(
                        'Hospital',
                        style: TextStyle(
                          fontSize: getDeviceType() == Device.Tablet?21.sp:17.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        hospital,
                        style: GoogleFonts.sourceSansPro(
                            fontSize: getDeviceType() == Device.Tablet?21.sp:17.sp, fontWeight: FontWeight.w400, color: kGreyText),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: getDeviceType() == Device.Tablet?10.h:8.h),

                //Speciality
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width:90.w,
                      child: Text(
                        'Speciality',
                        style: TextStyle(
                          fontSize: getDeviceType() == Device.Tablet?21.sp:17.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Expanded(
                      child:Text(
                        speciality,
                        style: GoogleFonts.sourceSansPro(
                            fontSize: getDeviceType() == Device.Tablet?21.sp:17.sp, fontWeight: FontWeight.w400, color: kGreyText),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: getDeviceType() == Device.Tablet?10.h:8.h),

                //Email
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width:90.w,
                      child: Text(
                        'Email',
                        style: TextStyle(
                          fontSize: getDeviceType() == Device.Tablet?21.sp:17.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Expanded(
                      child:Text(
                        email,
                        style: GoogleFonts.sourceSansPro(
                            fontSize: getDeviceType() == Device.Tablet?21.sp:17.sp, fontWeight: FontWeight.w400, color: kGreyText),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: getDeviceType() == Device.Tablet?10.h:8.h),

                if (showAcceptButton) SizedBox(height: getDeviceType() == Device.Tablet?45.h:30.h),
                if (showAcceptButton)
                  Row(
                    children: [
                      Expanded(
                        child: CustomIconBtn(icon: Icons.check_circle_outline, color: Color(0xff4CAF50)),
                      ),
                      SizedBox(
                        width: getDeviceType() == Device.Tablet?20.w:15.w,
                      ),
                      Expanded(
                          child: CustomIconBtn(icon: Icons.cancel_outlined, color: kRed,),
                      )
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
