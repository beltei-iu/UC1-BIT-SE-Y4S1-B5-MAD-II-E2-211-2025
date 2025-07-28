
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {

  bool _isKhmer = false;

  @override
  void initState() {
    super.initState();
    _isKhmer = Get.locale?.languageCode == 'km' ? true : false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("language".tr),
        elevation: 0.5,
        backgroundColor: Colors.red,
        centerTitle: true,
      ),
      body: ListView(
        children: [
            ListTile(
              leading: Icon(Icons.language),
              title: Text("khmerLanguage".tr),
              trailing: Checkbox(value: _isKhmer, onChanged: (v){
                var locale = Locale('km', 'KH');
                Get.updateLocale(locale);
                setState(() {
                  _isKhmer = true;
                });
              }),
            ),
          Divider(),
          ListTile(
            leading: Icon(Icons.language),
            title: Text("englishLanguage".tr),
            trailing: Checkbox(value: !_isKhmer, onChanged: (v){
              var locale = Locale('en', 'US');
              Get.updateLocale(locale);
              setState(() {
                _isKhmer = false;
              });
            }),
          ),
          Divider(),
        ],
      ),
    );
  }
}
