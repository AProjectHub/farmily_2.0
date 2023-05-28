import 'package:flutter/foundation.dart';

class RoleProvider with ChangeNotifier {
  String _selectedRole = '';

  String get selectedRole => _selectedRole;

  void setSelectedRole(String role) {
    _selectedRole = role;
    notifyListeners();
  }
}
