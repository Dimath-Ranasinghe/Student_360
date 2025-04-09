import 'dart:convert';
import 'package:http/http.dart' as http;
import '../API/basedata.dart';

class FeedbackService {
  // Fetch messages between two users
  Future<List<dynamic>> fetchMessages(String from, String to) async {
    final response = await http.get(
      Uri.parse(Base.getMessages(from, to)),
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
    );

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      return data['data'] ?? [];  // Return the list of messages
    } else {
      throw Exception('Failed to load messages: ${response.statusCode}');
    }
  }

  // Send a message
  Future<bool> sendMessage(String text, String from, String to) async {
    try {
      final url = Uri.parse(Base.sendMessage);
      print('Sending message to URL: $url');

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode({
          'text': text,
          'from': from,
          'to': to,
          'timestamp': DateTime.now().toIso8601String(),
        }),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 201 || response.statusCode == 200) {
        print('Message saved to database successfully');
        return true;
      } else {
        print('Failed to save message: ${response.statusCode}, ${response.body}');
        return false;
      }
    } catch (e) {
      print('Exception sending message: $e');
      return false;
    }
  }
}