import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:top_admin/widgets/approval_tile.dart';

import '../constants.dart';
import '../widgets/backdrop.dart';
import '../widgets/heading_card.dart';

class Approval extends StatelessWidget {

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
                  title: 'Manager Approval',
                  phoneSize: EdgeInsets.symmetric(horizontal: 35.w,vertical: 15.h),
                  tabletSize: EdgeInsets.symmetric(horizontal: 25.w,vertical: 12.h),
                  child: Padding(
                    padding: getDeviceType() == Device.Tablet?EdgeInsets.fromLTRB(15.w,35.h,15.w,20.h):EdgeInsets.fromLTRB(15.w,30.h,15.w,25.h),
                    child: Column(
                      children: [
                        ApprovalTile(name: "Jamie Siede", email: "jamie.siede@gmail.com", hospital: "Sydney Adventist Hospital", speciality: "Speciality 1", showAcceptButton: true,)
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
