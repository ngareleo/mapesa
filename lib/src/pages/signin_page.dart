import 'package:flutter/material.dart';
import 'package:mapesa/src/features/auth_provider.dart';
import 'package:mapesa/src/models/users.dart';
import 'package:mapesa/src/pages/home_page.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  static const usernameKey = "Username";
  static const passwordKey = "Password";
  static final _authProvider = AuthProvider.instance;

  final _controllers = {
    usernameKey: TextEditingController(),
    passwordKey: TextEditingController(),
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
                controller: _controllers[usernameKey],
                decoration: const InputDecoration(
                  labelText: usernameKey,
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  border: UnderlineInputBorder(),
                ),
                keyboardType: TextInputType.text,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _controllers[passwordKey],
                decoration: const InputDecoration(
                  labelText: passwordKey,
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  border: UnderlineInputBorder(),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: FilledButton(
                  onPressed: signUpUser,
                  child: const Text("Sign In"),
                ),
              ),
              const SizedBox(height: 20),
              TextButton(
                  onPressed: navigateToHomePage,
                  child: const Text("I don't have an account"))
            ],
          ),
        ),
      ),
    )));
  }

  void signUpUser() async {
    for (final controller in _controllers.entries) {
      if (controller.value.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Please fill in ${controller.key}"),
          ),
        );
        return;
      }
    }

    var (status, user) = await _authProvider.loginUser(
      username: _controllers[usernameKey]!.text,
      password: _controllers[passwordKey]!.text,
    );

    postSignUp(status, user);
  }

  void postSignUp(UserLoginStatus status, User? newUser) {
    switch (status) {
      case UserLoginStatus.success:
        if (newUser == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Unknown error"),
            ),
          );
          return;
        }
        navigateToHomePage();
        break;
      case UserLoginStatus.incorrectPassword:
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Incorrect password"),
          ),
        );
        break;
      case UserLoginStatus.userNotFound:
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("User not found"),
          ),
        );
        break;
      case UserLoginStatus.internalServerError:
      case UserLoginStatus.unknown:
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Sorry something went wrong :("),
          ),
        );
        break;
    }
  }

  void navigateToHomePage() {
    Navigator.push(
        context, MaterialPageRoute(builder: (_) => const HomePage()));
  }
}
