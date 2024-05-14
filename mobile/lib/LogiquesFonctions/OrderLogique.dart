import 'dart:convert' as convert;

import 'package:http/http.dart' as http;
import 'package:projetfinprepa/Data/ANSQST.dart';
import 'package:projetfinprepa/Data/Order_class.dart';
import 'package:projetfinprepa/Data/Tailor_Class.dart';
import 'package:projetfinprepa/Providers/Tailors%20copy.dart';
import 'package:projetfinprepa/Providers/Tailors.dart';
import 'package:provider/provider.dart';

class OrderLogique {
  static Future<void> AddOrder(
      IdClient, IdTailor, TotalPrice, posts, context) async {
    print("in add order");
    var uri = "https://tailor-client-ps9z.onrender.com/order/create";
    var uri2 = "https://tailor-client-ps9z.onrender.com/chat/fetch";

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
    }
  }

  static Future<void> AddOrderByMe(IdClient, IdTailor, TotalPrice, posts, image,
      List<QSTANSRSELECTED> qsts, Tailor tailor, context) async {
    print("in add order");
    var uri = "https://tailor-client-ps9z.onrender.com/order/create";
    // var uri2 = "https://tailor-client-ps9z.onrender.com/chat/fetch";
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

      await Provider.of<TailorsProvider>(context, listen: false)
          .GetTailor(IdTailor);
      print("in add order by be prove apre get tailor");
      // var res2 =
      //     await http.post(Uri.parse(uri2), headers: headerall, body: bodyall2);
    }
  }

  static Future<void> AcceptOrder(idOrder, status, totalPrice, context) async {
    print("in update order");
    var uri = "https://tailor-client-ps9z.onrender.com/order/update/$idOrder";

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
          .GetTailor("6626eb65ed54ccf5c1e7e8ed");
    }
    print(res.statusCode);
  }

  static Future<void> RejectedOrder(idOrder, status, context) async {
    print("in update order");
    var uri = "https://tailor-client-ps9z.onrender.com/order/update/$idOrder";

    final headerall = {'Content-Type': 'application/json'};
    print("aqqqqqqqqqqqqqwwwwwwww");

    final bodyall = convert.jsonEncode({
      "status": status,
    });

    var res = await http.put(Uri.parse(uri), headers: headerall, body: bodyall);
    print("in rej order................................");
    if (res.statusCode == 200) {
      await Provider.of<TailorsProvider>(context, listen: false)
          .GetTailor("6626eb65ed54ccf5c1e7e8ed");
    }
    print(res.statusCode);
  }
}
