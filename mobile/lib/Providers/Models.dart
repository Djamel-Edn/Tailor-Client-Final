import 'package:flutter/material.dart';
import 'package:projetfinprepa/Data/Models_Class.dart';
import 'package:projetfinprepa/Data/category.dart';
import 'package:projetfinprepa/LogiquesFonctions/ModelLogique.dart';

class ModelsProvider extends ChangeNotifier {
  bool _IsLoading = true;
  bool get IsLoading => _IsLoading;

  List<List<Model>> _AllModelsByCategory = [];
  List<Model> _AllModels = [];
  List<Model> _ManModels = [];
  List<Model> _WomanModels = [];
  List<Model> _KidModels = [];

  List<Model> get AllModel => _AllModels;
  List<List<Model>> get AllModelsByCategory => _AllModelsByCategory;
  List<Model> get ManModels => _ManModels;
  List<Model> get WomanModels => _WomanModels;
  List<Model> get KidModels => _KidModels;

  Future<void> GetAllModels() async {
    _AllModels = await ModelLogique.GetAllModels();
    _IsLoading = false;

    for (var model in _AllModels) {
      model.category == CategoryData.category[2].category
          ? ManModels.add(model)
          : model.category == CategoryData.category[3].category
              ? WomanModels.add(model)
              : KidModels.add(model);
    }
    AllModelsByCategory.add(_AllModels);
    AllModelsByCategory.add(_AllModels);
    AllModelsByCategory.add(_ManModels);
    AllModelsByCategory.add(_WomanModels);
    AllModelsByCategory.add(_KidModels);
    notifyListeners();
  }
}
