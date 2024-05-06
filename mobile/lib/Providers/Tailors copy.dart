import 'package:flutter/material.dart';
import 'package:projetfinprepa/Data/Client_Class.dart';
import 'package:projetfinprepa/IpConfig/Ipconfig.dart';
import 'package:projetfinprepa/LogiquesFonctions/ClientLogique.dart';

class ClientProvider extends ChangeNotifier {
  ClientClass? _client;
  ClientClass? get client => _client;

  Future<void> GetALlAboutCurrentUser() async {
    _client = await ClientLogique.GetAllAboutClient(IPCONFIG.ClientId);
    notifyListeners();
  }
}
