import 'package:flutter/material.dart';
import '../models/leave_request.dart';      // Model representing a leave request
import '../services/leave_service.dart';   // Service to interact with backend or data source

/// A provider that manages leave-related state and logic for the app
/// Extends ChangeNotifier so it can notify UI widgets when data changes
class LeaveProvider extends ChangeNotifier {
  // Instance of LeaveService to handle API/data operations
  final LeaveService _leaveService = LeaveService();

  // Private list to hold the current user's leave requests
  List<LeaveRequest> _userRequests = [];

  // Private list to hold all leave requests (for admin)
  List<LeaveRequest> _allRequests = [];

  // Public getter to access user requests
  List<LeaveRequest> get userRequests => _userRequests;

  // Public getter to access all leave requests
  List<LeaveRequest> get allRequests => _allRequests;

  /// Submits a new leave request for a specific user
  /// - Creates a new LeaveRequest object
  /// - Sends it to the backend/service
  /// - Reloads user requests to reflect changes
  /// - Notifies listeners (UI) to rebuild with updated data
  Future<void> submitRequest(
    String userId,
    String reason,
    DateTime date,
  ) async {
    final request = LeaveRequest(
      userId: userId,
      reason: reason,
      date: date,
      id: '',
    );
    await _leaveService.submitLeaveRequest(request);
    await loadUserRequests(userId);  // Refresh the user's leave list
    notifyListeners();               // Notify UI to update
  }

  /// Loads the current user's leave requests from the backend/service
  Future<void> loadUserRequests(String userId) async {
    _userRequests = await _leaveService.getUserLeaveRequests(userId);
    notifyListeners(); // Notify UI to update with new data
  }

  /// Loads all leave requests (for admin or manager view)
  Future<void> loadAllRequests() async {
    _allRequests = await _leaveService.getAllLeaveRequests();
    notifyListeners(); // Notify UI to update
  }

  /// Updates the status of a leave request (e.g., approve/reject)
  /// - Usually called by an admin
  /// - Reloads all requests after updating status
  Future<void> updateStatus(String requestId, String status) async {
    await _leaveService.updateLeaveRequestStatus(requestId, status);
    await loadAllRequests(); // Refresh all leave requests
    // Optional: could reload userRequests if needed
    notifyListeners();       // Notify UI to update
  }
}
