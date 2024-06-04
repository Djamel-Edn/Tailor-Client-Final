import 'dart:convert' as convert;

import 'package:http/http.dart' as http;
import 'package:projetfinprepa/Data/ANSQST.dart';
import 'package:projetfinprepa/Data/Order_class.dart';
import 'package:projetfinprepa/Data/Tailor_Class.dart';
import 'package:projetfinprepa/Providers/LocalDB.dart';
import 'package:projetfinprepa/Providers/Tailors%20copy.dart';
import 'package:projetfinprepa/Providers/Tailors.dart';
import 'package:provider/provider.dart';

class OrderLogique {
  static Future<OrderEmit?> AddOrder(
      IdClient, IdTailor, TotalPrice, posts, socket, context) async {
    print("in add order");
    var uri = "https://tailor-client-5cqi.onrender.com/order/create";
    var uri2 = "https://tailor-client-5cqi.onrender.com/chat/fetch";
    //  late IO.Socket socket;

    final headerall = {'Content-Type': 'application/json'};
    print("aqqqqqqqqqqqqqwwwwwwww");

    final bodyall = convert.jsonEncode({
      "client": IdClient,
      "tailor": IdTailor,
      "totalPrice": TotalPrice,
      "posts": posts
    });
    final bodyall2 = convert.jsonEncode({
      "clientId": IdClient,
      "tailorId": IdTailor,
    });
    var res =
        await http.post(Uri.parse(uri), headers: headerall, body: bodyall);
    print(res.statusCode);
    if (res.statusCode == 201) {
      var res2 =
          await http.post(Uri.parse(uri2), headers: headerall, body: bodyall2);
      var jsonres = convert.jsonDecode(res.body);
      print("her in res ////// ${jsonres}");
      OrderEmit orderobj = OrderEmit(
          orderDate: jsonres["orderDate"],
          id: jsonres["_id"],
          models: jsonres["posts"],
          questionnaire: jsonres["questionnaire"],
          postStyle: jsonres["postStyle"],
          status: jsonres["status"],
          totalPrice: jsonres["totalPrice"],
          tailor: jsonres["tailor"]);
      socket.emit("newOrder", jsonres);

      return orderobj;
      // "id": jsonres["_id"],
      // "models": jsonres["posts"],
      // "orderDate": jsonres["orderDate"],
      // "postStyle": jsonres["postStyle"],
      // "questionnaire": jsonres["questionnaire"],
      // "status": jsonres["status"],
      // "tailor": jsonres["tailor"],
      // "totalPrice": jsonres["totalPrice"],

      // socket!.emit("newOrder", {
      //   "newOrder": orderobj,
      // });
    }
  }

  static Future<OrderEmit?> AddOrderByMe(IdClient, IdTailor, TotalPrice, posts,
      image, List<QSTANSRSELECTED> qsts, Tailor tailor, socket, context) async {
    print("in add order");
    var uri = "https://tailor-client-5cqi.onrender.com/order/create";
    // var uri2 = "https://tailor-client-5cqi.onrender.com/chat/fetch";
    final headerall = {'Content-Type': 'application/json'};

    List<Map<String, dynamic>> jsonListOfObjects = qsts.map((obj) {
      return {"qst": obj.qst, "ansr": obj.ansr};
    }).toList();

    final bodyall = convert.jsonEncode({
      "client": IdClient,
      "tailor": IdTailor,
      "totalPrice": 0,
      "postStyle": image,
      "questionnaire": jsonListOfObjects,
    });
    // final bodyall2 = convert.jsonEncode({
    //   "clientId": IdClient,
    //   "tailorId": IdTailor,
    // });
    var res =
        await http.post(Uri.parse(uri), headers: headerall, body: bodyall);
    if (res.statusCode == 201) {
      print("sssssssssssssssssssssssssss ${res.statusCode}");
      var jsonres = convert.jsonDecode(res.body);

      Order order = Order(
          questionnaire: jsonres["questionnaire"],
          status: jsonres["status"],
          tailor: tailor,
          totalPrice: jsonres["totalPrice"],
          id: jsonres["_id"],
          models: [],
          orderDate: jsonres["orderDate"],
          postStyle: jsonres["postStyle"]);

      Provider.of<ClientProvider>(context, listen: false).SetOrderTMP(order);
      OrderEmit orderobj = OrderEmit(
          orderDate: jsonres["orderDate"],
          id: jsonres["_id"],
          models: jsonres["posts"],
          questionnaire: jsonres["questionnaire"],
          postStyle: jsonres["postStyle"],
          status: jsonres["status"],
          totalPrice: jsonres["totalPrice"],
          tailor: jsonres["tailor"]);

      await Provider.of<TailorsProvider>(context, listen: false)
          .GetTailor(IdTailor);
      print("in add order by be prove apre get tailor");
      socket.emit("newOrder", orderobj);
      // var res2 =
      //     await http.post(Uri.parse(uri2), headers: headerall, body: bodyall2);
      return orderobj;
    }
  }

  void sendOrder(order, IdReciever, socket) {
    Map<String, dynamic> msgobj = {
      "ChatId": order.ChatId,
      "senderId": order.senderId,
      "text": order.text,
      "images": order.images,
      "date": order.date.toString()
    };
  }

  static Future<void> AcceptOrder(idOrder, status, totalPrice, context) async {
    print("in update order");
    var uri = "https://tailor-client-5cqi.onrender.com/order/update/$idOrder";

    final headerall = {'Content-Type': 'application/json'};
    print("aqqqqqqqqqqqqqwwwwwwww");

    final bodyall = convert.jsonEncode({
      "status": status,
      "totalPrice": totalPrice,
    });

    var res = await http.put(Uri.parse(uri), headers: headerall, body: bodyall);
    print("in update order................................");
    if (res.statusCode == 200) {
      await Provider.of<TailorsProvider>(context, listen: false)
          .GetTailor(Provider.of<LocalDbProvider>(context, listen: false).id);
    }
  }

  static Future<void> RejectedOrder(idOrder, status, context) async {
    print("in update order");
    var uri = "https://tailor-client-5cqi.onrender.com/order/update/$idOrder";

    final headerall = {'Content-Type': 'application/json'};
    print("aqqqqqqqqqqqqqwwwwwwww");

    final bodyall = convert.jsonEncode({
      "status": status,
    });

    var res = await http.put(Uri.parse(uri), headers: headerall, body: bodyall);
    print("in rej order................................");
    if (res.statusCode == 200) {
      await Provider.of<TailorsProvider>(context, listen: false)
          .GetTailor(Provider.of<LocalDbProvider>(context, listen: false).id);
    }
    print(res.statusCode);
  }

  static Future<void> DeletOrder(idOrder, context) async {
    print("in update order");
    var uri = "https://tailor-client-5cqi.onrender.com/order/delete/$idOrder";

    final headerall = {'Content-Type': 'application/json'};
    print("aqqqqqqqqqqqqqwwwwwwww");

    var res = await http.delete(
      Uri.parse(uri),
      headers: headerall,
    );
    print("in delete order................................");
    if (res.statusCode == 200) {
      await Provider.of<ClientProvider>(context, listen: false)
          .GetALlAboutCurrentUser(
              Provider.of<LocalDbProvider>(context, listen: false).id, context);
    }
  }
}
