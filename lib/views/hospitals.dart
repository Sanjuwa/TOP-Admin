import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:top_admin/models/user_model.dart';

import '../constants.dart';
import '../widgets/backdrop.dart';
import '../widgets/heading_card.dart';
import '../widgets/tile.dart';

class Hospitals extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Padding(
        padding: getDeviceType() == Device.Tablet?EdgeInsets.only(right: 10.w,bottom: 10.h):EdgeInsets.zero,
        child: getDeviceType() == Device.Tablet?FloatingActionButton.large(
          backgroundColor: kGreen,
          elevation: 7,
          onPressed: (){},
          child: Icon(Icons.add,size: 50,),
        ):FloatingActionButton(
          backgroundColor: kGreen,
          elevation: 7,
          onPressed: (){},
          child: Icon(Icons.add),
        ),
      ),
      body: Backdrop(
        child: Padding(
          padding: getDeviceType() == Device.Tablet?EdgeInsets.symmetric(horizontal: 40.w, vertical: 30.h):EdgeInsets.all(30.w),
          child: Column(
            children: [
              SizedBox(height: ScreenUtil().statusBarHeight),

              Expanded(
                child: HeadingCard(
                  title: 'Hospitals',
                  child: Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.w),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20.h,
                          ),
                          Expanded(
                            child: ListView.builder(
                              padding: getDeviceType() == Device.Tablet?EdgeInsets.symmetric(vertical: 10.h):EdgeInsets.symmetric(vertical: 0),
                              physics: BouncingScrollPhysics(),
                              itemCount: 20,
                              itemBuilder: (context, i) => Tile(name: 'bdf'),
                            ),
                          ),
                        ],
                      ),
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
