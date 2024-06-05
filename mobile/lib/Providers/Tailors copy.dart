import 'package:flutter/material.dart';
import 'package:projetfinprepa/Data/Client_Class.dart';
import 'package:projetfinprepa/LogiquesFonctions/ClientLogique.dart';
import 'package:projetfinprepa/LogiquesFonctions/RegistaerLogique.dart';

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

  Future<void> EditProfilclient(IdTailor, name, context) async {
    await Register.EditProfileClient(IdTailor, name, context);

    notifyListeners();
  }
}
