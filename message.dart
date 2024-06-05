enum Sender { user1, user2 }

class Message {
  final String text;
  final bool isImage;
  final Sender sender;

  Message({required this.text, this.isImage = false, required this.sender});
}