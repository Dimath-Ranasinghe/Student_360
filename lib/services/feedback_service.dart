import 'dart:convert';
import 'package:http/http.dart' as http;

class FeedbackService {
  static const String baseUrl2 = 'http://localhost:5000/api/messages'; // Replace with backend URL

  // Fetch messages between two users
  Future<List<dynamic>> fetchMessages(String from, String to) async {
    final response = await http.get(Uri.parse('$baseUrl2?from=$from&to=$to'));

    if (response.statusCode == 200) {
      return json.decode(response.body);  // Return the list of messages
    } else {
      throw Exception('Failed to load messages');
    }
  }

  // Send a message
  Future<bool> sendMessage(String text, String from, String to) async {
    final response = await http.post(
      Uri.parse(baseUrl2),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode({
        'text': text,
        'from': from,
        'to': to,
      }),
    );

    return response.statusCode == 201; // Returns true if the message is successfully posted
  }
}
