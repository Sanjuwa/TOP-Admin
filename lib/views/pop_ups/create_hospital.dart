import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:top_admin/constants.dart';
import 'package:top_admin/controllers/role_controller.dart';
import 'package:top_admin/widgets/button.dart';
import 'package:top_admin/widgets/heading_card.dart';
import 'package:top_admin/widgets/input_filed.dart';
import 'package:top_admin/widgets/toast.dart';

class CreateHospital extends StatelessWidget {

  final TextEditingController name = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var roleController = Provider.of<RoleController>(context);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 280.h),
      child: HeadingCard(
        title: 'Create Hospital',
        child: Padding(
          padding: EdgeInsets.all(25.w),
          child: Column(
            children: [
              InputField(
                text: 'Hospital Name',
                controller: name,
              ),

              SizedBox(height: 50.h),
              SizedBox(
                width: double.infinity,
                child: Button(
                  text: 'Create',
                  color: kRed,
                  onPressed: () async {
                    ToastBar(text: 'Please wait...', color: Colors.orange).show();
                    if(name.text.trim().isEmpty){
                      ToastBar(text: 'Please fill the name', color: Colors.red).show();
                    } else {
                      bool success = await roleController.addHospital(name.text.trim());
                      if(success){
                        Navigator.pop(context);
                        roleController.refresh();
                      }
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
