import 'package:flutter/material.dart';
import 'package:leave_management_app/widgets/custom_text_field.dart';
import 'package:provider/provider.dart';
import '../../providers/user_provider.dart';
import '../../providers/leave_provider.dart';

class LeaveRequestScreen extends StatefulWidget {
  @override
  _LeaveRequestScreenState createState() => _LeaveRequestScreenState();
}

class _LeaveRequestScreenState extends State<LeaveRequestScreen> {
  final _reasonController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent, // Set background color to skyBlue
      appBar: AppBar(
        title: Text(
          'Leave Request', // Title in uppercase
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold, // Bold title text
            letterSpacing: 1.5, // Add spacing for a sharper look
          ),
        ),
        centerTitle: true, // Center the title
        backgroundColor: Colors.blue, // Adjust app bar background color
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView( // Enable scrolling for content
          child: Column(
            children: [
              SizedBox(height: 50), // Add space at the top for better layout
              CustomTextField(controller: _reasonController, label: 'Reason'),
              SizedBox(height: 20), // Space between text field and date section
              Row(
                children: [
                  Text('Date: ${_selectedDate.toString().split(' ')[0]}'),
                  TextButton(
                    onPressed: () async {
                      final date = await showDatePicker(
                        context: context,
                        initialDate: _selectedDate,
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(Duration(days: 365)),
                      );
                      if (date != null) setState(() => _selectedDate = date);
                    },
                    child: Text(
                      'Select Date',
                      style: TextStyle(color: Colors.white),
                      ),
                  ),
                ],
              ),
              SizedBox(height: 20), // Space between date section and submit button
              ElevatedButton(
                onPressed: () async {
                  final provider = Provider.of<LeaveProvider>(context, listen: false);
                  final user = Provider.of<UserProvider>(context, listen: false).user!;
                  await provider.submitRequest(user.uid, _reasonController.text, _selectedDate);
                  Navigator.pop(context);
                },
                child: Text(
                  'Submit',
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
