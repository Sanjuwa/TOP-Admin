import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:top_admin/controllers/role_controller.dart';
import 'package:top_admin/models/hospital_model.dart';
import 'package:top_admin/widgets/custom_icon_btn.dart';
import 'package:top_admin/constants.dart';
import 'package:top_admin/widgets/toast.dart';

class ApprovalTile extends StatelessWidget {
  final String id;
  final String name;
  final String? hospitalID;
  final String speciality;
  final String email;
  final String? phone;
  final bool showHospital;
  final bool showPhone;
  final Function? onAcceptButtonPressed;
  final Function? onDeclineButtonPressed;
  final bool showButtons;
  final bool showDeleteButton;

  ApprovalTile({
    super.key,
    required this.name,
    required this.email,
    this.onAcceptButtonPressed,
    this.hospitalID,
    required this.speciality,
    this.showHospital = false,
    this.phone,
    required this.showPhone,
    this.onDeclineButtonPressed,
    this.showButtons = true,
    this.showDeleteButton = false,
    required this.id,
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
                      width: 90.w,
                      child: Text(
                        'Name',
                        style: TextStyle(
                          fontSize: getDeviceType() == Device.Tablet ? 21.sp : 18.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        name,
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
                if (showHospital)
                  FutureBuilder<Hospital?>(
                    future: Provider.of<RoleController>(context).getSingleHospital(hospitalID!),
                    builder: (context, snapshot) {
                      String name = "Loading";
                      if (snapshot.connectionState == ConnectionState.waiting ||
                          !snapshot.hasData) {
                        name = "Loading";
                      } else {
                        name = snapshot.data!.name;
                      }

                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 90.w,
                            child: Text(
                              'Hospital',
                              style: TextStyle(
                                fontSize: getDeviceType() == Device.Tablet ? 21.sp : 17.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              name,
                              style: GoogleFonts.sourceSansPro(
                                  fontSize: getDeviceType() == Device.Tablet ? 21.sp : 17.sp,
                                  fontWeight: FontWeight.w400,
                                  color: kGreyText),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                if (showHospital) SizedBox(height: getDeviceType() == Device.Tablet ? 10.h : 8.h),

                //Phone
                if (showPhone)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 90.w,
                        child: Text(
                          'Phone',
                          style: TextStyle(
                            fontSize: getDeviceType() == Device.Tablet ? 21.sp : 17.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          phone!,
                          style: GoogleFonts.sourceSansPro(
                              fontSize: getDeviceType() == Device.Tablet ? 21.sp : 17.sp,
                              fontWeight: FontWeight.w400,
                              color: kGreyText),
                        ),
                      ),
                    ],
                  ),
                if (showPhone) SizedBox(height: getDeviceType() == Device.Tablet ? 10.h : 8.h),

                //Speciality
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 90.w,
                      child: Text(
                        'Speciality',
                        style: TextStyle(
                          fontSize: getDeviceType() == Device.Tablet ? 21.sp : 17.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        speciality,
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
                        'Email',
                        style: TextStyle(
                          fontSize: getDeviceType() == Device.Tablet ? 21.sp : 17.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        email,
                        style: GoogleFonts.sourceSansPro(
                            fontSize: getDeviceType() == Device.Tablet ? 21.sp : 17.sp,
                            fontWeight: FontWeight.w400,
                            color: kGreyText),
                      ),
                    ),
                  ],
                ),

                if (showButtons) SizedBox(height: getDeviceType() == Device.Tablet ? 10.h : 8.h),

                if (showButtons) SizedBox(height: getDeviceType() == Device.Tablet ? 45.h : 30.h),

                if (showButtons)
                  Row(
                    children: [
                      Expanded(
                        child: CustomIconBtn(
                          icon: Icons.check_circle_outline,
                          color: Color(0xff4CAF50),
                          onPressed: () => onAcceptButtonPressed!(),
                        ),
                      ),
                      SizedBox(
                        width: getDeviceType() == Device.Tablet ? 20.w : 15.w,
                      ),
                      Expanded(
                        child: CustomIconBtn(
                          icon: Icons.cancel_outlined,
                          color: kRed,
                          onPressed: () => onDeclineButtonPressed!(),
                        ),
                      )
                    ],
                  ),

                if (showDeleteButton)
                  SizedBox(height: getDeviceType() == Device.Tablet ? 45.h : 30.h),
                if (showDeleteButton)
                  SizedBox(
                    width: double.infinity,
                    child: CustomIconBtn(
                      icon: Icons.delete,
                      color: kRed,
                      onPressed: () => showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          content: Text('Are you sure you want to delete the manager?'),
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
                                        .deleteUser(id);
                                if (isDeleted) {
                                  Navigator.pop(context);
                                  Navigator.pop(context);
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
