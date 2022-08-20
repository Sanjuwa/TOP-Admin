import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants.dart';

class InputField extends StatefulWidget {
  final String text;
  final bool isPassword;
  final TextInputType? keyboard;
  final TextEditingController? controller;
  final bool enabled;
  final bool multiLine;

  const InputField({
    super.key,
    required this.text,
    this.isPassword = false,
    this.keyboard,
    this.controller,
    this.enabled = true, this.multiLine = false,
  });

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  bool hideText = false;

  @override
  void initState() {
    super.initState();
    hideText = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      keyboardType: widget.keyboard,
      obscureText: hideText,
      cursorColor: kGreen,
      enabled: widget.enabled,
      maxLines: widget.multiLine ? null : 1,
      style: getDeviceType() == Device.Tablet? TextStyle(
        color: kDisabled,
        fontWeight: FontWeight.w400,
        fontSize: 20.sp,
      ):null,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 25.h, horizontal: 10.w),
        labelText: widget.text,
        isDense: true,
        filled: true,
        fillColor: Colors.white,
        labelStyle: TextStyle(
          color: kDisabled,
          fontWeight: FontWeight.w400,
          fontSize: getDeviceType() == Device.Tablet? 20.sp:18.sp,
        ),
        floatingLabelStyle: getDeviceType() == Device.Tablet? TextStyle(
          color: kDisabled,
          fontWeight: FontWeight.w400,
          fontSize: 23.sp,
        ):null,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.r),
          borderSide: BorderSide(
            color: kDisabled,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.r),
          borderSide: BorderSide(
            color: kDisabled,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.r),
          borderSide: BorderSide(
            color: kGreen,
            width: 2,
          ),
        ),
        suffixIcon: widget.isPassword ? IconButton(
          padding: getDeviceType() == Device.Tablet? EdgeInsets.only(right: 15.w):EdgeInsets.only(right: 8.w),
          iconSize: getDeviceType() == Device.Tablet? 25.h:null,
          splashColor: Colors.transparent,
          icon: Icon(
            hideText ? Icons.visibility_off : Icons.visibility,
            color: kDisabled,
            size: getDeviceType() == Device.Phone?22:null,
          ),
          onPressed: () {
            if (widget.isPassword) {
              setState(() {
                hideText = !hideText;
              });
            }
          },
        ) : null,
      ),
    );
  }
}
