class LeaveRequest {
  final String id;
  final String userId;
  final String reason;
  final DateTime date;
  String status; // pending, approved, rejected

  LeaveRequest({
    required this.id,
    required this.userId,
    required this.reason,
    required this.date,
    this.status = 'pending',
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'reason': reason,
      'date': date,
      'status': status,
    };
  }
}