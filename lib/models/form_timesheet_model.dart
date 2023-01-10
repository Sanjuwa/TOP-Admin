import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:top_admin/models/job_model.dart';
import 'package:top_admin/models/timesheet_model.dart';

class FormTimeSheet extends Timesheet{
  final String startTime;
  final String endTime;
  final bool mealBreakIncluded;
  final int? mealBreakTime;
  final String? additionalDetails;
  String? nurseSignatureURL;
  String? hospitalSignatureURL;
  final String? hospitalSignatureName;

  FormTimeSheet({
    id,
    job,
    required this.startTime,
    required this.endTime,
    required this.mealBreakIncluded,
    this.mealBreakTime,
    this.additionalDetails,
    this.nurseSignatureURL,
    this.hospitalSignatureURL,
    this.hospitalSignatureName,
  }) : super(job, id);

  static FormTimeSheet fromDocument(QueryDocumentSnapshot doc, Job job) {
    return FormTimeSheet(
      id: doc.id,
      job: job,
      startTime: doc['shiftStartTime'],
      endTime: doc['shiftEndTime'],
      mealBreakIncluded: doc['mealBreakIncluded'],
      hospitalSignatureName: doc['hospitalName'],
      additionalDetails: doc['additionalDetails'],
      hospitalSignatureURL: doc['hospitalSignature'],
      nurseSignatureURL: doc['nurseSignature'],
      mealBreakTime: doc['mealBreakTime'],
    );
  }
}
