import 'package:flutter/material.dart';
import '../models/leave_request.dart';
import '../services/leave_service.dart';

class LeaveProvider extends ChangeNotifier {
  final LeaveService _leaveService = LeaveService();
  List<LeaveRequest> _userRequests = [];
  List<LeaveRequest> _allRequests = [];

  List<LeaveRequest> get userRequests => _userRequests;
  List<LeaveRequest> get allRequests => _allRequests;

  Future<void> submitRequest(String userId, String reason, DateTime date) async {
    final request = LeaveRequest(userId: userId, reason: reason, date: date, id: '');
    await _leaveService.submitLeaveRequest(request);
    await loadUserRequests(userId);
    notifyListeners();
  }

  Future<void> loadUserRequests(String userId) async {
    _userRequests = await _leaveService.getUserLeaveRequests(userId);
    notifyListeners();
  }

  Future<void> loadAllRequests() async {
    _allRequests = await _leaveService.getAllLeaveRequests();
    notifyListeners();
  }

  Future<void> updateStatus(String requestId, String status) async {
    await _leaveService.updateLeaveRequestStatus(requestId, status);
    await loadAllRequests();
    // Reload user requests if needed, but for simplicity, assume admin updates affect all
    notifyListeners();
  }
  
}