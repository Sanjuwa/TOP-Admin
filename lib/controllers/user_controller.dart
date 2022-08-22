import 'package:top_admin/models/user_model.dart';
import 'package:top_admin/services/auth_service.dart';
import 'package:top_admin/services/database_service.dart';

class UserController{
  final AuthService _authService = AuthService();
  final DatabaseService _databaseService = DatabaseService();

  Future<bool?> isAdmin() async {
    User? user = await _authService.currentUser;

    if (user == null) {
      return null;
    }

    return await _databaseService.isAdmin(user.uid);
  }

  Future<bool> signOut() async => await _authService.signOut();

  Future<bool> signIn(String email, String password) async {
    User? user = await _authService.signIn(email, password);

    if (user == null) {
      return false;
    }

    bool result = await _databaseService.isAdmin(user.uid);
    if(!result){
      signOut();
    }

    return result;
  }
}