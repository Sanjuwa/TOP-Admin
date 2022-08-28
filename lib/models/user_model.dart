import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:top_admin/constants.dart';

class User {
  final String uid;
  final String? email;
  String? name;
  Role? role;
  String? hospital;
  List? specialities;
  bool? isApproved;
  String? phone;

  User(this.uid, this.email);
  
  static User fromDocument(QueryDocumentSnapshot doc){
    User user = User(doc.id, doc['email']);
    user.name = doc['name'];
    user.isApproved = doc['isApproved'];
    user.role = Role.values.byName(doc['role']);
    user.specialities = doc['specialities'];

    if(user.role == Role.Nurse){
      user.phone = doc['phone'];
    } else {
      user.hospital = doc['hospitalID'];
    }

    return user;
  }
  
}