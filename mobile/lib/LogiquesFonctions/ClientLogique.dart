import 'dart:convert' as convert;

import 'package:http/http.dart' as http;
import 'package:projetfinprepa/Data/Client_Class.dart';
import 'package:projetfinprepa/Data/Models_Class.dart';
import 'package:projetfinprepa/Data/Order_class.dart';
import 'package:projetfinprepa/Data/Tailor_Class.dart';
import 'package:projetfinprepa/Providers/CollecionProv.dart';
import 'package:provider/provider.dart';

class ClientLogique {
  static Future<ClientClass?> GetAllAboutClient(IDCLIENT, context) async {
    ClientClass? client;
    List<Order> orders = [];
    List<Model> models = [];
    var uri = "https://tailor-client-5cqi.onrender.com/getClient/${IDCLIENT}";
    var res = await http.get(Uri.parse(uri));
    print("in gettttttttttttttttttttttttt client ${res.statusCode}");

    if (res.statusCode == 200) {
      var jsonres = convert.jsonDecode(res.body);

      for (var order in jsonres["orders"]) {
        models = [];
        for (var model in order["posts"]) {
          Model newmodel = Model(
              category: model["category"],
              titel: model["title"],
              description: model["description"],
              id: model["_id"],
              speciality: model["speciality"],
              tailor: null,
              CreatedAt: model["createdAt"],
              price: model["price"],
              image: model["image"]);
          models.add(newmodel);
        }

        Order Neworder = Order(
          postStyle: order["postStyle"],
          questionnaire: order["questionnaire"],
          models: models,
          orderDate: order["orderDate"],
          id: order["_id"],
          status: order["status"],
          totalPrice: order["totalPrice"],
          tailor: Tailor(
              name: order["tailor"]["name"],
              id: order["tailor"]["_id"],
              models: null,
              rating: null,
              email: null,
              password: null,
              phone: null,
              city: null,
              gender: null,
              Speciality: null,
              description: null,
              reviews: null,
              verified: null,
              address: null,
              resetPasswordToken: null,
              profilePicture: order["tailor"]["profilePicture"],
              orders: null),
        );
        // print(
        //     "mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm addd order to list ${order["questionnaire"]}");
        orders.add(Neworder);
      }
      client = ClientClass(
          name: jsonres["name"],
          email: jsonres["email"],
          id: jsonres["_id"],
          likes: jsonres["favorites"],
          favorites: jsonres["likes"],
          password: jsonres["passwrd"],
          verified: jsonres["verified"],
          resetPasswordToken: jsonres["passwrd"],
          profilePicture: jsonres["profilePicture"],
          orders: orders);
    }
    Provider.of<CollectionProvider>(context, listen: false)
        .GetFavs(context, client);
    Provider.of<CollectionProvider>(context, listen: false)
        .GetLikes(context, client!.likes);
    print(
        "wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww ${client.likes} ${client}");

    return client;
  }
}
