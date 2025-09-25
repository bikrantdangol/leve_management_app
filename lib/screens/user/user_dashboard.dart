import 'package:flutter/material.dart';
import 'package:leave_management_app/widgets/leave_request_tile.dart';
import 'package:provider/provider.dart';
import '../../providers/user_provider.dart';
import '../../providers/leave_provider.dart';
import 'leave_request_screen.dart';

class UserDashboard extends StatefulWidget {
  @override
  _UserDashboardState createState() => _UserDashboardState();
}

class _UserDashboardState extends State<UserDashboard> {
  @override
  void initState() {
    super.initState();
    final provider = Provider.of<LeaveProvider>(context, listen: false);
    final user = Provider.of<UserProvider>(context, listen: false).user!;
    provider.loadUserRequests(user.uid);
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user!;
    final leaveProvider = Provider.of<LeaveProvider>(context);

    return Scaffold(
      backgroundColor: Colors.lightBlueAccent, // Set background color
      appBar: AppBar(
        title: Text(
          'User Dashboard: ${user.name}',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold, // Bold title text
            letterSpacing: 1.5, // Add spacing
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
              SizedBox(height: 50), // Add space at the top
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context, 
                    MaterialPageRoute(builder: (_) => LeaveRequestScreen())
                  );
                },
                child: Text('Request Leave'),
              ),
              SizedBox(height: 20), // Add space between button and list
              leaveProvider.userRequests.isEmpty
              ? Center(child: Text(
                  'No leave requests yet.',
                  style: TextStyle(color: Colors.white),
                ),
              ):
              ListView.builder(
                shrinkWrap: true,
                itemCount: leaveProvider.userRequests.length,
                itemBuilder: (context, index) {
                  return LeaveRequestTile(request: leaveProvider.userRequests[index]);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
