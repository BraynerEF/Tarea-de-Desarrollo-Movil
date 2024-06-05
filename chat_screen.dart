import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/chat_provider.dart';
import '../models/message.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  bool isUser1 = true;

  void _sendMessage() {
    if (_controller.text.isEmpty) return;
    final message = Message(
      text: _controller.text,
      sender: isUser1 ? Sender.user1 : Sender.user2,
    );
    Provider.of<ChatProvider>(context, listen: false).addMessage(message);
    _controller.clear();
    isUser1 = !isUser1;
  }

  void _sendImage() {
    final message = Message(
      text: 'image',
      isImage: true,
      sender: isUser1 ? Sender.user1 : Sender.user2,
    );
    Provider.of<ChatProvider>(context, listen: false).addMessage(message);
    isUser1 = !isUser1;
  }

  Widget _buildMessage(Message message) {
    final isUser1 = message.sender == Sender.user1;
    final alignment = isUser1 ? Alignment.centerLeft : Alignment.centerRight;
    final bgColor = isUser1 ? Colors.grey[300] : Colors.blue[100];
    final textColor = isUser1 ? Colors.black : const Color.fromARGB(255, 6, 6, 6);
    final senderName = isUser1 ? 'Yo' : 'Alver';

    return Align(
      alignment: alignment,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment:
              isUser1 ? CrossAxisAlignment.start : CrossAxisAlignment.end,
          children: [
            Text(
              senderName,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
            SizedBox(height: 5),
            message.isImage
                ? Image.network(
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTh4Fmxi1DoVGsjUVemGbnatPCntpOQIF9oVA&s',
                    width: 200,
                  )
                : Text(
                    message.text,
                    style: TextStyle(color: textColor),
                  ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final chatProvider = Provider.of<ChatProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Alver'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: chatProvider.messages.length,
              itemBuilder: (ctx, i) {
                final message = chatProvider.messages[i];
                return _buildMessage(message);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(labelText: 'Escribe un mensaje...'),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
                IconButton(
                  icon: Icon(Icons.image),
                  onPressed: _sendImage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}