class RequestModel {
  String id;
  String userId;
  String userName;
  String userPhone;
  String issue;
  String location;
  String status;
  String timestamp;

  RequestModel({
    required this.id,
    required this.userId,
    required this.userName,
    required this.userPhone,
    required this.issue,
    required this.location,
    required this.status,
    required this.timestamp,
  });

  factory RequestModel.fromMap(String id, Map<String, dynamic> data) {
    return RequestModel(
      id: id,
      userId: data['userId'],
      userName: data['userName'],
      userPhone: data['userPhone'],
      issue: data['issue'],
      location: data['location'],
      status: data['status'],
      timestamp: data['timestamp'],
    );
  }

  Map<String, dynamic> toMap() => {
    'userId': userId,
    'userName': userName,
    'userPhone': userPhone,
    'issue': issue,
    'location': location,
    'status': status,
    'timestamp': timestamp,
  };
}