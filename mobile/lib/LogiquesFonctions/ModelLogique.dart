import 'dart:convert' as convert;

import 'package:http/http.dart' as http;
import 'package:projetfinprepa/Data/Models_Class.dart';
import 'package:projetfinprepa/Data/Tailor_Class.dart';

class ModelLogique {
  static Future<List<Model>> GetAllModels() async {
    List<Model> AllModel = [];
    print("in get modelssssssssssssssssssssssssssssssss");
    var uri = "https://tailor-client-ps9z.onrender.com/post/getall";
    var res = await http.get(Uri.parse(uri));
    print("in get modelssssssssssssssssssssssssssssssss${res.statusCode}");
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
          image: jsonres["image"].toString().substring(23),
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
}
