import 'dart:convert' as convert;

import 'package:http/http.dart' as http;
import 'package:projetfinprepa/Providers/Tailors.dart';
import 'package:provider/provider.dart';

class RevLogique {
  static Future<void> CreateRev(clientId, tailorId, text, rating, cntx) async {
    print("in create review");
    var uri = "https://tailor-client-final.onrender.com/review/create";

    final headerall = {'Content-Type': 'application/json'};

    final bodyall = convert.jsonEncode({
      "client": clientId,
      "text": text,
      "rating": rating,
      "tailorId": tailorId,
    });

    print("client id $clientId");
    var res =
        await http.post(Uri.parse(uri), headers: headerall, body: bodyall);
    print(res.statusCode);
    if (res.statusCode == 201) {
      var jsonres = convert.jsonDecode(res.body);
      await Provider.of<TailorsProvider>(cntx, listen: false).GetAllTailors();
    }
  }

  static Future<void> AddFavTailor(clientId, tailorId, cntx) async {
    print("in create review");
    var uri = "https://tailor-client-final.onrender.com/addLike/$clientId";

    final headerall = {'Content-Type': 'application/json'};

    final bodyall = convert.jsonEncode({
      "tailorId": tailorId,
    });

    var res =
        await http.post(Uri.parse(uri), headers: headerall, body: bodyall);
    print(res.statusCode);
    if (res.statusCode == 201) {
      var jsonres = convert.jsonDecode(res.body);
    }
  }

  static Future<void> AddLikePost(clientId, postId, cntx) async {
    print("in create like");
    var uri = "https://tailor-client-final.onrender.com/addFavorite/$clientId";

    final headerall = {'Content-Type': 'application/json'};

    final bodyall = convert.jsonEncode({
      "postId": postId,
    });

    var res =
        await http.post(Uri.parse(uri), headers: headerall, body: bodyall);
    print(res.statusCode);
    if (res.statusCode == 201) {
      var jsonres = convert.jsonDecode(res.body);
    }
  }
}
