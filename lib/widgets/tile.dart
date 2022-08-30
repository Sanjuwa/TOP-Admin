import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:top_admin/constants.dart';

class Tile extends StatelessWidget {
  final String name;
  final Function? onTap;
  final bool showDeleteButton;
  final Function? onDeletePressed;

  const Tile({super.key, required this.name, this.onTap, this.showDeleteButton = false, this.onDeletePressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap != null ? onTap!() : 1,
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
        elevation: 3,
        margin: EdgeInsets.only(bottom: 16.h),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Padding(
                  padding: getDeviceType() == Device.Tablet
                      ? EdgeInsets.all(20.h)
                      : EdgeInsets.all(15.h),
                  child: Text(
                    name,
                    style: GoogleFonts.sourceSansPro(
                      fontSize: getDeviceType() == Device.Tablet ? 23.sp : 20.sp,
                      fontWeight: FontWeight.w600,
                      color: kGreyText,
                    ),
                  ),
                ),
              ),
              showDeleteButton
                  ? IconButton(
                      onPressed: () => onDeletePressed!(),
                      icon: Icon(
                        Icons.delete,
                        color: kRed,
                      ),
                    )
                  : Container(
                      decoration: BoxDecoration(
                        color: kRed,
                        borderRadius: BorderRadius.horizontal(right: Radius.circular(10.r)),
                      ),
                      child: SizedBox(
                        width: getDeviceType() == Device.Tablet ? 20.w : null,
                        child: Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                          size: getDeviceType() == Device.Tablet ? 30 : 20,
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
