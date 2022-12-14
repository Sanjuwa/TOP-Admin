import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:top_admin/constants.dart';

class HeadingCard extends StatelessWidget {
  final String title;
  final Widget child;
  final EdgeInsetsGeometry ?tabletSize;
  final EdgeInsetsGeometry ?phoneSize;

  const HeadingCard({required this.title, required this.child, this.tabletSize, this.phoneSize});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.r),
        ),
        elevation: 7,
        color: Colors.white,
        child: Column(
          children: [
            //title
            Container(
              decoration: BoxDecoration(
                color: kGreen,
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(15.r),
                ),
              ),
              padding: getDeviceType() == Device.Tablet?tabletSize ?? EdgeInsets.symmetric(horizontal: 50.w,vertical: 12.h):phoneSize ?? EdgeInsets.symmetric(horizontal: 60.w,vertical: 15.h),
              child: Text(
                title,
                style: TextStyle(
                  fontSize: getDeviceType() == Device.Tablet?25.sp:22.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            child,
          ],
        ),
      ),
    );
  }
}
