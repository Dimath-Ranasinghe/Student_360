class Base {
  static String baseURL = 'http://10.0.2.2:3001/api/notices';

  static String getNotice = baseURL;
  static String postNotice = baseURL;

  static String deleteNotice(String noticeId) => "$baseURL/$noticeId";
}

