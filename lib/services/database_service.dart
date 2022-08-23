import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:top_admin/constants.dart';

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

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> getAllAvailability(String uid) async {
    var sub = await _firestore.collection('users').doc(uid).collection('shifts').get();
    return sub.docs;
  }

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> getAllHospitals() async {
    var sub = await _firestore.collection('hospitals').orderBy('name').get();
    return sub.docs;
  }

  addHospital(String name) async {
    var ref = await _firestore.collection('hospitals').add({
      'name': name,
    });

    await _firestore.collection('hospitals').doc(ref.id).update({
      'id': ref.id,
    });
  }
}