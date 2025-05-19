
import 'package:flutter/material.dart';
import 'package:mad_2_211/screens/main_screen.dart';
import 'package:mad_2_211/widgets/logo_widget.dart';

class LoginScreen extends StatefulWidget {

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  bool _isObscure = true;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
      title: const Text('Login', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),),
      centerTitle: true,
      backgroundColor: Colors.white,
    );
  }

  Widget get _body {
      return Padding(padding: EdgeInsets.only(left: 16, right: 16, top: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LogoWidget(),
                
              ],
            )),
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
            _register
          ],
        ),
      );
  }

Widget get _username {
  return TextField(
    controller: _usernameController,
    decoration: InputDecoration(
      prefix: Icon(Icons.person),
      labelText: 'Username',
      border: OutlineInputBorder(),
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
      border: OutlineInputBorder(),
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
      child: const Text('Login', style: TextStyle(fontSize: 16, color: Colors.white),),
    ),
    );
  }


  void _login(){
      String username = _usernameController.text;
      String password = _passwordController.text;

      print('Username: $username');
      print('Password: $password');

      final route = MaterialPageRoute(builder: (context) => const MainScreen());
      Navigator.pushReplacement(context, route);
  }

  Widget get _forgotPassword {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
      onPressed: () {

      },
      child: const Text('Forgot Password?', style: TextStyle(color: Colors.red),),
    )
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
          icon: Image.asset('assets/images/facebook.png', width: 30, height: 30),
        ),
      ],
    );
  }

  Widget get _register {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Don\'t have an account?'),
        TextButton(
          onPressed: () {
            // Navigate to register screen
          },
          child: const Text('Register', style: TextStyle(color: Colors.red),),
        )
      ],
    );
  }


}