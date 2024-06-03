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
      print(CategoryData.category[3].category);
      print("ssss ${model.category == "Women"}");

      print(model.category);
      model.category == "Man"
          ? _ManModels.add(model)
          : model.category == "Women"
              ? _WomanModels.add(model)
              : model.category == "Kid"
                  ? _KidModels.add(model)
                  : null;
    }
    AllModelsByCategory.add(_AllModels);
    AllModelsByCategory.add(_AllModels);
    AllModelsByCategory.add(_ManModels);
    AllModelsByCategory.add(_WomanModels);
    AllModelsByCategory.add(_KidModels);
    // AllModelsByCategory.add(_AllModels);
    // AllModelsByCategory.add(_AllModels);
    // AllModelsByCategory.add(_AllModels);
    // AllModelsByCategory.add(_AllModels);
    // AllModelsByCategory.add(_AllModels);
    print(
        "zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz all${AllModelsByCategory[0].length}");
    print(
        "zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz all${AllModelsByCategory[1].length}");
    print(
        "zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz man${AllModelsByCategory[2].length}");
    print(
        "zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzwoman ${AllModelsByCategory[3].length}");
    print(
        "zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzkid ${AllModelsByCategory[4].length}");

    notifyListeners();
  }
}
