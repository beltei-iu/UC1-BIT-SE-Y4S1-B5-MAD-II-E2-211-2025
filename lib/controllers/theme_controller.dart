
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeController extends GetxController {

  final _storage = GetStorage();

  final String key = "theme";

  final String lightTheme = "lightTheme";

  ThemeMode get theme => _loadTheme() ? ThemeMode.dark : ThemeMode.light;

  bool _loadTheme() => _storage.read(key) ?? false;

  void _saveTheme(bool isDarkMode) => _storage.write(key, isDarkMode);

  void switchTheme() {
    bool isDark = !_loadTheme();
    Get.changeThemeMode(isDark ? ThemeMode.dark : ThemeMode.light);
    _saveTheme(isDark);
  }
}