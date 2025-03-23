class Base {
  static const String baseURL = 'http://10.0.2.2:3001/api';

  static String loginURL = "$baseURL/auth/login";


  static String getNotices = "$baseURL/notices";
  static String postNotice = "$baseURL/notices";

  static String deleteNotice(String noticeId) => "$baseURL/notices/$noticeId";


  static const String studentBaseURL = '$baseURL/students';
  static String submitMarks = "$studentBaseURL/enter-marks";

  static String fetchMarks(String studentID) => "$studentBaseURL/students/view-marks/$studentID";
}
