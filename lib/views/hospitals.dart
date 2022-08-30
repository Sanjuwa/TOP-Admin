import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:top_admin/controllers/role_controller.dart';
import 'package:top_admin/models/hospital_model.dart';
import 'package:top_admin/constants.dart';
import 'package:top_admin/views/pop_ups/create_hospital.dart';
import 'package:top_admin/views/manager_details.dart';
import 'package:top_admin/widgets/backdrop.dart';
import 'package:top_admin/widgets/heading_card.dart';
import 'package:top_admin/widgets/tile.dart';

class Hospitals extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var roleController = Provider.of<RoleController>(context);

    return Scaffold(
      floatingActionButton: Padding(
        padding: getDeviceType() == Device.Tablet?EdgeInsets.only(right: 10.w,bottom: 10.h):EdgeInsets.zero,
        child: getDeviceType() == Device.Tablet?FloatingActionButton.large(
          backgroundColor: kGreen,
          elevation: 7,
          onPressed: () => showDialog(context: context, builder: (_) => CreateHospital()),
          child: Icon(Icons.add,size: 50,),
        ):FloatingActionButton(
          backgroundColor: kGreen,
          elevation: 7,
          onPressed: () => showDialog(context: context, builder: (_) => CreateHospital()),
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
                            child: RefreshIndicator(
                              onRefresh: () async => roleController.refresh(),
                              child:
                              FutureBuilder<List<QueryDocumentSnapshot<Map<String, dynamic>>>>(
                                future: roleController.getAllHospitals(),
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
                                      Hospital hospital = Hospital(snapshot.data![i].id, snapshot.data![i]['name']);

                                      return Tile(
                                        onTap: () => Navigator.push(
                                          context,
                                          CupertinoPageRoute(
                                            builder: (_) => ManagerDetails(hospital: hospital),
                                          ),
                                        ),
                                        name: hospital.name,
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
