import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool> isAdmin(String uid) async {
    DocumentSnapshot doc = await _firestore.collection('admin').doc(uid).get();
    return doc.exists;
  }

}