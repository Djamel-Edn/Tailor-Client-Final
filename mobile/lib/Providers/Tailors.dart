import 'dart:convert' as convert;

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:projetfinprepa/Data/Tailor_Class.dart';
import 'package:projetfinprepa/IpConfig/Ipconfig.dart';

class TailorsProvider extends ChangeNotifier {
  List<Tailor> _AllTailors = [];
  List<Tailor> get AllTailors => _AllTailors;

  Future<void> GetAllTailors() async {
    _AllTailors = [];
    var uri = "http://${IPCONFIG.iPCONFIG}:5001/getallTailors";
    var res = await http.get(Uri.parse(uri));
    if (res.statusCode == 200) {
      var jsonres = convert.jsonDecode(res.body);
      print(jsonres.length);
      for (var tailorobj in jsonres) {
        Tailor tailor = Tailor(
            name: tailorobj["name"],
            id: tailorobj["_id"],
            email: tailorobj["email"],
            password: tailorobj["password"],
            phone: tailorobj["phone"],
            city: tailorobj["city"],
            gender: tailorobj["gender"],
            reviews: tailorobj["reviews"],
            verified: tailorobj["verified"],
            profilePicture: tailorobj["profilePicture"],
            orders: tailorobj["orders"]);
        _AllTailors.add(tailor);
      }
    }
  }
}
