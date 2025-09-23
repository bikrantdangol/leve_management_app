import 'package:flutter/material.dart';
import 'package:leave_management_app/providers/leave_provider.dart';
import 'package:leave_management_app/providers/user_provider.dart';
import 'package:leave_management_app/screens/auth/login_screen.dart';
import 'package:provider/provider.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => LeaveProvider()),
      ],
      child: MaterialApp(
        title: 'Leave Management',
        home: LoginScreen(),
      ),
    );
  }
}