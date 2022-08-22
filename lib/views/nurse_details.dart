import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:top_admin/models/user_model.dart';

import '../constants.dart';
import '../widgets/backdrop.dart';
import '../widgets/button.dart';
import '../widgets/heading_card.dart';
import '../widgets/input_filed.dart';

class NurseDetails extends StatelessWidget {
  final User nurse;

  NurseDetails({super.key, required this.nurse});

  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController speciality = TextEditingController();
  final TextEditingController phone = TextEditingController();

  @override
  Widget build(BuildContext context) {
    name.text = nurse.name!;
    email.text = nurse.email!;
    speciality.text = nurse.specialities!.join(', ');
    phone.text = nurse.phone!;

    return Scaffold(
      body: Backdrop(
        child: Padding(
          padding: getDeviceType() == Device.Tablet?EdgeInsets.symmetric(horizontal: 40.w, vertical: 30.h):EdgeInsets.all(30.w),
          child: Column(
            children: [
              SizedBox(height: ScreenUtil().statusBarHeight),

              HeadingCard(
                title: 'Nurse’s Details',
                tabletSize: EdgeInsets.symmetric(horizontal: 30.w,vertical: 15.h),
                phoneSize: EdgeInsets.symmetric(horizontal: 40.w,vertical: 15.h),
                child: Padding(
                  padding: EdgeInsets.all(20.w),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: getDeviceType() == Device.Tablet?10.h:10.w),
                        child: InputField(
                          text: 'Name',
                          enabled: false,
                          controller: name,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: getDeviceType() == Device.Tablet?10.h:10.w),
                        child: InputField(
                          text: 'Email',
                          enabled: false,
                          controller: email,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: getDeviceType() == Device.Tablet?10.h:10.w),
                        child: InputField(
                          text: 'Speciality',
                          enabled: false,
                          multiLine: true,
                          controller: speciality,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: getDeviceType() == Device.Tablet?10.h:10.w),
                        child: InputField(
                          text: 'Mobile Number',
                          enabled: false,
                          controller: phone,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(child: SizedBox()),
              SizedBox(
                width: double.infinity,
                child: Button(
                  text: 'Check Availability',
                  color: kGreen,
                  onPressed: () async {},
                ),
              ),
              SizedBox(
                height: getDeviceType() == Device.Tablet?25.h:20.h,
              ),
              SizedBox(
                width: double.infinity,
                child: Button(
                  text: 'Assign a Custom Shift',
                  color: kRed,
                  onPressed: () async {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
