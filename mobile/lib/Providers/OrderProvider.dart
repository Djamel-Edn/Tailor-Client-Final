import 'package:flutter/material.dart';
import 'package:projetfinprepa/LogiquesFonctions/OrderLogique.dart';
import 'package:projetfinprepa/Providers/Tailors.dart';
import 'package:provider/provider.dart';

class OrderProvider extends ChangeNotifier {
  Future<void> AddOrder(IdClient, Idtailor, TotalPrice, Posts, context) async {
    await OrderLogique.AddOrder(IdClient, Idtailor, TotalPrice, Posts, context);
    await Provider.of<TailorsProvider>(context, listen: false)
        .GetTailor(Idtailor);
    notifyListeners();
  }

  Future<void> AddOrderByMe(IdClient, Idtailor, TotalPrice, Posts, image,
      qstans, tailor, context) async {
    print("in add order by be prove");
    await OrderLogique.AddOrderByMe(
        IdClient, Idtailor, TotalPrice, Posts, image, qstans, tailor, context);
    print("in add order by be prove apre adding");

    await Provider.of<TailorsProvider>(context, listen: false)
        .GetTailor(Idtailor);
    print("in add order by be prove apre get tailor");

    notifyListeners();
  }

  // Future<void> UpdateOrder(idOrder, status, totalPrice, context) async {
  //   await OrderLogique.UpdateOrder(idOrder, status, totalPrice, context);
  // }
}
