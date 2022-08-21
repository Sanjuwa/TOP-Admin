import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants.dart';

class Button extends StatelessWidget {
  final String text;
  final Function onPressed;
  final Color? color;
  final Color? textColor;
  final bool enabled;
  final double? padding;
  final double? fontSize;

  const Button({super.key, required this.text, required this.onPressed, this.color, this.textColor, this.enabled = true, this.padding, this.fontSize});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          primary: enabled ? color ?? kGreen : kDisabledSecondary,
          padding: getDeviceType() == Device.Tablet?EdgeInsets.all(padding ?? 20.h):EdgeInsets.all(padding ?? 14.h),
      ),
      child: Text(
        text,
        style: TextStyle(
            color: enabled ? textColor ?? Colors.white : kDisabled,
            fontSize: getDeviceType() == Device.Tablet?fontSize ?? 26.sp:fontSize ?? 24.sp,
            fontWeight: FontWeight.w600
        ),
      ),
      onPressed: () {
        if (enabled){
          onPressed();
        }
      },
    );
  }
}
