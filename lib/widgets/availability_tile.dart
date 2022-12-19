import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:top_admin/constants.dart';
import 'package:top_admin/controllers/job_controller.dart';
import 'package:top_admin/widgets/badge.dart';
import 'package:top_admin/widgets/shift_tile.dart';

import '../models/job_model.dart';

class AvailabilityTile extends StatelessWidget {
  final String nurseID;
  final String dateString;
  final DateTime date;
  final AvailabilityStatus am;
  final AvailabilityStatus pm;
  final AvailabilityStatus ns;

  const AvailabilityTile(
      {super.key, required this.dateString, required this.am, required this.pm, required this.ns, required this.nurseID, required this.date,});

  void onBadgeTapped(String shift, AvailabilityStatus availabilityStatus, BuildContext context){
    var jobController = Provider.of<JobController>(context, listen: false);

    if(availabilityStatus == AvailabilityStatus.Booked){
      showCupertinoModalPopup(context: context, builder: (BuildContext context){return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(30.r)),
          color: Colors.white,
        ),
        height: 0.75.sh,
        child: Padding(
          padding: EdgeInsets.all(30.w),
          child: FutureBuilder<List<QueryDocumentSnapshot<Map<String, dynamic>>>>(
            future: jobController.getJobsForNurse(nurseID, shift, date),
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
                padding: getDeviceType() == Device.Tablet
                    ? EdgeInsets.symmetric(vertical: 10.h)
                    : EdgeInsets.symmetric(vertical: 0),
                physics: BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics(),
                ),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, i) {
                  Job job = Job.createJobFromDocument(snapshot.data![i]);

                  return Padding(
                    padding: EdgeInsets.only(bottom: 20.h),
                    child: Card(
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
      );});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.r),
      ),
      elevation: 3,
      margin: EdgeInsets.only(bottom: 16.h),
      child: Padding(
        padding: getDeviceType() == Device.Tablet?EdgeInsets.all(20.h):EdgeInsets.all(15.h),
        child: Row(
          children: [
            Text(
              dateString,
              style: GoogleFonts.sourceSansPro(
                fontSize: getDeviceType() == Device.Tablet?23.sp:20.sp,
                fontWeight: FontWeight.w600,
                color: kGreyText,
              ),
            ),
            Expanded(child: SizedBox.shrink()),
            Badge(
              text: 'AM',
              color: am == AvailabilityStatus.Available ? Colors.green : Colors.red,
              enabled: am != AvailabilityStatus.NotAvailable,
              onTap: () => onBadgeTapped('AM', am, context),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Badge(
                text: 'PM',
                color: pm == AvailabilityStatus.Available ? Colors.green : Colors.red,
                enabled: pm != AvailabilityStatus.NotAvailable,
                onTap: () => onBadgeTapped('PM', pm, context),
              ),
            ),
            Badge(
              text: 'NS',
              color: ns == AvailabilityStatus.Available ? Colors.green : Colors.red,
              enabled: ns != AvailabilityStatus.NotAvailable,
              onTap: () => onBadgeTapped('NS', ns,context),
            ),
          ],
        ),
      ),
    );
  }
}
