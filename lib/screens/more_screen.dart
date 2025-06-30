import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mad_2_211/controllers/theme_controller.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({super.key});

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {


  final ThemeController themeController = Get.put(ThemeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("More"),
        elevation: 0.2,
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      body: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.language),
            title: Text("Language"),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.newspaper),
            title: Text("Theme"),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: (){
              themeController.switchTheme();
            },
          ),
          Divider()
        ],
      ),
    );
  }
}
