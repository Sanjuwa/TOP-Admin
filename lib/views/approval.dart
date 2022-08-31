import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:top_admin/controllers/role_controller.dart';
import 'package:top_admin/models/user_model.dart';
import 'package:top_admin/widgets/approval_tile.dart';
import 'package:top_admin/widgets/toast.dart';

import '../constants.dart';
import '../widgets/backdrop.dart';
import '../widgets/heading_card.dart';

class Approval extends StatelessWidget {
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

              //details
              Expanded(
                child: HeadingCard(
                  title: '${roleController.selectedApprovalRole.name} Approval',
                  phoneSize: EdgeInsets.symmetric(horizontal: 35.w, vertical: 15.h),
                  tabletSize: EdgeInsets.symmetric(horizontal: 25.w, vertical: 12.h),
                  child: Expanded(
                    child: Padding(
                      padding: getDeviceType() == Device.Tablet
                          ? EdgeInsets.fromLTRB(15.w, 15.h, 15.w, 20.h)
                          : EdgeInsets.fromLTRB(15.w, 10.h, 15.w, 25.h),
                      child: Column(
                        children: [
                          //filter
                          Padding(
                            padding: getDeviceType() == Device.Tablet
                                ? EdgeInsets.only(top: 35.h, bottom: 20.h)
                                : EdgeInsets.only(top: 30.h, bottom: 25.h),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: ToggleSwitch(
                                initialLabelIndex:
                                    roleController.selectedApprovalRole == Role.Nurse ? 0 : 1,
                                activeFgColor: Colors.white,
                                inactiveBgColor: kDisabledSecondary,
                                inactiveFgColor: kGreyText,
                                totalSwitches: 2,
                                labels: [Role.Nurse.name, Role.Manager.name],
                                fontSize: getDeviceType() == Device.Tablet ? 18.sp : 16.sp,
                                activeBgColor: [kOrange],
                                cornerRadius: 5.r,
                                animate: true,
                                animationDuration: 200,
                                minHeight: getDeviceType() == Device.Tablet ? 40.h : 35,
                                curve: Curves.easeIn,
                                customWidths: [150.w, 150.w],
                                onToggle: (index) {
                                  if (index == 0) {
                                    roleController.selectedApprovalRole = Role.Nurse;
                                  } else {
                                    roleController.selectedApprovalRole = Role.Manager;
                                  }
                                },
                              ),
                            ),
                          ),

                          //data
                          Expanded(
                            child: RefreshIndicator(
                              onRefresh: () async => roleController.refresh(),
                              child:
                              FutureBuilder<List<QueryDocumentSnapshot<Map<String, dynamic>>>>(
                                future: roleController.getPendingApprovals(),
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
                                      User user = User.fromDocument(snapshot.data![i]);

                                      return ApprovalTile(
                                        name: user.name!,
                                        email: user.email!,
                                        hospitalID: user.hospital,
                                        speciality: user.specialities!.join(', '),
                                        phone: user.phone,
                                        showHospital: roleController.selectedApprovalRole == Role.Manager,
                                        showPhone: roleController.selectedApprovalRole == Role.Nurse,
                                        onAcceptButtonPressed: () async {
                                          ToastBar(text: 'Please wait...', color: Colors.orange).show();
                                          bool success = await roleController.approveUser(user);
                                          if(success){
                                            roleController.refresh();
                                          }
                                        },
                                        onDeclineButtonPressed: () async {
                                          ToastBar(text: 'Please wait...', color: Colors.orange).show();
                                          bool success = await roleController.declineUser(user.uid);
                                          if(success){
                                            roleController.refresh();
                                          }
                                        },
                                      );
                                    },
                                  );
                                },
                              ),
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
