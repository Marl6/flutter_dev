import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SignUpPage(),
    );
  }
}

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  bool fullNameError = false;
  bool emailError = false;
  bool passwordError = false;

  void _handleSignUp() {
    setState(() {
      fullNameError = fullNameController.text.isEmpty;
      emailError = emailController.text.isEmpty;
      passwordError = passwordController.text.isEmpty ||
          confirmPasswordController.text.isEmpty ||
          passwordController.text != confirmPasswordController.text;

      if (!fullNameError && !emailError && !passwordError) {
        // Successful sign-up logic goes here.
        // You can navigate to the next screen or perform other actions.
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Sign-up successful"),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign Up"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              TextField(
                controller: fullNameController,
                decoration: InputDecoration(
                  labelText: "Full Name",
                  errorText: fullNameError ? "Please input full name" : null,
                  suffixIcon: fullNameError
                      ? Icon(Icons.error, color: Colors.red)
                      : null,
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: "Email",
                  errorText: emailError ? "Please input email" : null,
                  suffixIcon: emailError
                      ? Icon(Icons.error, color: Colors.red)
                      : null,
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Password",
                  errorText: passwordError
                      ? "Please input a valid password"
                      : null,
                  suffixIcon: passwordError
                      ? Icon(Icons.error, color: Colors.red)
                      : null,
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: confirmPasswordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Confirm Password",
                  errorText: passwordError
                      ? "Passwords do not match"
                      : null,
                  suffixIcon: passwordError
                      ? Icon(Icons.error, color: Colors.red)
                      : null,
                ),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _handleSignUp,
                child: Text("Sign Up"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
