import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:top_admin/constants.dart';
import 'package:top_admin/controllers/role_controller.dart';
import 'package:top_admin/views/pop_ups/create_notification.dart';
import 'package:top_admin/widgets/backdrop.dart';
import 'package:top_admin/widgets/button.dart';
import 'package:top_admin/widgets/heading_card.dart';
import 'package:top_admin/widgets/tile.dart';
import 'package:top_admin/widgets/toast.dart';

class Notifications extends StatelessWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var roleController = Provider.of<RoleController>(context);

    return Scaffold(
      body: Backdrop(
        child: Padding(
          padding: getDeviceType() == Device.Tablet
              ? EdgeInsets.only(left: 40.w, right: 40.w, bottom: 30.h)
              : EdgeInsets.only(left: 30.w, right: 30.w, bottom: 30.w),
          child: Column(
            children: [
              SizedBox(height: ScreenUtil().statusBarHeight),
              Align(
                alignment: Alignment.topLeft,
                child: BackButton(
                  color: kGreyText,
                ),
              ),
              Expanded(
                child: HeadingCard(
                  title: 'Notifications',
                  child: Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.w),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20.h,
                          ),
                          Expanded(
                            child: RefreshIndicator(
                              onRefresh: () async => roleController.refresh(),
                              child:
                                  FutureBuilder<List<QueryDocumentSnapshot<Map<String, dynamic>>>>(
                                future: roleController.getAllNotifications(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState == ConnectionState.waiting) {
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                                    return Stack(
                                      children: [
                                        ListView(
                                          physics: AlwaysScrollableScrollPhysics(),
                                        ),
                                        Center(
                                          child: Button(
                                            text: 'Add Notification',
                                            color: kRed,
                                            onPressed: () => showDialog(context: context, builder: (_) => CreateNotification()),
                                          ),
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
                                      return Column(
                                        children: [
                                          Tile(
                                            name: snapshot.data![i]['text'],
                                            showDeleteButton: true,
                                            onDeletePressed: () => showDialog(
                                              context: context,
                                              builder: (context) => AlertDialog(
                                                content: Text(
                                                  "Are you sure you want to delete this notification?",
                                                ),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () => Navigator.pop(context),
                                                    child: Text('No'),
                                                  ),
                                                  TextButton(
                                                    onPressed: () async {
                                                      ToastBar(
                                                              text: 'Please wait...',
                                                              color: Colors.orange)
                                                          .show();
                                                      bool success = await roleController
                                                          .deleteNotification(snapshot.data![i].id);
                                                      if (success) {
                                                        Navigator.pop(context);
                                                        roleController.refresh();
                                                      }
                                                    },
                                                    child: Text('Yes'),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),

                                          Center(
                                            child: Button(
                                              text: 'Edit Notification',
                                              fontSize: 16.sp,
                                              padding: 8.w,
                                              color: kRed,
                                              onPressed: () => showDialog(context: context, builder: (_) => CreateNotification(text: snapshot.data![i]['text'],)),
                                            ),
                                          )
                                        ],
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
