import 'dart:math';

import 'package:diplom/models/chart_data.dart';
import 'package:diplom/models/chart_data_compare.dart';
import 'package:diplom/models/log.dart';
import 'package:diplom/models/mark.dart';
import 'package:diplom/models/test.dart';
import 'package:intl/intl.dart';

class Calculator {
  /// Counts progress for course by time spent on branches (2 hours to complete)
  int countProgress(userLogs, course, branches) {
    int progress = 0;
    double time = 0;

    for (String branch in branches) {
      double branchTime = 0;

      for (UserLog userLog in userLogs) {
        if (userLog.contentId!.contains(branch)) {
          branchTime += int.parse(userLog.seconds.toString());
        }

        if (branchTime > 7200 / branches.length) {
          branchTime = 7200 / branches.length;
        }
      }

      time += branchTime;
    }

    progress = (time / 72).round();

    if (progress > 100) {
      progress = 100;
    }

    return progress;
  }

  /// Counts time spent on course
  double countTime(userLogs, course) {
    double time = 0;
    final splittedCourse = course.split('-')[0];

    for (UserLog userLog in userLogs) {
      if ('${userLog.contentId}'.contains(course) ||
          '${userLog.contentId}'.contains(splittedCourse)) {
        time += int.parse(userLog.seconds.toString()) / 3600;
      }
    }

    return double.parse(time.toStringAsPrecision(1));
  }

  /// Counts time spent on course
  List<List<ChartData>> countTimeForLast7Days(userLogs, course, branches) {
    List<List<ChartData>> weekTime = [];

    for (int i = 0; i < 7; i++) {
      DateTime date = DateTime.now().subtract(Duration(days: 6 - i));
      String dateFormat = DateFormat('yyyy-MM-dd').format(date);
      List<ChartData> dayTime = <ChartData>[];
      int index = 0;

      for (var branch in branches) {
        double branchTime = 0;

        for (UserLog userLog in userLogs) {
          if (userLog.contentId!.contains(branch) &&
              userLog.time!.contains(dateFormat)) {
            branchTime += double.parse(userLog.seconds.toString());
          }
        }

        branchTime /= 60;
        index++;

        dayTime.add(ChartData(index.toString(), branchTime));
      }

      weekTime.add(dayTime);
    }

    return weekTime;
  }

  /// Counts time spent on course branches
  List<ChartData> countTimeByBranches(
      List<UserLog> userLogs, course, branches) {
    List<ChartData> time = <ChartData>[];
    int index = 0;

    for (var branch in branches) {
      double branchTime = 0;

      for (UserLog userLog in userLogs) {
        if (userLog.contentId!.contains(branch)) {
          branchTime += double.parse(userLog.seconds.toString());
        }
      }

      branchTime /= 60;
      index++;

      time.add(ChartData(index.toString(), branchTime));
    }

    return time;
  }

  /// Counts daily activity (45 minutes = 100%)
  double countWeeklyProgress(logs) {
    double progress = 0;

    for (UserLog userLog in logs) {
      progress += int.parse(userLog.seconds.toString());
    }

    progress /= 27;

    if (progress > 100) {
      progress = 100;
    }

    return progress.roundToDouble();
  }

  String getDailyProgressMessage(progress) {
    if (progress == 100) {
      return 'You did a great work today. Be proud!';
    } else if (progress >= 75) {
      return 'You made decent work today!';
    } else if (progress >= 50) {
      return "Half way passed! Don't stop!";
    } else if (progress >= 25) {
      return 'Good start. Keep it up!';
    } else {
      return 'Lets learn something new today';
    }
  }

  /// Counts number of completed and inProgress courses
  List countCompletedCourses(courses, userLogs) {
    int completedCourses = 0;
    int inProgressCourses = 0;
    int progress = 0;
    int time = 0;
    List<int> coursesProgress = [];

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

      coursesProgress.add(progress);

      time = 0;
    }

    return [completedCourses, inProgressCourses, coursesProgress];
  }

  /// Calculates closest global achievement
  dynamic getClosestGlobalAchievement(
      achievements, courses, userLogs, userTests) {
    dynamic closest = {
      'id': achievements[0]['id'],
      'header': achievements[0]['header'],
      'label': achievements[0]['label'],
      'closest': true,
    };
    int progress = 0;

    for (var achievement in achievements) {
      if (achievement['id'] == 0) {
        return closest;
      }

      if (achievement['id'] == 1) {
        List<int> coursesProgress =
            countCompletedCourses(courses, userLogs)[2].cast<int>();
        if (progress < coursesProgress.reduce(max)) {
          progress = coursesProgress.reduce(max);
          closest = {
            'id': achievement['id'],
            'header': achievement['header'],
            'label': achievement['label'],
            'closest': true,
          };
        }
      }

      if (achievement['id'] == 2) {
        return {
          'id': achievement['id'],
          'header': achievement['header'],
          'label': achievement['label'],
          'closest': true,
        };
      }

      if (achievement['id'] == 3) {
        for (var userTest in userTests) {
          if (int.parse(userTest.percentage) > progress) {
            progress = int.parse(userTest.percentage);
            closest = {
              'id': achievement['id'],
              'header': achievement['header'],
              'label': achievement['label'],
              'closest': true,
            };
          }
        }
      }
    }

    return closest;
  }

  /// check which global achievements are completed
  List getGlobalAchievements(courses, userLogs, userTests) {
    List achievements = [];
    List uncompletedAchievements = [];
    String bestMark = '0';

    if (courses.length > 0) {
      achievements.add({
        'id': 0,
        'header': 'Newcomer',
        'label': 'You’ve enrolled your first course. Keep it up!',
        'uncompleted': false,
      });
    } else {
      uncompletedAchievements.add({
        'id': 0,
        'header': 'Newcomer',
        'label': 'You’ve enrolled your first course. Keep it up!',
        'uncompleted': true,
      });
    }

    if (countCompletedCourses(courses, userLogs)[0] > 0) {
      achievements.add({
        'id': 1,
        'header': 'First win',
        'label': 'You’ve completed your first course. Well done!',
        'uncompleted': false,
      });
    } else {
      uncompletedAchievements.add({
        'id': 1,
        'header': 'First win',
        'label': 'You’ve completed your first course. Well done!',
        'uncompleted': true,
      });
    }

    if (userTests.length > 0) {
      achievements.add({
        'id': 2,
        'header': 'Smarter?',
        'label': 'You’ve taken your first test.',
        'uncompleted': false,
      });
    } else {
      uncompletedAchievements.add({
        'id': 2,
        'header': 'Smarter?',
        'label': 'You’ve taken your first test.',
        'uncompleted': true,
      });
    }

    for (var userTest in userTests) {
      if (userTest.percentage == '100') {
        bestMark = '100';
      }
    }

    if (bestMark == '100') {
      achievements.add({
        'id': 3,
        'header': 'Boss of the test',
        'label': 'You’ve got 100% in test.',
        'uncompleted': false,
      });
    } else {
      uncompletedAchievements.add({
        'id': 3,
        'header': 'Boss of the test',
        'label': 'You’ve got 100% in test.',
        'uncompleted': true,
      });
    }

    return [achievements, uncompletedAchievements];
  }

  /// check which course achievements are completed
  List getCourseAchievements(Mark bestMark, course, userLogs, branches) {
    List achievements = [];
    List uncompletedAchievements = [];

    if (countTime(userLogs, course.toLowerCase()) > 0) {
      achievements.add({
        'header': 'Getting started',
        'course': course,
        'label': 'You have started the course',
        'closest': false,
      });
    } else {
      uncompletedAchievements.add({
        'header': 'Getting started',
        'course': course,
        'label': 'You have started the course',
        'closest': true,
      });
    }

    if (bestMark.mark != null) {
      if (int.parse(bestMark.mark!) > 80) {
        achievements.add({
          'header': 'Great knowledge',
          'course': course,
          'label': 'You`re best mark > 80%',
          'closest': false,
        });
      } else {
        uncompletedAchievements.add({
          'header': 'Great knowledge',
          'course': course,
          'label': 'You`re best mark > 80%',
          'closest': true,
        });
      }
    } else {
      uncompletedAchievements.add({
        'header': 'Great knowledge',
        'course': course,
        'label': 'You`re best mark > 80%',
        'closest': true,
      });
    }

    if (countProgress(userLogs, course, branches) >= 100) {
      achievements.add({
        'header': '$course master',
        'course': course,
        'label': 'You have completed the course',
        'closest': false,
      });
    } else {
      uncompletedAchievements.add({
        'header': '$course master',
        'course': course,
        'label': 'You have completed the course',
        'closest': true,
      });
    }

    return [achievements, uncompletedAchievements];
  }

  /// calculates time spent every day on course through last 7 days
  List<ChartData> getTimeChartData(userWeekLogs, course) {
    List<ChartData> chartData = <ChartData>[];

    for (int i = 0; i < 7; i++) {
      String currentDay = DateFormat('EEEE')
          .format(DateTime.now().subtract(Duration(days: 6 - i)));
      String currentDate = DateFormat('yyyy-MM-dd')
          .format(DateTime.now().subtract(Duration(days: 6 - i)));
      List<UserLog> currentDayLogs = [];
      currentDayLogs.addAll(userWeekLogs);
      currentDayLogs.retainWhere(
          (UserLog userLog) => userLog.time!.contains(currentDate));

      chartData.add(ChartData(
          '${currentDay[0]}${currentDay[1]}${currentDay[2]}',
          countTime(currentDayLogs, course.toLowerCase())));
    }

    return chartData;
  }

  double getAverageTestsResult(data) {
    double averageMark = 0;
    int counter = 0;

    for (var elem in data) {
      averageMark += int.parse(elem.percentage.toString());
      counter++;
    }

    averageMark /= counter;

    return averageMark.roundToDouble();
  }

  double getAverageTestsDuration(List<Test> tests, String course) {
    double averageTime = 0;
    int counter = 0;

    for (Test elem in tests) {
      if('${elem.courseId}'.contains(course)) {
        int duration = Duration(seconds: DateTime.parse('${elem.timeEnd}').difference(DateTime.parse('${elem.timeStart}')).inSeconds).inSeconds;
        averageTime += duration;
        counter++;
      }
    }

    if(counter > 0) {
      averageTime /= counter * 60;
    } else {
      averageTime /= 60;
    }

    return averageTime;
  }

  List<ChartData> getTestsChartData(courseTests, Mark bestMark) {
    List<ChartData> chartData = <ChartData>[];

    chartData.add(ChartData('Average', getAverageTestsResult(courseTests)));
    if (bestMark.mark != null) {
      chartData.add(
          ChartData('You`re best', double.parse(bestMark.mark.toString())));
    } else {
      chartData.add(ChartData('You`re best', 0));
    }

    return chartData;
  }

  List getTimeSpentOnCourseCompareData(
      courses, userLogs, allLogs, listOfCourses) {
    List<ChartDataCompare> chartData = <ChartDataCompare>[];
    double userAverageTime = 0;
    double courseAverageTime = 0;
    int courseCounter = 0;
    int index = 0;

    for (var course in courses) {
      // if (course['active'] == '1') {
        double userTime = 0;
        double averageTime = 0;

        userTime = countTime(userLogs, course['course']);
        averageTime = countTime(allLogs, course['course']) /
            listOfCourses[index].users.length;

        courseCounter++;
        userAverageTime += userTime * 60;
        courseAverageTime += averageTime * 60;

        chartData.add(ChartDataCompare(
            course['course'].split('-')[0], averageTime, userTime));
      }

      index++;
    // }

    if(courseCounter > 0) {
      userAverageTime /= courseCounter;
      courseAverageTime /= courseCounter;
    }

    double difference = userAverageTime - courseAverageTime;
    String word = "more";

    if(difference < 0) {
      difference *= -1;
      word = "less";
    }

    return [chartData, difference.toStringAsFixed(2), word];
  }

  List getTestResultCompareData(
      courses, courseTests, userTests) {
    List<ChartDataCompare> chartData = <ChartDataCompare>[];
    double bestMarkAverage = 0;
    double courseAverageMark = 0;
    int courseCounter = 0;
    int index = 0;

    for (var course in courses) {
      // if (course['active'] == '1') {
        double averageTestsResult = getAverageTestsResult(courseTests[index]);
        double bestMark = 0;

        for (Test userTest in userTests) {
          if ('${userTest.courseId}'.contains(course['course'].split('-')[0]) ||
              '${userTest.branchId}'.contains(course['course'].split('-')[0])) {
            if(bestMark < double.parse(userTest.percentage.toString())) {
              bestMark = double.parse(userTest.percentage.toString());
            }
          }
        }

        courseCounter++;
        bestMarkAverage += bestMark;
        courseAverageMark += averageTestsResult;

        chartData.add(ChartDataCompare(course['course'].split('-')[0],
            averageTestsResult, bestMark));
      // }

        index++;
    }

    if(courseCounter > 0) {
      bestMarkAverage /= courseCounter;
      courseAverageMark /= courseCounter;
    }

    double difference = bestMarkAverage - courseAverageMark;
    String word = "better";

    if(difference < 0) {
      word = "worse";
      difference *= -1;
    }

    return [chartData, difference.toStringAsFixed(2), word];
  }

  List getTestDurationCompareData(
      courses, courseTests, userTests) {
    List<ChartDataCompare> chartData = <ChartDataCompare>[];
    double userTimeTestAverage = 0;
    double timeTestAverage = 0;
    int courseCounter = 0;
    int index = 0;

    for (var course in courses) {
      // if (course['active'] == '1') {
        double averageTestsResult = getAverageTestsDuration(courseTests[index], course['course'].split('-')[0]);
        double averageUserTestsResult = getAverageTestsDuration(userTests, course['course'].split('-')[0]);

        courseCounter++;
        userTimeTestAverage += averageUserTestsResult;
        timeTestAverage += averageTestsResult;

        chartData.add(ChartDataCompare(course['course'].split('-')[0],
            averageTestsResult, averageUserTestsResult));
      // }

      index++;
    }

    if(courseCounter > 0) {
      userTimeTestAverage /= courseCounter;
      timeTestAverage /= courseCounter;
    }

    double difference = userTimeTestAverage - timeTestAverage;
    String word = "more";

    if(difference < 0) {
      difference *= -1;
      word = "less";
    }

    return [chartData, difference.toStringAsFixed(2), word];
  }
}
