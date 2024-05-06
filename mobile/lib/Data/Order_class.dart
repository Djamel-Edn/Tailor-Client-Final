import 'package:projetfinprepa/Data/Models_Class.dart';
import 'package:projetfinprepa/Data/Tailor_Class.dart';

class Order {
  String status, id;
  String orderDate;
  Tailor tailor;
  List<Model>? models;
  var totalPrice;
  Order(
      {required this.orderDate,
      required this.id,
      required this.models,
      required this.status,
      required this.totalPrice,
      required this.tailor});
}
