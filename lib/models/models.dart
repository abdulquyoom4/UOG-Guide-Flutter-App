import 'package:flutter/material.dart';

class Subject {
  String name;
  int creditHours;
  String grade;

  Subject({
    required this.name,
    required this.creditHours,
    required this.grade,
  });

  double get gradePoints {
    switch (grade) {
      case 'A+':
        return 4.0;
      case 'A':
        return 3.7;
      case 'B+':
        return 3.4;
      case 'B':
        return 3.0;
      case 'B-':
        return 2.5;
      case 'C+':
        return 2.0;
      case 'C':
        return 1.5;
      case 'D':
        return 1.0;
      case 'F':
        return 0.0;
      default:
        return 0.0;
    }
  }

  static double calculateGPA(List<Subject> subjects) {
    if (subjects.isEmpty) return 0.0;
    double totalPoints = 0;
    int totalCredits = 0;
    for (var s in subjects) {
      totalPoints += s.gradePoints * s.creditHours;
      totalCredits += s.creditHours;
    }
    return totalCredits == 0 ? 0 : totalPoints / totalCredits;
  }

  static String getLetterGrade(double gpa) {
    if (gpa >= 3.7) return 'A+';
    if (gpa >= 3.3) return 'A';
    if (gpa >= 3.0) return 'B+';
    if (gpa >= 2.7) return 'B';
    if (gpa >= 2.3) return 'B-';
    if (gpa >= 2.0) return 'C+';
    if (gpa >= 1.5) return 'C';
    if (gpa >= 1.0) return 'D';
    return 'F';
  }

  static Color getGradeColor(String grade) {
    if (grade.startsWith('A')) return const Color(0xFF14532D);
    if (grade.startsWith('B')) return const Color(0xFF1E40AF);
    if (grade.startsWith('C')) return const Color(0xFF92400E);
    return const Color(0xFF991B1B);
  }

  static Color getGradeBgColor(String grade) {
    if (grade.startsWith('A')) return const Color(0xFFDCFCE7);
    if (grade.startsWith('B')) return const Color(0xFFDBEAFE);
    if (grade.startsWith('C')) return const Color(0xFFFEF3C7);
    return const Color(0xFFFEE2E2);
  }
}

class Department {
  final String name;
  final String shortName;
  final String icon;
  final int years;
  final int creditHours;
  final List<Color> gradientColors;
  final String description;

  const Department({
    required this.name,
    required this.shortName,
    required this.icon,
    required this.years,
    required this.creditHours,
    required this.gradientColors,
    required this.description,
  });
}

class Announcement {
  final String text;
  final String date;
  final Color dotColor;

  const Announcement({
    required this.text,
    required this.date,
    required this.dotColor,
  });
}