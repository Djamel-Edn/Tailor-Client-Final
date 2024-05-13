import 'dart:convert' as convert;

import 'package:http/http.dart' as http;
import 'package:projetfinprepa/Data/Chat_Class.dart';
import 'package:projetfinprepa/Data/Client_Class.dart';
import 'package:projetfinprepa/Data/Message_Class.dart';
import 'package:projetfinprepa/Data/Tailor_Class.dart';

class ChatLogique {
  static Future GetChat(IdClient, IdTailor) async {
    Chat? chat;
    List<Message> messages = [];
    var uri = "https://tailor-client-ps9z.onrender.com/chat/fetch";

    final headerall = {'Content-Type': 'application/json'};
    final bodyall =
        convert.jsonEncode({"clientId": IdClient, "tailorId": IdTailor});

    var res =
        await http.post(Uri.parse(uri), headers: headerall, body: bodyall);

    if (res.statusCode == 200) {
      var jsonres = convert.jsonDecode(res.body);

      ClientClass client = ClientClass(
          name: jsonres["client"]["name"],
          email: jsonres["client"]["email"],
          id: jsonres["client"]["_id"],
          password: jsonres["client"]["password"],
          verified: jsonres["client"]["verified"],
          resetPasswordToken: jsonres["client"]["resetPasswordToken"],
          profilePicture: jsonres["client"]["profilePicture"],
          orders: []);
      Tailor tailor = Tailor(
          Speciality: jsonres["tailor"]["speciality"],
          address: jsonres["tailor"]["address"],
          models: jsonres["tailor"]["posts"],
          rating: jsonres["tailor"]["rating"],
          description: jsonres["tailor"]["description"],
          resetPasswordToken: jsonres["tailor"]["resetPasswordToken"],
          name: jsonres["tailor"]["name"],
          id: jsonres["tailor"]["_id"],
          email: jsonres["tailor"]["email"],
          password: jsonres["tailor"]["password"],
          phone: jsonres["tailor"]["phone"],
          city: jsonres["tailor"]["city"],
          gender: jsonres["tailor"]["gender"],
          reviews: jsonres["tailor"]["reviews"],
          verified: jsonres["tailor"]["verified"],
          profilePicture: jsonres["tailor"]["profilePicture"],
          orders: jsonres["tailor"]["orders"]);

      for (var message in jsonres["messages"]) {
        print("zzzzzzzzzzzzzzzzzzzzzzzzz  ${message["text"]} ");
        List<String> images = [];
        for (var image in message["image"]) {
          images.add(image);
        }

        Message msg = Message(
            ChatId: message["_id"],
            senderId: message["senderId"],
            text: message["text"],
            date: DateTime.parse(message["createdAt"]),
            images: images);
        messages.add(msg);
      }

      return chat = Chat(
        client: client,
        id: jsonres["_id"],
        messages: messages,
        tailor: tailor,
      );
    }
    return chat;
  }

  static Future PostMessage(IdSender, IdChat, textmsg, images) async {
    Message? message;
    var uri = "https://tailor-client-ps9z.onrender.com/message/create";

    final headerall = {'Content-Type': 'application/json'};
    final bodyall = convert.jsonEncode({
      "chatId": IdChat,
      "senderId": IdSender,
      "text": textmsg,
      "image": images
    });

    var res =
        await http.post(Uri.parse(uri), headers: headerall, body: bodyall);

    if (res.statusCode == 201) {
      var jsonres = convert.jsonDecode(res.body);
      List<String> images = [];
      for (var image in jsonres["image"]) {
        images.add(image);
      }
      message = Message(
          ChatId: jsonres["_id"],
          senderId: jsonres["senderId"],
          text: jsonres["text"],
          date: DateTime.parse(jsonres["createdAt"]),
          images: images);
      return message;
    }
    return message;
  }
}
