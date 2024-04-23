import 'package:flutter/material.dart';
import 'package:projetfinprepa/Data/Models_Class.dart';
import 'package:projetfinprepa/LogiquesFonctions/ModelLogique.dart';

class ModelsProvider extends ChangeNotifier {
  List<Model> _AllModel = [];
  List<Model> get AllModel => _AllModel;

  Future<void> GetAllModels() async {
    _AllModel = await ModelLogique.GetAllModels();
  }
}
