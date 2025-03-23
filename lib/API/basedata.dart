class Base {
  static const String baseURL = 'http://10.0.2.2:3001/api';

  static String getNotices = "$baseURL/notices";
  static String postNotice = "$baseURL/notices";

  static String deleteNotice(String noticeId) => "$baseURL/notices/$noticeId";

  static const String baseURL1 = 'http://10.0.2.2:3001/api/students';
  static String submitMarks = "$baseURL1/enter-marks";

  static String fetchMarks(String studentID) => "$baseURL1/marks/$studentID";
}
