import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:top_admin/constants.dart';
import 'package:top_admin/controllers/role_controller.dart';
import 'package:top_admin/models/user_model.dart';
import 'package:top_admin/views/notifications.dart';
import 'package:top_admin/views/nurse_details.dart';
import 'package:top_admin/widgets/backdrop.dart';
import 'package:top_admin/widgets/button.dart';
import 'package:top_admin/widgets/heading_card.dart';
import 'package:top_admin/widgets/tile.dart';

class Nurses extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var roleController = Provider.of<RoleController>(context);

    return Scaffold(
      body: Backdrop(
        child: Padding(
          padding: getDeviceType() == Device.Tablet
              ? EdgeInsets.symmetric(horizontal: 40.w, vertical: 30.h)
              : EdgeInsets.all(30.w),
          child: Column(
            children: [
              SizedBox(height: ScreenUtil().statusBarHeight),
              Expanded(
                child: HeadingCard(
                  title: 'Nurses',
                  child: Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.w),
                      child: Column(
                        children: [
                          Padding(
                            padding: getDeviceType() == Device.Tablet
                                ? EdgeInsets.only(top: 35.h, bottom: 20.h)
                                : EdgeInsets.only(top: 30.h, bottom: 25.h),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: ToggleSwitch(
                                initialLabelIndex: ["All", ...specialities]
                                    .indexOf(roleController.selectedSpeciality),
                                activeFgColor: Colors.white,
                                inactiveBgColor: kDisabledSecondary,
                                inactiveFgColor: kGreyText,
                                totalSwitches: specialities.length + 1,
                                labels: ["All", ...specialities].cast(),
                                fontSize: getDeviceType() == Device.Tablet ? 18.sp : 16.sp,
                                activeBgColor: [kOrange],
                                cornerRadius: 5.r,
                                animate: true,
                                animationDuration: 200,
                                minHeight: getDeviceType() == Device.Tablet ? 40.h : 35,
                                curve: Curves.easeIn,
                                customWidths: ["All", ...specialities]
                                    .map((e) => (getDeviceType() == Device.Tablet
                                        ? e.length * 5 + 70.w
                                        : e.length * 5 + 70.w))
                                    .toList(),
                                onToggle: (index) => roleController.selectedSpeciality =
                                    ["All", ...specialities][index!],
                              ),
                            ),
                          ),
                          Expanded(
                            child: RefreshIndicator(
                              onRefresh: () async => roleController.refresh(),
                              child:
                                  FutureBuilder<List<QueryDocumentSnapshot<Map<String, dynamic>>>>(
                                future: roleController.getAllNurses(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState == ConnectionState.waiting) {
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                                    return Stack(
                                      children: [
                                        Center(
                                          child: Text('No data to show!', style: TextStyle(fontSize: getDeviceType() == Device.Tablet ? 20.sp : null),),
                                        ),
                                        ListView(
                                          physics: AlwaysScrollableScrollPhysics(),
                                        ),
                                      ],
                                    );
                                  }

                                  return ListView.builder(
                                    padding: getDeviceType() == Device.Tablet
                                        ? EdgeInsets.symmetric(vertical: 10.h)
                                        : EdgeInsets.symmetric(vertical: 0),
                                    physics: BouncingScrollPhysics(
                                      parent: AlwaysScrollableScrollPhysics(),
                                    ),
                                    itemCount: snapshot.data!.length,
                                    itemBuilder: (context, i) {
                                      User nurse = User.fromDocument(snapshot.data![i]);

                                      return Tile(
                                        onTap: () => Navigator.push(
                                          context,
                                          CupertinoPageRoute(
                                            builder: (_) => NurseDetails(nurse: nurse),
                                          ),
                                        ),
                                        name: nurse.name!,
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: Button(
                              text: 'Notifications',
                              color: kGreen,
                              onPressed: () => Navigator.push(
                                context,
                                CupertinoPageRoute(
                                  builder: (_) => Notifications(),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 30.h),
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
