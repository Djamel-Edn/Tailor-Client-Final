import 'dart:convert' as convert;

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:projetfinprepa/Data/Models_Class.dart';
import 'package:projetfinprepa/Data/Tailor_Class.dart';
import 'package:projetfinprepa/Providers/Tailors.dart';
import 'package:provider/provider.dart';

class ModelLogique {
  static Future<List<Model>> GetAllModels() async {
    List<Model> AllModel = [];
    var uri = "https://tailor-client-ps9z.onrender.com/post/getall";
    var res = await http.get(Uri.parse(uri));
    if (res.statusCode == 200) {
      var jsonres = convert.jsonDecode(res.body);
      for (var jsonres in jsonres) {
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
        Model model = Model(
          titel: jsonres["title"],
          image: jsonres["image"].toString(),
          description: jsonres["description"],
          price: jsonres["price"],
          category: jsonres["category"],
          id: jsonres["_id"],
          speciality: jsonres["speciality"],
          tailor: tailor,
          CreatedAt: jsonres["createdAt"],
        );
        AllModel.add(model);
      }
    }

    return AllModel;
  }

  static Future<void> AddPost(
      name, desc, image, price, categ, spec, context) async {
    var uri = "https://tailor-client-ps9z.onrender.com/post/create";

    final headerall = {'Content-Type': 'application/json'};
    print("aaaaaaaaaaa add post");

    final bodyall = convert.jsonEncode({
      "title": name,
      "description": desc,
      "image": image,
      "price": 0,
      "category": categ,
      "postSpeciality": spec,
      "tailor": "6626eb65ed54ccf5c1e7e8ed"
    });

    var res =
        await http.post(Uri.parse(uri), headers: headerall, body: bodyall);
    print("adddddd post    ${res.statusCode}");
    if (res.statusCode == 201) {
      Provider.of<TailorsProvider>(context, listen: false)
          .GetTailor("6626eb65ed54ccf5c1e7e8ed");
      Navigator.pop(context);
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Wrap(
              children: [Text("Your post is has been published.")],
            ),
          );
        },
      );
      Future.delayed(
        Duration(seconds: 2),
        () {
          Navigator.pop(context);
        },
      );
    }
  }
}
