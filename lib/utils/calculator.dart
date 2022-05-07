import 'package:diplom/models/log.dart';

class Calculator {
  int countProgress(userLogs, course) {
    int progress = 0;
    double time = 0;

    for(UserLog userLog in userLogs) {
      if(userLog.contentId!.contains(course)) {
        time += int.parse(userLog.seconds.toString());
      }
    }

    progress = (time / 30).round();

    return progress;
  }

  double countTime(userLogs, course) {
    double time = 0;

    for(UserLog userLog in userLogs) {
      if(userLog.contentId!.contains(course)) {
        time += int.parse(userLog.seconds.toString()) / 3600;
      }
    }

    return double.parse(time.toStringAsPrecision(1));
  }

  double countDailyProgress(logs) {
    double progress = 0;

    for(UserLog userLog in logs) {
      progress += int.parse(userLog.seconds.toString());
    }

    return progress.roundToDouble();
  }

  List<int> countCompletedCourses(courses, userLogs) {
    int completedCourses = 0;
    int inProgressCourses = 0;
    int progress = 0;
    int time = 0;

    for(var course in courses) {
      for(UserLog userLog in userLogs) {
        if(userLog.contentId!.contains(course['course'])) {
          time += int.parse(userLog.seconds.toString());
        }
      }

      progress = (time / 30).round();

      if(progress >= 100) {
        completedCourses += 1;
      } else {
        inProgressCourses += 1;
      }

      time = 0;
    }

    return [completedCourses, inProgressCourses];
  }
}