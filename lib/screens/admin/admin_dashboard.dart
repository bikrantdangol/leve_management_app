import 'package:flutter/material.dart';
import 'package:leave_management_app/widgets/leave_request_tile.dart';
import 'package:provider/provider.dart';
import '../../providers/leave_provider.dart';
// import '../../providers/user_provider.dart';

class AdminDashboard extends StatefulWidget {
  @override
  _AdminDashboardState createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  @override
  void initState() {
    super.initState();
    Provider.of<LeaveProvider>(context, listen: false).loadAllRequests();
  }

  @override
  Widget build(BuildContext context) {
    final leaveProvider = Provider.of<LeaveProvider>(context);

    return Scaffold(
      backgroundColor: Colors.lightBlueAccent, // Set background color to skyBlue
      appBar: AppBar(
        title: Text(
          'Admin Dashboard', // Title
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
              SizedBox(height: 50), // Space at the top for better layout
              leaveProvider.allRequests.isEmpty
                  ? Center(child: Text(
                    'No leave requests yet.',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  )
                  : ListView.builder(
                      shrinkWrap: true, // Use shrinkWrap to prevent infinite scrolling
                      itemCount: leaveProvider.allRequests.length,
                      itemBuilder: (context, index) {
                        return LeaveRequestTile(
                          request: leaveProvider.allRequests[index],
                          isAdmin: true, // Indicate that this is an admin view
                        );
                      },
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
