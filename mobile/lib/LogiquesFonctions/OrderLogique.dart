import 'dart:convert' as convert;

import 'package:http/http.dart' as http;

class OrderLogique {
  static Future<void> AddOrder(IdClient, IdTailor, TotalPrice, posts) async {
    print("in add order");
    var uri = "https://tailor-client-ps9z.onrender.com/order/create";

    final headerall = {'Content-Type': 'application/json'};
    print("aqqqqqqqqqqqqqwwwwwwww");

    final bodyall = convert.jsonEncode({
      "client": IdClient,
      "tailor": IdTailor,
      "totalPrice": TotalPrice,
      "posts": posts
    });
    print("aqqqqqqqqqqqqq");
    var res =
        await http.post(Uri.parse(uri), headers: headerall, body: bodyall);
    print(res.statusCode);
    if (res.statusCode == 201) {}
  }
}
