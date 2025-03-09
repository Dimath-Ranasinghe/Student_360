import 'dart:convert';
import 'package:http/http.dart' as http;
import 'base_data.dart';

Future<http.Response> getNotices() async {
  String url = "${Base.getNotice}";
  print("getDailySummary url: $url");
  return await http.get(Uri.parse(url), headers: <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',

  });
}