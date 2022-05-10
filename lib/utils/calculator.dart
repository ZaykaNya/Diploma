import 'package:diplom/models/chart_data.dart';
import 'package:diplom/models/log.dart';
import 'package:diplom/models/mark.dart';
import 'package:diplom/models/test.dart';
import 'package:intl/intl.dart';

class Calculator {
  /// Counts progress for course
  int countProgress(userLogs, course) {
    int progress = 0;
    double time = 0;
    final splittedCourse = course.split('-')[0];

    for (UserLog userLog in userLogs) {
      if (userLog.contentId!.contains(course) || userLog.contentId!.contains(splittedCourse)) {
        time += int.parse(userLog.seconds.toString());
      }
    }

    progress = (time / 30).round();

    if(progress > 100) {
      progress = 100;
    }

    return progress;
  }

  /// Counts time spent on course
  double countTime(userLogs, course) {
    double time = 0;
    final splittedCourse = course.split('-')[0];

    for (UserLog userLog in userLogs) {
      if (userLog.contentId!.contains(course) || userLog.contentId!.contains(splittedCourse)) {
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

    if(progress > 100) {
      progress = 100;
    }

    return progress.roundToDouble();
  }

  String getDailyProgressMessage(progress) {
    if(progress == 100) {
      return 'You did a great work today. Be proud!';
    } else if(progress >= 75) {
      return 'You made decent work today!';
    } else if(progress >= 50) {
      return "Half way passed! Don't stop!";
    } else if(progress >= 25) {
      return 'Good start. Keep it up!';
    } else {
      return 'Lets learn something new today';
    }

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

  /// check which global achievements are completed
  List<int> getGlobalAchievements(courses, userLogs, userTests) {
    List<int> achievements = [];
    String bestMark = '0';

    if (courses.length > 0) {
      achievements.add(1);
    }

    if (countCompletedCourses(courses, userLogs)[0] > 0) {
      achievements.add(2);
    }

    if (userTests.length > 0) {
      achievements.add(3);
    }

    for (var userTest in userTests) {
      if (userTest.percentage == '100') {
        bestMark = '100';
      }
    }

    if (bestMark == '100') {
      achievements.add(4);
    }

    return achievements;
  }

  /// check which course achievements are completed
  List<int> getCourseAchievements(Mark bestMark, course, userLogs) {
    List<int> achievements = [];

    if(countTime(userLogs, course.toLowerCase()) > 0) {
      achievements.add(1);
    }

    if(bestMark.mark != null) {
      if(int.parse(bestMark.mark!) > 80) {
        achievements.add(2);
      }
    }

    if(countProgress(userLogs, course) >= 100) {
      achievements.add(3);
    }

    return achievements;
  }

  /// calculates time spent every day on course through last 7 days
  List<ChartData> getTimeChartData(userWeekLogs, course) {
    List<ChartData> chartData = <ChartData>[];

    for (int i = 0; i < 7; i++) {
      String currentDay = DateFormat('EEEE').format(DateTime.now().subtract(Duration(days: 6 - i)));
      String currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now().subtract(Duration(days: 6 - i)));
      List<UserLog> currentDayLogs = [];
      currentDayLogs.addAll(userWeekLogs);
      currentDayLogs.retainWhere((UserLog userLog) => userLog.time!.contains(currentDate));

      chartData.add(ChartData(
          '${currentDay[0]}${currentDay[1]}${currentDay[2]}',
          countTime(currentDayLogs, course.toLowerCase())));
    }

    return chartData;
  }

  double getAverageTestsResult(data) {
    double averageMark = 0;
    int counter = 0;

    for(var elem in data) {
      averageMark += int.parse(elem.percentage.toString());
      counter++;
    }

    averageMark /= counter;

    return averageMark.roundToDouble();
  }

  List<ChartData> getTestsChartData(courseTests, Mark bestMark) {
    List<ChartData> chartData = <ChartData>[];

    chartData.add(ChartData('Average', getAverageTestsResult(courseTests)));
    if(bestMark.mark != null) {
      chartData.add(ChartData('You`re best', double.parse(bestMark.mark.toString())));
    } else {
      chartData.add(ChartData('You`re best', 0));
    }


    return chartData;
  }
}
