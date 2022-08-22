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
}