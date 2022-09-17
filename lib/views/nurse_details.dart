import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:top_admin/controllers/role_controller.dart';
import 'package:top_admin/models/user_model.dart';
import 'package:top_admin/views/availability.dart';
import 'package:top_admin/constants.dart';
import 'package:top_admin/views/create_job.dart';
import 'package:top_admin/views/page_selector.dart';
import 'package:top_admin/widgets/backdrop.dart';
import 'package:top_admin/widgets/button.dart';
import 'package:top_admin/widgets/heading_card.dart';
import 'package:top_admin/widgets/input_filed.dart';
import 'package:top_admin/widgets/toast.dart';

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
          padding: getDeviceType() == Device.Tablet
              ? EdgeInsets.only(left: 40.w, right: 40.w, bottom: 30.h)
              : EdgeInsets.only(left: 30.w, right: 30.w, bottom: 30.w),
          child: Column(
            children: [
              SizedBox(height: ScreenUtil().statusBarHeight),
              Align(
                alignment: Alignment.topLeft,
                child: BackButton(
                  color: kGreyText,
                ),
              ),
              HeadingCard(
                title: 'Nurse’s Details',
                tabletSize: EdgeInsets.symmetric(horizontal: 30.w, vertical: 15.h),
                phoneSize: EdgeInsets.symmetric(horizontal: 40.w, vertical: 15.h),
                child: Padding(
                  padding: EdgeInsets.all(20.w),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: getDeviceType() == Device.Tablet ? 10.h : 10.w),
                        child: InputField(
                          text: 'Name',
                          enabled: false,
                          controller: name,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: getDeviceType() == Device.Tablet ? 10.h : 10.w),
                        child: InputField(
                          text: 'Email',
                          enabled: false,
                          controller: email,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: getDeviceType() == Device.Tablet ? 10.h : 10.w),
                        child: InputField(
                          text: 'Speciality',
                          enabled: false,
                          multiLine: true,
                          controller: speciality,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: getDeviceType() == Device.Tablet ? 10.h : 10.w),
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
                  text: 'Delete Nurse',
                  color: kRed,
                  onPressed: () => showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      content: Text('Are you sure you want to delete the nurse?'),
                      actions: [
                        TextButton(
                          child: Text(
                            'Yes',
                            style: TextStyle(
                              color: kGreen,
                            ),
                          ),
                          onPressed: () async {
                            ToastBar(text: "Please wait...", color: Colors.orange).show();
                            bool isDeleted =
                                await Provider.of<RoleController>(context, listen: false)
                                    .deleteUser(nurse.uid);
                            if (isDeleted) {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  CupertinoPageRoute(builder: (context) => PageSelector()),
                                      (Route<dynamic> route) => false);
                            }
                          },
                        ),
                        TextButton(
                          child: Text(
                            'No',
                            style: TextStyle(
                              color: kGreen,
                            ),
                          ),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: getDeviceType() == Device.Tablet ? 25.h : 20.h),
              SizedBox(
                width: double.infinity,
                child: Button(
                  text: 'Check Availability',
                  color: kGreen,
                  onPressed: () => Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (_) => Availability(user: nurse),
                    ),
                  ),
                ),
              ),
              SizedBox(height: getDeviceType() == Device.Tablet ? 25.h : 20.h),
              SizedBox(
                width: double.infinity,
                child: Button(
                  text: 'Assign a Custom Shift',
                  color: kRed,
                  onPressed: () => Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (_) => CreateJob(assignShift: true, nurse: nurse),
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
