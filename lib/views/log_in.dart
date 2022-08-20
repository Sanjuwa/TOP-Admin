import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/backdrop.dart';
import '../widgets/button.dart';
import '../constants.dart';
import '../widgets/input_filed.dart';

class LogIn extends StatelessWidget {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Backdrop(
        child: Padding(
          padding: getDeviceType() == Device.Tablet?EdgeInsets.fromLTRB(60.w, 30.h, 60.w, 0.h):EdgeInsets.fromLTRB(40.w, 30.h, 40.w, 0.h),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: ScreenUtil().statusBarHeight + 40.h),

                //logo
                Center(
                  child: Container(
                    width: getDeviceType() == Device.Tablet? 110.w: 150.w,
                    height: getDeviceType() == Device.Tablet? 110.w: 150.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.r),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade700,
                          blurRadius: 10,
                        ),
                      ],
                    ),
                    padding: EdgeInsets.all(20.w),
                    child: Image.asset('assets/logo.png'),
                  ),
                ),
                SizedBox(height: 75.h),

                //heading
                RichText(
                  text: TextSpan(
                    text: 'Login to',
                      style: GoogleFonts.sourceSansPro(
                        fontWeight: FontWeight.w700,
                        fontSize: getDeviceType() == Device.Tablet? 40.sp: 35.sp,
                        color: Colors.black,
                      ),
                    children: [
                      TextSpan(
                        text: ' TOP',
                        style: TextStyle(
                          color: kGreen,
                        ),
                      )
                    ]
                  ),
                ),
                Text(
                  "Theatre Operation Professional",
                  style: GoogleFonts.sourceSansPro(
                    fontWeight: FontWeight.w600,
                    fontSize: getDeviceType() == Device.Tablet? 28.sp:23.sp,
                    color: kGreen,
                  ),
                ),
                SizedBox(height: getDeviceType() == Device.Tablet? 50.h:35.h),


                //text fields
                InputField(
                  text: 'Admin Email',
                  controller: email,
                ),
                SizedBox(height: getDeviceType() == Device.Tablet? 22.h:20.h),
                InputField(
                  text: 'Admin Password',
                  controller: password,
                  isPassword: true,
                ),

                SizedBox(
                  height: getDeviceType() == Device.Tablet? 100.h:70.h,
                ),

                //buttons
                SizedBox(
                  width: double.infinity,
                  child: Button(
                    text: 'Login',
                    color: kRed,
                    onPressed: () async {},
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
