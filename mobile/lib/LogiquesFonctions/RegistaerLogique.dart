import 'dart:convert' as convert;

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:projetfinprepa/Pages/FirstPage.dart';
import 'package:projetfinprepa/Pages/TailorPages/FirstPageTailor.dart';
import 'package:projetfinprepa/Providers/Tailors%20copy.dart';
import 'package:projetfinprepa/Providers/Tailors.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Register {
  static Future<void> LoginAccount(email, password, context) async {
    print("in logi clinet");
    var uri = "https://tailor-client-ps9z.onrender.com/login";

    final headerall = {'Content-Type': 'application/json'};

    final bodyall = convert.jsonEncode({"email": email, "password": password});
    print("res.statusCode");
    var res =
        await http.post(Uri.parse(uri), headers: headerall, body: bodyall);
    if (res.statusCode == 200) {
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      var jsonres = convert.jsonDecode(res.body);
      print("get id res");
      if (jsonres["userType"] != "Tailor") {
        await Provider.of<ClientProvider>(context, listen: false)
            .GetALlAboutCurrentUser(jsonres["_id"]);

        var tst = await prefs.setString('id', jsonres["_id"]);
        var tst1 = await prefs.setString('type', "CLIENT");
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => FirstPage(),
            ),
            (route) => false);
      } else {
        await Provider.of<TailorsProvider>(context, listen: false)
            .GetTailor(jsonres["_id"]);
        var tst = await prefs.setString('id', jsonres["_id"]);
        var tst1 = await prefs.setString('type', "TAILOR");
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => FirstPageTailor(),
            ),
            (route) => false);
      }
    }
  }

  static Future<void> CreateAccount(
      email, name, password, gender, city, context) async {
    print("in registration clinet");
    var uri = "https://tailor-client-ps9z.onrender.com/register/client";

    final headerall = {'Content-Type': 'application/json'};

    final bodyall = convert.jsonEncode({
      "email": "sidoa065@gmail.com",
      "name": "Test",
      "password": "Test1234!",
      "gender": "Homme",
      "city": "Oran"
    });

    var res =
        await http.post(Uri.parse(uri), headers: headerall, body: bodyall);
    print(res.statusCode);
    if (res.statusCode == 200) {
      var jsonres = convert.jsonDecode(res.body);
      print("get id res");
      await Provider.of<ClientProvider>(context, listen: false)
          .GetALlAboutCurrentUser(jsonres["_id"]);
      print(Provider.of<ClientProvider>(context, listen: false).client!.id);
    }
  }

  static Future<void> CreateAccountTailor(
      email, name, password, gender, city, context) async {
    print("in registration tailor");
    var uri = "https://tailor-client-ps9z.onrender.com/register/tailor";

    final headerall = {'Content-Type': 'application/json'};

    final bodyall = convert.jsonEncode({
      "email": "a.bouacheri@esi-sba.dz",
      "name": "Test",
      "password": "Test1234!",
      "gender": "Homme",
      "city": "Oran",
      "phone": 088920283
    });

    var res =
        await http.post(Uri.parse(uri), headers: headerall, body: bodyall);
    print(res.statusCode);
    if (res.statusCode == 200) {
      var jsonres = convert.jsonDecode(res.body);

      await Provider.of<TailorsProvider>(context, listen: false)
          .GetTailor(jsonres["_id"]);
    }
  }

  static Future<void> VerfiOTP(IdClient, OTPSTR, index, context) async {
    print("in registration");
    var uri = "https://tailor-client-ps9z.onrender.com/verifyEmail/$IdClient";
    final headerall = {'Content-Type': 'application/json'};

    final bodyall = convert.jsonEncode({"uniqueString": OTPSTR});

    var res =
        await http.post(Uri.parse(uri), headers: headerall, body: bodyall);
    print("in verefy ${res.statusCode}");

    if (res.statusCode == 200) {
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      if (index == 1) {
        var tst = await prefs.setString('id', IdClient);
        var tst1 = await prefs.setString('type', "CLIENT");
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => FirstPage(),
            ),
            (route) => false);

        print("ggggggggggggg hhh save local ${tst}");
        print("in registration clinet local");
      } else {
        var tst = await prefs.setString('id', IdClient);
        var tst1 = await prefs.setString('type', "TAILOR");
        print("in registration local tailor");
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => FirstPageTailor(),
            ),
            (route) => false);

        print("ggggggggggggg hhh save local ${tst}");
      }
    }
  }

  static Future<String?> GetLocalDBId() async {
    String? id;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    id = prefs.getString("id");
    print(prefs.get("type"));
    print("idnis is is $id");
    // await prefs.clear();

    return id;
  }

  static Future<String?> GetLocalDBType() async {
    String? type;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    type = prefs.getString("type");
    print("in get aaaaaaaa");
    // await prefs.clear();

    return type;
  }
}
