import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:top_admin/controllers/role_controller.dart';
import 'package:top_admin/models/hospital_model.dart';
import 'package:top_admin/models/user_model.dart';
import 'package:top_admin/widgets/approval_tile.dart';
import 'package:top_admin/widgets/input_filed.dart';
import 'package:top_admin/constants.dart';
import 'package:top_admin/widgets/backdrop.dart';
import 'package:top_admin/widgets/heading_card.dart';

class ManagerDetails extends StatelessWidget {

  final Hospital hospital;

  ManagerDetails({super.key, required this.hospital});

  final TextEditingController hospitalName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var roleController = Provider.of<RoleController>(context);
    hospitalName.text = hospital.name;

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
                  title: "Managers' Details",
                  phoneSize: EdgeInsets.symmetric(horizontal: 35.w, vertical: 15.h),
                  tabletSize: EdgeInsets.symmetric(horizontal: 25.w, vertical: 12.h),
                  child: Expanded(
                    child: Padding(
                      padding: getDeviceType() == Device.Tablet
                          ? EdgeInsets.fromLTRB(15.w, 15.h, 15.w, 20.h)
                          : EdgeInsets.fromLTRB(15.w, 10.h, 15.w, 25.h),
                      child: Column(
                        children: [
                          //name
                          Padding(
                            padding: EdgeInsets.only(top: 35.h),
                            child: InputField(
                              text: 'Hospital Name',
                              enabled: false,
                              controller: hospitalName,
                            ),
                          ),

                          //managers
                          Expanded(
                            child: RefreshIndicator(
                              onRefresh: () async => roleController.refresh(),
                              child:
                                  FutureBuilder<List<QueryDocumentSnapshot<Map<String, dynamic>>>>(
                                future: roleController.getManagers(hospital.id),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState == ConnectionState.waiting) {
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                                    return Stack(
                                      children: [
                                        Center(
                                          child: Text(
                                            'No data to show!',
                                            style: TextStyle(
                                                fontSize: getDeviceType() == Device.Tablet
                                                    ? 20.sp
                                                    : null),
                                          ),
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
                                        : EdgeInsets.symmetric(vertical: 15.h),
                                    physics: BouncingScrollPhysics(
                                      parent: AlwaysScrollableScrollPhysics(),
                                    ),
                                    itemCount: snapshot.data!.length,
                                    itemBuilder: (context, i) {
                                      User user = User.fromDocument(snapshot.data![i]);

                                      return Padding(
                                        padding: EdgeInsets.only(top: 15.h),
                                        child: ApprovalTile(
                                          name: user.name!,
                                          email: user.email!,
                                          hospitalID: user.hospital,
                                          speciality: user.specialities!.join(', '),
                                          showHospital: true,
                                          showPhone: false,
                                          showButtons: false,
                                        ),
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
