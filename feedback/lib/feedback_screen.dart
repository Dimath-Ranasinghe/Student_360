import 'package:flutter/material.dart';

class FeedbackScreen extends StatelessWidget {
  const FeedbackScreen({Key? key}) : super(key: key);

  @override
  _FeedbackScreenState createState() => _FeedbackScreenState();
}
 class _FeedbackScreenState extends State<FeedbackScreen> {
    final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Feedback Section"),
      ),
      backgroundColor: Colors.white,
       body:Column(
        children: [
            const SizedBox(height: 16.0),
            Padding(
                paddding: const EdgeInsets.all(16.0),//the gap below the app bar
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
            Expanded(child: Container()),
        ],
    ),      
    
       
              
       
    );
  }
}
