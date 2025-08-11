import 'package:flutter/material.dart';
import 'package:mad_2_211/route/app_route.dart';
import 'package:mad_2_211/services/facebook_service.dart';
import 'package:mad_2_211/services/firebase_auth_service.dart';
import 'package:mad_2_211/services/google_service.dart';
import 'package:mad_2_211/widgets/logo_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isObscure = true;
  bool _isValidEmail = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _loginFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white, body: _body);
  }

  Widget get _body {
    return Padding(
      padding: EdgeInsets.only(left: 16, right: 16, top: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [LogoWidget()],
            ),
          ),
          const SizedBox(height: 20),
          Form(
            key: _loginFormKey,
            child: Column(
              children: [
                _email,
                const SizedBox(height: 20),
                _password,
                const SizedBox(height: 10),
                _forgotPassword,
                const SizedBox(height: 40),
                _loginButton,
              ],
            ),
          ),
          const SizedBox(height: 40),
          const Text('Or login with'),
          _socialLogin,
          const SizedBox(height: 20),
          _navigateToRegister,
        ],
      ),
    );
  }

  Widget get _email {
    return TextFormField(
      controller: _emailController,
      onChanged: (value) {
        print("Value $value");
        if (value.contains("@")) {
          setState(() {
            _isValidEmail = true;
          });
        }
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your email';
        }
        return null;
      },
      decoration: InputDecoration(
        prefix: Icon(Icons.person),
        suffix:
            _isValidEmail
                ? Icon(Icons.check_circle, color: Colors.green)
                : Icon(Icons.check_circle),
        labelText: 'Email',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  Widget get _password {
    return TextFormField(
      controller: _passwordController,
      obscureText: _isObscure,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your password';
        }
        return null;
      },
      decoration: InputDecoration(
        prefix: Icon(Icons.lock),
        labelText: 'Password',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        suffixIcon: IconButton(
          icon: Icon(Icons.visibility),
          onPressed: () {
            setState(() {
              _isObscure = !_isObscure;
            });
          },
        ),
      ),
    );
  }

  Widget get _loginButton {
    return SizedBox(
      height: 40,
      width: MediaQuery.of(context).size.width * 0.8,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        onPressed: () {
          if (_loginFormKey.currentState!.validate()) {
            String email = _emailController.text;
            String password = _passwordController.text;
            FirebaseAuthService.instance.signInFirebaseWithEmailAndPassword(
              email,
              password,
            );
          }
        },
        child: const Text(
          'Login',
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
      ),
    );
  }

  Widget get _forgotPassword {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          onPressed: () {
            AppRoute.key.currentState?.pushNamed(AppRoute.phoneScreen);
          },
          child: const Text(
            'Forgot Password?',
            style: TextStyle(color: Colors.red),
          ),
        ),
      ],
    );
  }

  Widget get _socialLogin {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: () {
            GoogleService.instance.signInWithGoogle();
          },
          icon: Image.asset('assets/images/google.png', width: 30, height: 30),
        ),
        IconButton(
          onPressed: () {
            FacebookService.instance.signInWithFacebook();
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

  Widget get _navigateToRegister {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Don\'t have an account?'),
        TextButton(
          onPressed: () {
            AppRoute.key.currentState?.pushReplacementNamed(
              AppRoute.registerScreen,
            );
          },
          child: const Text('Register', style: TextStyle(color: Colors.red)),
        ),
      ],
    );
  }
}
