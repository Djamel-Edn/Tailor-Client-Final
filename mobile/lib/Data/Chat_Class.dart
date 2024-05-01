import 'package:projetfinprepa/Data/Client_Class.dart';
import 'package:projetfinprepa/Data/Message_Class.dart';
import 'package:projetfinprepa/Data/Tailor_Class.dart';

class Chat {
  String id;
  // Client client;
  Tailor tailor;
  ClientClass client;
  List<Message> messages;
  Chat({
    required this.id,
    required this.client,
    required this.tailor,
    required this.messages,
  });
}
