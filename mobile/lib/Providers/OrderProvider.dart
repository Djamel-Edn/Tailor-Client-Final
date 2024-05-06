import 'package:flutter/material.dart';
import 'package:projetfinprepa/LogiquesFonctions/OrderLogique.dart';

class OrderProvider extends ChangeNotifier {
  Future<void> AddOrder(IdClient, Idtailor, TotalPrice, Posts) async {
    await OrderLogique.AddOrder(IdClient, Idtailor, TotalPrice, Posts);
  }
}
