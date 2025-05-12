import 'package:flutter/material.dart';

class ChatBotPage extends StatefulWidget {
  const ChatBotPage({super.key});

  @override
  State<ChatBotPage> createState() => _ChatBotPageState();
}

class _ChatBotPageState extends State<ChatBotPage> {
  final List<Map<String, String>> messages = [
    {"sender": "bot", "text": "Hi there! 👋 How may I help you today?"},
  ];
  final TextEditingController _controller = TextEditingController();
  final List<String> _recommendedQuestions = [
    "How do I book a ride?",
    "Is the ride safe?",
    "How is the fare calculated?",
    "Can I offer a ride?",
    "How do I view my ride history?",
    "What are the payment options?",
    "How do I contact support?",
    "What if the driver is late?",
    "Can I cancel a ride?",
    "How do ratings work?",
  ];

  void _sendMessage(String text) {
    setState(() {
      messages.add({"sender": "user", "text": text});
      String botResponse = "";
      if (text.toLowerCase().contains("book") ||
          text.toLowerCase().contains("ride") &&
              text.toLowerCase().contains("book")) {
        botResponse =
        "To book a ride, go to 'Find a Ride' and enter your details.";
      } else if (text.toLowerCase().contains("safe") ||
          text.toLowerCase().contains("safety")) {
        botResponse =
        "Yes! All rides are with verified NCU users and you can choose same-gender carpools.";
      } else if (text.toLowerCase().contains("fare") ||
          text.toLowerCase().contains("cost") ||
          text.toLowerCase().contains("price")) {
        botResponse =
        "The fare is calculated based on distance and can be set while offering a ride.";
      } else if (text.toLowerCase().contains("offer") ||
          text.toLowerCase().contains("provide") &&
              text.toLowerCase().contains("ride")) {
        botResponse =
        "You can offer a ride by navigating to the 'Offer a Ride' section and filling in your travel details.";
      } else if (text.toLowerCase().contains("history") ||
          text.toLowerCase().contains("past") &&
              text.toLowerCase().contains("rides")) {
        botResponse =
        "You can view your ride history in the 'My Rides' section of the app.";
      } else if (text.toLowerCase().contains("payment") ||
          text.toLowerCase().contains("pay")) {
        botResponse =
        "We currently support [mention supported payment methods, e.g., in-app wallet, UPI].";
      } else if (text.toLowerCase().contains("support") ||
          text.toLowerCase().contains("help") ||
          text.toLowerCase().contains("contact")) {
        botResponse =
        "You can contact our support team through the 'Help & Support' section in the app.";
      } else if (text.toLowerCase().contains("late") &&
          text.toLowerCase().contains("driver")) {
        botResponse =
        "If your driver is significantly late, please contact support for assistance.";
      } else if (text.toLowerCase().contains("cancel") &&
          text.toLowerCase().contains("ride")) {
        botResponse =
        "You can cancel a ride through the 'My Rides' section, but cancellation fees may apply depending on the timing.";
      } else if (text.toLowerCase().contains("rating") ||
          text.toLowerCase().contains("ratings")) {
        botResponse =
        "Ratings help us ensure a quality experience for everyone. You can rate your driver after the ride, and drivers can also rate passengers.";
      } else {
        botResponse =
        "Sorry, I didn’t get that. Try asking about booking, safety, fare, offering rides, ride history, payment, support, delays, cancellations, or ratings.";
      }
      messages.add({"sender": "bot", "text": botResponse});
    });
    _controller.clear();
  }

  Widget _buildRecommendedQuestions() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: SizedBox(
        height: 40.0, // Adjust height as needed
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: _recommendedQuestions.length,
          itemBuilder: (context, index) {
            final question = _recommendedQuestions[index];
            return Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: InkWell(
                onTap: () {
                  _sendMessage(question);
                },
                child: Chip(
                  label: Text(
                    question,
                    style: const TextStyle(color: Colors.white),
                  ),
                  backgroundColor: Colors.green[400],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chat with NCU Bot"),
        backgroundColor: Colors.green[700],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                final isBot = message['sender'] == 'bot';
                return Align(
                  alignment:
                  isBot ? Alignment.centerLeft : Alignment.centerRight,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isBot ? Colors.green[100] : Colors.green[300],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(message['text']!),
                  ),
                );
              },
            ),
          ),
          _buildRecommendedQuestions(),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: "Type your question...",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    if (_controller.text.trim().isNotEmpty) {
                      _sendMessage(_controller.text.trim());
                    }
                  },
                  color: Colors.green,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}