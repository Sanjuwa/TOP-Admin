import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants.dart';

class CustomIconBtn extends StatelessWidget {

  final IconData icon;
  final Color color;

  const CustomIconBtn({super.key, required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){},
      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.r),
            color: color,
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: getDeviceType() == Device.Tablet?10.h:8.h),
            child: Icon(icon, color: Colors.white, size: getDeviceType() == Device.Tablet?40:20,),
          )
      ),
    );
  }
}
