import 'package:flutter/material.dart';
class ChatMessage{
    final String text;
    final bool isSender; // true if the message is sent by the teacher /false by student

    ChatMessage({required this.text, required this.isSender});
}
class FeedbackScreen extends StatelessWidget {
  const FeedbackScreen({Key? key}) : super(key: key);

  @override
  _FeedbackScreenState createState() => _FeedbackScreenState();
}
 class _FeedbackScreenState extends State<FeedbackScreen> {
    final TextEditingController _controller = TextEditingController();
    final TextEditingController _messageController = TextEditingController();
    //sample message
    final List<ChatMessage> _messages = [
        ChatMessage(text: 'Hello, how was the project?', isSender: true),
        ChatMessage(text: 'Sure, I will check it out.', isSender: false),
        ChatMessage(text: 'Let me know if you have questions.', isSender: true),

    ];
    void _sendMessage(){
        final text = _messageController.text.trim();    
        if (text.isEmpty) return;
        setState(() {
      _messages.add(ChatMessage(text: text, isSender: true));
    });
    _messageController.clear();
    // TODO: Connect to backend for real-time messaging.
  }
        
 Widget _buildMessageBubble(ChatMessage message) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment:
            message.isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12.0),
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.7,
            ),
            decoration: BoxDecoration(
              color: message.isSender ? Colors.blue : Colors.grey[300],
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Text(
              message.text,
              style: TextStyle(
                color: message.isSender ? Colors.white : Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Feedback Section"),
      ),
      backgroundColor: const Color.fromRGBO(27, 105, 215, 1),
       centerTitle: true,
        elevation: 0,
        title: const Text(
          "Feedback Section",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            ),
        ),
         iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 0.0),
            child: Container(
              width: 130,
              height: 100,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/logo.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
       backgroungColor: Colors.white,
       body:Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
            const SizedBox(height: 16.0),
            Padding(
                paddding: const EdgeInsets.symmetric(horizontal: 16.0),//the gap below the app bar
                child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                        hintText: 'Select student ID/Teacher',
                        prefixIcon:const Icon(Icons.search),
                        border: OutlineInputBorder(),
                            borderRadius: BorderRadius.circular(8.0),
                        ),
                    ) 
                ),
            ),
          const SizedBox(height: 16.0),
          // Chat area with message bubbles.
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return _buildMessageBubble(_messages[index]);
              },
            ),
          ),
         // Bottom text input area.
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            color: Colors.white,
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
                const SizedBox(width: 8.0),
                IconButton(
                  icon: const Icon(Icons.send, color: Colors.blue),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}    

