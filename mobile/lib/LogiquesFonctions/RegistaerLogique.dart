import 'dart:convert' as convert;

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:projetfinprepa/Pages/FirstPage.dart';
import 'package:projetfinprepa/Pages/TailorPages/FirstPageTailor.dart';
import 'package:projetfinprepa/Providers/LocalDB.dart';
import 'package:projetfinprepa/Providers/Tailors%20copy.dart';
import 'package:projetfinprepa/Providers/Tailors.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Register {
  static Future<void> LoginAccount(email, password, context) async {
    print("in logi clinet");
    var uri = "https://tailor-client-5cqi.onrender.com/login";

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
            .GetALlAboutCurrentUser(jsonres["_id"], context);

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
        Provider.of<LocalDbProvider>(context, listen: false).GetIDLocal();
        Provider.of<LocalDbProvider>(context, listen: false).GetTYPELocal();
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
    print(email);
    print(name);

    print(password);

    print(gender);

    print(city);

    var uri = "https://tailor-client-5cqi.onrender.com/register/client";

    final headerall = {'Content-Type': 'application/json'};

    final bodyall = convert.jsonEncode({
      "email": email.toString(),
      "name": name.toString(),
      "password": password.toString(),
      "gender": gender.toString(),
      "city": "Oran"
    });

    var res =
        await http.post(Uri.parse(uri), headers: headerall, body: bodyall);
    print(res.statusCode);
    if (res.statusCode == 200) {
      var jsonres = convert.jsonDecode(res.body);
      print("get id res");
      await Provider.of<ClientProvider>(context, listen: false)
          .GetALlAboutCurrentUser(jsonres["_id"], context);
      print(Provider.of<ClientProvider>(context, listen: false).client!.id);
    }
  }

  static Future<void> CreateAccountTailor(
      email, name, password, gender, city, phone, context) async {
    print("in registration tailor");
    var uri = "https://tailor-client-5cqi.onrender.com/register/tailor";

    final headerall = {'Content-Type': 'application/json'};
    print(email);
    print(name);
    print(password);
    print(gender);
    print(city);
    print(int.parse(phone));
    final bodyall = convert.jsonEncode({
      "email": email.toString(),
      "name": name.toString(),
      "password": password.toString(),
      "gender": gender.toString(),
      "city": city.toString(),
      "phone": int.parse(phone)
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
    var uri = "https://tailor-client-5cqi.onrender.com/verifyEmail/$IdClient";
    final headerall = {'Content-Type': 'application/json'};

    final bodyall = convert.jsonEncode({"uniqueString": OTPSTR});

    var res =
        await http.post(Uri.parse(uri), headers: headerall, body: bodyall);
    print("in verefy ${res.statusCode}");
    if (res.statusCode == 200) {
      print("valiiiiiiiiiiiiiiiiiiiiiiiiiiiide otp tailor");
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      if (index == 1) {
        var tst = await prefs.setString('id', IdClient);
        var tst1 = await prefs.setString('type', "CLIENT");
        Provider.of<LocalDbProvider>(context, listen: false).GetIDLocal();
        Provider.of<LocalDbProvider>(context, listen: false).GetTYPELocal();
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
        Provider.of<LocalDbProvider>(context, listen: false).GetIDLocal();
        Provider.of<LocalDbProvider>(context, listen: false).GetTYPELocal();

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

  static Future<void> LOgOUT() async {
    String? id;
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.clear();
  }

  static Future<String?> GetLocalDBType() async {
    String? type;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    type = prefs.getString("type");
    print("in get aaaaaaaa");
    // await prefs.clear();

    return type;
  }

  static Future<void> EditProfile(iduser, name, city, phone, context) async {
    print("in registration tailor");
    var uri = "https://tailor-client-5cqi.onrender.com/update/$iduser";

    final headerall = {'Content-Type': 'application/json'};

    final bodyall = convert.jsonEncode(
        {"name": name.toString(), "city": city.toString(), "phone": 123});
    var res = await http.put(Uri.parse(uri), headers: headerall, body: bodyall);
    print("in eiiiiiiiiiiiiiiiit profile");
    print(res.statusCode);
    if (res.statusCode == 200) {
      var jsonres = convert.jsonDecode(res.body);

      await Provider.of<TailorsProvider>(context, listen: false)
          .GetTailor(jsonres["_id"]);
    }
  }

  static Future<void> EditProfileClient(iduser, name, context) async {
    print("in registration tailor");
    var uri = "https://tailor-client-5cqi.onrender.com/update/$iduser";

    final headerall = {'Content-Type': 'application/json'};

    final bodyall = convert.jsonEncode({
      "name": name.toString(),
    });
    var res = await http.put(Uri.parse(uri), headers: headerall, body: bodyall);
    print("in eiiiiiiiiiiiiiiiit profile");
    print(res.statusCode);
    if (res.statusCode == 200) {
      var jsonres = convert.jsonDecode(res.body);

      await Provider.of<ClientProvider>(context, listen: false)
          .GetALlAboutCurrentUser(jsonres["_id"], context);
    }
  }
}
