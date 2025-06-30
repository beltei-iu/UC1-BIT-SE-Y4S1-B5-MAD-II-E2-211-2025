import 'package:flutter/material.dart';
import 'package:mad_2_211/data/user_shared_preference.dart';
import 'package:mad_2_211/route/app_route.dart';
import 'package:mad_2_211/screens/main_screen.dart';
import 'package:mad_2_211/widgets/logo_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isObscure = true;
  bool _isValidEmail = false;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _loginFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    ElevatedButton(
      onPressed: () {
        if (_loginFormKey.currentState!.validate()) {
          // All fields are valid, proceed with data submission
        }
      },
      child: Text('Submit'),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: _body,
    );
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
          _username,
          const SizedBox(height: 20),
          _password,
          const SizedBox(height: 10),
          _forgotPassword,
          const SizedBox(height: 40),
          _loginButton,
          const SizedBox(height: 40),
          const Text('Or login with'),
          _socialLogin,
          const SizedBox(height: 20),
          _navigateToRegister,
        ],
      ),
    );
  }

  Widget get _username {
    return TextField(
      controller: _usernameController,
      onChanged: (value) {
        print("Value $value");
        if (value.contains("@")) {
          setState(() {
            _isValidEmail = true;
          });
        }
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
    return TextField(
      controller: _passwordController,
      obscureText: _isObscure,
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
          _login();
        },
        child: const Text(
          'Login',
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
      ),
    );
  }

  void _login() {
    // email : mad@gmail.com
    // pass  : 123456
    String username = _usernameController.text;
    String password = _passwordController.text;

    print('Username: $username');
    print('Password: $password');

    if (username.isEmpty) {
      final alertDialog = AlertDialog(
        title: Icon(Icons.error, color: Colors.red, size: 80),
        content: Text("Email is invalid"),
      );
      showDialog(context: context, builder: (context) => alertDialog);
    } else if (password.isEmpty) {
      final alertDialog = AlertDialog(
        title: Icon(Icons.error, color: Colors.red, size: 80),
        content: Text("Password is invalid"),
      );
      showDialog(context: context, builder: (context) => alertDialog);
    } else {
      // Call to Server
      // if (username == "mad@gmail.com" && password == "123456") {
      //   AppRoute.key.currentState?.pushNamed(AppRoute.mainScreen);
      // } else {
      //   final alertDialog = AlertDialog(
      //     title: Icon(Icons.error, color: Colors.red, size: 80),
      //     content: Text("Wrong email and password"),
      //   );
      //   showDialog(context: context, builder: (context) => alertDialog);
      // }

      UserSharedPreference.login(username, password);
      AppRoute.key.currentState?.pushNamed(AppRoute.mainScreen);
    }
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
