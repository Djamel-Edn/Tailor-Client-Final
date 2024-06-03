import 'package:projetfinprepa/Data/Tailor_Class.dart';

class Order {
  String status, id;
  String orderDate;
  Tailor tailor;
  List<dynamic>? models;
  List<dynamic>? questionnaire;
  String? postStyle;

  var totalPrice;
  Order(
      {required this.orderDate,
      required this.id,
      required this.models,
      required this.questionnaire,
      required this.postStyle,
      required this.status,
      required this.totalPrice,
      required this.tailor});
}

class OrderEmit {
  String status, id;
  String orderDate;
  String tailor;
  List<dynamic>? models;
  List<dynamic>? questionnaire;
  String? postStyle;

  var totalPrice;
  OrderEmit(
      {required this.orderDate,
      required this.id,
      required this.models,
      required this.questionnaire,
      required this.postStyle,
      required this.status,
      required this.totalPrice,
      required this.tailor});
}
