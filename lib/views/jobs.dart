import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:top_admin/constants.dart';
import 'package:top_admin/controllers/job_controller.dart';
import 'package:top_admin/models/job_model.dart';
import 'package:top_admin/views/create_job.dart';
import 'package:top_admin/widgets/backdrop.dart';
import 'package:top_admin/widgets/heading_card.dart';
import 'package:top_admin/widgets/shift_tile.dart';

class Jobs extends StatefulWidget {
  @override
  State<Jobs> createState() => _JobsState();
}

class _JobsState extends State<Jobs> {
  @override
  Widget build(BuildContext context) {
    var jobController = Provider.of<JobController>(context);

    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        label: Text('Create Job'),
        icon: Icon(Icons.add_box),
        backgroundColor: kGreen,
        onPressed: () => Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (_) => CreateJob(),
          ),
        ),
      ),
      body: Backdrop(
        child: Padding(
          padding: EdgeInsets.all(30.w),
          child: Column(
            children: [
              SizedBox(height: ScreenUtil().statusBarHeight),
              Expanded(
                child: HeadingCard(
                  title: "Jobs",
                  child: Expanded(
                    child: Column(
                      children: [
                        SizedBox(height: 30.h),

                        //filter
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15.w),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: ToggleSwitch(
                              initialLabelIndex: jobController.selectedStatus == JobStatus.Available
                                  ? 0
                                  : jobController.selectedStatus == JobStatus.Confirmed
                                      ? 1
                                      : 2,
                              activeFgColor: Colors.white,
                              inactiveBgColor: kDisabledSecondary,
                              inactiveFgColor: kGreyText,
                              totalSwitches: JobStatus.values.length,
                              labels: [
                                JobStatus.Available.name,
                                JobStatus.Confirmed.name,
                                JobStatus.Completed.name,
                              ],
                              fontSize: 13.sp,
                              activeBgColor: [kOrange],
                              cornerRadius: 5.r,
                              animate: true,
                              animationDuration: 200,
                              customWidths: JobStatus.values
                                  .map((e) => (getDeviceType() == Device.Tablet
                                  ? e.name.length * 5 + 70.w
                                  : e.name.length * 5 + 70.w))
                                  .toList(),
                              curve: Curves.easeIn,
                              onToggle: (index) => jobController.selectedStatus = index == 0
                                  ? JobStatus.Available
                                  : index == 1
                                      ? JobStatus.Confirmed
                                      : JobStatus.Completed,
                            ),
                          ),
                        ),

                        //jobs
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15.w),
                            child: RefreshIndicator(
                              onRefresh: () async => setState(() {}),
                              child:
                                  FutureBuilder<List<QueryDocumentSnapshot<Map<String, dynamic>>>>(
                                future: jobController.getJobs(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState == ConnectionState.waiting) {
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                                    return Stack(
                                      children: [
                                        Center(
                                          child: Text('No data to show!'),
                                        ),
                                        ListView(
                                          physics: AlwaysScrollableScrollPhysics(),
                                        ),
                                      ],
                                    );
                                  }

                                  return ListView.builder(
                                    physics: BouncingScrollPhysics(
                                      parent: AlwaysScrollableScrollPhysics(),
                                    ),
                                    itemCount: snapshot.data!.length,
                                    itemBuilder: (context, i) {
                                      Job job = Job.createJobFromDocument(snapshot.data![i]);

                                      return Padding(
                                        padding: EdgeInsets.only(bottom: 20.h),
                                        child: Card(
                                          margin: EdgeInsets.symmetric(horizontal: 15.w),
                                          elevation: 5,
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(10.r)),
                                          child: ShiftTile(
                                            hospital: job.hospital,
                                            nurse: job.nurseID ?? '',
                                            shiftTime:
                                                "${job.shiftStartTime} to ${job.shiftEndTime}",
                                            shiftDate:
                                                DateFormat('EEEE MMMM dd').format(job.shiftDate),
                                            speciality: job.speciality,
                                            additionalDetails: job.additionalDetails,
                                            showBackStrip: false,
                                            showFrontStrip: true,
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
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
