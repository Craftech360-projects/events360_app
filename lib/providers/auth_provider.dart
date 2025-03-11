import 'package:events360/infrastructure/supabase_service.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  final SupabaseService _supabaseService = SupabaseService();
  final SharedPreferences _prefs;
  bool _isAuthenticated = false;
  String? _errorMessage;

  AuthProvider(this._prefs) {
    // Use Supabase's session status instead of SharedPreferences
    _isAuthenticated = _supabaseService.isAuthenticated();
  }

  bool get isAuthenticated => _isAuthenticated;
  String? get errorMessage => _errorMessage;

  Future<Map<String, dynamic>> signIn(String email, String password) async {
    final response = await _supabaseService.signIn(email, password);

    if (response['success'] == true) {
      _isAuthenticated = true;
      _errorMessage = null;
      await _prefs.setBool('isAuthenticated', true);
      notifyListeners();
      return {'success': true, 'error': null};
    } else {
      _errorMessage = response['error'] ?? 'Authentication failed';
      notifyListeners();
      return {'success': false, 'error': _errorMessage};
    }
  }

  Future<Map<String, dynamic>> signUp(
      String name, String email, String password) async {
    final response = await _supabaseService.signUp(name, email, password);
    
    if (response['success'] == true) {
      _isAuthenticated = true;
      _errorMessage = null;
      await _prefs.setBool('isAuthenticated', true);
      notifyListeners();
      return {'success': true, 'error': null};
    } else {
      _errorMessage = response['error'] ?? 'Failed to create account';
      notifyListeners();
      return {'success': false, 'error': _errorMessage};
    }
  }

  Future<void> signOut() async {
    await _supabaseService.signOut();
    _isAuthenticated = false;
    await _prefs.setBool('isAuthenticated', false);
    notifyListeners();
  }
}
