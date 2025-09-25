import '../models/leave_request.dart';

class LeaveService {
  // Stores leave requests temporarily in memory
  static final List<LeaveRequest> _requests = [];

  // Used to generate a unique ID for each request
  int _requestIdCounter = 0;

  Future<void> submitLeaveRequest(LeaveRequest request) async {
    final newRequest = LeaveRequest(
      id: 'req_${_requestIdCounter++}',
      userId: request.userId,
      reason: request.reason,
      date: request.date,
      status: request.status,
    );
    _requests.add(newRequest);
  }

  Future<List<LeaveRequest>> getUserLeaveRequests(String userId) async {
    return _requests.where((req) => req.userId == userId).toList();
  }

  Future<List<LeaveRequest>> getAllLeaveRequests() async {
    return _requests;
  }

  Future<void> updateLeaveRequestStatus(String requestId, String status) async {
    final request = _requests.firstWhere((r) => r.id == requestId, orElse: () => LeaveRequest(id: '', userId: '', reason: '', date: DateTime.now()));
    if (request.id.isNotEmpty) {
      request.status = status;
    }
  }
}