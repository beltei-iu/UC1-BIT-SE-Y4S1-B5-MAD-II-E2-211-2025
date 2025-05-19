
import 'package:flutter/material.dart';
import 'package:mad_2_211/widgets/logo_widget.dart';

class PhoneScreen extends StatefulWidget {
  const PhoneScreen({super.key});

  @override
  State<PhoneScreen> createState() => _PhoneScreenState();
}

class _PhoneScreenState extends State<PhoneScreen> {


  final TextEditingController _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _appBar,
      body: _body,
    );
  }

  PreferredSizeWidget get _appBar {
    return AppBar(
      title: const Text('Phone Number', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),),
      centerTitle: true,
      backgroundColor: Colors.white,
    );
  }

  Widget get _body {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LogoWidget(),
                const SizedBox(height: 20),
                //_phoneNumber,
              ],
            ),
          ),
          const SizedBox(height: 20),
          //_continueButton,
          const SizedBox(height: 40),
        ],
      ),
    );  
  }



}