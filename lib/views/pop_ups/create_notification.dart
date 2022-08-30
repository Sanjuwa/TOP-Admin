import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:top_admin/constants.dart';
import 'package:top_admin/controllers/role_controller.dart';
import 'package:top_admin/widgets/button.dart';
import 'package:top_admin/widgets/input_filed.dart';
import 'package:top_admin/widgets/toast.dart';

class CreateNotification extends StatelessWidget {
  final TextEditingController notificationText = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var roleController = Provider.of<RoleController>(context);

    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      content: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25.w),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              //title
              Container(
                decoration: BoxDecoration(
                  color: kGreen,
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(15.r),
                  ),
                ),
                padding: getDeviceType() == Device.Tablet
                    ? EdgeInsets.symmetric(horizontal: 40.w, vertical: 12.h)
                    : EdgeInsets.symmetric(horizontal: 30.w, vertical: 15.h),
                child: Text(
                  "Create Notification",
                  style: TextStyle(
                    fontSize: getDeviceType() == Device.Tablet ? 25.sp : 22.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              SizedBox(height: 30.h),
              InputField(
                text: 'Notification',
                controller: notificationText,
                multiLine: true,
              ),

              SizedBox(height: 30.h),
              SizedBox(
                width: double.infinity,
                child: Button(
                  text: 'Create',
                  color: kRed,
                  onPressed: () async {
                    ToastBar(text: 'Please wait...', color: Colors.orange).show();
                    if (notificationText.text.trim().isEmpty) {
                      ToastBar(text: 'Please fill the name', color: Colors.red).show();
                    } else {
                      bool success =
                          await roleController.createNotification(notificationText.text.trim());
                      if (success) {
                        Navigator.pop(context);
                        roleController.refresh();
                      }
                    }
                  },
                ),
              ),
              SizedBox(height: 30.h),
            ],
          ),
        ),
      ),
    );
  }
}
