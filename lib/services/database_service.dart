import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:top_admin/constants.dart';
import 'package:top_admin/models/job_model.dart';

class DatabaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool> isAdmin(String uid) async {
    DocumentSnapshot doc = await _firestore.collection('admin').doc(uid).get();
    return doc.exists;
  }

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> getNurses(String speciality) async {
    var query = _firestore
        .collection('users')
        .where('role', isEqualTo: Role.Nurse.name)
        .where('isApproved', isEqualTo: true);

    if (speciality != 'All') {
      query = query.where('specialities', arrayContains: speciality);
    }

    var sub = await query.orderBy('name').get();

    return sub.docs;
  }

  Future<Map<String, dynamic>?> getSingleNurse(String id) async {
    var sub = await _firestore.collection('users').doc(id).get();
    return sub.data();
  }

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> getAllAvailability(String uid) async {
    var sub = await _firestore.collection('users').doc(uid).collection('shifts').get();
    return sub.docs;
  }

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> getAllHospitals() async {
    var sub = await _firestore.collection('hospitals').orderBy('name').get();
    return sub.docs;
  }

  Future<Map<String, dynamic>?> getSingleHospital(String id) async {
    var sub = await _firestore.collection('hospitals').doc(id).get();
    return sub.data();
  }

  addHospital(String name) async {
    var ref = await _firestore.collection('hospitals').add({
      'name': name,
    });

    await _firestore.collection('hospitals').doc(ref.id).update({
      'id': ref.id,
    });
  }

  createJob(Job job) async {
    await _firestore.collection('jobs').add({
      'hospitalName': job.hospital,
      'hospitalID': job.hospitalID,
      'managerName': job.managerName,
      'managerID': job.managerID,
      'speciality': job.speciality,
      'shiftDate': job.shiftDate,
      'shiftStartTime': job.shiftStartTime,
      'shiftEndTime': job.shiftEndTime,
      'shiftType': job.shiftType,
      'additionalDetails': job.additionalDetails,
      'status': JobStatus.Available.name,
      'nurse': null,
    });
  }

  assignJobToNurse(Job job, String nurseID, String shiftID, String shiftType) async {
    await _firestore.collection('jobs').add({
      'hospitalName': job.hospital,
      'hospitalID': job.hospitalID,
      'managerName': job.managerName,
      'managerID': job.managerID,
      'speciality': job.speciality,
      'shiftDate': job.shiftDate,
      'shiftStartTime': job.shiftStartTime,
      'shiftEndTime': job.shiftEndTime,
      'shiftType': job.shiftType,
      'additionalDetails': job.additionalDetails,
      'status': JobStatus.Confirmed.name,
      'nurse': nurseID,
    });

    DocumentSnapshot<Map<String, dynamic>> docRef = await _firestore.collection('users').doc(nurseID).collection('shifts').doc(shiftID).get();
    if(!docRef.exists){
      await _firestore.collection('users').doc(nurseID).collection('shifts').doc(shiftID).set({
        'AM': AvailabilityStatus.NotAvailable.name,
        'PM': AvailabilityStatus.NotAvailable.name,
        'NS': AvailabilityStatus.NotAvailable.name,
        'date': shiftID
      });
    }

      await _firestore.collection('users').doc(nurseID).collection('shifts').doc(shiftID).update({
        shiftType: AvailabilityStatus.Booked.name,
      });

  }

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> getSingleAvailability(
      String uid, String date) async {
    var sub = await _firestore
        .collection('users')
        .doc(uid)
        .collection('shifts')
        .where('date', isEqualTo: date)
        .get();
    return sub.docs;
  }

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> getPendingApprovals(Role role) async {
    var sub = await _firestore
        .collection('users')
        .where('role', isEqualTo: role.name)
        .where('isApproved', isEqualTo: false)
        .where('isDeclined', isEqualTo: false)
        .orderBy('name')
        .get();

    return sub.docs;
  }

  approveUser(String id) async {
    await _firestore.collection('users').doc(id).update({
      'isApproved': true,
    });
  }

  declineUser(String id) async {
    await _firestore.collection('users').doc(id).update({
      'isDeclined': true,
      'isApproved': false,
    });
  }

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> getTimeSheets(String? date) async {
    var sub = await _firestore.collection('timesheets').where('date', isEqualTo: date).get();

    return sub.docs;
  }

  Future<Map<String, dynamic>?> getSingleJob(String id) async {
    var sub = await _firestore.collection('jobs').doc(id).get();
    return sub.data();
  }

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> getManagers(String hospitalID) async {
    var sub = await _firestore
        .collection('users')
        .where('role', isEqualTo: Role.Manager.name)
        .where('isApproved', isEqualTo: true)
        .where('hospitalID', isEqualTo: hospitalID)
        .orderBy('name')
        .get();

    return sub.docs;
  }

  createNotification(String text) async {
    await _firestore.collection('notifications').doc('1').set({
      'text': text,
      'date': DateTime.now().toString(),
    });
  }

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> getAllNotifications() async {
    var sub = await _firestore.collection('notifications').orderBy('date', descending: true).get();
    return sub.docs;
  }

  deleteNotification(String id) async {
    await _firestore.collection('notifications').doc(id).delete();
  }

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> getJobs(JobStatus status) async {
    var sub = await _firestore
        .collection('jobs')
        .where('status', isEqualTo: status.name)
        .orderBy('shiftDate', descending: true)
        .get();
    return sub.docs;
  }

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> getJobsForNurse(String nurseID, String shift, DateTime date) async {
    var sub = await _firestore
        .collection('jobs')
        .where('status', isEqualTo: JobStatus.Confirmed.name)
        .where('nurse', isEqualTo: nurseID)
        .where('shiftType', isEqualTo: shift)
        .where('shiftDate', isEqualTo: date)
        .get();
    return sub.docs;
  }

  deleteJob(String id) async {
    await _firestore.collection('jobs').doc(id).delete();
  }

  unBookNurse(String nurseID, String shiftID, String shiftType) async {
    await _firestore.collection('users').doc(nurseID).collection('shifts').doc(shiftID).update({
      shiftType: AvailabilityStatus.Available.name,
    });
  }
}
