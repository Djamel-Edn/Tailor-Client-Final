import 'dart:convert' as convert;

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:projetfinprepa/Data/Tailor_Class.dart';

class TailorsProvider extends ChangeNotifier {
  List<Tailor> _AllTailors = [];
  List<Tailor> get AllTailors => _AllTailors;
  Tailor? _tailor;
  Tailor? get tailor => _tailor;

  Future<void> GetAllTailors() async {
    _AllTailors = [];
    var uri = "https://tailor-client-5cqi.onrender.com/getallTailors";
    var res = await http.get(Uri.parse(uri));
    if (res.statusCode == 200) {
      var jsonres = convert.jsonDecode(res.body);
      for (var tailorobj in jsonres) {
        Tailor tailor = Tailor(
            Speciality: tailorobj["speciality"],
            address: tailorobj["address"],
            models: tailorobj["posts"],
            rating: tailorobj["rating"],
            description: tailorobj["description"],
            resetPasswordToken: tailorobj["resetPasswordToken"],
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

  Future<void> GetTailor(IdTailor) async {
    var uri = "https://tailor-client-5cqi.onrender.com/getTailor/$IdTailor";
    var res = await http.get(Uri.parse(uri));
    print("getttttttttttttttttttthhhhhhhhhhhhhhhh ${res.statusCode}");
    if (res.statusCode == 200) {
      var jsonres = convert.jsonDecode(res.body);

      _tailor = Tailor(
          Speciality: jsonres["speciality"],
          address: jsonres["address"],
          models: jsonres["posts"],
          rating: jsonres["rating"],
          description: jsonres["description"],
          resetPasswordToken: jsonres["resetPasswordToken"],
          name: jsonres["name"],
          id: jsonres["_id"],
          email: jsonres["email"],
          password: jsonres["password"],
          phone: jsonres["phone"],
          city: jsonres["city"],
          gender: jsonres["gender"],
          reviews: jsonres["reviews"],
          verified: jsonres["verified"],
          profilePicture: jsonres["profilePicture"],
          orders: jsonres["orders"]);
    }
    print("getttttttttttttttttttthhhhhhhhhhhhhhhh ${res.statusCode}");

    notifyListeners();
  }
}
