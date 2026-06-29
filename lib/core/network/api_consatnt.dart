class ApiConsatnt {
  static const String baseUrl = 'http://127.0.0.1:8000/api';

  static const String register = '/register';
  static const String login = '/login';

  static const String me = '/me';
  static const String completeProfile = '/students/complete-profile';
  static const String enroll = '/enroll';
  static const String myEnrollments = '/my-enrollments';
  static const String grades = '/grades';
  static const String teacherCompleteProfile = '/teachers/complete-profile';
  static const String teacherRequestUpdate = '/teachers/request-update';
  static const String attendance = '$baseUrl/attendance';
  static const String attendanceToday = '/attendance/today';
  static const String subjects = '/subjects';
  static const String schedules = '/schedules';
  static const String exams = '/exams';
}
