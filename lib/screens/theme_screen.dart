import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mad_2_211/controllers/theme_controller.dart';

class ThemeScreen extends StatefulWidget {
  const ThemeScreen({super.key});

  @override
  State<ThemeScreen> createState() => _ThemeScreenState();
}

class _ThemeScreenState extends State<ThemeScreen> {

  bool _isLight = false;
  final ThemeController themeController = Get.put(ThemeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Theme"),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      body: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.language),
            title: Text("khmerLanguage".tr),
            trailing: Checkbox(value: _isLight, onChanged: (v){
              themeController.switchTheme();
            }),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.language),
            title: Text("englishLanguage".tr),
            trailing: Checkbox(value: !_isLight, onChanged: (v){
              themeController.switchTheme();
            }),
          ),
          Divider(),
        ],
      ),
    );
  }
}
