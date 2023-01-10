import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:top_admin/models/job_model.dart';
import 'package:top_admin/models/timesheet_model.dart';

class ImageTimesheet extends Timesheet{
  final String url;

  ImageTimesheet({id,job,required this.url}) : super(job, id);

  static ImageTimesheet fromDocument(QueryDocumentSnapshot doc, Job job) {
    return ImageTimesheet(
      id: doc.id,
      job: job,
      url: doc['url'],
    );
  }
}
