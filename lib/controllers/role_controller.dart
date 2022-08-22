import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:top_admin/services/database_service.dart';

class RoleController extends ChangeNotifier {
  final DatabaseService _databaseService = DatabaseService();

  String _selectedSpeciality = 'All';

  String get selectedSpeciality => _selectedSpeciality;

  set selectedSpeciality(String speciality) {
    _selectedSpeciality = speciality;
    notifyListeners();
  }

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> getAllNurses() async {
    return _databaseService.getAllNurses(_selectedSpeciality);
  }

  refresh() => notifyListeners();
}
