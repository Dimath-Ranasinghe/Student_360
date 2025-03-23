import 'package:flutter/material.dart';

import '../../services/feedback_service.dart';
import '../../services/socket_service.dart';   // Import the SocketService class

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({Key? key}) : super(key: key);

  @override
  _FeedbackScreenState createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  final SocketService _socketService = SocketService(); // Initialize SocketService
  final FeedbackService _feedbackService = FeedbackService(); // Initialize FeedbackService
  final TextEditingController _messageController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();

  List<dynamic> _messages = [];
  String currentUser = 'teacher123'; // Example, replace with actual user ID
  String selectedUser = 'student456'; // Example, replace with actual selected user ID

  @override
  void initState() {
    super.initState();
    _socketService.connect(); // Connect to the server on widget initialization
    _socketService.socket.on('receiveMessage', (data) {
      setState(() {
        _messages.add(data);  // Add the received message to the list
      });
    });
    _loadMessages(); // Load initial messages from the backend
  }

  // Fetch messages from the backend using the FeedbackService
  void _loadMessages() async {
    try {
      final messages = await _feedbackService.fetchMessages(currentUser, selectedUser);
      setState(() {
        _messages = messages;
      });
    } catch (e) {
      print('Error fetching messages: $e');
    }
  }

  // Send a message using Socket.IO
  void _sendMessage() async {
    final text = _messageController.text.trim();
    if (text.isEmpty) return;

    _socketService.sendMessage(text, currentUser, selectedUser);
    _messageController.clear(); // Clear the message input field
  }

  @override
  void dispose() {
    _socketService.disconnect(); // Disconnect from the server when the widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Feedback Section")),
      body: Column(
        children: [
          // Search bar for selecting user (teacher or student)
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Select student ID/Teacher',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return ListTile(
                  title: Text(message['text']),
                  subtitle: Text(message['from']),
                );
              },
            ),
          ),
          // Input field for sending messages
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Type your message...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send, color: Colors.blue),
                  onPressed: _sendMessage, // Send message when pressed
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
