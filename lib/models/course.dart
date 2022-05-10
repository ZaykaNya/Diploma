class Course {
  final ShortCourse course;
  final List<CourseUser> users;
  final List<String> branches;

  const Course({
    required this.course,
    required this.users,
    required this.branches,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      course: ShortCourse.fromJson(json['course']),
      users: List<CourseUser>.from(json['users'].map((x) => CourseUser.fromJson(x))),
      branches: List<String>.from(json['branches'].map((x) => x)),
    );
  }
}

class CourseUser {
  final String? userId;
  final String? enrollDate;
  final String? active;

  const CourseUser({
    required this.userId,
    required this.enrollDate,
    required this.active,
  });

  factory CourseUser.fromJson(Map<String, dynamic> json) {
    return CourseUser(
      userId: json['userid'],
      enrollDate: json['enrollDate'],
      active: json['active'],
    );
  }

  factory CourseUser.fromMap(Map<CourseUser, dynamic> json) {
    return CourseUser(
      userId: json['userId'],
      enrollDate: json['enrollDate'],
      active: json['active'],
    );
  }
}

class ShortCourse {
  final String course;
  final String caption;
  final String image;

  const ShortCourse({
    required this.course,
    required this.caption,
    required this.image,
  });

  factory ShortCourse.fromJson(Map<String, dynamic> json) {
    return ShortCourse(
      course: json['course'],
      caption: json['caption'],
      image: json['image'],
    );
  }
}
