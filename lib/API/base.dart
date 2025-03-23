import 'dart:convert';
import 'package:http/http.dart' as http;
import 'basedata.dart';

Future<http.Response> getNotices() async {
  String url = Base.getNotices;

  try {
    final response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json; charset=UTF-8',
    });
    return response;
  } catch (e) {
    throw Exception("Failed to load notices");
  }
}


Future<bool> postNotice(String title, String content) async {
  String url = Base.postNotice;
  print("Posting notice to: $url");

  try {
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode({"title": title, "content": content}),
    );

    if (response.statusCode == 201) {
      print("Notice posted successfully: ${response.body}");
      return true;
    } else {
      print("Failed to post notice: ${response.body}");
      return false;
    }
  } catch (e) {
    print("Error posting notice: $e");
    return false;
  }
}



Future<bool> deleteNotice(String noticeId) async {
  String url = "${Base.deleteNotice(noticeId)}";
  print("Deleting notice with ID: $noticeId from: $url");

  try {
    final response = await http.delete(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      print("Notice deleted successfully");
      return true;
    } else {
      print("Failed to delete notice: ${response.body}");
      return false;
    }
  } catch (e) {
    print("Error deleting notice: $e");
    return false;
  }
}


