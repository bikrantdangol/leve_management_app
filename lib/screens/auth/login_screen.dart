import 'package:flutter/material.dart';
import 'package:leave_management_app/widgets/custom_text_field.dart';
import 'package:provider/provider.dart';
import '../../providers/user_provider.dart';
import '../../screens/user/user_dashboard.dart';
import '../../screens/admin/admin_dashboard.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent, // Set background color to skyblue
      appBar: AppBar(
        title: Text(
          'LOGIN', 
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold, // Make title bold
            letterSpacing: 1.5, // Add spacing to make it look better in caps
          ),
        ),
        centerTitle: true, // Center title
        backgroundColor: Colors.blue, // You can adjust the app bar color here
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView( // To allow scrolling if the keyboard is up
          child: Column(
            children: [
              SizedBox(height: 50), // Add space to push content down
              CustomTextField(
                controller: _emailController,
                label: 'Email',
              ),
              CustomTextField(
                controller: _passwordController,
                label: 'Password',
                obscure: true,
              ),
              SizedBox(height: 20), // Space between button and text field
              ElevatedButton(
                onPressed: () async {
                  final provider = Provider.of<UserProvider>(context, listen: false);
                  final success = await provider.login(_emailController.text, _passwordController.text);
                  if (success) {
                    if (provider.user!.isAdmin) {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => AdminDashboard()));
                    } else {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => UserDashboard()));
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Login failed', style: TextStyle(color: Colors.white),)));
                  }
                },
                child: Text(
                  'Login',
                  // style: TextStyle(color: Colors.white),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => RegisterScreen()));
                },
                child: Text(
                  "Don't have an account? Register",
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
