import 'package:flutter/material.dart';
import 'package:mad_2_211/data/user_shared_preference.dart';
import 'package:mad_2_211/route/app_route.dart';
import 'package:mad_2_211/widgets/logo_widget.dart';
import 'package:mad_2_211/widgets/social_login_widget.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _isObscure = true;
  bool _isValidEmail = false;

  final _resgisterFormKey = GlobalKey<FormState>();

  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _appBar, body: _body);
  }

  PreferredSizeWidget get _appBar {
    return AppBar(
      //title: const Text('Login', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),),
      centerTitle: true,
      backgroundColor: Colors.white,
    );
  }

  Widget get _body {
    return Padding(
      padding: EdgeInsets.only(left: 16, right: 16, top: 16),
      child: Form(
        key: _resgisterFormKey,
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
            _fullName,
            const SizedBox(height: 20),
            _username,
            const SizedBox(height: 20),
            _password,
            const SizedBox(height: 10),
            _registerButton,
            const SizedBox(height: 40),
            const Text('Or login with'),
            SocialLoginWidget(),
            const SizedBox(height: 20),
            _navigateToLogin,
          ],
        ),
      ),
    );
  }

  Widget get _fullName {
    return TextFormField(
      controller: _fullNameController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Please input your full name";
        }
        return null;
      },
      decoration: InputDecoration(
        prefix: Icon(Icons.account_circle),
        labelText: 'Full Name',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  Widget get _username {
    return TextFormField(
      controller: _usernameController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Please input your email";
        } else if (!value.contains("@")) {
          return "Email is invalid";
        }
        return null;
      },
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
    return TextFormField(
      validator:
          (value) =>
              (value == null || value.isEmpty)
                  ? "Please input your password"
                  : null,
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

  Widget get _registerButton {
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
          _registerHandler();
        },
        child: const Text(
          'Resgister',
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
      ),
    );
  }

  Widget get _navigateToLogin {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Already has an account?'),
        TextButton(
          onPressed: () {
            AppRoute.key.currentState?.pushNamed(AppRoute.loginScreen);
          },
          child: const Text('Login', style: TextStyle(color: Colors.red)),
        ),
      ],
    );
  }

  void _registerHandler() {
    // email : mad@gmail.com
    // pass  : 123456
    String username = _usernameController.text;
    String password = _passwordController.text;

    print('Username: $username');
    print('Password: $password');

    if (_resgisterFormKey.currentState?.validate() == true) {
      // Process call API to backend

      String fullName = _fullNameController.text;
      String username = _usernameController.text;
      String password = _passwordController.text;

      print('Full Name: $fullName');
      print('Username: $username');
      print('Password: $password');

      UserSharedPreference.register(fullName, username, password);
      AppRoute.key.currentState?.pushNamed(AppRoute.mainScreen);
    } else {
      final alertDialog = AlertDialog(
        title: Icon(Icons.error, color: Colors.red, size: 80),
        content: Text("Please fill all fields correctly"),
      );
      showDialog(context: context, builder: (context) => alertDialog);
    }

    // if (username.isEmpty) {
    //   final alertDialog = AlertDialog(
    //     title: Icon(Icons.error, color: Colors.red, size: 80),
    //     content: Text("Email is invalid"),
    //   );
    //   showDialog(context: context, builder: (context) => alertDialog);
    // } else if (password.isEmpty) {
    //   final alertDialog = AlertDialog(
    //     title: Icon(Icons.error, color: Colors.red, size: 80),
    //     content: Text("Password is invalid"),
    //   );
    //   showDialog(context: context, builder: (context) => alertDialog);
    // } else {
    //   // Call to Server
    //   if (username == "mad@gmail.com" && password == "123456") {
    //     AppRoute.key.currentState?.pushNamed(AppRoute.mainScreen);
    //   } else {
    //     final alertDialog = AlertDialog(
    //       title: Icon(Icons.error, color: Colors.red, size: 80),
    //       content: Text("Wrong email and password"),
    //     );
    //     showDialog(context: context, builder: (context) => alertDialog);
    //   }
    // }
  }
}
