import 'package:flutter/material.dart';
import 'package:projetfinprepa/LogiquesFonctions/OrderLogique.dart';

class OrderProvider extends ChangeNotifier {
  Future<void> AddOrder(IdClient, Idtailor, TotalPrice, Posts, context) async {
    await OrderLogique.AddOrder(IdClient, Idtailor, TotalPrice, Posts, context);
  }

  Future<void> AddOrderByMe(IdClient, Idtailor, TotalPrice, Posts, image,
      qstans, tailor, context) async {
    await OrderLogique.AddOrderByMe(
        IdClient, Idtailor, TotalPrice, Posts, image, qstans, tailor, context);
  }

  // Future<void> UpdateOrder(idOrder, status, totalPrice, context) async {
  //   await OrderLogique.UpdateOrder(idOrder, status, totalPrice, context);
  // }
}
