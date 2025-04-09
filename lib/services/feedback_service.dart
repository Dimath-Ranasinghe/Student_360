import 'dart:convert';
import 'package:http/http.dart' as http;

class FeedbackService {
  static const String _baseUrl =
      'http://10.0.2.2:3001/api/messages'; // Update with your backend URL

  // Fetch messages from the server (GET request)
  Future<List<dynamic>> fetchMessages(String from, String to) async {
    final response = await http.get(Uri.parse('$_baseUrl?from=$from&to=$to'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load messages');
    }
  }

  // Send message to the server (POST request)
  Future<bool> sendMessage(String text, String from, String to) async {
    final response = await http.post(
      Uri.parse(_baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'text': text, 'from': from, 'to': to}),
    );

    if (response.statusCode == 201) {
      return true; // Success
    } else {
      return false; // Failure
    }
  }
}
