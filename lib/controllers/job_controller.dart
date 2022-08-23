import 'package:flutter/material.dart';
import 'package:top_admin/constants.dart';
import 'package:top_admin/models/job_model.dart';
import 'package:top_admin/services/database_service.dart';
import 'package:top_admin/widgets/toast.dart';

class JobController {
  final DatabaseService _databaseService = DatabaseService();

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
}
