import 'dart:html';

class WebStorageService {
  final Storage _localStorage = window.localStorage;
  
  static const String _themeKey = 'isDark';
  
  Future<void> saveTheme(bool isDark) async {
    _localStorage[_themeKey] = isDark.toString();
  }
  
  Future<bool> getTheme() async {
    final value = _localStorage[_themeKey];
    return value == 'true';
  }
  
  Future<void> clearAll() async {
    _localStorage.clear();
  }
} 