import 'dart:convert';
import 'package:http/http.dart' as http;
import 'basedata.dart';

Future<http.Response> getNotices() async {
  String url = "${Base.getNotice}";
  print("getDailySummary url: $url");
  return await http.get(Uri.parse(url), headers: <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',

  });
}

Future<bool> postNotice(String title, String content) async {
  String url = Base.postNotice;
  print("Posting notice to: $url");

  try {
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json'
      },
      body: json.encode({"title": title, "content": content}),
    );

    return response.statusCode == 200 || response.statusCode == 201;
  } catch (e) {
    print("Error posting notice: $e");
    return false;
  }
}
