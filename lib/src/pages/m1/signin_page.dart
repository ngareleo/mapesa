import 'package:flutter/material.dart';
import 'package:mapesa/src/features/auth_provider.dart';
import 'package:mapesa/src/pages/m1/home_page.dart';
import 'package:mapesa/src/pages/m1/signup_page.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  static const _usernameKey = "Username";
  static const _passwordKey = "Password";
  static final _authProvider = AuthProvider.instance;

  final _controllers = {
    _usernameKey: TextEditingController(),
    _passwordKey: TextEditingController(),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              const SizedBox(height: 20),
              const Text(
                "Sign In",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _controllers[_usernameKey],
                decoration: const InputDecoration(
                  labelText: _usernameKey,
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  border: UnderlineInputBorder(),
                ),
                keyboardType: TextInputType.text,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _controllers[_passwordKey],
                decoration: const InputDecoration(
                  labelText: _passwordKey,
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  border: UnderlineInputBorder(),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: FilledButton(
                  onPressed: _signUpUser,
                  child: const Text("Sign In"),
                ),
              ),
              const SizedBox(height: 20),
              TextButton(
                  onPressed: () => Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const SignUpPage())),
                  child: const Text("I don't have an account"))
            ],
          ),
        ),
      ),
    )));
  }

  void _signUpUser() async {
    for (final controller in _controllers.entries) {
      if (controller.value.text.isEmpty) {
        _showSnackBar("${controller.key} cannot be empty");
        return;
      }
    }

    var (status, user) = await _authProvider.loginUser(
      username: _controllers[_usernameKey]!.text,
      password: _controllers[_passwordKey]!.text,
    );

    switch (status) {
      case UserLoginStatus.success:
        if (user == null) {
          _showSnackBar("An error occurred while logging in");
          return;
        }
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => const HomePage()));
        break;
      case UserLoginStatus.incorrectPassword:
      case UserLoginStatus.userNotFound:
      case UserLoginStatus.internalServerError:
      case UserLoginStatus.unknown:
        _showSnackBar(status.message);
        break;
    }
  }

  void _showSnackBar(String message) =>
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
        ),
      );
}
