import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:top_admin/constants.dart';
import 'package:top_admin/models/shift_model.dart';
import 'package:top_admin/services/database_service.dart';
import 'package:top_admin/widgets/toast.dart';

class RoleController extends ChangeNotifier {
  final DatabaseService _databaseService = DatabaseService();

  String _selectedSpeciality = 'All';

  String get selectedSpeciality => _selectedSpeciality;

  set selectedSpeciality(String speciality) {
    _selectedSpeciality = speciality;
    notifyListeners();
  }

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> getAllNurses() async {
    return _databaseService.getNurses(_selectedSpeciality);
  }

  Future<List<Shift>> getAllAvailability(String uid) async {
    try {
      List<QueryDocumentSnapshot<Map<String, dynamic>>> datesAndShifts =
      await _databaseService.getAllAvailability(uid);

      List<String> allDays =
      _getDaysInBetween(DateTime.now(), DateTime.parse(datesAndShifts.last['date']));

      List<Shift> shifts = allDays.map((day) {
        int index = datesAndShifts.indexWhere((element) => element['date'] == day);

        //not in db
        if (index == -1) {
          return Shift(
            date: day,
            am: AvailabilityStatus.NotAvailable,
            pm: AvailabilityStatus.NotAvailable,
            ns: AvailabilityStatus.NotAvailable,
          );
        }
        // in db
        else {
          return Shift(
            date: datesAndShifts[index]['date'],
            am: AvailabilityStatus.values.byName(datesAndShifts[index]['AM']),
            pm: AvailabilityStatus.values.byName(datesAndShifts[index]['PM']),
            ns: AvailabilityStatus.values.byName(datesAndShifts[index]['NS']),
          );
        }
      }).toList();

      return shifts;
    } catch (e) {
      return [];
    }
  }

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> getAllHospitals() async {
    return _databaseService.getAllHospitals();
  }

  Future<bool> addHospital(String name) async {
    try{
      await _databaseService.addHospital(name);
      ToastBar(text: "Hospital added", color: Colors.green).show();
      return true;
    } catch(e){
      ToastBar(text: e.toString(), color: Colors.red).show();
      return false;
    }
  }

  Future<bool> isNurseAvailable(String uid, String date, String shiftType) async {
    List shift = await _databaseService.getSingleAvailability(uid, date);
    if (shift.isEmpty) {
      return false;
    } else {
      return shift[0][shiftType] == AvailabilityStatus.Available.name;
    }
  }

  void refresh() => notifyListeners();

  List<String> _getDaysInBetween(DateTime startDate, DateTime endDate) {
    List<String> days = [];
    for (int i = 0; i <= endDate.difference(startDate).inDays + 1; i++) {
      days.add(startDate.add(Duration(days: i)).toYYYYMMDDFormat());
    }
    return days;
  }
}
