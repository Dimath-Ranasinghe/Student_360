class Base {
  // Use a single base URL for all endpoints
  static const String baseURL = 'http://10.0.2.2:3001/api';

  // Message endpoints - updated to use baseURL instead of serverURL
  static const String sendMessage = "$baseURL/messages/send";
  static String getMessages(String from, String to) => "$baseURL/messages?from=$from&to=$to";

  // Other endpoints remain the same
  static String loginURL = "$baseURL/auth/login";
  static String getNotices = "$baseURL/notices";
  static String postNotice = "$baseURL/notices";
  // Student endpoints
  static String searchStudent(String studentID) =>
      '$baseURL/students/search/$studentID';

  static String deleteNotice(String noticeId) => "$baseURL/notices/$noticeId";
  static const String studentBaseURL = '$baseURL/students';
  static String submitMarks = "$studentBaseURL/enter-marks";
  static String getStudentMarks = "$studentBaseURL/view-marks/";

  // For student's entire inbox (all messages to/from them)
  static String getInboxUrl(String userId) =>
      '$baseURL/messages/inbox?userId=$userId';
}