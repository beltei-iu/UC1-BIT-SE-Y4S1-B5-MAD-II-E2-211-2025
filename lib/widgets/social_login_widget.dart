import 'package:flutter/material.dart';

class SocialLoginWidget extends StatefulWidget {
  const SocialLoginWidget({super.key});

  @override
  State<SocialLoginWidget> createState() => _SocialLoginWidgetState();
}

class _SocialLoginWidgetState extends State<SocialLoginWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: () {
            // Handle Google login
          },
          icon: Image.asset('assets/images/google.png', width: 30, height: 30),
        ),
        IconButton(
          onPressed: () {
            // Handle Facebook login
          },
          icon: Image.asset(
            'assets/images/facebook.png',
            width: 30,
            height: 30,
          ),
        ),
      ],
    );
  }
}
