import 'package:http/http.dart';
import 'package:projetfinprepa/Data/Tailor_Class.dart';

class Order {
  String status, id;
  DateTime orderDate;
  Client client;
  Tailor tailor;
  double totalPrice;
  Order(
      {required this.client,
      required this.orderDate,
      required this.id,
      required this.status,
      required this.totalPrice,
      required this.tailor});
}
