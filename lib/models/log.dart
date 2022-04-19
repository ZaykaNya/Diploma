import 'dart:convert';

List<UserLog> postFromJson(String str) =>
    List<UserLog>.from(json.decode(str).map((x) => UserLog.fromMap(x)));

class UserLog {
  final String? id;
  final String? userId;
  final String? contentType;
  final String? contentId;
  final String? event;
  final String? time;
  final String? seconds;
  final String? parentLog;
  final String? status;
  final String? lastTime;

  const UserLog({
    required this.id,
    required this.userId,
    required this.contentType,
    required this.contentId,
    required this.event,
    required this.time,
    required this.seconds,
    required this.parentLog,
    required this.status,
    required this.lastTime,
  });

  factory UserLog.fromMap(Map<String, dynamic> json) => UserLog(
    id: json['id'],
    userId: json['userId'],
    contentType: json['contentType'],
    contentId: json['contentId'],
    event: json['event'],
    time: json['time'],
    seconds: json['seconds'],
    parentLog: json['parentLog'],
    status: json['status'],
    lastTime: json['lastTime'],
  );
}