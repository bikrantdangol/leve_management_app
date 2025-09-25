import 'package:flutter/material.dart';
import 'package:leave_management_app/screens/auth/login_screen.dart';
import 'package:leave_management_app/widgets/custom_text_field.dart';
import 'package:provider/provider.dart';
import '../../providers/user_provider.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent, // Set background color
      appBar: AppBar(
        title: Text(
          'REGISTER', 
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold, // Make title bold
            letterSpacing: 1.5, // Add spacing to make it look better in caps
          ),
        ),
        centerTitle: true, // Center title
        backgroundColor: Colors.blue, // the app bar color
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView( // Allow scrolling when keyboard is up
          child: Column(
            children: [
              SizedBox(height: 50), // Space at the top to move content down
              CustomTextField(controller: _nameController, label: 'Name'),
              CustomTextField(controller: _emailController, label: 'Email'),
              CustomTextField(controller: _passwordController, label: 'Password', obscure: true),
              SizedBox(height: 20), // Space between button and text fields
              ElevatedButton(
                onPressed: () async {
                  final provider = Provider.of<UserProvider>(context, listen: false);
                  final success = await provider.register(
                    _nameController.text, 
                    _emailController.text, 
                    _passwordController.text
                  );
                  if (success) {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => LoginScreen()));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Registration failed', style: TextStyle(color: Colors.white),)));
                  }
                },
                child: Text('Register'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => LoginScreen()));
                },
                child: Text(
                  "Already have an account? Login",
                  style: TextStyle(color: Colors.white),
                  ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
