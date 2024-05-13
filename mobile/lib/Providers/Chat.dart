import 'package:flutter/material.dart';
import 'package:projetfinprepa/Data/Chat_Class.dart';
import 'package:projetfinprepa/Data/Message_Class.dart';
import 'package:projetfinprepa/LogiquesFonctions/ChatLogique.dart';

class ChatProvider extends ChangeNotifier {
  Chat? _chat;
  Chat? get chat => _chat;

  Future<void> GetChat(Idclient, IdTailor) async {
    _chat = await ChatLogique.GetChat(Idclient, IdTailor);
    notifyListeners();
  }

  Future<void> PostMessageInChat(IdSender, IdChat, text, images) async {
    Message NewMessage =
        await ChatLogique.PostMessage(IdSender, IdChat, text, images);
    _chat!.messages.add(NewMessage);

    notifyListeners();
  }
}
