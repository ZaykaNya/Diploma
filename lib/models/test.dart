class Test {
  final String? id;
  final String? userId;
  final String? branchId;
  final String? courseId;
  final String? testType;
  final String? timeStart;
  final String? correctCount;
  final String? wrongCount;
  final String? percentage;

  const Test({
    required this.id,
    required this.userId,
    required this.branchId,
    required this.courseId,
    required this.testType,
    required this.timeStart,
    required this.correctCount,
    required this.wrongCount,
    required this.percentage,
  });

  factory Test.fromJson(Map<String, dynamic> json) {
    return Test(
      id: json['id'],
      userId: json['user_id'],
      branchId: json['branch_id'],
      courseId: json['course_id'],
      testType: json['time_start'],
      timeStart: json['time_end'],
      correctCount: json['correct_count'],
      wrongCount: json['wrong_count'],
      percentage: json['percentage'],
    );
  }
}