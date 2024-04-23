import 'dart:convert' as convert;

import 'package:http/http.dart' as http;
import 'package:projetfinprepa/Data/Models_Class.dart';
import 'package:projetfinprepa/Data/Tailor_Class.dart';
import 'package:projetfinprepa/IpConfig/Ipconfig.dart';

class ModelLogique {
  static Future<List<Model>> GetAllModels() async {
    print("22222222222222222222222222222222222222222222222222222222");
    List<Model> AllModel = [];
    var uri = "http://${IPCONFIG.iPCONFIG}:5001/post/getall";
    var res = await http.get(Uri.parse(uri));
    if (res.statusCode == 200) {
      var jsonres = convert.jsonDecode(res.body);
      print("jsonres.length");
      for (var modelobj in jsonres) {
        print(modelobj["createdAt"].runtimeType);
        print("jsonres.length ${res.statusCode}");
        Tailor tailor = Tailor(
            Speciality: modelobj["tailor"]["speciality"],
            address: modelobj["tailor"]["address"],
            models: modelobj["tailor"]["posts"],
            rating: modelobj["tailor"]["rating"],
            description: modelobj["tailor"]["description"],
            resetPasswordToken: modelobj["tailor"]["resetPasswordToken"],
            name: modelobj["tailor"]["name"],
            id: modelobj["tailor"]["_id"],
            email: modelobj["tailor"]["email"],
            password: modelobj["tailor"]["password"],
            phone: modelobj["tailor"]["phone"],
            city: modelobj["tailor"]["city"],
            gender: modelobj["tailor"]["gender"],
            reviews: modelobj["tailor"]["reviews"],
            verified: modelobj["tailor"]["verified"],
            profilePicture: modelobj["tailor"]["profilePicture"],
            orders: modelobj["tailor"]["orders"]);
        Model model = Model(
          titel: modelobj["title"],
          image: modelobj["image"].toString().substring(23),
          description: modelobj["description"],
          price: modelobj["price"],
          category: modelobj["category"],
          id: modelobj["_id"],
          speciality: modelobj["speciality"],
          tailor: tailor,
          CreatedAt: modelobj["createdAt"],
        );
        AllModel.add(model);
      }
    }
    return AllModel;
  }
}
