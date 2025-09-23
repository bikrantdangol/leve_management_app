import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/leave_request.dart';
import '../providers/leave_provider.dart';

class LeaveRequestTile extends StatelessWidget {
  final LeaveRequest request;
  final bool isAdmin;

  const LeaveRequestTile({required this.request, this.isAdmin = false});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text('${request.reason} on ${request.date.toString().split(' ')[0]}'),
        subtitle: Text('Status: ${request.status}'),
        trailing: isAdmin && request.status == 'pending'
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () {
                      Provider.of<LeaveProvider>(context, listen: false).updateStatus(request.id, 'approved');
                    },
                    icon: Icon(Icons.check),
                  ),
                  IconButton(
                    onPressed: () {
                      Provider.of<LeaveProvider>(context, listen: false).updateStatus(request.id, 'rejected');
                    },
                    icon: Icon(Icons.close),
                  ),
                ],
              )
            : null,
      ),
    );
  }
}