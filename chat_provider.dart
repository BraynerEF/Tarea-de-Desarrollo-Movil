import 'package:flutter/material.dart';
import '../models/message.dart';

class ChatProvider with ChangeNotifier {
  List<Message> _messages = [
    Message(text: "Ey klk", sender: Sender.user1),
        Message(text: "Klk ¿Cómo estás?", sender: Sender.user2),
        Message(text: "To tranquilo, ¿y tú?", sender: Sender.user1),
        Message(text: "To frio.", sender: Sender.user2),
        Message(text: "Ya no, molondrone pa tí.", sender: Sender.user1),
        Message(text: "Mira esto.", sender: Sender.user1, isImage: true),
        Message(text: "¡XD!", sender: Sender.user2),
  ];

  List<Message> get messages => _messages;

  ChatProvider() {
    //total de 110 mensajes
    while (_messages.length < 110) {
      _messages.addAll([
        Message(text: "Ey klk", sender: Sender.user1),
        Message(text: "Klk ¿Cómo estás?", sender: Sender.user2),
        Message(text: "To tranquilo, ¿y tú?", sender: Sender.user1),
        Message(text: "To frio.", sender: Sender.user2),
        Message(text: "Ya no, molondrone pa tí.", sender: Sender.user1),
        Message(text: "Mira esto.", sender: Sender.user1, isImage: true),
        Message(text: "¡XD!", sender: Sender.user2),
      ]);
    }
    //110 mensajes
    _messages = _messages.sublist(0, 110);
    notifyListeners();
  }

  void addMessage(Message message) {
    _messages.add(message);
    notifyListeners();
  }
}