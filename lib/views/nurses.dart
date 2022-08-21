import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toggle_switch/toggle_switch.dart';
import '../constants.dart';
import '../widgets/backdrop.dart';
import '../widgets/heading_card.dart';
import '../widgets/nurse_tile.dart';

class Nurses extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Backdrop(
        child: Padding(
          padding: getDeviceType() == Device.Tablet?EdgeInsets.symmetric(horizontal: 40.w, vertical: 30.h):EdgeInsets.all(30.w),
          child: Column(
            children: [
              SizedBox(height: ScreenUtil().statusBarHeight),

              Expanded(
                child: HeadingCard(
                  title: 'Nurses',
                  child: Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.w),
                      child: Column(
                        children: [
                          Padding(
                            padding: getDeviceType() == Device.Tablet?EdgeInsets.only(top: 35.h, bottom: 20.h):EdgeInsets.only(top: 30.h, bottom: 25.h),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: ToggleSwitch(
                                initialLabelIndex:0,
                                activeFgColor: Colors.white,
                                inactiveBgColor: kDisabledSecondary,
                                inactiveFgColor: kGreyText,
                                totalSwitches: specialities.length+1,
                                labels: ["All", ...specialities].cast(),
                                fontSize: getDeviceType() == Device.Tablet?18.sp:16.sp,
                                activeBgColor: [kOrange],
                                cornerRadius: 5.r,
                                animate: true,
                                animationDuration: 200,
                                minHeight: getDeviceType() == Device.Tablet?40.h:35,
                                curve: Curves.easeIn,
                                customWidths: ["All", ...specialities].map((e) => (getDeviceType() == Device.Tablet?e.length * 5+70.w:e.length * 5+70.w)).toList(),
                                onToggle: (index){},
                              ),
                            ),
                          ),
                          Expanded(
                            child: ListView.builder(
                              padding: getDeviceType() == Device.Tablet?EdgeInsets.symmetric(vertical: 10.h):EdgeInsets.symmetric(vertical: 0),
                              physics: BouncingScrollPhysics(),
                              itemCount: 20,
                              itemBuilder: (context, i) => NurseTile(),
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
