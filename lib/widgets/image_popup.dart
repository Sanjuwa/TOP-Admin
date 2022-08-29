import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:top_admin/constants.dart';
import 'package:top_admin/widgets/input_filed.dart';

class ImagePopUp extends StatelessWidget {
  final String imageURL;
  final String role;
  final String? name;

  ImagePopUp({super.key, required this.imageURL, this.name, required this.role});

  final TextEditingController signName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    signName.text = name ?? "";

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
      contentPadding: EdgeInsets.zero,
      insetPadding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 35.h),
      content: SizedBox(
        width: 1.sw,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              //heading
              Container(
                decoration: BoxDecoration(
                  color: kGreen,
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(15.r),
                  ),
                ),
                padding: EdgeInsets.all(15.w),
                child: Text(
                  '$role Signature',
                  style: TextStyle(
                    fontSize: 22.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(height: 30.h),

              //image
              CachedNetworkImage(
                imageUrl: imageURL,
                fit: BoxFit.contain,
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    CircularProgressIndicator(value: downloadProgress.progress),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
              SizedBox(height: 30.h),

              //name
              if (name != null)
                Padding(
                  padding: EdgeInsets.all(30.w),
                  child: InputField(
                    text: "Signature's Name",
                    controller: signName,
                    enabled: false,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
