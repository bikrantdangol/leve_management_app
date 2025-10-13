import 'package:flutter/material.dart';
// Importing custom providers to manage app-wide state
import 'package:leave_management_app/providers/leave_provider.dart';  // Manages leave-related data
import 'package:leave_management_app/providers/user_provider.dart';   // Manages user-related data
// Importing the login screen UI
import 'package:leave_management_app/screens/auth/login_screen.dart';
// Importing the Provider package for state management0
import 'package:provider/provider.dart';
/// The main function is the entry point of the app
void main() {
  runApp(MyApp()); // Runs the app with MyApp widget
}
/// MyApp is the root widget of the application
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      // Using MultiProvider to provide multiple ChangeNotifierProviders
      providers: [
        // Providing UserProvider to manage user-related data across the app
        ChangeNotifierProvider(create: (_) => UserProvider()),

        // Providing LeaveProvider to manage leave-related data across the app
        ChangeNotifierProvider(create: (_) => LeaveProvider()),
      ],
      child: MaterialApp(
        // title inside the app used in some places like Android task switcher
        title: 'Leave Management',
        // The first screen that will be displayed when the app starts
        home: LoginScreen(),
      ),
    );
  }
}
