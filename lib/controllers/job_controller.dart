import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:top_admin/constants.dart';
import 'package:top_admin/models/job_model.dart';
import 'package:top_admin/models/timesheet_model.dart';
import 'package:top_admin/services/database_service.dart';
import 'package:top_admin/widgets/toast.dart';

class JobController extends ChangeNotifier{
  final DatabaseService _databaseService = DatabaseService();
  String? _timeSheetDate;

  String? get timeSheetDate => _timeSheetDate;

  set timeSheetDate(String? date) {
    _timeSheetDate = date;
    notifyListeners();
  }

  void refresh() => notifyListeners();

  Future<bool> createJob(Job job) async {
    try {
      await _databaseService.createJob(job);
      ToastBar(text: "Job Posted Successfully!", color: Colors.green).show();
      return true;
    } catch (e) {
      ToastBar(text: e.toString(), color: Colors.red).show();
      return false;
    }
  }

  Future<bool> assignJobToNurse(Job job, String nurseID) async {
    try {
      await _databaseService.assignJobToNurse(
        job,
        nurseID,
        job.shiftDate.toYYYYMMDDFormat(),
        job.shiftType,
      );
      ToastBar(text: "Job Assigned!", color: Colors.green).show();
      return true;
    } catch (e) {
      ToastBar(text: e.toString(), color: Colors.red).show();
      return false;
    }
  }

  Future<List<TimeSheet>> getTimeSheets() async {
    List<QueryDocumentSnapshot<Map<String, dynamic>>> timeSheetDetails = await _databaseService.getTimeSheets(_timeSheetDate);
    List<TimeSheet> timeSheets = [];
    for(var timeSheetData in timeSheetDetails){
      Map<String, dynamic>? jobDetails = await _databaseService.getSingleJob(timeSheetData['jobID']);
      Job job = Job.createJobFromMap(jobDetails!, timeSheetData['jobID']);
      TimeSheet timeSheet = TimeSheet.fromDocument(timeSheetData, job);
      timeSheets.add(timeSheet);
    }

    return timeSheets;
  }
}
