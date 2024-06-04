import 'package:flutter/material.dart';
import 'package:projetfinprepa/LogiquesFonctions/RegistaerLogique.dart';

class LocalDbProvider extends ChangeNotifier {
  String? _id;
  String? get id => _id;
  String? _type;
  String? get type => _type;

  Future<void> GetIDLocal() async {
    _id = await Register.GetLocalDBId();
  }

  Future<void> LOGOUT() async {
    await Register.LOgOUT();
  }

  Future<void> GetTYPELocal() async {
    _type = await Register.GetLocalDBType();
  }
}
