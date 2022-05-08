import 'package:diplom/models/log.dart';

class Calculator {
  /// Counts progress for course
  int countProgress(userLogs, course) {
    int progress = 0;
    double time = 0;

    for (UserLog userLog in userLogs) {
      if (userLog.contentId!.contains(course)) {
        time += int.parse(userLog.seconds.toString());
      }
    }

    progress = (time / 30).round();

    return progress;
  }

  /// Counts time spent on course
  double countTime(userLogs, course) {
    double time = 0;

    for (UserLog userLog in userLogs) {
      if (userLog.contentId!.contains(course)) {
        time += int.parse(userLog.seconds.toString()) / 3600;
      }
    }

    return double.parse(time.toStringAsPrecision(1));
  }

  /// Counts daily activity
  double countDailyProgress(logs) {
    double progress = 0;

    for (UserLog userLog in logs) {
      progress += int.parse(userLog.seconds.toString());
    }

    return progress.roundToDouble();
  }

  /// Counts number of completed and inProgress courses
  List<int> countCompletedCourses(courses, userLogs) {
    int completedCourses = 0;
    int inProgressCourses = 0;
    int progress = 0;
    int time = 0;

    for (var course in courses) {
      for (UserLog userLog in userLogs) {
        if (userLog.contentId!.contains(course['course'])) {
          time += int.parse(userLog.seconds.toString());
        }
      }

      progress = (time / 30).round();

      if (progress >= 100) {
        completedCourses += 1;
      } else {
        inProgressCourses += 1;
      }

      time = 0;
    }

    return [completedCourses, inProgressCourses];
  }

  List<int> getGlobalAchievements(courses, userLogs, userTests) {
    List<int> achievements = [];
    String bestMark = '0';

    if(courses.length > 0) {
      achievements.add(1);
    }

    if(countCompletedCourses(courses, userLogs)[0] > 0) {
      achievements.add(2);
    }

    if(userTests.length > 0) {
      achievements.add(3);
    }

    for(var userTest in userTests) {
      if(userTest.percentage == '100') {
        bestMark = '100';
      }
    }

    if(bestMark == '100') {
      achievements.add(4);
    }

    return achievements;
  }
}
