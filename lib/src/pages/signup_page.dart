import 'package:flutter/material.dart';
import 'package:mapesa/src/features/auth_provider.dart';
import 'package:mapesa/src/models/users.dart';
import 'package:mapesa/src/pages/signin_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<StatefulWidget> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  // TODO: Add validation for form fields and error messages
  // TODO: Auto foward to login page after successful signup
  // TODO: Add loading indicator when signing up user
  // TODO: Autofil form fields with data from previous page

  final _authProvider = AuthProvider.instance;
  final _controllers = {
    "Username": TextEditingController(),
    "Email": TextEditingController(),
    "Password": TextEditingController(),
    "Confirm Password": TextEditingController(),
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
                "Create an account",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _controllers["Username"],
                decoration: const InputDecoration(
                  labelText: "Username",
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  border: UnderlineInputBorder(),
                ),
                keyboardType: TextInputType.text,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _controllers["Email"],
                decoration: const InputDecoration(
                  labelText: "Email",
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  border: UnderlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _controllers["Password"],
                decoration: const InputDecoration(
                  labelText: "Password",
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  border: UnderlineInputBorder(),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _controllers["Confirm Password"],
                decoration: const InputDecoration(
                  labelText: "Confirm Password",
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
                  child: const Text("Sign Up"),
                ),
              ),
              const SizedBox(height: 20),
              TextButton(
                  onPressed: navigateToLoginPage,
                  child: const Text("I already have an account")),
            ],
          ),
        ),
      ),
    )));
  }

  void signUpUser() async {
    for (final entry in _controllers.entries) {
      final key = entry.key;
      final controller = entry.value;
      // Use key and controller variables here

      if (controller.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Please fill in $key"),
          ),
        );
        return;
      }
    }
    var newUser = await _authProvider.createNewUser(
      username: _controllers["Username"]!.text,
      email: _controllers["Email"]!.text,
      password: _controllers["Password"]!.text,
    );
    postSignUp(newUser);
  }

  void postSignUp(User? newUser) {
    if (newUser == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("An error occured while creating your account"),
        ),
      );
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Account created successfully"),
      ),
    );

    navigateToLoginPage();
  }

  void navigateToLoginPage() {
    Navigator.push(
        context, MaterialPageRoute(builder: (_) => const SignInPage()));
  }
}
