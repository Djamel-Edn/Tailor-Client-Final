import 'package:flutter/material.dart';
import 'package:projetfinprepa/Data/Client_Class.dart';
import 'package:projetfinprepa/LogiquesFonctions/ClientLogique.dart';

class ClientProvider extends ChangeNotifier {
  ClientClass? _client;
  ClientClass? get client => _client;

  Future<void> GetALlAboutCurrentUser(IDCurrentUser, context) async {
    _client = await ClientLogique.GetAllAboutClient(IDCurrentUser, context);
    notifyListeners();
  }

  Future<void> SetOrderTMP(order) async {
    _client!.orders!.add(order);
    notifyListeners();
  }
}
