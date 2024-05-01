import 'package:flutter/material.dart';
import 'package:projetfinprepa/Data/Chat_Class.dart';
import 'package:projetfinprepa/Data/Message_Class.dart';
import 'package:projetfinprepa/LogiquesFonctions/ChatLogique.dart';

class ChatProvider extends ChangeNotifier {
  Chat? _chat;
  Chat? get chat => _chat;

  Future<void> GetChat() async {
    _chat = await ChatLogique.GetChat("", "");
    notifyListeners();
  }

  Future<void> PostMessageInChat(IdClient, IdChat, text) async {
    Message NewMessage = await ChatLogique.PostMessage(IdClient, IdChat, text);
    _chat!.messages.add(NewMessage);

    notifyListeners();
  }
}
